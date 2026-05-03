import 'package:flutter/material.dart';
import '../../domain/models/listen_tap_state.dart';

/// Banner feedback xuất hiện sau khi chọn đáp án.
/// Gồm headline, XP, và nút Tiếp.
class ListenTapFeedbackWidget extends StatefulWidget {
  final ListenTapState gameState;
  final VoidCallback onContinue;
  final VoidCallback? onReveal;

  const ListenTapFeedbackWidget({
    required this.gameState,
    required this.onContinue,
    this.onReveal,
    super.key,
  });

  @override
  State<ListenTapFeedbackWidget> createState() =>
      _ListenTapFeedbackWidgetState();
}

class _ListenTapFeedbackWidgetState extends State<ListenTapFeedbackWidget>
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
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;
    if (!gs.isAnswered) return const SizedBox.shrink();

    final isCorrect = gs.isCorrect;
    final isRevealed = gs.status == ListenTapStatus.revealed;

    final bgColor = isCorrect || isRevealed
        ? const Color(0xFFE1F5EE)
        : const Color(0xFFFCEBEB);
    final borderColor = isCorrect || isRevealed
        ? const Color(0xFF1D9E75)
        : const Color(0xFFE24B4A);

    final emoji = isCorrect
        ? '🎧'
        : isRevealed
        ? '💡'
        : '😅';
    final headline = isCorrect
        ? 'Đúng rồi!'
        : isRevealed
        ? 'Đáp án đúng'
        : 'Chưa đúng!';
    final subText = isCorrect
        ? '+${gs.xpEarned} XP'
              '${gs.replayCount <= 1 ? ' · Nghe 1 lần! 👂' : ''}'
        : 'Đáp án: "${gs.content.correctChoice.word}"';

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
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
                  // Nút tiếp
                  GestureDetector(
                    onTap: widget.onContinue,
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

              // Nút xem đáp án nếu sai
              if (!isCorrect && !isRevealed && widget.onReveal != null) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: widget.onReveal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
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
        ),
      ),
    );
  }
}
