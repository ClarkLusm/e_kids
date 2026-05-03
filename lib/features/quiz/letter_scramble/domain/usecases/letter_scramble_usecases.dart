import '../models/letter_scramble_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class ILetterScrambleRepository {
  Future<LetterScrambleContent> fetchById(String questionId);
}

abstract class ILetterScrambleAttemptRepository {
  Future<void> saveResult(LetterScrambleResult result);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class LetterScrambleResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final String submittedWord;
  final String correctWord;
  final int timeTakenMs;
  final int xpEarned;
  final int hintsUsed;
  final int wrongAttempts;

  const LetterScrambleResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.submittedWord,
    required this.correctWord,
    required this.timeTakenMs,
    required this.xpEarned,
    required this.hintsUsed,
    required this.wrongAttempts,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'submitted_word': submittedWord,
      'correct_word': correctWord,
      'hints_used': hintsUsed,
      'wrong_attempts': wrongAttempts,
    },
  };
}

// ─── Use Cases ────────────────────────────────────────────────────────────

class FetchLetterScrambleUseCase {
  final ILetterScrambleRepository _repo;
  const FetchLetterScrambleUseCase(this._repo);

  Future<LetterScrambleContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

class SaveLetterScrambleResultUseCase {
  final ILetterScrambleAttemptRepository _repo;
  const SaveLetterScrambleResultUseCase(this._repo);

  Future<void> call(LetterScrambleResult result) => _repo.saveResult(result);
}
