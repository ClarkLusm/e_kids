import '../models/fill_blank_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class IFillBlankRepository {
  Future<FillBlankContent> fetchById(String questionId);
}

abstract class IFillBlankAttemptRepository {
  Future<void> saveResult(FillBlankResult result);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class FillBlankResult {
  final String childId;
  final String lessonId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final String selectedWord;
  final String correctWord;
  final int timeTakenMs;
  final int xpEarned;
  final int hintsUsed;

  const FillBlankResult({
    required this.childId,
    required this.lessonId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.selectedWord,
    required this.correctWord,
    required this.timeTakenMs,
    required this.xpEarned,
    required this.hintsUsed,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'lesson_id': lessonId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'selected_word': selectedWord,
      'correct_word': correctWord,
      'hints_used': hintsUsed,
    },
  };
}

// ─── Use Cases ────────────────────────────────────────────────────────────

class FetchFillBlankUseCase {
  final IFillBlankRepository _repo;
  const FetchFillBlankUseCase(this._repo);

  Future<FillBlankContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

class SaveFillBlankResultUseCase {
  final IFillBlankAttemptRepository _repo;
  const SaveFillBlankResultUseCase(this._repo);

  Future<void> call(FillBlankResult result) => _repo.saveResult(result);
}
