import 'package:flutter/material.dart';
import '../../domain/models/sort_bucket_entities.dart';

/// Thẻ từ vựng có thể kéo thả từ pool vào bucket.
/// Hiện ảnh (nếu có) + tên từ.
class DraggableItemWidget extends StatefulWidget {
  final SortItem item;
  final bool isEnabled;

  const DraggableItemWidget({
    required this.item,
    this.isEnabled = true,
    super.key,
  });

  @override
  State<DraggableItemWidget> createState() => _DraggableItemWidgetState();
}

class _DraggableItemWidgetState extends State<DraggableItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _appearCtrl;
  late Animation<double> _appearAnim;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _appearCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
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
        data: widget.item.id,
        onDragStarted: () => setState(() => _isDragging = true),
        onDragEnd: (_) => setState(() => _isDragging = false),
        onDraggableCanceled: (_, __) => setState(() => _isDragging = false),
        feedback: _ItemCard(item: widget.item, style: _ItemStyle.dragging),
        childWhenDragging: _ItemCard(
          item: widget.item,
          style: _ItemStyle.ghost,
        ),
        child: AnimatedOpacity(
          opacity: _isDragging ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: _ItemCard(
            item: widget.item,
            style: widget.isEnabled ? _ItemStyle.normal : _ItemStyle.disabled,
          ),
        ),
      ),
    );
  }
}

// ─── Item card ────────────────────────────────────────────────────────────

enum _ItemStyle { normal, dragging, ghost, disabled }

class _ItemCard extends StatelessWidget {
  final SortItem item;
  final _ItemStyle style;

  const _ItemCard({required this.item, required this.style});

  Color get _bg => switch (style) {
    _ItemStyle.normal => Colors.white,
    _ItemStyle.dragging => const Color(0xFF534AB7),
    _ItemStyle.ghost => Colors.grey.shade100,
    _ItemStyle.disabled => Colors.grey.shade100,
  };

  Color get _border => switch (style) {
    _ItemStyle.normal => const Color(0xFFE0DEFC),
    _ItemStyle.dragging => const Color(0xFF3C3489),
    _ItemStyle.ghost => Colors.grey.shade200,
    _ItemStyle.disabled => Colors.grey.shade200,
  };

  Color get _textColor => switch (style) {
    _ItemStyle.normal => const Color(0xFF26215C),
    _ItemStyle.dragging => Colors.white,
    _ItemStyle.ghost => Colors.grey.shade300,
    _ItemStyle.disabled => Colors.grey.shade400,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 1.5),
        boxShadow: style == _ItemStyle.normal
            ? [
                BoxShadow(
                  color: const Color(0xFF534AB7).withOpacity(0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : style == _ItemStyle.dragging
            ? [
                BoxShadow(
                  color: const Color(0xFF534AB7).withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ảnh nhỏ
          if (item.imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                item.imageUrl!,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.image_outlined,
                  size: 26,
                  color: _textColor.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(width: 7),
          ],
          // Tên từ
          Text(
            item.word,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _textColor,
            ),
          ),
        ],
      ),
    );
  }
}
