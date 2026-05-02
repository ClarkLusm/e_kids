import 'package:flutter/material.dart';
import '../../domain/models/picture_match_state.dart';

/// Grid 2×2 hiển thị 4 lựa chọn từ vựng.
class ChoiceGridWidget extends StatelessWidget {
  final PictureMatchState gameState;
  final void Function(String word) onChoiceTap;
  final void Function(String word)? onChoiceAudioTap;

  const ChoiceGridWidget({
    required this.gameState,
    required this.onChoiceTap,
    this.onChoiceAudioTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      itemCount: gameState.shuffledChoices.length,
      itemBuilder: (ctx, i) {
        final choice = gameState.shuffledChoices[i];
        final result = gameState.resultOf(choice.word);
        return _ChoiceCard(
          word: choice.word,
          result: result,
          isAnswered: gameState.isAnswered,
          onTap: gameState.isAnswered ? null : () => onChoiceTap(choice.word),
          onAudioTap: onChoiceAudioTap != null
              ? () => onChoiceAudioTap!(choice.word)
              : null,
        );
      },
    );
  }
}

// ─── Thẻ lựa chọn đơn ─────────────────────────────────────────────────────

class _ChoiceCard extends StatefulWidget {
  final String word;
  final ChoiceResult result;
  final bool isAnswered;
  final VoidCallback? onTap;
  final VoidCallback? onAudioTap;

  const _ChoiceCard({
    required this.word,
    required this.result,
    required this.isAnswered,
    this.onTap,
    this.onAudioTap,
  });

  @override
  State<_ChoiceCard> createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<_ChoiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
    ]).animate(_shakeCtrl);
  }

  @override
  void didUpdateWidget(_ChoiceCard old) {
    super.didUpdateWidget(old);
    // Rung khi chọn sai
    if (widget.result == ChoiceResult.wrong &&
        old.result != ChoiceResult.wrong) {
      _shakeCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  // ── Màu sắc theo trạng thái ──────────────────────────────────────

  Color get _bgColor => switch (widget.result) {
    ChoiceResult.correct => const Color(0xFFE1F5EE),
    ChoiceResult.wrong => const Color(0xFFFCEBEB),
    ChoiceResult.none => Colors.white,
  };

  Color get _borderColor => switch (widget.result) {
    ChoiceResult.correct => const Color(0xFF1D9E75),
    ChoiceResult.wrong => const Color(0xFFE24B4A),
    ChoiceResult.none => const Color(0xFFE0DEFC),
  };

  Color get _textColor => switch (widget.result) {
    ChoiceResult.correct => const Color(0xFF085041),
    ChoiceResult.wrong => const Color(0xFF791F1F),
    ChoiceResult.none => const Color(0xFF26215C),
  };

  IconData? get _trailingIcon => switch (widget.result) {
    ChoiceResult.correct => Icons.check_circle_rounded,
    ChoiceResult.wrong => Icons.cancel_rounded,
    ChoiceResult.none => null,
  };

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (ctx, child) => Transform.translate(
        offset: Offset(_shakeAnim.value, 0),
        child: child,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor, width: 1.5),
            boxShadow: widget.result == ChoiceResult.none
                ? [
                    BoxShadow(
                      color: const Color(0xFF534AB7).withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Từ
              Expanded(
                child: Text(
                  widget.word,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _textColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),

              // Icon kết quả
              if (_trailingIcon != null) ...[
                const SizedBox(width: 4),
                Icon(_trailingIcon!, size: 20, color: _borderColor),
              ],

              // Nút phát âm (chỉ hiện sau khi trả lời)
              if (widget.isAnswered && widget.onAudioTap != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: widget.onAudioTap,
                  child: Icon(
                    Icons.volume_up_outlined,
                    size: 18,
                    color: _textColor.withOpacity(0.6),
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
