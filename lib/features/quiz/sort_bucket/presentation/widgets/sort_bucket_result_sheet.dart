import 'package:flutter/material.dart';
import '../../domain/models/sort_bucket_state.dart';
import '../../domain/models/sort_bucket_entities.dart';

/// Bottom sheet kết quả sau khi hoàn thành sort_bucket.
/// Hiện tỉ lệ đúng, XP, và danh sách từng item với màu đúng/sai.
class SortBucketResultSheet extends StatelessWidget {
  final SortBucketState gameState;
  final VoidCallback onReplay;
  final VoidCallback onNext;

  const SortBucketResultSheet({
    required this.gameState,
    required this.onReplay,
    required this.onNext,
    super.key,
  });

  int get _stars {
    final acc = gameState.accuracy;
    if (acc == 1.0) return 3;
    if (acc >= 0.7) return 2;
    return 1;
  }

  String _formatTime(int ms) {
    final s = ms ~/ 1000;
    final m = s ~/ 60;
    return m > 0 ? '${m}p ${s % 60}s' : '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final stars = _stars;
    final allCorrect = gs.correctCount == gs.content.items.length;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),

            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: i < stars
                        ? const Color(0xFFEF9F27)
                        : Colors.grey.shade300,
                    size: 42,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // XP + headline
            Text(
              '+${gs.xpEarned} XP',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF534AB7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              allCorrect
                  ? 'Tất cả đúng! 🎉'
                  : '${gs.correctCount}/${gs.content.items.length} từ đúng vị trí',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Stat chips
            Row(
              children: [
                _StatChip(
                  icon: Icons.check_circle_outline_rounded,
                  value: '${gs.correctCount}/${gs.content.items.length}',
                  label: 'Đúng',
                  color: const Color(0xFF1D9E75),
                ),
                const SizedBox(width: 8),
                _StatChip(
                  icon: Icons.timer_outlined,
                  value: _formatTime(gs.timeTakenMs),
                  label: 'Thời gian',
                  color: const Color(0xFF534AB7),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chi tiết từng bucket
            ...gs.content.buckets.map((bucket) {
              final items = gs.content.items
                  .where(
                    (item) => gs.placements[item.id]?.bucketId == bucket.id,
                  )
                  .toList();
              if (items.isEmpty) return const SizedBox.shrink();

              return _BucketResultSection(
                bucket: bucket,
                items: items,
                placements: gs.placements,
              );
            }),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReplay,
                    icon: const Icon(Icons.replay_rounded, size: 16),
                    label: const Text('Chơi lại'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      foregroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: FilledButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('Tiếp theo'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: const Color(0xFF534AB7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section kết quả cho 1 bucket ────────────────────────────────────────

class _BucketResultSection extends StatelessWidget {
  final SortBucket bucket;
  final List<SortItem> items;
  final Map<String, ItemPlacement> placements;

  const _BucketResultSection({
    required this.bucket,
    required this.items,
    required this.placements,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bucket.color.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bucket.label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: items.map((item) {
              final result = placements[item.id]?.result ?? ItemResult.pending;
              final isCorrect = result == ItemResult.correct;

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? const Color(0xFFE1F5EE)
                      : const Color(0xFFFCEBEB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isCorrect
                        ? const Color(0xFF1D9E75)
                        : const Color(0xFFE24B4A),
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
                          width: 20,
                          height: 20,
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
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      size: 13,
                      color: isCorrect
                          ? const Color(0xFF1D9E75)
                          : const Color(0xFFE24B4A),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Stat chip ────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
