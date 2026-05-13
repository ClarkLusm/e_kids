import '../models/word_pop_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class IWordPopRepository {
  Future<WordPopContent> fetchById(String questionId);
}

abstract class IWordPopAttemptRepository {
  Future<void> saveResult(WordPopResult result);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class WordPopResult {
  final String childId;
  final String lessonId;
  final String questionId;
  final bool isCorrect;
  final int score;
  final int targetsHit;
  final int totalTargets;
  final int wrongTaps;
  final int missedTargets;
  final int timeTakenMs;
  final int xpEarned;

  const WordPopResult({
    required this.childId,
    required this.lessonId,
    required this.questionId,
    required this.isCorrect,
    required this.score,
    required this.targetsHit,
    required this.totalTargets,
    required this.wrongTaps,
    required this.missedTargets,
    required this.timeTakenMs,
    required this.xpEarned,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'lesson_id': lessonId,
    'question_id': questionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'score': score,
      'targets_hit': targetsHit,
      'total_targets': totalTargets,
      'wrong_taps': wrongTaps,
      'missed_targets': missedTargets,
    },
  };
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchWordPopUseCase {
  final IWordPopRepository _repo;
  const FetchWordPopUseCase(this._repo);
  Future<WordPopContent> call(String id) => _repo.fetchById(id);
}

class SaveWordPopResultUseCase {
  final IWordPopAttemptRepository _repo;
  const SaveWordPopResultUseCase(this._repo);
  Future<void> call(WordPopResult r) => _repo.saveResult(r);
}
