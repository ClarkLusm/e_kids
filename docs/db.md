# Local Database Design

Tài liệu này mô tả thiết kế database local cho app `e_kids`.

App dùng Drift để lưu dữ liệu học tập của bé theo hướng local-first: app vẫn chạy được khi chưa có API, nhưng schema vẫn chừa đường để sync dữ liệu lên backend ở phase sau.

## Mục Tiêu

- Lưu profile bé sau màn chọn nhân vật.
- Lưu nội dung học local: chủ đề, bài học, câu hỏi quiz, từ vựng.
- Theo dõi tiến độ học, lịch sử làm quiz, XP, streak và hoạt động hằng ngày.
- Hỗ trợ resume bài học.
- Chuẩn bị sẵn metadata để sync API trong tương lai.

## Nguyên Tắc Thiết Kế

- Mỗi bảng dùng `TEXT` id để dễ đồng bộ với API sau này.
- Thời gian lưu bằng `INTEGER` Unix milliseconds.
- Các payload khác nhau theo từng quiz type lưu bằng JSON string.
- Các trạng thái enum lưu bằng `TEXT` để dễ debug.
- Bảng phát sinh từ hành vi user nên có field sync metadata.

## Sync Metadata

Các bảng dữ liệu do user tạo hoặc thay đổi nên có thêm các cột này:

```sql
remote_id TEXT,
sync_status TEXT NOT NULL DEFAULT 'pending',
last_synced_at INTEGER,
deleted_at INTEGER
```

Giá trị `sync_status`:

- `pending`: dữ liệu local chưa sync.
- `synced`: đã sync thành công.
- `failed`: sync lỗi, cần retry.

## Profile

### child_profiles

Lưu profile bé đã chọn ở onboarding.

```sql
child_profiles (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  avatar_id TEXT NOT NULL,
  level INTEGER NOT NULL DEFAULT 1,
  total_xp INTEGER NOT NULL DEFAULT 0,
  streak_days INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER
)
```

Ghi chú:

- `avatar_id` map với danh sách avatar có sẵn trong app.
- Phase hiện tại chỉ cần một bé, nhưng schema vẫn hỗ trợ nhiều profile.

## Nội Dung Học

Lưu ý: dữ liệu lesson và quiz có thể đến từ seed local ở phase đầu, sau đó được đồng bộ từ API khi backend sẵn sàng. Vì vậy các bảng nội dung như `topics`, `lessons`, `quiz_questions`, `vocabulary_items` nên giữ id ổn định, có version nội dung và tránh phụ thuộc vào id tự tăng local.

### topics

Chủ đề học như Animals, Food, Colors.

```sql
topics (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  icon TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_unlocked INTEGER NOT NULL DEFAULT 1
)
```

### lessons

Bài học thuộc một topic.

```sql
lessons (
  id TEXT PRIMARY KEY,
  topic_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  level INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  estimated_minutes INTEGER,
  is_unlocked INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY(topic_id) REFERENCES topics(id)
)
```

### quiz_questions

Cache câu hỏi quiz local.

```sql
quiz_questions (
  id TEXT PRIMARY KEY,
  lesson_id TEXT NOT NULL,
  quiz_type TEXT NOT NULL,
  prompt TEXT,
  content_json TEXT NOT NULL,
  difficulty INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY(lesson_id) REFERENCES lessons(id)
)
```

`quiz_type` hiện có:

- `picture_match`
- `listen_tap`
- `letter_scramble`
- `fill_blank`
- `speak_word`
- `memory_flip`
- `sort_bucket`
- `word_pop`
- `story_builder`

`content_json` chứa payload riêng từng quiz type. Ví dụ `memory_flip` có pairs, grid size, score config; `speak_word` có target word, accepted variants, min similarity score.

### vocabulary_items

Danh sách từ vựng.

```sql
vocabulary_items (
  id TEXT PRIMARY KEY,
  word TEXT NOT NULL,
  translation_vi TEXT,
  phonetic TEXT,
  image_url TEXT,
  audio_url TEXT,
  topic_id TEXT,
  difficulty INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY(topic_id) REFERENCES topics(id)
)
```

### content_versions

Theo dõi version nội dung đã seed hoặc import vào local DB.

```sql
content_versions (
  id TEXT PRIMARY KEY,
  version TEXT NOT NULL,
  source TEXT,
  applied_at INTEGER NOT NULL
)
```

## Tiến Độ Học

### lesson_progress

Trạng thái học của từng bé trong từng lesson.

```sql
lesson_progress (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  lesson_id TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'not_started',
  progress_percent REAL NOT NULL DEFAULT 0,
  completed_questions INTEGER NOT NULL DEFAULT 0,
  total_questions INTEGER NOT NULL DEFAULT 0,
  best_score INTEGER NOT NULL DEFAULT 0,
  earned_xp INTEGER NOT NULL DEFAULT 0,
  last_question_id TEXT,
  started_at INTEGER,
  completed_at INTEGER,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, lesson_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(lesson_id) REFERENCES lessons(id)
)
```

