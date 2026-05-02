class QuizAttemptModel {
  const QuizAttemptModel({
    required this.attemptId,
    required this.userId,
    required this.lessonId,
    required this.quizId,
    required this.score,
    required this.durationSeconds,
    required this.isPassed,
    required this.createdAt,
  });

  final String attemptId;
  final String userId;
  final String lessonId;
  final String quizId;
  final int score;
  final int durationSeconds;
  final bool isPassed;
  final DateTime createdAt;

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      attemptId: (json['attempt_id'] ?? '').toString(),
      userId: (json['user_id'] ?? '').toString(),
      lessonId: (json['lesson_id'] ?? '').toString(),
      quizId: (json['quiz_id'] ?? '').toString(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
      isPassed: json['is_passed'] == true,
      createdAt:
          DateTime.tryParse((json['created_at'] ?? '').toString()) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attempt_id': attemptId,
      'user_id': userId,
      'lesson_id': lessonId,
      'quiz_id': quizId,
      'score': score,
      'duration_seconds': durationSeconds,
      'is_passed': isPassed,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
