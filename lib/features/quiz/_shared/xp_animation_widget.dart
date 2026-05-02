import 'package:flutter/material.dart';

class XpAnimationWidget extends StatelessWidget {
  const XpAnimationWidget({super.key, required this.visible, required this.xp});

  final bool visible;
  final int xp;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 550),
      tween: Tween<double>(begin: visible ? 0 : 1, end: visible ? 1 : 0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 18),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text('+$xp XP'),
      ),
    );
  }
}
