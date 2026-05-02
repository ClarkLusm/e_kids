import 'package:flutter/material.dart';

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({
    super.key,
    required this.progress,
    required this.flipCount,
    required this.score,
  });

  final double progress;
  final int flipCount;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(value: progress.clamp(0, 1)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Lật: $flipCount'), Text('Điểm: $score')],
          ),
        ],
      ),
    );
  }
}
