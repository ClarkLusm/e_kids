import 'package:flutter/material.dart';
import '../../domain/models/word_pop_state.dart';

/// HUD hiển thị ở đầu màn hình: chỉ dẫn, điểm, progress target.
class WordPopHudWidget extends StatelessWidget {
  final WordPopState gameState;

  const WordPopHudWidget({required this.gameState, super.key});

  @override
  Widget build(BuildContext context) {
    final gs = gameState;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chỉ dẫn
          Text(
            gs.content.instruction,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF534AB7),
            ),
            textAlign: TextAlign.center,
          ),
          if (gs.content.instructionVi != null) ...[
            const SizedBox(height: 2),
            Text(
              gs.content.instructionVi!,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 8),

          // Score + target progress
          Row(
            children: [
              // Điểm
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEDFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text('⭐ ', style: TextStyle(fontSize: 14)),
                    Text(
                      '${gs.score}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Target progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${gs.targetsHit}/${gs.totalTargets} từ đúng',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF534AB7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (gs.content.missPenalty)
                          Text(
                            'Sai: ${gs.wrongTaps}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFE24B4A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: gs.totalTargets == 0
                            ? 0
                            : gs.targetsHit / gs.totalTargets,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF1D9E75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Màn hình đếm ngược 3-2-1 trước khi bắt đầu
class CountdownOverlay extends StatefulWidget {
  final int count;
  const CountdownOverlay({required this.count, super.key});

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.2), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 3),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    _fadeAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 3),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF534AB7).withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.count > 0 ? '${widget.count}' : 'GO!',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Banner kết quả sau khi game complete
class WordPopResultBanner extends StatefulWidget {
  final WordPopState gameState;
  final VoidCallback onContinue;
  final VoidCallback onReplay;

  const WordPopResultBanner({
    required this.gameState,
    required this.onContinue,
    required this.onReplay,
    super.key,
  });

  @override
  State<WordPopResultBanner> createState() => _WordPopResultBannerState();
}

class _WordPopResultBannerState extends State<WordPopResultBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;
    final allCorrect = gs.targetsHit == gs.totalTargets;

    return SlideTransition(
      position: _slideAnim,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final stars = allCorrect
                    ? 3
                    : gs.accuracy >= 0.7
                    ? 2
                    : 1;
                return Icon(
                  i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: i < stars
                      ? const Color(0xFFEF9F27)
                      : Colors.grey.shade300,
                  size: 38,
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(
              '+${gs.xpEarned} XP',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF534AB7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              allCorrect
                  ? 'Bắt hết bong bóng! 🎉'
                  : '${gs.targetsHit}/${gs.totalTargets} từ đúng',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 14),
            // Stats
            Row(
              children: [
                _Stat(
                  icon: '🎯',
                  value: '${gs.targetsHit}/${gs.totalTargets}',
                  label: 'Đúng',
                ),
                _Stat(icon: '❌', value: '${gs.wrongTaps}', label: 'Sai'),
                _Stat(
                  icon: '💨',
                  value: '${gs.missedTargets}',
                  label: 'Bỏ sót',
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onReplay,
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
                    onPressed: widget.onContinue,
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

class _Stat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
