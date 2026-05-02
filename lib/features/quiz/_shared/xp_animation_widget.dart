import 'package:flutter/material.dart';

/// Overlay widget hiển thị animation "+XP" bay lên và mờ dần.
/// Dùng với OverlayEntry hoặc trực tiếp trong Stack.
class XpAnimationWidget extends StatefulWidget {
  final int xpAmount;
  final Offset startOffset;
  final VoidCallback? onDone;

  const XpAnimationWidget({
    required this.xpAmount,
    required this.startOffset,
    this.onDone,
    super.key,
  });

  @override
  State<XpAnimationWidget> createState() => _XpAnimationWidgetState();
}

class _XpAnimationWidgetState extends State<XpAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _yAnim;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _yAnim = Tween<double>(
      begin: 0,
      end: -80,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.3), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 70),
    ]).animate(_ctrl);

    _ctrl.forward().then((_) => widget.onDone?.call());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, _) => Positioned(
        left: widget.startOffset.dx - 24,
        top: widget.startOffset.dy + _yAnim.value,
        child: Opacity(
          opacity: _opacityAnim.value,
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF534AB7),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF534AB7).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '+${widget.xpAmount} XP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper: hiện XP animation qua Overlay
class XpOverlayHelper {
  static void show(
    BuildContext context, {
    required int xpAmount,
    required Offset startOffset,
  }) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => XpAnimationWidget(
        xpAmount: xpAmount,
        startOffset: startOffset,
        onDone: () => entry.remove(),
      ),
    );
    Overlay.of(context).insert(entry);
  }
}
