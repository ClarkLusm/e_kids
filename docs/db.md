# Local Database Design

Tài liệu này mô tả thiết kế database local cho app `e_kids`.

App dùng Drift để lưu dữ liệu học tập của bé theo hướng local-first: app vẫn chạy được khi chưa có API, nhưng schema vẫn chừa đường để sync dữ liệu lên backend ở phase sau.

## Mục Tiêu

- Lưu profile bé sau màn chọn nhân vật.
- Lưu nội dung học local: chủ đề, bài học, câu hỏi quiz, từ vựng.
- Lưu kết quả khảo sát đầu vào để gán lộ trình học phù hợp.
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

Lưu ý: dữ liệu path, topic, lesson và quiz có thể đến từ seed local ở phase đầu, sau đó được đồng bộ từ API khi backend sẵn sàng. Vì vậy các bảng nội dung như `learning_paths`, `topics`, `lessons`, `quiz_questions`, `vocabulary_items` nên giữ id ổn định và tránh phụ thuộc vào id tự tăng local.

Flow nội dung chính:

```text
learning_paths -> path_topics -> topics -> lessons -> quiz_questions
```

### learning_paths

Lộ trình học phù hợp theo độ tuổi hoặc trình độ của bé.

```sql
learning_paths (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  age_min INTEGER,
  age_max INTEGER,
  level TEXT NOT NULL DEFAULT 'beginner',
  is_active INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
```

### topics

Chủ đề học như Animals, Food, Colors.

```sql
topics (
  id TEXT PRIMARY KEY,
  name_en TEXT NOT NULL,
  name_vi TEXT NOT NULL,
  icon_url TEXT,
  color_hex TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active INTEGER NOT NULL DEFAULT 1
)
```

### path_topics

Bảng nối để xác định topic nào nằm trong path nào và thứ tự học trong path.

```sql
path_topics (
  id TEXT PRIMARY KEY,
  path_id TEXT NOT NULL,
  topic_id TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_required INTEGER NOT NULL DEFAULT 1,
  unlock_rule_json TEXT,
  UNIQUE(path_id, topic_id),
  FOREIGN KEY(path_id) REFERENCES learning_paths(id),
  FOREIGN KEY(topic_id) REFERENCES topics(id)
)
```

### lessons

Bài học thuộc một topic.

```sql
lessons (
  id TEXT PRIMARY KEY,
  topic_id TEXT NOT NULL,
  title_en TEXT NOT NULL,
  title_vi TEXT NOT NULL,
  description_vi TEXT,
  level INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  min_xp_required INTEGER NOT NULL DEFAULT 0,
  is_published INTEGER NOT NULL DEFAULT 1,
  thumbnail_url TEXT,
  vocabulary_count INTEGER NOT NULL DEFAULT 0,
  question_count INTEGER NOT NULL DEFAULT 0,
  xp_reward INTEGER NOT NULL DEFAULT 50,
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
  xp_reward INTEGER NOT NULL DEFAULT 10,
  time_limit_sec INTEGER,
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
  lesson_id TEXT NOT NULL,
  word TEXT NOT NULL,
  phonetic TEXT,
  translation_vi TEXT NOT NULL,
  image_url TEXT,
  audio_url TEXT,
  part_of_speech TEXT,
  is_key_word INTEGER NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY(lesson_id) REFERENCES lessons(id)
)
```

### child_learning_paths

Path đang được gán cho từng bé.

```sql
child_learning_paths (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  path_id TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'active',
  current_topic_id TEXT,
  current_lesson_id TEXT,
  started_at INTEGER NOT NULL,
  completed_at INTEGER,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, path_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(path_id) REFERENCES learning_paths(id)
)
```

### placement_sessions

Lưu lịch sử chọn lộ trình ở onboarding. Bé có thể bỏ qua khảo sát, khi đó app gán `learning_paths` mặc định. Nếu bé làm khảo sát, app lưu điểm và path được chọn theo kết quả.

```sql
placement_sessions (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'started',
  score INTEGER NOT NULL DEFAULT 0,
  max_score INTEGER NOT NULL DEFAULT 0,
  recommended_path_id TEXT,
  selected_path_id TEXT,
  answers_json TEXT,
  started_at INTEGER NOT NULL,
  completed_at INTEGER,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(recommended_path_id) REFERENCES learning_paths(id),
  FOREIGN KEY(selected_path_id) REFERENCES learning_paths(id)
)
```