Giá trị `status`:

- `not_started`
- `in_progress`
- `completed`

### vocabulary_progress

Theo dõi mức độ thành thạo từng từ.

```sql
vocabulary_progress (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  vocabulary_id TEXT NOT NULL,
  seen_count INTEGER NOT NULL DEFAULT 0,
  correct_count INTEGER NOT NULL DEFAULT 0,
  wrong_count INTEGER NOT NULL DEFAULT 0,
  mastery_level INTEGER NOT NULL DEFAULT 0,
  last_seen_at INTEGER,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, vocabulary_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(vocabulary_id) REFERENCES vocabulary_items(id)
)
```

`mastery_level` đề xuất:

- `0`: chưa học.
- `1`: đã thấy.
- `2`: đang nhớ.
- `3`: thành thạo.

## Lịch Sử Học

### learning_sessions

Một phiên bé vào học hoặc chơi.

```sql
learning_sessions (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  lesson_id TEXT,
  started_at INTEGER NOT NULL,
  ended_at INTEGER,
  duration_seconds INTEGER NOT NULL DEFAULT 0,
  earned_xp INTEGER NOT NULL DEFAULT 0,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(lesson_id) REFERENCES lessons(id)
)
```

### quiz_sessions

Một lượt làm quiz trong lesson.

```sql
quiz_sessions (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  lesson_id TEXT NOT NULL,
  started_at INTEGER NOT NULL,
  ended_at INTEGER,
  total_questions INTEGER NOT NULL DEFAULT 0,
  correct_count INTEGER NOT NULL DEFAULT 0,
  xp_earned INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'in_progress',
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(lesson_id) REFERENCES lessons(id)
)
```

Giá trị `status`:

- `in_progress`
- `completed`
- `abandoned`

### quiz_attempts

Lịch sử trả lời từng câu quiz.

```sql
quiz_attempts (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  session_id TEXT,
  lesson_id TEXT NOT NULL,
  question_id TEXT NOT NULL,
  quiz_type TEXT NOT NULL,
  attempt_index INTEGER NOT NULL DEFAULT 1,
  is_correct INTEGER NOT NULL,
  is_completed INTEGER NOT NULL DEFAULT 1,
  score INTEGER NOT NULL DEFAULT 0,
  stars INTEGER NOT NULL DEFAULT 0,
  xp_earned INTEGER NOT NULL DEFAULT 0,
  time_taken_ms INTEGER NOT NULL DEFAULT 0,
  hints_used INTEGER NOT NULL DEFAULT 0,
  answer_json TEXT,
  created_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(session_id) REFERENCES quiz_sessions(id),
  FOREIGN KEY(lesson_id) REFERENCES lessons(id),
  FOREIGN KEY(question_id) REFERENCES quiz_questions(id)
)
```

Ví dụ `answer_json`:

```json
{
  "selected_word": "cat",
  "correct_word": "cat",
  "replay_count": 1
}
```

Các quiz khác có thể lưu dữ liệu riêng:

- `memory_flip`: `flip_count`, `matched_pairs`.
- `speak_word`: `transcript`, `similarity`, `attempt_count`.
- `sort_bucket`: `placements`.
- `story_builder`: `submitted_sentence`.

### Cách Tính quiz_attempts.xp_earned

`quiz_attempts.xp_earned` được tính khi controller quiz chuẩn bị lưu attempt. User không nhập trực tiếp giá trị này.

Công thức chung:

```text
xp_earned = base_xp + bonus_xp - penalty_xp
```

Nếu trả lời sai hoặc không hoàn thành câu quiz:

```text
xp_earned = 0
```

Nếu trả lời đúng:

```text
base_xp:
  difficulty = 1 -> 10 XP
  difficulty = 2 -> 15 XP
  difficulty = 3 -> 20 XP

speed_bonus:
  time_taken_ms <= 5000  -> +5 XP
  time_taken_ms <= 10000 -> +2 XP
  còn lại -> +0 XP

no_hint_bonus:
  hints_used == 0 -> +5 XP

first_try_bonus:
  attempt_index == 1 -> +5 XP

penalty:
  hints_used * 2
```

Kết quả cuối cùng được clamp trong khoảng `0..100`.

Ví dụ:

```text
difficulty = 2
is_correct = true
time_taken_ms = 4000
hints_used = 0
attempt_index = 1

xp_earned = 15 + 5 + 5 + 5 - 0 = 30
```

Trong code, rule này nằm ở shared quiz use case:

```text
lib/features/quiz/_shared/domain/usecases/calculate_quiz_xp_usecase.dart
```

Các controller quiz gọi use case này trước khi save result. Khi Drift được nối với `quiz_questions`, field `difficulty` nên lấy từ `quiz_questions.difficulty`.

