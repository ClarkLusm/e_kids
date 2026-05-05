import '../models/speak_word_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class ISpeakWordRepository {
  Future<SpeakWordContent> fetchById(String questionId);
}

abstract class ISpeakWordAttemptRepository {
  Future<void> saveResult(SpeakWordResult result);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class SpeakWordResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final String targetWord;
  final String? bestTranscript;
  final double bestSimilarity;
  final int attemptCount;
  final int timeTakenMs;
  final int xpEarned;

  const SpeakWordResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.targetWord,
    this.bestTranscript,
    required this.bestSimilarity,
    required this.attemptCount,
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
      'target_word': targetWord,
      'best_transcript': bestTranscript,
      'best_similarity': bestSimilarity,
      'attempt_count': attemptCount,
    },
  };
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchSpeakWordUseCase {
  final ISpeakWordRepository _repo;
  const FetchSpeakWordUseCase(this._repo);
  Future<SpeakWordContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

class SaveSpeakWordResultUseCase {
  final ISpeakWordAttemptRepository _repo;
  const SaveSpeakWordResultUseCase(this._repo);
  Future<void> call(SpeakWordResult result) => _repo.saveResult(result);
}
