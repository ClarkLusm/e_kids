import '../../../lesson/domain/models/lesson_models.dart';

class PathTopicSummary {
  const PathTopicSummary({
    required this.topic,
    required this.completedLessons,
    required this.totalLessons,
    required this.totalXpReward,
  });

  final Topic topic;
  final int completedLessons;
  final int totalLessons;
  final int totalXpReward;

  double get progress =>
      totalLessons == 0 ? 0 : (completedLessons / totalLessons).clamp(0, 1);
}
