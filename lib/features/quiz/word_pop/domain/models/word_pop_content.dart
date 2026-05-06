import 'package:equatable/equatable.dart';

/// Một bong bóng chữ trong game word pop.
class WordPopBubble extends Equatable {
  final String word;
  final bool isTarget;

  /// Hệ số tốc độ nổi lên (1.0 = bình thường, 1.5 = nhanh hơn 50%)
  final double speed;

  const WordPopBubble({
    required this.word,
    required this.isTarget,
    this.speed = 1.0,
  });

  factory WordPopBubble.fromJson(Map<String, dynamic> json) => WordPopBubble(
    word: json['word'] as String,
    isTarget: json['is_target'] as bool,
    speed: (json['speed'] as num?)?.toDouble() ?? 1.0,
  );

  Map<String, dynamic> toJson() => {
    'word': word,
    'is_target': isTarget,
    'speed': speed,
  };

  @override
  List<Object?> get props => [word, isTarget, speed];
}

/// Model cho quiz word_pop — bong bóng nổi lên, chạm đúng từ mục tiêu.
///
/// JSON mẫu:
/// ```json
/// {
///   "instruction": "Tap all ANIMALS!",
///   "instruction_vi": "Chạm vào tất cả ĐỘNG VẬT!",
///   "target_category": "animals",
///   "bubbles": [
///     { "word": "dog",   "is_target": true,  "speed": 1.0 },
///     { "word": "pizza", "is_target": false, "speed": 0.8 },
///     { "word": "cat",   "is_target": true,  "speed": 1.2 }
///   ],
///   "spawn_interval_ms": 1200,
///   "miss_penalty": false
/// }
/// ```
class WordPopContent extends Equatable {
  final String instruction;
  final String? instructionVi;
  final String? targetCategory;
  final List<WordPopBubble> bubbles;

  /// Khoảng cách ms giữa mỗi lần spawn bubble mới
  final int spawnIntervalMs;

  /// Trừ điểm khi chạm nhầm bubble không phải target
  final bool missPenalty;

  const WordPopContent({
    required this.instruction,
    this.instructionVi,
    this.targetCategory,
    required this.bubbles,
    this.spawnIntervalMs = 1500,
    this.missPenalty = false,
  }) : assert(
         bubbles.length >= 5 && bubbles.length <= 12,
         'Số bubble phải từ 5–12',
       );

  factory WordPopContent.fromJson(Map<String, dynamic> json) {
    final bubbles = (json['bubbles'] as List)
        .map((b) => WordPopBubble.fromJson(b as Map<String, dynamic>))
        .toList();

    return WordPopContent(
      instruction: json['instruction'] as String,
      instructionVi: json['instruction_vi'] as String?,
      targetCategory: json['target_category'] as String?,
      bubbles: bubbles,
      spawnIntervalMs: json['spawn_interval_ms'] as int? ?? 1500,
      missPenalty: json['miss_penalty'] as bool? ?? false,
    );
  }

  static WordPopContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'word_pop');
    return WordPopContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'instruction': instruction,
    if (instructionVi != null) 'instruction_vi': instructionVi,
    if (targetCategory != null) 'target_category': targetCategory,
    'bubbles': bubbles.map((b) => b.toJson()).toList(),
    'spawn_interval_ms': spawnIntervalMs,
    'miss_penalty': missPenalty,
  };

  int get targetCount => bubbles.where((b) => b.isTarget).length;
  int get nonTargetCount => bubbles.where((b) => !b.isTarget).length;

  @override
  List<Object?> get props => [
    instruction,
    instructionVi,
    targetCategory,
    bubbles,
    spawnIntervalMs,
    missPenalty,
  ];
}
