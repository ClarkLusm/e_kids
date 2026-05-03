import 'package:flutter/material.dart';
import '../../domain/models/letter_tile.dart';
import '../../domain/models/letter_scramble_state.dart';

/// Hàng ô đáp án — mỗi ô là một DragTarget nhận LetterTile.
/// Tap vào ô đã điền → trả tile về source.
class AnswerSlotsWidget extends StatelessWidget {
  final List<LetterTile?> slots;
  final LetterScrambleState gameState;
  final void Function(int slotIndex) onSlotTap;
  final void Function(String tileId, int slotIndex) onDrop;

  const AnswerSlotsWidget({
    required this.slots,
    required this.gameState,
    required this.onSlotTap,
    required this.onDrop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Tính kích thước tile theo độ dài từ — từ dài hơn thì tile nhỏ hơn
    final wordLen = slots.length;
    final tileSize = wordLen <= 4
        ? 58.0
        : wordLen <= 6
        ? 50.0
        : wordLen <= 8
        ? 44.0
        : 38.0;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: List.generate(slots.length, (i) {
        final tile = slots[i];
        final slotState = gameState.slotStateAt(i);
        return DragTarget<String>(
          onWillAcceptWithDetails: (details) {
            // Không nhận nếu slot bị khóa
            return !(tile?.isLocked ?? false);
          },
          onAcceptWithDetails: (details) => onDrop(details.data, i),
          builder: (ctx, candidateData, rejectedData) {
            final isHovered = candidateData.isNotEmpty;
            return _AnswerSlot(
              tile: tile,
              slotState: slotState,
              size: tileSize,
              isHovered: isHovered,
              onTap: () => onSlotTap(i),
            );
          },
        );
      }),
    );
  }
}

// ─── Ô đáp án đơn ─────────────────────────────────────────────────────────

class _AnswerSlot extends StatefulWidget {
  final LetterTile? tile;
  final SlotDisplayState slotState;
  final double size;
  final bool isHovered;
  final VoidCallback onTap;

  const _AnswerSlot({
    required this.tile,
    required this.slotState,
    required this.size,
    required this.isHovered,
    required this.onTap,
  });

  @override
  State<_AnswerSlot> createState() => _AnswerSlotState();
}

class _AnswerSlotState extends State<_AnswerSlot>
    with SingleTickerProviderStateMixin {
  late AnimationController _popCtrl;
  late Animation<double> _popAnim;

  @override
  void initState() {
    super.initState();
    _popCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _popAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _popCtrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AnswerSlot old) {
    super.didUpdateWidget(old);
    if (widget.tile?.id != old.tile?.id && widget.tile != null) {
      _popCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _popCtrl.dispose();
    super.dispose();
  }

  Color get _bgColor => switch (widget.slotState) {
    SlotDisplayState.empty => Colors.white,
    SlotDisplayState.filled => const Color(0xFFEEEDFE),
    SlotDisplayState.locked => const Color(0xFFFAEEDA),
    SlotDisplayState.correct => const Color(0xFFE1F5EE),
    SlotDisplayState.wrong => const Color(0xFFFCEBEB),
    SlotDisplayState.revealed => const Color(0xFFE1F5EE),
  };

  Color get _borderColor => switch (widget.slotState) {
    SlotDisplayState.empty =>
      widget.isHovered ? const Color(0xFF534AB7) : Colors.grey.shade300,
    SlotDisplayState.filled => const Color(0xFF534AB7),
    SlotDisplayState.locked => const Color(0xFFEF9F27),
    SlotDisplayState.correct => const Color(0xFF1D9E75),
    SlotDisplayState.wrong => const Color(0xFFE24B4A),
    SlotDisplayState.revealed => const Color(0xFF1D9E75),
  };

  Color get _textColor => switch (widget.slotState) {
    SlotDisplayState.empty => Colors.grey.shade300,
    SlotDisplayState.filled => const Color(0xFF3C3489),
    SlotDisplayState.locked => const Color(0xFF633806),
    SlotDisplayState.correct => const Color(0xFF085041),
    SlotDisplayState.wrong => const Color(0xFF791F1F),
    SlotDisplayState.revealed => const Color(0xFF085041),
  };

  @override
  Widget build(BuildContext context) {
    final isEmpty = widget.tile == null;
    final isInteractable = widget.tile != null && !widget.tile!.isLocked;

    return ScaleTransition(
      scale: _popAnim,
      child: GestureDetector(
        onTap: isInteractable ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.isHovered ? const Color(0xFFEEEDFE) : _bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _borderColor,
              width: isEmpty ? 1.5 : 2,
              style: isEmpty ? BorderStyle.solid : BorderStyle.solid,
            ),
            boxShadow: widget.slotState == SlotDisplayState.filled
                ? [
                    BoxShadow(
                      color: const Color(0xFF534AB7).withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isEmpty
                ? null
                : Text(
                    widget.tile!.letter,
                    key: ValueKey(widget.tile!.id),
                    style: TextStyle(
                      fontSize: widget.size * 0.46,
                      fontWeight: FontWeight.w800,
                      color: _textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
