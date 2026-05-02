import 'dart:async';
import 'package:flutter/material.dart';

class GameHeaderWidget extends StatefulWidget {
  final int matchCount;
  final int totalPairs;
  final int flipCount;
  final int? maxFlips;
  final bool showTimer;

  const GameHeaderWidget({
    required this.matchCount,
    required this.totalPairs,
    required this.flipCount,
    this.maxFlips,
    this.showTimer = true,
    super.key,
  });

  @override
  State<GameHeaderWidget> createState() => _GameHeaderWidgetState();
}

class _GameHeaderWidgetState extends State<GameHeaderWidget> {
  late Timer _ticker;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  String get _timeLabel {
    final m = _seconds ~/ 60;
    final s = _seconds % 60;
    return m > 0
        ? '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}'
        : '0:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.matchCount / widget.totalPairs;
    final flipLimitWarning =
        widget.maxFlips != null &&
        widget.flipCount >= (widget.maxFlips! * 0.8).ceil();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: tiến độ + timer + flip counter
          Row(
            children: [
              // Tiến độ văn bản
              Text(
                '${widget.matchCount}/${widget.totalPairs} cặp',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF534AB7),
                ),
              ),
              const Spacer(),
              // Timer
              if (widget.showTimer) ...[
                const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 3),
                Text(
                  _timeLabel,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(width: 12),
              ],
              // Flip counter
              Icon(
                Icons.flip,
                size: 14,
                color: flipLimitWarning ? const Color(0xFFE24B4A) : Colors.grey,
              ),
              const SizedBox(width: 3),
              Text(
                widget.maxFlips != null
                    ? '${widget.flipCount}/${widget.maxFlips}'
                    : '${widget.flipCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: flipLimitWarning
                      ? const Color(0xFFE24B4A)
                      : Colors.grey,
                  fontWeight: flipLimitWarning
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress == 1.0
                    ? const Color(0xFF1D9E75)
                    : const Color(0xFF534AB7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
