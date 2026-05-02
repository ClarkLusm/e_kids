import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/card_state.dart';
import '../../domain/models/memory_flip_game_state.dart';
import 'memory_flip_providers.dart';

class MemoryFlipController extends AsyncNotifier<MemoryFlipGameState> {
  @override
  Future<MemoryFlipGameState> build() async {
    final lessonId = ref.watch(memoryFlipLessonIdProvider);
    final quizId = ref.watch(memoryFlipQuizIdProvider);
    final fetchUseCase = ref.watch(fetchMemoryFlipUseCaseProvider);

    final content = await fetchUseCase(lessonId: lessonId, quizId: quizId);
    return MemoryFlipGameState.initial(content);
  }

  Future<void> flipCard(String cardId) async {
    final current = state.valueOrNull;
    if (current == null || current.isCompleted) {
      return;
    }

    final currentCardState = current.cardStates[cardId] ?? CardState.faceDown;
    if (currentCardState != CardState.faceDown) {
      return;
    }

    if (current.secondSelectedCardId != null) {
      return;
    }

    final nextCardStates = Map<String, CardState>.from(current.cardStates)
      ..[cardId] = CardState.faceUp;

    final firstSelected = current.firstSelectedCardId;
    if (firstSelected == null) {
      state = AsyncData(
        current.copyWith(
          cardStates: nextCardStates,
          firstSelectedCardId: cardId,
          flipCount: current.flipCount + 1,
        ),
      );
      return;
    }

    if (firstSelected == cardId) {
      return;
    }

    final firstPairId = current.cardPairMap[firstSelected];
    final secondPairId = current.cardPairMap[cardId];
    final isMatch = firstPairId != null && firstPairId == secondPairId;

    final updated = current.copyWith(
      cardStates: nextCardStates,
      secondSelectedCardId: cardId,
      flipCount: current.flipCount + 1,
    );

    state = AsyncData(updated);

    if (isMatch) {
      final matchedCardStates = Map<String, CardState>.from(updated.cardStates)
        ..[firstSelected] = CardState.matched
        ..[cardId] = CardState.matched;

      final matchedPairs = <String>{...updated.matchedPairIds, firstPairId!};
      final done = matchedPairs.length == updated.content.pairs.length;
      final matchScore = updated.content.scoreConfig.pointsPerMatch;

      final completedState = updated.copyWith(
        cardStates: matchedCardStates,
        matchedPairIds: matchedPairs,
        firstSelectedCardId: null,
        secondSelectedCardId: null,
        score: updated.score + matchScore,
        isCompleted: done,
      );

      state = AsyncData(completedState);

      if (done) {
        await _saveResult(completedState);
      }
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 700));

    final latest = state.valueOrNull;
    if (latest == null || latest.isCompleted) {
      return;
    }

    final resetCardStates = Map<String, CardState>.from(latest.cardStates)
      ..[firstSelected] = CardState.faceDown
      ..[cardId] = CardState.faceDown;

    state = AsyncData(
      latest.copyWith(
        cardStates: resetCardStates,
        firstSelectedCardId: null,
        secondSelectedCardId: null,
      ),
    );
  }

  Future<void> useHint() async {
    final current = state.valueOrNull;
    if (current == null || current.isCompleted) {
      return;
    }
    if (current.content.pairs.isEmpty) {
      return;
    }

    final unmatchedPair = current.content.pairs.firstWhere(
      (pair) => !current.matchedPairIds.contains(pair.pairId),
      orElse: () => current.content.pairs.first,
    );

    final nextCardStates = Map<String, CardState>.from(current.cardStates)
      ..[unmatchedPair.first.cardId] = CardState.faceUp
      ..[unmatchedPair.second.cardId] = CardState.faceUp;

    state = AsyncData(
      current.copyWith(
        cardStates: nextCardStates,
        hintsUsed: current.hintsUsed + 1,
        score: (current.score - current.content.scoreConfig.hintPenalty)
            .clamp(0, 1 << 30)
            .toInt(),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 900));

    final latest = state.valueOrNull;
    if (latest == null || latest.isCompleted) {
      return;
    }

    final resetCardStates = Map<String, CardState>.from(latest.cardStates)
      ..[unmatchedPair.first.cardId] = CardState.faceDown
      ..[unmatchedPair.second.cardId] = CardState.faceDown;

    state = AsyncData(
      latest.copyWith(
        cardStates: resetCardStates,
        firstSelectedCardId: null,
        secondSelectedCardId: null,
      ),
    );
  }

  void updateRemainingSeconds(int seconds) {
    final current = state.valueOrNull;
    if (current == null || current.isCompleted) {
      return;
    }
    state = AsyncData(current.copyWith(remainingSeconds: seconds));
  }

  Future<void> finishByTimeout() async {
    final current = state.valueOrNull;
    if (current == null || current.isCompleted) {
      return;
    }
    final timeoutState = current.copyWith(isCompleted: true);
    state = AsyncData(timeoutState);
    await _saveResult(timeoutState);
  }

  Future<void> _saveResult(MemoryFlipGameState gameState) async {
    final lessonId = ref.read(memoryFlipLessonIdProvider);
    final quizId = ref.read(memoryFlipQuizIdProvider);
    final saveUseCase = ref.read(saveMemoryFlipResultUseCaseProvider);

    await saveUseCase(
      lessonId: lessonId,
      quizId: quizId,
      score: gameState.score,
      flipCount: gameState.flipCount,
      hintsUsed: gameState.hintsUsed,
      completed: gameState.hasWon,
    );
  }
}
