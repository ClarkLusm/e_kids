import 'package:flutter/material.dart';
import '../../domain/models/picture_match_state.dart';

/// Banner phản hồi hiện bên dưới grid lựa chọn.
/// Hiện "Đúng rồi! +XP" hoặc "Sai rồi! Đáp án đúng là..."
class AnswerFeedbackWidget extends StatefulWidget {
  final PictureMatchState gameState;
  final VoidCallback onContinue;
  final VoidCallback? onReveal;

  const AnswerFeedbackWidget({
    required this.gameState,
    required this.onContinue,
    this.onReveal,
    super.key,
  });

  @override
  State<AnswerFeedbackWidget> createState() => _AnswerFeedbackWidgetState();
}

class _AnswerFeedbackWidgetState extends State<AnswerFeedbackWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_slideCtrl);
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;
    if (!gs.isAnswered) return const SizedBox.shrink();

    final isCorrect = gs.isCorrect;
    final bgColor = isCorrect
        ? const Color(0xFFE1F5EE)
        : const Color(0xFFFCEBEB);
    final borderColor = isCorrect
        ? const Color(0xFF1D9E75)
        : const Color(0xFFE24B4A);
    final iconEmoji = isCorrect ? '🎉' : '😅';
    final headline = isCorrect ? 'Đúng rồi!' : 'Chưa đúng!';
    final subText = isCorrect
        ? '+${gs.xpEarned} XP'
        : 'Đáp án đúng là: ${gs.content.correctWord}';

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
              Text(iconEmoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
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
              const SizedBox(width: 8),
              // Nút tiếp tục
              GestureDetector(
                onTap: widget.onContinue,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Tiếp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
