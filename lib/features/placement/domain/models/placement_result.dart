class PlacementResult {
  const PlacementResult({
    required this.pathId,
    required this.pathTitle,
    required this.pathDescription,
    required this.levelLabel,
    required this.levelDescription,
    required this.score,
    required this.maxScore,
  });

  final String pathId;
  final String pathTitle;
  final String pathDescription;
  final String levelLabel;
  final String levelDescription;
  final int score;
  final int maxScore;

  double get scoreRatio => maxScore <= 0 ? 0 : score / maxScore;
}
