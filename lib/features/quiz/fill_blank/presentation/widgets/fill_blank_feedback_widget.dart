import 'package:flutter/material.dart';
import '../../domain/models/fill_blank_state.dart';

/// Khu vực phía dưới màn hình — chứa nút Submit hoặc banner feedback.
class FillBlankFeedbackWidget extends StatefulWidget {
  final FillBlankState gameState;
  final VoidCallback onSubmit;
  final VoidCallback onContinue;
  final VoidCallback? onReveal;

  const FillBlankFeedbackWidget({
    required this.gameState,
    required this.onSubmit,
    required this.onContinue,
    this.onReveal,
    super.key,
  });

  @override
  State<FillBlankFeedbackWidget> createState() =>
      _FillBlankFeedbackWidgetState();
}

class _FillBlankFeedbackWidgetState extends State<FillBlankFeedbackWidget>
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
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(FillBlankFeedbackWidget old) {
    super.didUpdateWidget(old);
    // Animate khi chuyển sang trạng thái answered
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
          child: _FeedbackBanner(
            gameState: gs,
            onContinue: widget.onContinue,
            onReveal: widget.onReveal,
          ),
        ),
      );
    }

    // Chưa trả lời → nút Check hoặc disabled
    return _SubmitButton(enabled: gs.hasSelection, onTap: widget.onSubmit);
  }
}

// ─── Nút Check / Submit ───────────────────────────────────────────────────

class _SubmitButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _SubmitButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFF534AB7) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(14),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: const Color(0xFF534AB7).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            enabled ? 'Kiểm tra ✓' : 'Chọn một từ...',
            style: TextStyle(
              color: enabled ? Colors.white : Colors.grey.shade500,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Feedback banner sau khi trả lời ─────────────────────────────────────

class _FeedbackBanner extends StatelessWidget {
  final FillBlankState gameState;
  final VoidCallback onContinue;
  final VoidCallback? onReveal;

  const _FeedbackBanner({
    required this.gameState,
    required this.onContinue,
    this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final isCorrect = gs.isCorrect;
    final isRevealed = gs.status == FillBlankStatus.revealed;

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
        ? 'Đúng rồi!'
        : isRevealed
        ? 'Đáp án đúng'
        : 'Chưa đúng!';

    final subText = isCorrect
        ? '+${gs.xpEarned} XP${gs.hintsUsed == 0 ? ' · Không dùng gợi ý! 🌟' : ''}'
        : 'Đáp án: "${gs.content.correctAnswer}"';

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
          // Hàng trên: emoji + text + nút tiếp
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
                        color: isCorrect || isRevealed
                            ? const Color(0xFF085041)
                            : const Color(0xFF791F1F),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      style: TextStyle(
                        fontSize: 13,
                        color: isCorrect || isRevealed
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
              const SizedBox(width: 8),
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

          // Nút "Xem đáp án" khi sai (chưa reveal)
          if (!isCorrect && !isRevealed && onReveal != null) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onReveal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Xem đáp án đúng',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