Giá trị `status`:

- `started`: bé đã bắt đầu khảo sát nhưng chưa hoàn tất.
- `skipped`: phụ huynh/bé bỏ qua khảo sát, app dùng path mặc định.
- `completed`: khảo sát đã hoàn tất và app đã gán path theo điểm.

Flow gán path hiện tại:

```text
select_profile -> placement_intro -> skip -> assign default path -> home
select_profile -> placement_intro -> placement_test -> score -> assign matched path -> placement_result -> home
```

Phase local hiện tại có seed path tối thiểu trong app để flow chạy được khi chưa sync API. Sau này API có thể trả về danh sách path và rule chọn path chi tiết hơn; local vẫn chỉ cần ghi `placement_sessions` và cập nhật `child_learning_paths`.

## Đồng Bộ Nội Dung

### sync_versions

Theo dõi version sync theo từng nhóm dữ liệu độc lập. Ví dụ API báo `lessons` có version mới nhưng `quiz_questions` không đổi, app chỉ cần sync `lessons`.

```sql
sync_versions (
  id TEXT PRIMARY KEY,
  sync_key TEXT NOT NULL UNIQUE,
  version TEXT NOT NULL,
  source TEXT NOT NULL,
  applied_at INTEGER NOT NULL,
  last_checked_at INTEGER,
  last_error TEXT
)
```

Ví dụ `sync_key`:

- `learning_paths`
- `path_topics`
- `topics`
- `lessons`
- `quiz_questions`
- `vocabulary_items`

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

### Cách Tính XP

XP không nên chỉ nằm trong `quiz_attempts`. Mỗi lần bé nhận XP cần ghi thêm một dòng vào `xp_events`, sau đó cộng vào `child_progress.total_xp`.

XP cơ bản mỗi bài học:

```text
base_xp = lesson_base_xp * accuracy_multiplier * streak_multiplier + first_try_bonus
```

Hệ số:

```text
lesson_base_xp:
  bài 5 từ        -> 10 XP
  bài 10 từ       -> 25 XP
  quiz đầy đủ     -> 50 XP

accuracy_multiplier:
  accuracy >= 90% -> *1.5
  accuracy 70-89% -> *1.0
  accuracy 50-69% -> *0.7
  accuracy < 50%  -> *0.5

streak_multiplier:
  streak 1-2 ngày   -> *1.0
  streak 3-6 ngày   -> *1.1
  streak 7-13 ngày  -> *1.25
  streak >= 14 ngày -> *1.5

first_try_bonus:
  +5 XP / câu đúng ngay lần đầu
```

Ví dụ:

```text
Bé làm quiz 10 từ: lesson_base_xp = 25
Accuracy = 80% -> *1.0
Streak = 8 ngày -> *1.25
2 câu đúng ngay lần đầu -> +10

total = 25 * 1.0 * 1.25 + 10 = 41 XP
```

XP từ daily mission:

```text
mission_xp = template_xp_reward * completion_bonus

completion_bonus:
  hoàn thành đúng hạn trong ngày -> *1.0
  hoàn thành tất cả mission trong ngày -> +50 XP
```

XP từ streak milestone:

```text
3 ngày  -> +30 XP
7 ngày  -> +100 XP
14 ngày -> +250 XP
30 ngày -> +500 XP + huy hiệu đặc biệt
```

### xp_events

Log bất biến của mọi lần bé nhận XP.

