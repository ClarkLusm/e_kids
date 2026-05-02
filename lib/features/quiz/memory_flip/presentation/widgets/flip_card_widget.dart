import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/models/card_content.dart';
import '../../domain/models/card_state.dart';

class FlipCardWidget extends StatelessWidget {
  const FlipCardWidget({
    super.key,
    required this.card,
    required this.state,
    required this.onTap,
  });

  final CardContent card;
  final CardState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isFaceUp = state != CardState.faceDown;
    final isMatched = state == CardState.matched;

    return GestureDetector(
      onTap: isMatched ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isMatched ? Colors.green.shade100 : Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 4),
              color: Color(0x1A000000),
            ),
          ],
          border: Border.all(
            color: isFaceUp ? Colors.blue.shade300 : Colors.blueGrey.shade200,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, animation) {
            return AnimatedBuilder(
              animation: animation,
              child: child,
              builder: (context, child) {
                final rotation = (1 - animation.value) * math.pi;
                return Transform(
                  transform: Matrix4.rotationY(rotation),
                  alignment: Alignment.center,
                  child: child,
                );
              },
            );
          },
          child: isFaceUp
              ? _CardFront(key: ValueKey(card.cardId), card: card)
              : const _CardBack(key: ValueKey('back')),
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.help_outline_rounded, size: 28, color: Colors.blueGrey),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({super.key, required this.card});

  final CardContent card;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: switch (card.type) {
        CardContentType.text => Text(
          card.value,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        CardContentType.emoji => Text(
          card.value,
          style: const TextStyle(fontSize: 30),
        ),
        CardContentType.image => const Icon(Icons.image_outlined, size: 30),
        CardContentType.audio => const Icon(Icons.volume_up_rounded, size: 30),
      },
    );
  }
}
