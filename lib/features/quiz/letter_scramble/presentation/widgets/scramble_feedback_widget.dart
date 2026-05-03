import 'package:flutter/material.dart';
import '../../domain/models/letter_scramble_state.dart';

/// Khu vực phía dưới — toolbar khi đang chơi, banner khi đã trả lời.
class ScrambleFeedbackWidget extends StatefulWidget {
  final LetterScrambleState gameState;
  final int hintsRemaining;
  final VoidCallback onHint;
  final VoidCallback onClear;
  final VoidCallback onReveal;
  final VoidCallback onContinue;

  const ScrambleFeedbackWidget({
    required this.gameState,
    required this.hintsRemaining,
    required this.onHint,
    required this.onClear,
    required this.onReveal,
    required this.onContinue,
    super.key,
  });

  @override
  State<ScrambleFeedbackWidget> createState() => _ScrambleFeedbackWidgetState();
}

class _ScrambleFeedbackWidgetState extends State<ScrambleFeedbackWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(ScrambleFeedbackWidget old) {
    super.didUpdateWidget(old);
    if (widget.gameState.isAnswered && !old.gameState.isAnswered) {
      _slideCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
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

    // Đang chơi → toolbar
    return _PlayingToolbar(
      gameState: gs,
      hintsRemaining: widget.hintsRemaining,
      onHint: widget.onHint,
      onClear: widget.onClear,
      onReveal: widget.onReveal,
    );
  }
}

// ─── Toolbar khi đang chơi ────────────────────────────────────────────────

class _PlayingToolbar extends StatelessWidget {
  final LetterScrambleState gameState;
  final int hintsRemaining;
  final VoidCallback onHint;
  final VoidCallback onClear;
  final VoidCallback onReveal;

  const _PlayingToolbar({
    required this.gameState,
    required this.hintsRemaining,
    required this.onHint,
    required this.onClear,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final hasContent = gs.answerSlots.any((t) => t != null && !t.isLocked);
    final isWrong = gs.status == LetterScrambleStatus.wrong;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Banner "Chưa đúng" nếu sai lần trước
        if (isWrong) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFCEBEB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE24B4A).withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                const Text('😅 ', style: TextStyle(fontSize: 16)),
                const Expanded(
                  child: Text(
                    'Chưa đúng! Thử lại hoặc dùng gợi ý.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF791F1F)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],

        // Toolbar buttons
        Row(
          children: [
            // Hint
            _ToolbarButton(
              icon: Icons.lightbulb_outline_rounded,
              label: 'Gợi ý ($hintsRemaining)',
              color: const Color(0xFFEF9F27),
              enabled: hintsRemaining > 0,
              onTap: onHint,
            ),
            const SizedBox(width: 8),
            // Clear
            _ToolbarButton(
              icon: Icons.refresh_rounded,
              label: 'Xoá',
              color: Colors.grey,
              enabled: hasContent,
              onTap: onClear,
            ),
            const SizedBox(width: 8),
            // Xem đáp án
            _ToolbarButton(
              icon: Icons.visibility_outlined,
              label: 'Đáp án',
              color: const Color(0xFF534AB7),
              enabled: true,
              onTap: onReveal,
            ),
          ],
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        opacity: enabled ? 1.0 : 0.4,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Banner sau khi trả lời ───────────────────────────────────────────────

class _AnsweredBanner extends StatelessWidget {
  final LetterScrambleState gameState;
  final VoidCallback onContinue;

  const _AnsweredBanner({required this.gameState, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final isCorrect = gs.status == LetterScrambleStatus.correct;
    final isRevealed = gs.status == LetterScrambleStatus.revealed;

    final bgColor = isCorrect || isRevealed
        ? const Color(0xFFE1F5EE)
        : const Color(0xFFFCEBEB);
    final borderColor = isCorrect || isRevealed
        ? const Color(0xFF1D9E75)
        : const Color(0xFFE24B4A);
    final emoji = isCorrect
        ? '🎉'
        : isRevealed
        ? '💡'
        : '😅';
    final headline = isCorrect
        ? 'Tuyệt vời!'
        : isRevealed
        ? 'Đây là đáp án'
        : 'Chưa đúng!';

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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isCorrect || isRevealed
                            ? const Color(0xFF085041)
                            : const Color(0xFF791F1F),
                      ),
                    ),
                    if (isCorrect)
                      Text(
                        '+${gs.xpEarned} XP'
                        '${gs.hintsUsed == 0 && gs.wrongAttempts == 0 ? ' · Perfect! 🌟' : ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F6E56),
                        ),
                      ),
                    if (!isCorrect)
                      Text(
                        'Từ đúng: "${gs.content.word.toUpperCase()}"',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFA32D2D),
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

          // Stats dạng chip nhỏ
          if (isCorrect) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                if (gs.hintsUsed == 0)
                  _StatChip(label: 'Không dùng gợi ý', icon: '💡'),
                if (gs.wrongAttempts == 0)
                  _StatChip(label: 'Không sai lần nào', icon: '✅'),
                if (gs.timeTakenMs < 15000)
                  _StatChip(label: 'Trả lời nhanh', icon: '⚡'),
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
        color: Colors.white.withOpacity(0.7),
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
