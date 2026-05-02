import 'package:flutter/material.dart';

class HintButtonWidget extends StatelessWidget {
  const HintButtonWidget({
    super.key,
    required this.onPressed,
    this.label = 'Hint',
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.lightbulb_outline_rounded),
      label: Text(label),
    );
  }
}
