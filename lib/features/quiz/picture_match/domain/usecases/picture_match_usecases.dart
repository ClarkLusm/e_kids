import '../models/picture_match_content.dart';

// ─── Repository interface ────────────────────────────────────────────────

abstract class IPictureMatchRepository {
  Future<PictureMatchContent> fetchById(String questionId);
}

// ─── UseCase: Fetch ───────────────────────────────────────────────────────

class FetchPictureMatchUseCase {
  final IPictureMatchRepository _repo;
  const FetchPictureMatchUseCase(this._repo);

  Future<PictureMatchContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class PictureMatchResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final String selectedWord;
  final String correctWord;
  final int timeTakenMs;
  final int xpEarned;

  const PictureMatchResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.selectedWord,
    required this.correctWord,
    required this.timeTakenMs,
    required this.xpEarned,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'selected_word': selectedWord,
      'correct_word': correctWord,
    },
  };
}

// ─── Repository interface (save) ─────────────────────────────────────────

abstract class IPictureMatchAttemptRepository {
  Future<void> saveResult(PictureMatchResult result);
}

// ─── UseCase: Save ────────────────────────────────────────────────────────

class SavePictureMatchResultUseCase {
  final IPictureMatchAttemptRepository _repo;
  const SavePictureMatchResultUseCase(this._repo);

  Future<void> call(PictureMatchResult result) => _repo.saveResult(result);
}
