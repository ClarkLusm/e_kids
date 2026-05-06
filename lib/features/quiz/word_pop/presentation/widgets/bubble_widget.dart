import 'package:flutter/material.dart';
import '../../domain/models/word_pop_state.dart';

/// Widget đại diện cho 1 bubble đang nổi trên màn hình.
/// Tự động nổi lên từ dưới lên trên trong [duration].
/// Gọi [onEscaped] khi bay ra khỏi màn hình.
/// Gọi [onTap] khi người dùng chạm.
class BubbleWidget extends StatefulWidget {
  final ActiveBubble bubble;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;
  final VoidCallback onEscaped;

  const BubbleWidget({
    required this.bubble,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
    required this.onEscaped,
    super.key,
  });

  @override
  State<BubbleWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late Animation<double> _yAnim;
  late Animation<double> _sizeAnim;

  bool _popped = false;

  static const _bubbleSize = 72.0;

  @override
  void initState() {
    super.initState();

    // Tốc độ nổi: base 4 giây, chia cho speed factor
    final duration = Duration(
      milliseconds: (4000 / widget.bubble.data.speed).round(),
    );

    _floatCtrl = AnimationController(vsync: this, duration: duration);

    // Y đi từ bottom+bubble đến -bubble (ra ngoài top)
    _yAnim = Tween<double>(
      begin: widget.screenHeight + _bubbleSize,
      end: -_bubbleSize,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.linear));

    // Scale: nổi lên lớn dần rồi nhỏ dần
    _sizeAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.05), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.92), weight: 70),
    ]).animate(_floatCtrl);

    _floatCtrl.forward();

    _floatCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        widget.onEscaped();
      }
    });
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  // ── Màu bubble theo loại ────────────────────────────────────────

  Color get _bgColor =>
      widget.bubble.data.isTarget ? const Color(0xFFEEEDFE) : Colors.white;

  Color get _borderColor => widget.bubble.data.isTarget
      ? const Color(0xFF534AB7)
      : Colors.grey.shade300;

  Color get _textColor => widget.bubble.data.isTarget
      ? const Color(0xFF26215C)
      : Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    if (_popped) return const SizedBox.shrink();

    final xPos = widget.bubble.xFraction * widget.screenWidth - _bubbleSize / 2;

    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (ctx, _) => Positioned(
        left: xPos,
        top: _yAnim.value,
        child: GestureDetector(
          onTap: () {
            if (_popped) return;
            setState(() => _popped = true);
            _floatCtrl.stop();
            widget.onTap();
          },
          child: ScaleTransition(
            scale: _sizeAnim,
            child: _popped
                ? const SizedBox.shrink()
                : _BubbleBody(
                    word: widget.bubble.data.word,
                    bgColor: _bgColor,
                    borderColor: _borderColor,
                    textColor: _textColor,
                    size: _bubbleSize,
                  ),
          ),
        ),
      ),
    );
  }
}

// ─── Bubble body ──────────────────────────────────────────────────────────

class _BubbleBody extends StatelessWidget {
  final String word;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double size;

  const _BubbleBody({
    required this.word,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            word,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ─── Pop effect overlay (bắn confetti khi chạm đúng) ──────────────────────

class BubblePopEffect extends StatefulWidget {
  final Offset position;
  final bool isCorrect;

  const BubblePopEffect({
    required this.position,
    required this.isCorrect,
    super.key,
  });

  @override
  State<BubblePopEffect> createState() => _BubblePopEffectState();
}

class _BubblePopEffectState extends State<BubblePopEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _scaleAnim = Tween<double>(
      begin: 0.5,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.4, 1.0)));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 36,
      top: widget.position.dy - 36,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (widget.isCorrect
                            ? const Color(0xFF1D9E75)
                            : const Color(0xFFE24B4A))
                        .withOpacity(0.25),
              ),
              child: Center(
                child: Text(
                  widget.isCorrect ? '✓' : '✗',
                  style: TextStyle(
                    fontSize: 28,
                    color: widget.isCorrect
                        ? const Color(0xFF1D9E75)
                        : const Color(0xFFE24B4A),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
