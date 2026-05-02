import 'package:equatable/equatable.dart';
import 'memory_flip_pair.dart';
import 'score_config.dart';

enum GridSize {
  g3x2(cols: 3, rows: 2),
  g4x2(cols: 4, rows: 2),
  g4x3(cols: 4, rows: 3),
  g4x4(cols: 4, rows: 4),
  g5x4(cols: 5, rows: 4);

  const GridSize({required this.cols, required this.rows});

  final int cols;
  final int rows;

  int get totalCards => cols * rows;
  int get pairCount => totalCards ~/ 2;

  /// Chuyển từ string "4x3" → GridSize.g4x3
  static GridSize fromString(String s) {
    final key = 'g${s.replaceAll('x', 'x')}';
    return GridSize.values.firstWhere(
      (e) => e.name == key,
      orElse: () => throw ArgumentError('GridSize không hợp lệ: $s'),
    );
  }

  /// Chuyển ngược về "4x3"
  String toJsonString() => name.substring(1); // bỏ chữ 'g' đầu
}

class MemoryFlipContent extends Equatable {
  final GridSize gridSize;
  final List<MemoryFlipPair> pairs;
  final String? theme;
  final int flipDurationMs;
  final int previewDurationMs;
  final int mismatchHideMs;
  final int? maxFlips;
  final ScoreConfig scoreConfig;
  final AccessibilityConfig accessibility;

  const MemoryFlipContent({
    required this.gridSize,
    required this.pairs,
    this.theme,
    this.flipDurationMs = 700,
    this.previewDurationMs = 0,
    this.mismatchHideMs = 1000,
    this.maxFlips,
    this.scoreConfig = const ScoreConfig(),
    this.accessibility = const AccessibilityConfig(),
  });

  factory MemoryFlipContent.fromJson(Map<String, dynamic> json) {
    final gridSize = GridSize.fromString(json['grid_size'] as String);
    final pairs = (json['pairs'] as List)
        .map((p) => MemoryFlipPair.fromJson(p as Map<String, dynamic>))
        .toList();

    assert(
      pairs.length == gridSize.pairCount,
      'pairs.length (${pairs.length}) phải bằng ${gridSize.pairCount} với grid ${gridSize.toJsonString()}',
    );

    final scoreJson = json['score_config'];
    final accessJson = json['accessibility'];

    return MemoryFlipContent(
      gridSize: gridSize,
      pairs: pairs,
      theme: json['theme'] as String?,
      flipDurationMs: json['flip_duration_ms'] as int? ?? 700,
      previewDurationMs: json['preview_duration_ms'] as int? ?? 0,
      mismatchHideMs: json['mismatch_hide_ms'] as int? ?? 1000,
      maxFlips: json['max_flips'] as int?,
      scoreConfig: scoreJson != null
          ? ScoreConfig.fromJson(scoreJson as Map<String, dynamic>)
          : const ScoreConfig(),
      accessibility: accessJson != null
          ? AccessibilityConfig.fromJson(accessJson as Map<String, dynamic>)
          : const AccessibilityConfig(),
    );
  }

  /// Shortcut: parse trực tiếp từ question row của DB
  static MemoryFlipContent fromQuestion(Map<String, dynamic> question) {
    assert(
      question['quiz_type'] == 'memory_flip',
      'quiz_type phải là memory_flip',
    );
    return MemoryFlipContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'grid_size': gridSize.toJsonString(),
    'pairs': pairs.map((p) => p.toJson()).toList(),
    if (theme != null) 'theme': theme,
    'flip_duration_ms': flipDurationMs,
    'preview_duration_ms': previewDurationMs,
    'mismatch_hide_ms': mismatchHideMs,
    if (maxFlips != null) 'max_flips': maxFlips,
    'score_config': scoreConfig.toJson(),
    'accessibility': accessibility.toJson(),
  };

  @override
  List<Object?> get props => [
    gridSize,
    pairs,
    theme,
    flipDurationMs,
    previewDurationMs,
    mismatchHideMs,
    maxFlips,
    scoreConfig,
    accessibility,
  ];
}
