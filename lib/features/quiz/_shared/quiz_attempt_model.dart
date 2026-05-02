/// Model chung để ghi quiz_attempts lên DB
/// Mọi quiz type đều map sang model này trước khi lưu
class QuizAttemptModel {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final int timeTakenMs;
  final Map<String, dynamic> answerGiven;
  final int xpEarned;

  const QuizAttemptModel({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.timeTakenMs,
    required this.answerGiven,
    required this.xpEarned,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'answer_given': answerGiven,
    'xp_earned': xpEarned,
  };
}
