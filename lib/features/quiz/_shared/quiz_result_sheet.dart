import 'package:flutter/material.dart';

/// Base result bottom sheet dùng chung cho mọi quiz type.
/// Mỗi quiz type có thể wrap và customize thêm.
class QuizResultSheet extends StatelessWidget {
  final int stars;
  final int xpEarned;
  final int timeTakenSec;
  final int correctCount;
  final int totalCount;
  final String? streakMessage;
  final List<String> learnedWords;
  final VoidCallback onReplay;
  final VoidCallback onNext;

  const QuizResultSheet({
    required this.stars,
    required this.xpEarned,
    required this.timeTakenSec,
    required this.correctCount,
    required this.totalCount,
    this.streakMessage,
    this.learnedWords = const [],
    required this.onReplay,
    required this.onNext,
    super.key,
  });

  String get _headline => switch (stars) {
    3 => 'Xuất sắc! 🎉',
    2 => 'Tốt lắm! 👏',
    _ => 'Cố gắng thêm nhé! 💪',
  };

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return m > 0 ? '${m}p ${s}s' : '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

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
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // XP + headline
          Text(
            '+$xpEarned XP',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color(0xFF534AB7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _headline,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),

          // Streak banner
          if (streakMessage != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFAEEDA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    streakMessage!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF412402),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Stats row
          Row(
            children: [
              _StatItem(
                icon: Icons.check_circle_outline_rounded,
                color: const Color(0xFF1D9E75),
                value: '$correctCount/$totalCount',
                label: 'Đúng',
              ),
              const SizedBox(width: 8),
              _StatItem(
                icon: Icons.timer_outlined,
                color: const Color(0xFF534AB7),
                value: _formatTime(timeTakenSec),
                label: 'Thời gian',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Từ đã học
          if (learnedWords.isNotEmpty) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Từ vừa học',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: learnedWords
                  .map(
                    (w) => Chip(
                      label: Text(
                        w,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF3C3489),
                        ),
                      ),
                      backgroundColor: const Color(0xFFEEEDFE),
                      side: BorderSide.none,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Action buttons
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
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
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
                fontSize: 16,
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
