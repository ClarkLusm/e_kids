import 'package:e_kids/features/quiz/memory_flip/domain/models/card_content.dart';

class MemoryFlipPair {
  final String id;
  final CardContent cardA;
  final CardContent cardB;
  final String? audioOnMatch;
  final int difficultyWeight;

  const MemoryFlipPair({
    required this.id,
    required this.cardA,
    required this.cardB,
    this.audioOnMatch,
    this.difficultyWeight = 1,
  });
}

class ScoreConfig {
  final int baseXp;
  final bool weightMultiplier;
  final bool timeBonus;
  final int timeBonusThresholdSec;
  final int timeBonusXp;
  final bool flipPenalty;
  final int flipPenaltyAfter;
  final int flipPenaltyXp;

  const ScoreConfig({
    this.baseXp = 10,
    this.weightMultiplier = true,
    this.timeBonus = false,
    this.timeBonusThresholdSec = 60,
    this.timeBonusXp = 20,
    this.flipPenalty = false,
    this.flipPenaltyAfter = 30,
    this.flipPenaltyXp = 2,
  });
}
