import 'package:flutter/material.dart';
import '../../domain/models/listen_tap_choice.dart';
import '../../domain/models/listen_tap_state.dart';

/// Grid 2×2 hiển thị 4 lựa chọn hình ảnh cho quiz listen_tap.
/// Mỗi card có ảnh chiếm toàn bộ diện tích + label word phía dưới.
class ImageChoiceGridWidget extends StatelessWidget {
  final List<ListenTapChoice> choices;
  final ListenTapState gameState;
  final void Function(String word) onChoiceTap;

  const ImageChoiceGridWidget({
    required this.choices,
    required this.gameState,
    required this.onChoiceTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemCount: choices.length,
      itemBuilder: (ctx, i) {
        final choice = choices[i];
        final cardStatus = gameState.cardStatusOf(choice.word);
        return _ImageChoiceCard(
          choice: choice,
          status: cardStatus,
          showWord:
              gameState.isAnswered && gameState.content.showWordAfterAnswer,
          onTap:
              gameState.isAnswered ||
                  gameState.status == ListenTapStatus.waitingToPlay ||
                  gameState.status == ListenTapStatus.playing
              ? null
              : () => onChoiceTap(choice.word),
        );
      },
    );
  }
}

// ─── Image choice card ─────────────────────────────────────────────────────

class _ImageChoiceCard extends StatefulWidget {
  final ListenTapChoice choice;
  final ChoiceCardStatus status;
  final bool showWord;
  final VoidCallback? onTap;

  const _ImageChoiceCard({
    required this.choice,
    required this.status,
    required this.showWord,
    this.onTap,
  });

  @override
  State<_ImageChoiceCard> createState() => _ImageChoiceCardState();
}

class _ImageChoiceCardState extends State<_ImageChoiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _tapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.94,
    ).animate(CurvedAnimation(parent: _tapCtrl, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _tapCtrl.dispose();
    super.dispose();
  }

  // ── Màu border theo trạng thái ───────────────────────────────────

  Color get _borderColor => switch (widget.status) {
    ChoiceCardStatus.correct => const Color(0xFF1D9E75),
    ChoiceCardStatus.wrong => const Color(0xFFE24B4A),
    ChoiceCardStatus.normal => const Color(0xFFE0DEFC),
    ChoiceCardStatus.dimmed => Colors.grey.shade200,
  };

  double get _borderWidth => switch (widget.status) {
    ChoiceCardStatus.correct => 3,
    ChoiceCardStatus.wrong => 3,
    _ => 1.5,
  };

  Color? get _overlayColor => switch (widget.status) {
    ChoiceCardStatus.correct => const Color(0xFF1D9E75).withOpacity(0.15),
    ChoiceCardStatus.wrong => const Color(0xFFE24B4A).withOpacity(0.15),
    ChoiceCardStatus.dimmed => Colors.grey.withOpacity(0.35),
    _ => null,
  };

  Widget? get _resultBadge => switch (widget.status) {
    ChoiceCardStatus.correct => Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Color(0xFF1D9E75),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
    ),
    ChoiceCardStatus.wrong => Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Color(0xFFE24B4A),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
    ),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: widget.onTap != null ? (_) => _tapCtrl.forward() : null,
        onTapUp: widget.onTap != null
            ? (_) {
                _tapCtrl.reverse();
                widget.onTap?.call();
              }
            : null,
        onTapCancel: () => _tapCtrl.reverse(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _borderColor, width: _borderWidth),
            boxShadow: widget.status == ChoiceCardStatus.normal
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Ảnh
                Positioned.fill(
                  child: Image.asset(
                    widget.choice.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFEEEDFE),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 36,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),

                // Overlay màu khi answered
                if (_overlayColor != null)
                  Positioned.fill(child: ColoredBox(color: _overlayColor!)),

                // Label word phía dưới
                if (widget.showWord)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: widget.showWord ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        color: Colors.black.withOpacity(0.55),
                        child: Text(
                          widget.choice.word,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Badge đúng/sai góc trên phải
                if (_resultBadge != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      child: _resultBadge,
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
