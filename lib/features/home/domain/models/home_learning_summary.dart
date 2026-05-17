class HomeLearningSummary {
  const HomeLearningSummary({
    required this.totalXp,
    required this.completedLessons,
    required this.currentLevel,
    required this.nextLevel,
    required this.levelTitle,
    required this.nextLevelTitle,
    required this.levelProgressPercent,
    required this.accuracy7Days,
    required this.masteredWords,
  });

  final int totalXp;
  final int completedLessons;
  final int currentLevel;
  final int nextLevel;
  final String levelTitle;
  final String? nextLevelTitle;
  final int levelProgressPercent;
  final double accuracy7Days;
  final int masteredWords;

  static const empty = HomeLearningSummary(
    totalXp: 0,
    completedLessons: 0,
    currentLevel: 1,
    nextLevel: 2,
    levelTitle: 'Beginner',
    nextLevelTitle: 'Explorer',
    levelProgressPercent: 0,
    accuracy7Days: 0,
    masteredWords: 0,
  );

  int get level => currentLevel;
  double get levelProgress => (levelProgressPercent / 100).clamp(0.0, 1.0);
}
