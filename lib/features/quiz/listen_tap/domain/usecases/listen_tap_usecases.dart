import '../models/listen_tap_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class IListenTapRepository {
  Future<ListenTapContent> fetchById(String questionId);
}

abstract class IListenTapAttemptRepository {
  Future<void> saveResult(ListenTapResult result);
}

/// Interface service phát âm thanh — inject qua Riverpod
abstract class IAudioPlayerService {
  Future<void> play(String url);
  Future<void> stop();
  bool get isPlaying;
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class ListenTapResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect;
  final String selectedWord;
  final String correctWord;
  final int timeTakenMs;
  final int xpEarned;
  final int replayCount;

  const ListenTapResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.selectedWord,
    required this.correctWord,
    required this.timeTakenMs,
    required this.xpEarned,
    required this.replayCount,
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
      'replay_count': replayCount,
    },
  };
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchListenTapUseCase {
  final IListenTapRepository _repo;
  const FetchListenTapUseCase(this._repo);
  Future<ListenTapContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

class SaveListenTapResultUseCase {
  final IListenTapAttemptRepository _repo;
  const SaveListenTapResultUseCase(this._repo);
  Future<void> call(ListenTapResult result) => _repo.saveResult(result);
}
