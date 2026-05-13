import 'package:drift/drift.dart';

import '../app_database.dart';

class QuizAttemptWrite {
  const QuizAttemptWrite({
    required this.id,
    required this.childId,
    required this.lessonId,
    required this.questionId,
    required this.quizType,
    required this.isCorrect,
    required this.xpEarned,
    required this.timeTakenMs,
    required this.answerJson,
    this.sessionId,
    this.attemptIndex = 1,
    this.isCompleted = true,
    this.score = 0,
    this.stars = 0,
    this.hintsUsed = 0,
  });

  final String id;
  final String childId;
  final String? sessionId;
  final String lessonId;
  final String questionId;
  final String quizType;
  final int attemptIndex;
  final bool isCorrect;
  final bool isCompleted;
  final int score;
  final int stars;
  final int xpEarned;
  final int timeTakenMs;
  final int hintsUsed;
  final String? answerJson;
}

class QuizAttemptsDao {
  const QuizAttemptsDao(this._db);

  final AppDatabase _db;

  Future<void> insertAttempt(QuizAttemptWrite attempt) async {
    await _db
        .into(_db.quizAttempts)
        .insert(
          QuizAttemptsCompanion.insert(
            id: attempt.id,
            childId: attempt.childId,
            lessonId: attempt.lessonId,
            questionId: attempt.questionId,
            quizType: attempt.quizType,
            isCorrect: attempt.isCorrect,
            xpEarned: Value(attempt.xpEarned),
            timeTakenMs: Value(attempt.timeTakenMs),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            sessionId: Value(attempt.sessionId),
            attemptIndex: Value(attempt.attemptIndex),
            isCompleted: Value(attempt.isCompleted),
            score: Value(attempt.score),
            stars: Value(attempt.stars),
            hintsUsed: Value(attempt.hintsUsed),
            answerJson: Value(attempt.answerJson),
            syncStatus: const Value('pending'),
          ),
        );
  }

  Future<List<QuizAttempt>> getAttemptsForChild(String childId) {
    return (_db.select(_db.quizAttempts)
          ..where((tbl) => tbl.childId.equals(childId))
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.createdAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }
}
