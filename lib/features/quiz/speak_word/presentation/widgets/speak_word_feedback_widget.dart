import 'package:flutter/material.dart';
import '../../domain/models/speak_word_state.dart';

/// Khu vực phía dưới màn hình — hiện trạng thái + nút hành động.
class SpeakWordFeedbackWidget extends StatefulWidget {
  final SpeakWordState gameState;
  final VoidCallback onRevealHint;
  final VoidCallback onRevealAnswer;
  final VoidCallback onContinue;

  const SpeakWordFeedbackWidget({
    required this.gameState,
    required this.onRevealHint,
    required this.onRevealAnswer,
    required this.onContinue,
    super.key,
  });

  @override
  State<SpeakWordFeedbackWidget> createState() =>
      _SpeakWordFeedbackWidgetState();
}

class _SpeakWordFeedbackWidgetState extends State<SpeakWordFeedbackWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(SpeakWordFeedbackWidget old) {
    super.didUpdateWidget(old);
    if (widget.gameState.isAnswered && !old.gameState.isAnswered) {
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;

    if (gs.isAnswered) {
      return FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: _AnsweredBanner(gameState: gs, onContinue: widget.onContinue),
        ),
      );
    }

    // Đang chơi — hiện toolbar gợi ý
    return _PlayingToolbar(
      gameState: gs,
      onRevealHint: widget.onRevealHint,
      onRevealAnswer: widget.onRevealAnswer,
    );
  }
}

// ─── Toolbar khi đang chơi ────────────────────────────────────────────────

class _PlayingToolbar extends StatelessWidget {
  final SpeakWordState gameState;
  final VoidCallback onRevealHint;
  final VoidCallback onRevealAnswer;

  const _PlayingToolbar({
    required this.gameState,
    required this.onRevealHint,
    required this.onRevealAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final hasTriedOnce = gs.attemptCount > 0;
    final hasSyllables = gs.content.syllableBreakdown.isNotEmpty;

    return Row(
      children: [
        // Gợi ý âm tiết
        if (hasSyllables && !gs.showSyllableHint)
          Expanded(
            child: _ToolBtn(
              icon: Icons.lightbulb_outline_rounded,
              label: 'Gợi ý',
              color: const Color(0xFFEF9F27),
              enabled: hasTriedOnce,
              onTap: onRevealHint,
            ),
          ),
        if (hasSyllables && !gs.showSyllableHint) const SizedBox(width: 8),

        // Bỏ cuộc / xem đáp án
        Expanded(
          child: _ToolBtn(
            icon: Icons.visibility_outlined,
            label: 'Xem đáp án',
            color: Colors.grey.shade600,
            enabled: hasTriedOnce,
            onTap: onRevealAnswer,
          ),
        ),
      ],
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  const _ToolBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Banner sau khi trả lời ───────────────────────────────────────────────

class _AnsweredBanner extends StatelessWidget {
  final SpeakWordState gameState;
  final VoidCallback onContinue;

  const _AnsweredBanner({required this.gameState, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final isCorrect = gs.isCorrect;
    final isRevealed = gs.status == SpeakWordStatus.revealed;
    final isMaxReached = gs.status == SpeakWordStatus.maxReached;

    final bgColor = isCorrect
        ? const Color(0xFFE1F5EE)
        : const Color(0xFFFCEBEB);
    final borderColor = isCorrect
        ? const Color(0xFF1D9E75)
        : const Color(0xFFE24B4A);

    final emoji = isCorrect
        ? '🎙'
        : isRevealed
        ? '💡'
        : '😅';
    final headline = isCorrect
        ? 'Phát âm đúng!'
        : isMaxReached
        ? 'Hết lượt thử'
        : 'Hãy luyện thêm nhé!';

    final subText = isCorrect
        ? '+${gs.xpEarned} XP'
              '${gs.attemptCount == 1 ? ' · Lần đầu đúng! 🌟' : ''}'
        : '"${gs.content.targetWord}" — /${gs.content.phonetic ?? gs.content.targetWord}/';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headline,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isCorrect
                            ? const Color(0xFF085041)
                            : const Color(0xFF791F1F),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      style: TextStyle(
                        fontSize: 13,
                        color: isCorrect
                            ? const Color(0xFF0F6E56)
                            : const Color(0xFFA32D2D),
                        fontWeight: isCorrect
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onContinue,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Tiếp →',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bonus stats khi đúng
          if (isCorrect) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                if (gs.attemptCount == 1)
                  _StatChip(label: 'Lần đầu đúng', icon: '🎯'),
                if (gs.bestSimilarity >= 0.9)
                  _StatChip(label: 'Phát âm chuẩn', icon: '🔊'),
                if (gs.timeTakenMs < 10000)
                  _StatChip(label: 'Phản xạ nhanh', icon: '⚡'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String icon;
  const _StatChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$icon $label',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF085041),
        ),
      ),
    );
  }
}
