import 'memory_flip_pair.dart';
import 'score_config.dart';

class MemoryFlipContent {
  const MemoryFlipContent({
    required this.quizId,
    required this.pairs,
    required this.scoreConfig,
    this.title,
    this.timeLimitSeconds = 60,
  });

  final String quizId;
  final String? title;
  final List<MemoryFlipPair> pairs;
  final ScoreConfig scoreConfig;
  final int timeLimitSeconds;

  factory MemoryFlipContent.fromJson(Map<String, dynamic> json) {
    final rawPairs = (json['pairs'] as List<dynamic>? ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MemoryFlipPair.fromJson)
        .toList();

    return MemoryFlipContent(
      quizId: (json['quiz_id'] ?? json['id'] ?? '').toString(),
      title: json['title']?.toString(),
      pairs: rawPairs,
      scoreConfig: ScoreConfig.fromJson(
        (json['score_config'] as Map<String, dynamic>?) ?? const {},
      ),
      timeLimitSeconds: (json['time_limit_seconds'] as num?)?.toInt() ?? 60,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz_id': quizId,
      'title': title,
      'pairs': pairs.map((pair) => pair.toJson()).toList(),
      'score_config': scoreConfig.toJson(),
      'time_limit_seconds': timeLimitSeconds,
    };
  }
}
