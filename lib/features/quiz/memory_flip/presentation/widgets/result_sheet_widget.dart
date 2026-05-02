import 'package:flutter/material.dart';
import '../../domain/models/memory_flip_game_state.dart';
import '../../domain/models/card_content.dart';

class ResultSheetWidget extends StatelessWidget {
  final MemoryFlipGameState gameState;
  final VoidCallback onReplay;
  final VoidCallback onNext;

  const ResultSheetWidget({
    required this.gameState,
    required this.onReplay,
    required this.onNext,
    super.key,
  });

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return m > 0 ? '${m}p ${s}s' : '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final stars = gs.computeStars();
    final xp = gs.earnedXp;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
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
          const SizedBox(height: 20),

          // Sao thành tích
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300 + i * 150),
                  child: Icon(
                    i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                    key: ValueKey('star_$i'),
                    color: i < stars
                        ? const Color(0xFFEF9F27)
                        : Colors.grey.shade300,
                    size: 44,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // XP
          Text(
            '+$xp XP',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF534AB7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stars == 3
                ? 'Xuất sắc! 🎉'
                : stars == 2
                ? 'Tốt lắm! 👏'
                : 'Cố gắng thêm nhé! 💪',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),

          // Thống kê
          Row(
            children: [
              _StatBox(
                label: 'Số lần lật',
                value: '${gs.flipCount}',
                icon: Icons.flip,
                color: const Color(0xFF534AB7),
              ),
              const SizedBox(width: 10),
              _StatBox(
                label: 'Thời gian',
                value: _formatTime(gs.elapsedSec),
                icon: Icons.timer_outlined,
                color: const Color(0xFF1D9E75),
              ),
              const SizedBox(width: 10),
              _StatBox(
                label: 'Từ đã học',
                value: '${gs.content.pairs.length}',
                icon: Icons.book_outlined,
                color: const Color(0xFFEF9F27),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Danh sách từ đã học
          if (gs.content.accessibility.showLabelOnBack) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Từ vừa học',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: gs.content.pairs.map((pair) {
                final word = pair.cardA.type == CardType.word
                    ? pair.cardA.word
                    : pair.cardB.word;
                final vi = pair.cardA.translationVi ?? pair.cardB.translationVi;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEDFE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vi != null ? '$word · $vi' : word ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3C3489),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReplay,
                  icon: const Icon(Icons.replay_rounded, size: 18),
                  label: const Text('Chơi lại'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    side: BorderSide(color: Colors.grey.shade300),
                    foregroundColor: Colors.grey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: onNext,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: const Text('Tiếp theo'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
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

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
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
