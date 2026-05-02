import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/hint_button_widget.dart';
import '../../../_shared/quiz_timer_widget.dart';
import '../providers/memory_flip_providers.dart';
import '../widgets/flip_card_widget.dart';
import '../widgets/game_header_widget.dart';
import '../widgets/result_sheet_widget.dart';

class MemoryFlipScreen extends ConsumerStatefulWidget {
  const MemoryFlipScreen({super.key});

  @override
  ConsumerState<MemoryFlipScreen> createState() => _MemoryFlipScreenState();
}

class _MemoryFlipScreenState extends ConsumerState<MemoryFlipScreen> {
  bool _resultShown = false;

  @override
  Widget build(BuildContext context) {
    final gameAsync = ref.watch(memoryFlipControllerProvider);

    ref.listen(memoryFlipControllerProvider, (previous, next) {
      final game = next.valueOrNull;
      if (game == null || !game.isCompleted || _resultShown) {
        return;
      }

      _resultShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => ResultSheetWidget(
            score: game.score,
            flipCount: game.flipCount,
            hintsUsed: game.hintsUsed,
            onPrimaryTap: () => Navigator.of(context).pop(),
          ),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Memory Flip')),
      body: gameAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Không tải được quiz: $error'),
          ),
        ),
        data: (game) {
          final controller = ref.read(memoryFlipControllerProvider.notifier);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GameHeaderWidget(
                  progress: game.progress,
                  flipCount: game.flipCount,
                  score: game.score,
                ),
                const SizedBox(height: 12),
                QuizTimerWidget(
                  initialSeconds: game.content.timeLimitSeconds,
                  onTick: controller.updateRemainingSeconds,
                  onCompleted: controller.finishByTimeout,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: HintButtonWidget(
                    onPressed: controller.useHint,
                    label: 'Gợi ý',
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    itemCount: game.deck.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final card = game.deck[index];
                      final cardState = game.cardStates[card.cardId];

                      return FlipCardWidget(
                        card: card,
                        state: cardState!,
                        onTap: () => controller.flipCard(card.cardId),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
