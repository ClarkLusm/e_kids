/// DTO gửi lên DB sau khi hoàn thành ván
class MemoryFlipResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final int flipCount;
  final int elapsedSec;
  final int xpEarned;
  final int stars;
  final bool isComplete;

  const MemoryFlipResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.flipCount,
    required this.elapsedSec,
    required this.xpEarned,
    required this.stars,
    required this.isComplete,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isComplete,
    'time_taken_ms': elapsedSec * 1000,
    'xp_earned': xpEarned,
    'answer_given': {
      'flip_count': flipCount,
      'elapsed_sec': elapsedSec,
      'stars': stars,
    },
  };
}

/// Interface repository
abstract class IQuizAttemptRepository {
  Future<void> saveResult(MemoryFlipResult result);
}

/// Use case: ghi kết quả quiz_attempts lên DB
class SaveMemoryFlipResultUseCase {
  final IQuizAttemptRepository _repository;

  const SaveMemoryFlipResultUseCase(this._repository);

  Future<void> call(MemoryFlipResult result) => _repository.saveResult(result);
}
