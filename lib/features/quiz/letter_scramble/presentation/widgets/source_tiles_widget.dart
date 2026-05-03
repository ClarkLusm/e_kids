import 'package:flutter/material.dart';
import '../../domain/models/letter_tile.dart';

/// Pool chữ cái xáo trộn ở phía dưới màn hình.
/// Mỗi tile là Draggable<String> (drag ID của tile).
/// Tap tile → đặt vào slot trống đầu tiên.
class SourceTilesWidget extends StatelessWidget {
  final List<LetterTile> tiles;
  final bool isAnswered;
  final void Function(String tileId) onTileTap;

  const SourceTilesWidget({
    required this.tiles,
    required this.isAnswered,
    required this.onTileTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (tiles.isEmpty && !isAnswered) {
      return const SizedBox(height: 60);
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: tiles
          .map(
            (tile) => _DraggableLetterTile(
              tile: tile,
              isAnswered: isAnswered,
              onTap: () => onTileTap(tile.id),
            ),
          )
          .toList(),
    );
  }
}

// ─── Tile có thể drag ─────────────────────────────────────────────────────

class _DraggableLetterTile extends StatefulWidget {
  final LetterTile tile;
  final bool isAnswered;
  final VoidCallback onTap;

  const _DraggableLetterTile({
    required this.tile,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  State<_DraggableLetterTile> createState() => _DraggableLetterTileState();
}

class _DraggableLetterTileState extends State<_DraggableLetterTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _appearCtrl;
  late Animation<double> _appearAnim;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _appearCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _appearAnim = CurvedAnimation(
      parent: _appearCtrl,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _appearCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _appearAnim,
      child: Draggable<String>(
        data: widget.tile.id,
        onDragStarted: () => setState(() => _isDragging = true),
        onDragEnd: (_) => setState(() => _isDragging = false),
        onDraggableCanceled: (_, __) => setState(() => _isDragging = false),
        // Widget hiện khi đang kéo (ghost)
        feedback: _LetterTileBox(
          letter: widget.tile.letter,
          style: _TileStyle.dragging,
        ),
        // Widget còn lại ở vị trí gốc khi đang drag
        childWhenDragging: _LetterTileBox(
          letter: widget.tile.letter,
          style: _TileStyle.ghost,
        ),
        child: GestureDetector(
          onTap: widget.isAnswered ? null : widget.onTap,
          child: AnimatedOpacity(
            opacity: _isDragging ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: _LetterTileBox(
              letter: widget.tile.letter,
              style: widget.isAnswered
                  ? _TileStyle.disabled
                  : _TileStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Tile box ─────────────────────────────────────────────────────────────

enum _TileStyle { normal, dragging, ghost, disabled }

class _LetterTileBox extends StatelessWidget {
  final String letter;
  final _TileStyle style;

  const _LetterTileBox({required this.letter, required this.style});

  Color get _bg => switch (style) {
    _TileStyle.normal => Colors.white,
    _TileStyle.dragging => const Color(0xFF534AB7),
    _TileStyle.ghost => Colors.grey.shade100,
    _TileStyle.disabled => Colors.grey.shade100,
  };

  Color get _border => switch (style) {
    _TileStyle.normal => const Color(0xFFAFA9EC),
    _TileStyle.dragging => const Color(0xFF3C3489),
    _TileStyle.ghost => Colors.grey.shade200,
    _TileStyle.disabled => Colors.grey.shade200,
  };

  Color get _text => switch (style) {
    _TileStyle.normal => const Color(0xFF26215C),
    _TileStyle.dragging => Colors.white,
    _TileStyle.ghost => Colors.grey.shade300,
    _TileStyle.disabled => Colors.grey.shade300,
  };

  List<BoxShadow> get _shadow => switch (style) {
    _TileStyle.normal => [
      BoxShadow(
        color: const Color(0xFF534AB7).withOpacity(0.2),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
    _TileStyle.dragging => [
      BoxShadow(
        color: const Color(0xFF534AB7).withOpacity(0.4),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
    ],
    _ => [],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 2),
        boxShadow: _shadow,
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: _text,
        ),
      ),
    );
  }
}
