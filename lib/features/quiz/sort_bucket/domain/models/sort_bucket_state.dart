import 'sort_bucket_content.dart';
import 'sort_bucket_entities.dart';

enum SortBucketStatus {
  playing, // đang kéo thả
  checking, // đang chấm điểm (ngắn)
  complete, // tất cả đã đặt vào bucket
}

/// Trạng thái của từng item sau khi submit
enum ItemResult {
  pending, // chưa xếp
  correct, // xếp đúng
  wrong, // xếp sai
}

/// Vị trí đặt của 1 item — nằm ở bucket nào
class ItemPlacement {
  final String itemId;
  String? bucketId; // null = chưa xếp (còn trong pool)
  ItemResult result;

  ItemPlacement({
    required this.itemId,
    this.bucketId,
    this.result = ItemResult.pending,
  });
}

class SortBucketState {
  final SortBucketContent content;

  /// Items đã shuffle trong pool ban đầu
  final List<SortItem> poolItems;

  /// Map itemId → placement
  final Map<String, ItemPlacement> placements;

  SortBucketStatus status;
  int timeTakenMs;
  int xpEarned;

  SortBucketState(this.content)
    : poolItems = List<SortItem>.from(content.items)..shuffle(),
      placements = {
        for (final item in content.items)
          item.id: ItemPlacement(itemId: item.id),
      },
      status = SortBucketStatus.playing,
      timeTakenMs = 0,
      xpEarned = 0;

  // ─── Computed ─────────────────────────────────────────────────────

  bool get isComplete => status == SortBucketStatus.complete;

  bool get isAllPlaced => placements.values.every((p) => p.bucketId != null);

  /// Items còn trong pool (chưa xếp vào bucket nào)
  List<SortItem> get unplacedItems => content.items
      .where((item) => placements[item.id]?.bucketId == null)
      .toList();

  /// Items đã được xếp vào một bucket cụ thể
  List<SortItem> itemsInBucket(String bucketId) => content.items
      .where((item) => placements[item.id]?.bucketId == bucketId)
      .toList();

  /// Số item đúng
  int get correctCount =>
      placements.values.where((p) => p.result == ItemResult.correct).length;

  /// Số item sai
  int get wrongCount =>
      placements.values.where((p) => p.result == ItemResult.wrong).length;

  /// Tỉ lệ đúng (0.0 – 1.0)
  double get accuracy =>
      content.items.isEmpty ? 0 : correctCount / content.items.length;

  /// Trạng thái hiển thị của 1 item trong bucket
  ItemResult resultOf(String itemId) =>
      placements[itemId]?.result ?? ItemResult.pending;

  /// Bucket đang có item nào đang hover (drag over)
  String? hoveredBucketId;
}
