import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/sort_bucket_state.dart';
import '../../presentation/providers/sort_bucket_controller.dart';
import '../../presentation/widgets/bucket_zone_widget.dart';
import '../../presentation/widgets/draggable_item_widget.dart';
import '../../presentation/widgets/sort_bucket_result_sheet.dart';

class SortBucketScreen extends ConsumerStatefulWidget {
  final String questionId;
  final int totalQuestions;
  final int currentIndex;
  final VoidCallback? onNext;

  const SortBucketScreen({
    required this.questionId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<SortBucketScreen> createState() => _SortBucketScreenState();
}

class _SortBucketScreenState extends ConsumerState<SortBucketScreen> {
  final GlobalKey _bucketsKey = GlobalKey();
  bool _resultShown = false;

  SortBucketController get _ctrl =>
      ref.read(sortBucketControllerProvider(widget.questionId).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      sortBucketControllerProvider(widget.questionId),
    );

    // Hiện result sheet ngay khi isComplete
    asyncState.whenData((gs) {
      if (gs.isComplete && !_resultShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showResultSheet(context, gs);
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(sortBucketControllerProvider(widget.questionId)),
        ),
        data: (gs) => _buildBody(context, gs),
      ),
    );
  }

  // ─── AppBar ────────────────────────────────────────────────────────

  AppBar _buildAppBar() => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.close_rounded, color: Colors.grey),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: _ProgressBar(
      current: widget.currentIndex,
      total: widget.totalQuestions,
    ),
  );

  // ─── Body ──────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, SortBucketState gs) {
    final unplaced = gs.unplacedItems;
    final bucketCount = gs.content.buckets.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Label
            const Text(
              'Kéo từ vào đúng nhóm',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF534AB7),
              ),
            ),
            const SizedBox(height: 6),

            // Progress indicator (items đã xếp / tổng)
            _PlacementProgress(
              placed: gs.content.items.length - unplaced.length,
              total: gs.content.items.length,
            ),
            const SizedBox(height: 14),

            // Bucket zones — grid tự điều chỉnh theo số bucket
            Expanded(
              flex: 3,
              child: key_widget(
                key: _bucketsKey,
                child: _BucketGrid(
                  state: gs,
                  bucketCount: bucketCount,
                  onDrop: _ctrl.placeItem,
                  onHoverEnter: _ctrl.setHoveredBucket,
                  onHoverExit: () => _ctrl.setHoveredBucket(null),
                  onItemRemove: _ctrl.removeItemFromBucket,
                  onItemMove: _ctrl.moveItemToBucket,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade200)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    unplaced.isEmpty ? 'Đã xếp hết ✓' : 'Chưa xếp',
                    style: TextStyle(
                      fontSize: 12,
                      color: unplaced.isEmpty
                          ? const Color(0xFF1D9E75)
                          : Colors.grey.shade400,
                      fontWeight: unplaced.isEmpty
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade200)),
              ],
            ),
            const SizedBox(height: 10),

            // Pool item cards
            Expanded(
              flex: 2,
              child: unplaced.isEmpty
                  ? const _AllPlacedHint()
                  : SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: unplaced
                            .map(
                              (item) => DraggableItemWidget(
                                key: ValueKey(item.id),
                                item: item,
                                isEnabled: !gs.isComplete,
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Result sheet ──────────────────────────────────────────────────

  void _showResultSheet(BuildContext context, SortBucketState gs) {
    if (_resultShown) return;
    _resultShown = true;

    // XP animation
    if (gs.xpEarned > 0) {
      final box = _bucketsKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final center = box.localToGlobal(
          Offset(box.size.width / 2, box.size.height / 2),
        );
        XpOverlayHelper.show(
          context,
          xpAmount: gs.xpEarned,
          startOffset: center,
        );
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => SortBucketResultSheet(
        gameState: gs,
        onReplay: () {
          Navigator.of(context).pop();
          _resultShown = false;
          _ctrl.retry();
        },
        onNext: () {
          Navigator.of(context).pop();
          if (widget.onNext != null) {
            widget.onNext!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

// ─── Wrapper với key support ──────────────────────────────────────────────

Widget key_widget({Key? key, required Widget child}) =>
    KeyedSubtree(key: key, child: child);

// ─── Bucket grid layout ───────────────────────────────────────────────────

class _BucketGrid extends StatelessWidget {
  final SortBucketState state;
  final int bucketCount;
  final void Function(String itemId, String bucketId) onDrop;
  final void Function(String bucketId) onHoverEnter;
  final VoidCallback onHoverExit;
  final void Function(String itemId) onItemRemove;
  final void Function({required String itemId, required String targetBucketId})
  onItemMove;

  const _BucketGrid({
    required this.state,
    required this.bucketCount,
    required this.onDrop,
    required this.onHoverEnter,
    required this.onHoverExit,
    required this.onItemRemove,
    required this.onItemMove,
  });

  @override
  Widget build(BuildContext context) {
    // 2 bucket → 1 column, 3–4 bucket → 2 columns
    final crossCount = bucketCount <= 2 ? 1 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: bucketCount <= 2 ? 2.2 : 1.4,
      ),
      itemCount: state.content.buckets.length,
      itemBuilder: (ctx, i) {
        final bucket = state.content.buckets[i];
        final placed = state.itemsInBucket(bucket.id);

        return BucketZoneWidget(
          bucket: bucket,
          placedItems: placed,
          isHovered: state.hoveredBucketId == bucket.id,
          isComplete: state.isComplete,
          onDrop: onDrop,
          onHoverEnter: onHoverEnter,
          onHoverExit: onHoverExit,
          onItemRemove: onItemRemove,
        );
      },
    );
  }
}

// ─── Progress indicator ───────────────────────────────────────────────────

class _PlacementProgress extends StatelessWidget {
  final int placed;
  final int total;
  const _PlacementProgress({required this.placed, required this.total});

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0.0 : placed / total;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 5,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                pct == 1.0 ? const Color(0xFF1D9E75) : const Color(0xFF534AB7),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$placed/$total',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── All placed hint ──────────────────────────────────────────────────────

class _AllPlacedHint extends StatelessWidget {
  const _AllPlacedHint();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 32,
            color: Color(0xFF1D9E75),
          ),
          SizedBox(height: 6),
          Text(
            'Đã xếp hết tất cả từ!',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1D9E75),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Loading ──────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: Color(0xFF534AB7)),
        SizedBox(height: 16),
        Text('Đang tải bài quiz...', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}

// ─── Error ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: Color(0xFFE24B4A),
          ),
          const SizedBox(height: 12),
          const Text(
            'Không tải được câu hỏi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Thử lại'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF534AB7),
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Progress bar ─────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: current / total,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF534AB7)),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        '$current/$total',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
