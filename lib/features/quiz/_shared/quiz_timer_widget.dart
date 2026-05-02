import 'dart:async';
import 'package:flutter/material.dart';

/// Countdown timer widget dùng cho các quiz có giới hạn thời gian.
/// Gọi [onTimeUp] khi hết giờ.
class QuizTimerWidget extends StatefulWidget {
  final int totalSeconds;
  final VoidCallback onTimeUp;
  final bool autoStart;

  const QuizTimerWidget({
    required this.totalSeconds,
    required this.onTimeUp,
    this.autoStart = true,
    super.key,
  });

  @override
  State<QuizTimerWidget> createState() => QuizTimerWidgetState();
}

class QuizTimerWidgetState extends State<QuizTimerWidget>
    with SingleTickerProviderStateMixin {
  late int _remaining;
  Timer? _timer;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _remaining = widget.totalSeconds;
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    if (widget.autoStart) start();
  }

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_remaining > 0) {
          _remaining--;
          // Pulse khi còn ≤ 10 giây
          if (_remaining <= 10) {
            _pulseCtrl.forward().then((_) => _pulseCtrl.reverse());
          }
        } else {
          _timer?.cancel();
          widget.onTimeUp();
        }
      });
    });
  }

  void pause() => _timer?.cancel();
  void resume() => start();
  int get remainingSeconds => _remaining;

  @override
  void dispose() {
    _timer?.cancel();
    _pulseCtrl.dispose();
    super.dispose();
  }

  Color get _timerColor {
    final pct = _remaining / widget.totalSeconds;
    if (pct > 0.5) return const Color(0xFF1D9E75);
    if (pct > 0.25) return const Color(0xFFEF9F27);
    return const Color(0xFFE24B4A);
  }

  @override
  Widget build(BuildContext context) {
    final pct = _remaining / widget.totalSeconds;

    return ScaleTransition(
      scale: _pulseAnim,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress
            CircularProgressIndicator(
              value: pct,
              strokeWidth: 3,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(_timerColor),
            ),
            // Số giây
            Text(
              '$_remaining',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _timerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
