import 'dart:math';

import 'card_content.dart';
import 'card_state.dart';
import 'memory_flip_content.dart';

const Object _unset = Object();

class MemoryFlipGameState {
  const MemoryFlipGameState({
    required this.content,
    required this.deck,
    required this.cardStates,
    required this.cardPairMap,
    required this.matchedPairIds,
    this.firstSelectedCardId,
    this.secondSelectedCardId,
    this.flipCount = 0,
    this.score = 0,
    this.hintsUsed = 0,
    this.remainingSeconds = 60,
    this.isCompleted = false,
  });

  final MemoryFlipContent content;
  final List<CardContent> deck;
  final Map<String, CardState> cardStates;
  final Map<String, String> cardPairMap;
  final Set<String> matchedPairIds;
  final String? firstSelectedCardId;
  final String? secondSelectedCardId;
  final int flipCount;
  final int score;
  final int hintsUsed;
  final int remainingSeconds;
  final bool isCompleted;

  bool get hasWon => matchedPairIds.length == content.pairs.length;

  double get progress {
    if (content.pairs.isEmpty) {
      return 0;
    }
    return matchedPairIds.length / content.pairs.length;
  }

  factory MemoryFlipGameState.initial(MemoryFlipContent content, {int? seed}) {
    final cards = <CardContent>[];
    final cardPairMap = <String, String>{};
    final cardStates = <String, CardState>{};

    for (final pair in content.pairs) {
      cards.add(pair.first);
      cards.add(pair.second);
      cardPairMap[pair.first.cardId] = pair.pairId;
      cardPairMap[pair.second.cardId] = pair.pairId;
      cardStates[pair.first.cardId] = CardState.faceDown;
      cardStates[pair.second.cardId] = CardState.faceDown;
    }

    cards.shuffle(Random(seed));

    return MemoryFlipGameState(
      content: content,
      deck: cards,
      cardStates: cardStates,
      cardPairMap: cardPairMap,
      matchedPairIds: <String>{},
      remainingSeconds: content.timeLimitSeconds,
    );
  }

  MemoryFlipGameState copyWith({
    List<CardContent>? deck,
    Map<String, CardState>? cardStates,
    Map<String, String>? cardPairMap,
    Set<String>? matchedPairIds,
    Object? firstSelectedCardId = _unset,
    Object? secondSelectedCardId = _unset,
    int? flipCount,
    int? score,
    int? hintsUsed,
    int? remainingSeconds,
    bool? isCompleted,
  }) {
    return MemoryFlipGameState(
      content: content,
      deck: deck ?? this.deck,
      cardStates: cardStates ?? this.cardStates,
      cardPairMap: cardPairMap ?? this.cardPairMap,
      matchedPairIds: matchedPairIds ?? this.matchedPairIds,
      firstSelectedCardId: identical(firstSelectedCardId, _unset)
          ? this.firstSelectedCardId
          : firstSelectedCardId as String?,
      secondSelectedCardId: identical(secondSelectedCardId, _unset)
          ? this.secondSelectedCardId
          : secondSelectedCardId as String?,
      flipCount: flipCount ?? this.flipCount,
      score: score ?? this.score,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
