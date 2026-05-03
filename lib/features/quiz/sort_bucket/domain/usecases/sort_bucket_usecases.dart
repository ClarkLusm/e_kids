import '../models/sort_bucket_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class ISortBucketRepository {
  Future<SortBucketContent> fetchById(String questionId);
}

abstract class ISortBucketAttemptRepository {
  Future<void> saveResult(SortBucketResult result);
}

// ─── DTO kết quả ─────────────────────────────────────────────────────────

class SortBucketResult {
  final String childId;
  final String questionId;
  final String? sessionId;
  final bool isCorrect; // true nếu tất cả đúng
  final int correctCount;
  final int totalCount;
  final int timeTakenMs;
  final int xpEarned;
  final Map<String, String> placements; // itemId → bucketId

  const SortBucketResult({
    required this.childId,
    required this.questionId,
    this.sessionId,
    required this.isCorrect,
    required this.correctCount,
    required this.totalCount,
    required this.timeTakenMs,
    required this.xpEarned,
    required this.placements,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    if (sessionId != null) 'session_id': sessionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'correct_count': correctCount,
      'total_count': totalCount,
      'placements': placements,
    },
  };
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchSortBucketUseCase {
  final ISortBucketRepository _repo;
  const FetchSortBucketUseCase(this._repo);
  Future<SortBucketContent> call(String questionId) =>
      _repo.fetchById(questionId);
}

class SaveSortBucketResultUseCase {
  final ISortBucketAttemptRepository _repo;
  const SaveSortBucketResultUseCase(this._repo);
  Future<void> call(SortBucketResult result) => _repo.saveResult(result);
}