```sql
xp_events (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  source_type TEXT NOT NULL,
  source_id TEXT NOT NULL,
  xp_amount INTEGER NOT NULL,
  base_xp INTEGER NOT NULL DEFAULT 0,
  accuracy_multiplier REAL NOT NULL DEFAULT 1,
  streak_multiplier REAL NOT NULL DEFAULT 1,
  first_try_bonus INTEGER NOT NULL DEFAULT 0,
  metadata_json TEXT,
  created_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

`source_type` ví dụ: `lesson`, `quiz`, `daily_mission`, `streak_milestone`.

## XP Và Hoạt Động Ngày

### child_progress

Nguồn đọc nhanh cho level/XP hiện tại của bé. Bảng này được cập nhật từ `xp_events`, `quiz_attempts`, `word_mastery` và `level_definitions`.

```sql
child_progress (
  child_id TEXT PRIMARY KEY,
  current_level INTEGER NOT NULL DEFAULT 1,
  current_xp INTEGER NOT NULL DEFAULT 0,
  total_xp INTEGER NOT NULL DEFAULT 0,
  xp_to_next_level INTEGER NOT NULL DEFAULT 150,
  accuracy_7d REAL NOT NULL DEFAULT 0,
  words_mastered INTEGER NOT NULL DEFAULT 0,
  streak_days INTEGER NOT NULL DEFAULT 0,
  mastery_blocked INTEGER NOT NULL DEFAULT 0,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

Ý nghĩa:

- `total_xp`: tổng XP trọn đời, dùng để so với `level_definitions.xp_required`.
- `current_xp`: XP trong level hiện tại, dùng để hiển thị progress.
- `xp_to_next_level`: XP delta để lên level kế tiếp.
- `mastery_blocked`: bé đã đủ XP nhưng chưa đủ `accuracy_7d` hoặc `words_mastered`.

### level_definitions

Định nghĩa level chính thức của app. Đây là rule hệ thống/API, phụ huynh không chỉnh trực tiếp.

Level không phụ thuộc vào `skill_targets`. Skill chỉ dùng cho mục tiêu cá nhân hóa do phụ huynh giao bài.

```sql
level_definitions (
  level INTEGER PRIMARY KEY,
  xp_required INTEGER NOT NULL,
  xp_delta INTEGER NOT NULL,
  min_accuracy REAL NOT NULL DEFAULT 0,
  min_words INTEGER NOT NULL DEFAULT 0,
  title TEXT NOT NULL,
  badge_reward_id TEXT,
  unlock_feature TEXT,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER
)
```

Ý nghĩa:

- `xp_required`: tổng XP tối thiểu để đạt level này.
- `xp_delta`: XP cần thêm từ level trước lên level này, dùng để hiển thị progress.
- `min_accuracy`: accuracy tối thiểu trong 7 ngày gần nhất.
- `min_words`: số từ có `word_mastery.status = mastered` tối thiểu.
- `badge_reward_id`: huy hiệu tặng khi đạt level, có thể null ở phase đầu.
- `unlock_feature`: feature mở khóa khi đạt level, ví dụ `speaking_challenge`.

XP cần để lên level dùng đường cong bậc hai để càng lên cao càng cần nhiều XP hơn nhưng không tăng quá dốc:

```text
xp_delta(level -> level + 1) = 25 * level^2 + 25 * level + 100
xp_required(level N) = tổng xp_delta từ level 1 đến N - 1
```

Ví dụ:

```text
level 1 -> 2: 150 XP
level 2 -> 3: 250 XP
level 3 -> 4: 400 XP
```

Rule tăng level:

```text
current_level = level cao nhất thỏa:
  total_xp >= level_definitions.xp_required
  accuracy_7_days >= level_definitions.min_accuracy
  mastered_words >= level_definitions.min_words
```

Progress lên level kế tiếp:

```text
xp_progress       = XP từ current level đến next level
accuracy_progress = accuracy_7_days / next.min_accuracy
words_progress    = mastered_words / next.min_words

level_progress_percent = min(xp_progress, accuracy_progress, words_progress)
```

Lấy `min(...)` để nếu XP đủ nhưng accuracy hoặc từ vựng chưa đạt thì bé chưa lên level.

Nếu `mastery_blocked = true`, UI không hiển thị lỗi. Message nên là: "Bạn gần lên level rồi! Luyện thêm một chút nhé" và gợi ý bài cần làm.

### word_mastery

Tiến trình ghi nhớ từng từ của từng bé. Bảng này phục vụ mastery gate và spaced repetition.

```sql
word_mastery (
  child_id TEXT NOT NULL,
  word_id TEXT NOT NULL,
  word TEXT,
  times_seen INTEGER NOT NULL DEFAULT 0,
  times_correct INTEGER NOT NULL DEFAULT 0,
  times_wrong INTEGER NOT NULL DEFAULT 0,
  mastery_score REAL NOT NULL DEFAULT 0,
  last_seen_at INTEGER,
  next_review_at INTEGER,
  status TEXT NOT NULL DEFAULT 'learning',
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  PRIMARY KEY(child_id, word_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

Status:

- `learning`: bé đang học từ này.
- `mastered`: bé đã trả lời đúng đủ nhiều lần với `mastery_score` cao.
- `forgotten`: bé gặp lại nhiều lần nhưng sai nhiều, cần ôn lại sớm.

Rule tính:

```text
mastery_score = (times_correct / times_seen) * decay_factor

decay_factor:
  gặp lại trong 24h   -> 1.0
  2-3 ngày chưa gặp   -> 0.9
  4-7 ngày chưa gặp   -> 0.7
  > 7 ngày chưa gặp   -> 0.5

status:
  mastery_score >= 0.8 AND times_seen >= 3 -> mastered
  previously mastered AND decay về <= 0.5  -> forgotten
  còn lại                                  -> learning
```

Phase local hiện tại ưu tiên resolve `word_id` từ `vocabulary_items.id`. Nếu quiz mock chưa có UUID từ API, app dùng fallback ổn định dạng `word:<normalized_word>`.

### skill_targets

Mục tiêu học theo kỹ năng cho từng path và level. Bảng này phục vụ Parent Zone: phụ huynh giao mục tiêu luyện tập riêng cho bé.

Quan trọng: bảng này không dùng để quyết định tăng level, vì phụ huynh có thể chỉnh `required_units`.

```sql
skill_targets (
  id TEXT PRIMARY KEY,
  path_id TEXT NOT NULL,
  level INTEGER NOT NULL,
  skill_key TEXT NOT NULL,
  required_units INTEGER NOT NULL,
  unit_type TEXT NOT NULL,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(path_id, level, skill_key),
  FOREIGN KEY(path_id) REFERENCES learning_paths(id)
)
```

Ví dụ:

- `vocabulary`: `30 words`
- `listening`: `20 questions`
- `speaking`: `10 utterances`

### skill_progress

Tiến trình kỹ năng của từng bé trong path/level hiện tại.

```sql
skill_progress (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  path_id TEXT NOT NULL,
  level INTEGER NOT NULL,
  skill_key TEXT NOT NULL,
  completed_units INTEGER NOT NULL DEFAULT 0,
  required_units INTEGER NOT NULL,
  progress_percent REAL NOT NULL DEFAULT 0,
  correct_count INTEGER NOT NULL DEFAULT 0,
  attempt_count INTEGER NOT NULL DEFAULT 0,
  earned_xp INTEGER NOT NULL DEFAULT 0,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, path_id, level, skill_key),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(path_id) REFERENCES learning_paths(id)
)
```

Rule tính:

```text
progress_percent = completed_units / required_units * 100
```

Trong phase hiện tại, app seed mục tiêu mặc định nếu DB rỗng và phụ huynh có thể chỉnh `required_units` trong Parent Zone.

### mission_templates

Template nhiệm vụ hằng ngày. Đây là dữ liệu nội dung, có thể seed local ở phase đầu và sync từ API/CMS sau này.

```sql
mission_templates (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  topic_scope TEXT NOT NULL DEFAULT 'any',
  condition_json TEXT,
  title TEXT NOT NULL,
  description TEXT,
  target_metric TEXT NOT NULL,
  target_value INTEGER NOT NULL,
  xp_reward INTEGER NOT NULL,
  duration_est_min INTEGER NOT NULL,
  is_active INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER
)
```

Ghi chú:

- `type`: nhóm nhiệm vụ để render icon/màu/CTA, ví dụ `vocabulary`, `quiz`, `streak`, `review`, `speed`, `challenge`.
- `target_metric`: chỉ số app cần đo, ví dụ `new_words`, `quiz_count`, `speaking_count`, `accuracy_percent`.
- `condition_json`: rule chọn template phù hợp với tình trạng của bé, có thể để `NULL` ở phase local.
- `title` có thể chứa placeholder như `{n}`, `{topic}`; giá trị cụ thể nằm trong `daily_missions.params_json`.

### daily_missions

Nhiệm vụ cụ thể được giao cho một bé trong một ngày.

```sql
daily_missions (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  date TEXT NOT NULL,
  slot INTEGER NOT NULL DEFAULT 0,
  mission_template_id TEXT NOT NULL,
  params_json TEXT NOT NULL DEFAULT '{}',
  status TEXT NOT NULL DEFAULT 'pending',
  progress_value INTEGER NOT NULL DEFAULT 0,
  target_value INTEGER NOT NULL,
  xp_reward INTEGER NOT NULL,
  completed_at INTEGER,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, date, mission_template_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(mission_template_id) REFERENCES mission_templates(id)
)
```

Ghi chú:

- `date` dùng format `yyyy-MM-dd`.
- `slot` xác định vị trí mission trong ngày. Sau tuần đầu, app sinh 4 slot cố định: `1` dễ bắt buộc, `2` điểm yếu, `3` ôn tập, `4` thử thách.
- `target_value` và `xp_reward` là snapshot từ template để nhiệm vụ hôm nay không đổi nếu template sync update giữa chừng.
- `status`: `pending`, `completed`, `skipped`.

### child_signals

Snapshot tín hiệu học tập gần đây của bé. Bảng này là input cho mission engine từ tuần 2 trở đi. Tuần đầu app dùng bộ mission mặc định để thu thập dữ liệu trước khi cá nhân hóa sâu.

```sql
child_signals (
  child_id TEXT PRIMARY KEY,
  accuracy_7d REAL NOT NULL DEFAULT 0,
  accuracy_by_topic TEXT NOT NULL DEFAULT '{}',
  accuracy_by_type TEXT NOT NULL DEFAULT '{}',
  avg_response_sec REAL NOT NULL DEFAULT 0,
  weak_topics TEXT NOT NULL DEFAULT '[]',
  due_for_review TEXT NOT NULL DEFAULT '[]',
  days_since_new_words INTEGER NOT NULL DEFAULT 0,
  streak_days INTEGER NOT NULL DEFAULT 0,
  streak_at_risk INTEGER NOT NULL DEFAULT 0,
  mission_completion_7d REAL NOT NULL DEFAULT 0,
  preferred_mission_types TEXT NOT NULL DEFAULT '[]',
  preferred_hour INTEGER NOT NULL DEFAULT 19,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY(child_id) REFERENCES child_profiles(id)
)
```

Mission engine local:

- Ngày 1: placement test ngắn 5 câu.
- Ngày 2: học 5 từ chủ đề Animals.
- Ngày 3: quiz 5 từ vừa học và học 3 từ mới.
- Ngày 4: matching game và nghe phát âm.
- Ngày 5: ôn tập tổng hợp tuần đầu.
- Từ ngày 8: đọc `child_signals`, ghép với `mission_templates`, sinh 4 mission theo slot cố định.
- Trước khi ghi `daily_missions`, engine kiểm tra rotation với mission hôm qua và giới hạn tổng thời lượng khoảng 20 phút/ngày.

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

### titles

Catalog danh hiệu. Danh hiệu khác achievement ở chỗ bé có thể "đeo" một danh hiệu chính và một danh hiệu phụ trên UI.

```sql
titles (
  id TEXT PRIMARY KEY,
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  type TEXT NOT NULL,
  tier INTEGER,
  image_url TEXT,
  animation TEXT,
  color_hex TEXT,
  description TEXT,
  flavor_text TEXT,
  unlock_condition_json TEXT NOT NULL,
  priority INTEGER NOT NULL DEFAULT 0,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER
)
```

Quy ước:

- `type`: `main` hoặc `sub`.
- `tier`: dùng cho danh hiệu `main`, thường map với level.
- `priority`: dùng để quyết định auto-equip danh hiệu `sub` mới nếu nhiều danh hiệu cùng unlock.
- `unlock_condition_json`: điều kiện unlock, lưu dạng JSON text trong Drift.

Ví dụ condition:

```json
{ "type": "level", "value": 10 }
{ "type": "streak", "value": 7 }
{ "type": "accuracy_7d", "value": 0.85 }
{ "type": "speed_pct", "value": 0.30 }
{ "type": "mission_days", "value": 5 }
```

Nếu cần nhiều điều kiện:

```json
{
  "all": [
    { "type": "level", "value": 10 },
    { "type": "accuracy_7d", "value": 0.85 }
  ]
}
```

### child_titles

Mapping danh hiệu đã unlock của từng bé.

```sql
child_titles (
  id TEXT PRIMARY KEY,
  child_id TEXT NOT NULL,
  title_id TEXT NOT NULL,
  title_type TEXT NOT NULL,
  unlocked_at INTEGER NOT NULL,
  is_equipped INTEGER NOT NULL DEFAULT 0,
  equipped_at INTEGER,
  remote_id TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  last_synced_at INTEGER,
  deleted_at INTEGER,
  UNIQUE(child_id, title_id),
  FOREIGN KEY(child_id) REFERENCES child_profiles(id),
  FOREIGN KEY(title_id) REFERENCES titles(id)
)
```

`title_type` được denormalize từ `titles.type` để xử lý rule equip nhanh hơn:

- Mỗi bé chỉ có một `main` title equipped.
- Mỗi bé chỉ có một `sub` title equipped.
- Khi equip title mới, app update `is_equipped = false` cho các title cùng `title_type`, rồi set title mới thành equipped trong cùng transaction.

Flow unlock:

```text
Cập nhật child_progress
-> lấy titles active chưa unlock
-> evaluate unlock_condition_json
-> đủ điều kiện: insert child_titles
-> main: auto-equip
-> sub: auto-equip nếu priority >= sub đang equipped
```

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
child_profiles 1 - n child_learning_paths
child_profiles 1 - n placement_sessions
child_profiles 1 - n daily_missions
child_profiles 1 - 1 child_progress
child_profiles 1 - n skill_progress
child_profiles 1 - n word_mastery
child_profiles 1 - n xp_events
child_profiles 1 - n learning_sessions
child_profiles 1 - n quiz_sessions
child_profiles 1 - n quiz_attempts
child_profiles 1 - n vocabulary_progress
child_profiles 1 - n daily_activity
child_profiles 1 - n child_titles

learning_paths 1 - n path_topics
learning_paths 1 - n child_learning_paths
learning_paths 1 - n placement_sessions
learning_paths 1 - n skill_targets
learning_paths 1 - n skill_progress
mission_templates 1 - n daily_missions
level_definitions 1 - n child_progress (qua child_progress.current_level)
topics 1 - n path_topics
topics 1 - n lessons
lessons 1 - n quiz_questions
lessons 1 - n vocabulary_items
lessons 1 - n lesson_progress
lessons 1 - n quiz_sessions
quiz_sessions 1 - n quiz_attempts
quiz_questions 1 - n quiz_attempts
vocabulary_items 1 - n vocabulary_progress
vocabulary_items 1 - n word_mastery
titles 1 - n child_titles
achievements 1 - n child_achievements
```

