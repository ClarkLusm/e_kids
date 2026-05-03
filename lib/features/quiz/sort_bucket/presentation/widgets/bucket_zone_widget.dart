import 'package:flutter/material.dart';
import '../../domain/models/sort_bucket_entities.dart';
import '../../domain/models/sort_bucket_state.dart';

/// Vùng drop target đại diện cho 1 bucket.
/// Hiện tên bucket, màu sắc, danh sách item đã xếp vào.
class BucketZoneWidget extends StatelessWidget {
  final SortBucket bucket;
  final List<SortItem> placedItems;
  final bool isHovered;
  final bool isComplete;
  final void Function(String itemId, String bucketId) onDrop;
  final void Function(String bucketId) onHoverEnter;
  final void Function() onHoverExit;
  final void Function(String itemId) onItemRemove;

  const BucketZoneWidget({
    required this.bucket,
    required this.placedItems,
    required this.isHovered,
    required this.isComplete,
    required this.onDrop,
    required this.onHoverEnter,
    required this.onHoverExit,
    required this.onItemRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (_) {
        onHoverEnter(bucket.id);
        return true;
      },
      onLeave: (_) => onHoverExit(),
      onAcceptWithDetails: (details) {
        onHoverExit();
        onDrop(details.data, bucket.id);
      },
      builder: (ctx, candidateData, _) {
        final hovered = candidateData.isNotEmpty || isHovered;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
            color: hovered
                ? bucket.color.withOpacity(0.9)
                : bucket.color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hovered
                  ? _darkenColor(bucket.color, 0.25)
                  : _darkenColor(bucket.color, 0.1),
              width: hovered ? 2.5 : 1.5,
            ),
            boxShadow: hovered
                ? [
                    BoxShadow(
                      color: bucket.color.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header bucket
              _BucketHeader(
                bucket: bucket,
                itemCount: placedItems.length,
                isHovered: hovered,
              ),
              const SizedBox(height: 8),

              // Items đã xếp vào
              if (placedItems.isEmpty)
                _EmptyHint(isHovered: hovered)
              else
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: placedItems.map((item) {
                    return _PlacedItemChip(
                      item: item,
                      isComplete: isComplete,
                      onRemove: isComplete ? null : () => onItemRemove(item.id),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Color _darkenColor(Color color, double amount) {
    return Color.fromARGB(
      color.alpha,
      (color.red * (1 - amount)).round().clamp(0, 255),
      (color.green * (1 - amount)).round().clamp(0, 255),
      (color.blue * (1 - amount)).round().clamp(0, 255),
    );
  }
}

// ─── Header của bucket ────────────────────────────────────────────────────

class _BucketHeader extends StatelessWidget {
  final SortBucket bucket;
  final int itemCount;
  final bool isHovered;

  const _BucketHeader({
    required this.bucket,
    required this.itemCount,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            bucket.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        if (itemCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$itemCount',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
        if (isHovered) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.add_circle_outline_rounded,
            size: 16,
            color: Color(0xFF1A1A2E),
          ),
        ],
      ],
    );
  }
}

// ─── Gợi ý khi bucket rỗng ───────────────────────────────────────────────

class _EmptyHint extends StatelessWidget {
  final bool isHovered;
  const _EmptyHint({required this.isHovered});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isHovered ? 0.5 : 0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.6),
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        isHovered ? 'Thả vào đây ✓' : 'Kéo thả vào đây',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

// ─── Chip item đã được đặt vào bucket ────────────────────────────────────

class _PlacedItemChip extends StatelessWidget {
  final SortItem item;
  final bool isComplete;
  final VoidCallback? onRemove;

  const _PlacedItemChip({
    required this.item,
    required this.isComplete,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  item.imageUrl!,
                  width: 22,
                  height: 22,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
            Text(
              item.word,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
            if (!isComplete && onRemove != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.close_rounded, size: 12, color: Colors.grey.shade500),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Result overlay cho bucket sau khi chấm ──────────────────────────────

/// Hiển thị trạng thái đúng/sai của từng item bên trong bucket.
class BucketResultOverlay extends StatelessWidget {
  final SortItem item;
  final ItemResult result;

  const BucketResultOverlay({
    required this.item,
    required this.result,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = result == ItemResult.correct;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFE1F5EE) : const Color(0xFFFCEBEB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCorrect ? const Color(0xFF1D9E75) : const Color(0xFFE24B4A),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                item.imageUrl!,
                width: 22,
                height: 22,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            item.word,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isCorrect
                  ? const Color(0xFF085041)
                  : const Color(0xFF791F1F),
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 14,
            color: isCorrect
                ? const Color(0xFF1D9E75)
                : const Color(0xFFE24B4A),
          ),
        ],
      ),
    );
  }
}
