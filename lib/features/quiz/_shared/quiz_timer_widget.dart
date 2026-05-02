import 'dart:async';

import 'package:flutter/material.dart';

class QuizTimerWidget extends StatefulWidget {
  const QuizTimerWidget({
    super.key,
    required this.initialSeconds,
    required this.onTick,
    required this.onCompleted,
  });

  final int initialSeconds;
  final ValueChanged<int> onTick;
  final Future<void> Function() onCompleted;

  @override
  State<QuizTimerWidget> createState() => _QuizTimerWidgetState();
}

class _QuizTimerWidgetState extends State<QuizTimerWidget> {
  Timer? _timer;
  late int _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.initialSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remaining <= 0) {
        timer.cancel();
        await widget.onCompleted();
        return;
      }

      setState(() {
        _remaining -= 1;
      });
      widget.onTick(_remaining);
    });
  }

  @override
  void didUpdateWidget(covariant QuizTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSeconds != widget.initialSeconds) {
      _remaining = widget.initialSeconds;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.timer_outlined),
        const SizedBox(width: 8),
        Text('$_remaining s'),
      ],
    );
  }
}
