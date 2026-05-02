class ScoreConfig {
  const ScoreConfig({
    this.pointsPerMatch = 10,
    this.hintPenalty = 2,
    this.timeBonusPerSecond = 1,
  });

  final int pointsPerMatch;
  final int hintPenalty;
  final int timeBonusPerSecond;

  factory ScoreConfig.fromJson(Map<String, dynamic> json) {
    return ScoreConfig(
      pointsPerMatch: (json['points_per_match'] as num?)?.toInt() ?? 10,
      hintPenalty: (json['hint_penalty'] as num?)?.toInt() ?? 2,
      timeBonusPerSecond: (json['time_bonus_per_second'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points_per_match': pointsPerMatch,
      'hint_penalty': hintPenalty,
      'time_bonus_per_second': timeBonusPerSecond,
    };
  }
}