## Thứ Tự Implement Drift

1. `child_profiles`
2. `sync_versions`
3. `learning_paths`, `topics`, `path_topics`, `child_learning_paths`
4. `placement_sessions`
5. `lessons`, `quiz_questions`, `vocabulary_items`
6. `lesson_progress`
7. `level_definitions`, `word_mastery`, `child_progress`, `xp_events`
8. `skill_targets`, `skill_progress`
9. `mission_templates`, `daily_missions`, `child_signals`
10. `learning_sessions`, `quiz_sessions`, `quiz_attempts`
11. `vocabulary_progress`
12. `daily_activity`
13. `titles`, `child_titles`
14. `achievements`, `child_achievements`
15. `app_settings`, `asset_cache`, `parent_pins`

## Ghi Chú Cho Phase Hiện Tại

Phase hiện tại chỉ cần tối thiểu:

- `child_profiles`
- `sync_versions`
- `learning_paths`
- `path_topics`
- `child_learning_paths`
- `placement_sessions`
- `topics`
- `lessons`
- `quiz_questions`
- `vocabulary_items`
- `lesson_progress`
- `quiz_attempts`
- `level_definitions`
- `word_mastery`
- `child_progress`
- `xp_events`
- `skill_targets`
- `skill_progress`
- `mission_templates`
- `daily_missions`
- `titles`
- `child_titles`

Các bảng còn lại nên thiết kế sẵn trong tài liệu, nhưng có thể implement sau khi app cần dashboard, achievement, asset download hoặc sync API.
