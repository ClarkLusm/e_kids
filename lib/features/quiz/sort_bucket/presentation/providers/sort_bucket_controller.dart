import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sort_bucket_repository.dart';
import '../../domain/models/sort_bucket_state.dart';
import '../../domain/usecases/sort_bucket_usecases.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final sortBucketRepoProvider = Provider<ISortBucketRepository>(
  (_) => MockSortBucketRepository(),
);

final sortBucketAttemptRepoProvider = Provider<ISortBucketAttemptRepository>(
  (_) => MockSortBucketAttemptRepository(),
);

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchSortBucketProvider = Provider<FetchSortBucketUseCase>(
  (ref) => FetchSortBucketUseCase(ref.read(sortBucketRepoProvider)),
);

final saveSortBucketProvider = Provider<SaveSortBucketResultUseCase>(
  (ref) => SaveSortBucketResultUseCase(ref.read(sortBucketAttemptRepoProvider)),
);

// ─── Controller ───────────────────────────────────────────────────────────

final sortBucketControllerProvider =
    AsyncNotifierProviderFamily<SortBucketController, SortBucketState, String>(
      SortBucketController.new,
    );

class SortBucketController
    extends FamilyAsyncNotifier<SortBucketState, String> {
  late final Stopwatch _stopwatch;

  @override
  Future<SortBucketState> build(String questionId) async {
    _stopwatch = Stopwatch()..start();
    final content = await ref.read(fetchSortBucketProvider).call(questionId);
    return SortBucketState(content);
  }

  // ─── Đặt item vào bucket ──────────────────────────────────────────

  void placeItem(String itemId, String bucketId) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final placement = gs.placements[itemId];
    if (placement == null) return;

    // Cập nhật bucketId cho item
    placement.bucketId = bucketId;
    gs.hoveredBucketId = null;

    state = AsyncData(gs);

    // Tự động chấm khi tất cả items đã được đặt
    if (gs.isAllPlaced) {
      _checkAnswers(gs);
    }
  }

  // ─── Lấy item ra khỏi bucket (drag back ra pool) ─────────────────

  void removeItemFromBucket(String itemId) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final placement = gs.placements[itemId];
    if (placement == null) return;

    placement.bucketId = null;
    placement.result = ItemResult.pending;
    state = AsyncData(gs);
  }

  // ─── Di chuyển item giữa 2 bucket ───────────────────────────────

  void moveItemToBucket({
    required String itemId,
    required String targetBucketId,
  }) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final placement = gs.placements[itemId];
    if (placement == null) return;

    placement.bucketId = targetBucketId;
    placement.result = ItemResult.pending;
    gs.hoveredBucketId = null;

    state = AsyncData(gs);

    if (gs.isAllPlaced) {
      _checkAnswers(gs);
    }
  }

  // ─── Cập nhật hover bucket ────────────────────────────────────────

  void setHoveredBucket(String? bucketId) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;
    gs.hoveredBucketId = bucketId;
    state = AsyncData(gs);
  }

  // ─── Manual submit (nếu cần) ──────────────────────────────────────

  Future<void> submitAll() async {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;
    if (!gs.isAllPlaced) return;
    _checkAnswers(gs);
  }

  // ─── Chấm điểm ───────────────────────────────────────────────────

  void _checkAnswers(SortBucketState gs) {
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;

    // Đánh dấu kết quả từng item
    for (final item in gs.content.items) {
      final placement = gs.placements[item.id]!;
      placement.result = placement.bucketId == item.correctBucketId
          ? ItemResult.correct
          : ItemResult.wrong;
    }

    gs.xpEarned = _calcXp(gs);
    gs.status = SortBucketStatus.complete;
    state = AsyncData(gs);

    _saveResult(gs);
  }

  // ─── Retry ───────────────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final content = await ref.read(fetchSortBucketProvider).call(arg);
    state = AsyncData(SortBucketState(content));
  }

  // ─── Helpers ─────────────────────────────────────────────────────

  int _calcXp(SortBucketState gs) {
    if (gs.content.allowPartialScore) {
      // Tính theo tỉ lệ: mỗi item đúng = 10 XP
      const xpPerItem = 10;
      var xp = gs.correctCount * xpPerItem;
      // Bonus nếu tất cả đúng
      if (gs.correctCount == gs.content.items.length) xp += 20;
      return xp;
    } else {
      // All-or-nothing
      return gs.correctCount == gs.content.items.length ? 50 : 0;
    }
  }

  void _saveResult(SortBucketState gs) {
    final placements = <String, String>{};
    for (final entry in gs.placements.entries) {
      if (entry.value.bucketId != null) {
        placements[entry.key] = entry.value.bucketId!;
      }
    }

    ref
        .read(saveSortBucketProvider)
        .call(
          SortBucketResult(
            childId: 'mock_child_id',
            questionId: arg,
            isCorrect: gs.correctCount == gs.content.items.length,
            correctCount: gs.correctCount,
            totalCount: gs.content.items.length,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
            placements: placements,
          ),
        );
  }
}
