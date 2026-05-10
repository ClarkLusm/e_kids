import 'package:equatable/equatable.dart';

/// Tham chiếu nhẹ đến 1 câu hỏi — dùng để run quiz trong lesson flow.
/// Không chứa content_json đầy đủ (load lazy khi vào quiz screen).
class QuestionRef extends Equatable {
  final String id;
  final String lessonId;
  final String quizType;
  final int difficulty;
  final int xpReward;
  final int? timeLimitSec;
  final int sortOrder;

  const QuestionRef({
    required this.id,
    required this.lessonId,
    required this.quizType,
    this.difficulty = 1,
    this.xpReward = 10,
    this.timeLimitSec,
    this.sortOrder = 0,
  });

  factory QuestionRef.fromJson(Map<String, dynamic> j) => QuestionRef(
    id: j['id'] as String,
    lessonId: j['lesson_id'] as String,
    quizType: j['quiz_type'] as String,
    difficulty: j['difficulty'] as int? ?? 1,
    xpReward: j['xp_reward'] as int? ?? 10,
    timeLimitSec: j['time_limit_sec'] as int?,
    sortOrder: j['sort_order'] as int? ?? 0,
  );

  /// Label hiển thị tên quiz type thân thiện
  String get quizTypeLabel => switch (quizType) {
    'picture_match' => 'Nhận biết từ',
    'listen_tap' => 'Nghe & chọn',
    'letter_scramble' => 'Ghép chữ',
    'fill_blank' => 'Điền chỗ trống',
    'speak_word' => 'Phát âm',
    'memory_flip' => 'Lật thẻ',
    'sort_bucket' => 'Phân loại',
    'word_pop' => 'Bắt bong bóng',
    'story_builder' => 'Xây câu chuyện',
    _ => quizType,
  };

  /// Icon emoji tương ứng
  String get quizTypeIcon => switch (quizType) {
    'picture_match' => '🖼',
    'listen_tap' => '🔊',
    'letter_scramble' => '🔤',
    'fill_blank' => '✏️',
    'speak_word' => '🎙',
    'memory_flip' => '🃏',
    'sort_bucket' => '🗂',
    'word_pop' => '🫧',
    'story_builder' => '📖',
    _ => '❓',
  };

  @override
  List<Object?> get props => [
    id,
    lessonId,
    quizType,
    difficulty,
    xpReward,
    sortOrder,
  ];
}
