import 'package:flutter/material.dart';
import '../../domain/models/fill_blank_state.dart';

/// Hàng word chip cho người dùng chọn điền vào ô trống.
/// Chip thay đổi màu theo [ChipStatus] và có animation khi tap.
class WordChipBarWidget extends StatelessWidget {
  final List<String> choices;
  final FillBlankState gameState;
  final void Function(String word) onChipTap;

  const WordChipBarWidget({
    required this.choices,
    required this.gameState,
    required this.onChipTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: choices.map((word) {
        final chipStatus = gameState.statusOf(word);
        return _WordChip(
          word: word,
          status: chipStatus,
          onTap: gameState.isAnswered ? null : () => onChipTap(word),
        );
      }).toList(),
    );
  }
}

// ─── Word chip đơn ────────────────────────────────────────────────────────

class _WordChip extends StatefulWidget {
  final String word;
  final ChipStatus status;
  final VoidCallback? onTap;

  const _WordChip({required this.word, required this.status, this.onTap});

  @override
  State<_WordChip> createState() => _WordChipState();
}

class _WordChipState extends State<_WordChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  // ── Màu sắc theo trạng thái ─────────────────────────────────────

  Color get _bgColor => switch (widget.status) {
    ChipStatus.normal => Colors.white,
    ChipStatus.selected => const Color(0xFFEEEDFE),
    ChipStatus.correct => const Color(0xFFE1F5EE),
    ChipStatus.wrong => const Color(0xFFFCEBEB),
    ChipStatus.dimmed => Colors.grey.shade100,
  };

  Color get _borderColor => switch (widget.status) {
    ChipStatus.normal => const Color(0xFFE0DEFC),
    ChipStatus.selected => const Color(0xFF534AB7),
    ChipStatus.correct => const Color(0xFF1D9E75),
    ChipStatus.wrong => const Color(0xFFE24B4A),
    ChipStatus.dimmed => Colors.grey.shade200,
  };

  Color get _textColor => switch (widget.status) {
    ChipStatus.normal => const Color(0xFF26215C),
    ChipStatus.selected => const Color(0xFF3C3489),
    ChipStatus.correct => const Color(0xFF085041),
    ChipStatus.wrong => const Color(0xFF791F1F),
    ChipStatus.dimmed => Colors.grey.shade400,
  };

  double get _elevation => switch (widget.status) {
    ChipStatus.normal => 2,
    ChipStatus.selected => 4,
    _ => 0,
  };

  Widget? get _leadingIcon => switch (widget.status) {
    ChipStatus.correct => const Icon(
      Icons.check_circle_rounded,
      size: 16,
      color: Color(0xFF1D9E75),
    ),
    ChipStatus.wrong => const Icon(
      Icons.cancel_rounded,
      size: 16,
      color: Color(0xFFE24B4A),
    ),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: widget.onTap != null ? (_) => _pressCtrl.forward() : null,
        onTapUp: widget.onTap != null
            ? (_) {
                _pressCtrl.reverse();
                widget.onTap?.call();
              }
            : null,
        onTapCancel: () => _pressCtrl.reverse(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: _borderColor.withOpacity(0.25),
                blurRadius: _elevation * 2,
                offset: Offset(0, _elevation),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_leadingIcon != null) ...[
                _leadingIcon!,
                const SizedBox(width: 6),
              ],
              Text(
                widget.word,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _textColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