## XP Và Hoạt Động Ngày

### xp_events

Lịch sử cộng XP.

```sql
xp_events (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  source_type TEXT NOT NULL,
  source_id TEXT,
  xp INTEGER NOT NULL,
  reason TEXT,
  created_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

Giá trị `source_type`:

- `quiz`
- `lesson`
- `streak`
- `achievement`

### daily_activity

Tổng hợp hoạt động theo ngày để tính streak và dashboard phụ huynh.

```sql
daily_activity (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  activity_date TEXT NOT NULL,
  active_seconds INTEGER NOT NULL DEFAULT 0,
  completed_lessons INTEGER NOT NULL DEFAULT 0,
  completed_quizzes INTEGER NOT NULL DEFAULT 0,
  earned_xp INTEGER NOT NULL DEFAULT 0,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, activity_date),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

`activity_date` dùng format `yyyy-MM-dd`.

## Thành Tựu

### achievements

Định nghĩa huy hiệu hoặc phần thưởng.

```sql
achievements (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  icon TEXT,
  condition_json TEXT NOT NULL,
  xp_reward INTEGER NOT NULL DEFAULT 0
)
```

### child_achievements

Thành tựu bé đã mở khóa.

```sql
child_achievements (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  achievement_id TEXT NOT NULL,
  unlocked_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, achievement_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(achievement_id) REFERENCES achievements(id)
)
```

## Local App Infrastructure

### app_settings

Lưu cấu hình app local.

```sql
app_settings (
  key TEXT PRIMARY KEY,
  value_json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
)
```

Ví dụ:

- `sound_enabled`
- `music_volume`
- `ui_language`
- `parent_lock_enabled`

### asset_cache

Theo dõi asset đã tải hoặc đã cache local.

```sql
asset_cache (
  id TEXT PRIMARY KEY,
  remote_url TEXT,
  local_path TEXT NOT NULL,
  asset_type TEXT NOT NULL,
  checksum TEXT,
  downloaded_at INTEGER
)
```

Giá trị `asset_type`:

- `image`
- `audio`
- `animation`

### parent_pins

PIN để bảo vệ màn phụ huynh.

```sql
parent_pins (
  id TEXT PRIMARY KEY,
  pin_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
```

## Index Đề Xuất

```sql
CREATE INDEX idx_lessons_topic_order
ON lessons(topic_id, sort_order);

CREATE INDEX idx_questions_lesson_order
ON quiz_questions(lesson_id, sort_order);

CREATE INDEX idx_lesson_progress_child
ON lesson_progress(child_id, updated_at);

CREATE INDEX idx_quiz_attempts_child_created
ON quiz_attempts(child_id, created_at);

CREATE INDEX idx_quiz_attempts_question
ON quiz_attempts(question_id);

CREATE INDEX idx_vocab_progress_child
ON vocabulary_progress(child_id, updated_at);

CREATE INDEX idx_daily_activity_child_date
ON daily_activity(child_id, activity_date);

CREATE INDEX idx_sync_status
ON quiz_attempts(sync_status);
```

Khi implement Drift, mỗi bảng có sync metadata riêng nên index `sync_status` có thể được tạo riêng cho từng bảng cần sync.

## Quan Hệ Chính

```text
child_profiles 1 - n lesson_progress
child_profiles 1 - n learning_sessions
child_profiles 1 - n quiz_sessions
child_profiles 1 - n quiz_attempts
child_profiles 1 - n vocabulary_progress
child_profiles 1 - n xp_events
child_profiles 1 - n daily_activity

topics 1 - n lessons
topics 1 - n vocabulary_items
lessons 1 - n quiz_questions
lessons 1 - n lesson_progress
lessons 1 - n quiz_sessions
quiz_sessions 1 - n quiz_attempts
quiz_questions 1 - n quiz_attempts
vocabulary_items 1 - n vocabulary_progress
achievements 1 - n child_achievements
```

## Thứ Tự Implement Drift

1. `child_profiles`
2. `topics`, `lessons`, `quiz_questions`
3. `lesson_progress`
4. `learning_sessions`, `quiz_sessions`, `quiz_attempts`
5. `vocabulary_items`, `vocabulary_progress`
6. `xp_events`, `daily_activity`
7. `achievements`, `child_achievements`
8. `app_settings`, `asset_cache`, `parent_pins`
9. Sync metadata và migration cho phase API

## Ghi Chú Cho Phase Hiện Tại

Phase hiện tại chỉ cần tối thiểu:

- `child_profiles`
- `topics`
- `lessons`
- `quiz_questions`
- `lesson_progress`
- `quiz_attempts`
- `xp_events`
- `daily_activity`

Các bảng còn lại nên thiết kế sẵn trong tài liệu, nhưng có thể implement sau khi app cần dashboard, achievement, asset download hoặc sync API.
