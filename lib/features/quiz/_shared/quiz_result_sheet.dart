import 'package:flutter/material.dart';

class QuizResultSheet extends StatelessWidget {
  const QuizResultSheet({
    super.key,
    required this.title,
    required this.score,
    required this.primaryLabel,
    required this.onPrimaryTap,
    this.subtitle,
    this.metrics = const <String>[],
    this.secondaryLabel,
    this.onSecondaryTap,
  });

  final String title;
  final int score;
  final String? subtitle;
  final List<String> metrics;
  final String primaryLabel;
  final VoidCallback onPrimaryTap;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (subtitle != null) Text(subtitle!),
          const SizedBox(height: 16),
          Text('Điểm: $score', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...metrics.map(
            (metric) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('- $metric'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPrimaryTap,
              child: Text(primaryLabel),
            ),
          ),
          if (secondaryLabel != null) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onSecondaryTap,
                child: Text(secondaryLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
