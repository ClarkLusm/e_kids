import 'card_state.dart';
import 'memory_flip_content.dart';
import 'memory_flip_pair.dart';

class MemoryFlipGameState {
  final MemoryFlipContent content;

  /// Board đã shuffle — mỗi thẻ là 1 CardState độc lập
  final List<CardState> board;

  int flipCount = 0;
  int matchCount = 0;
  int earnedXp = 0;

  /// Thẻ lật đầu tiên đang chờ
  CardState? firstFlipped;

  final Stopwatch _timer = Stopwatch();

  MemoryFlipGameState(this.content) : board = _buildBoard(content);

  // ─── Factory ───────────────────────────────────────────────

  static List<CardState> _buildBoard(MemoryFlipContent c) {
    final cards = <CardState>[];
    for (final pair in c.pairs) {
      cards.add(CardState(pairId: pair.id, content: pair.cardA, isCardA: true));
      cards.add(
        CardState(pairId: pair.id, content: pair.cardB, isCardA: false),
      );
    }
    cards.shuffle();
    return cards;
  }

  // ─── Timer ─────────────────────────────────────────────────

  void startTimer() => _timer.start();
  void stopTimer() => _timer.stop();
  int get elapsedSec => _timer.elapsed.inSeconds;

  // ─── Game status ───────────────────────────────────────────

  bool get isComplete => matchCount == content.gridSize.pairCount;

  bool get isFlipLimitReached =>
      content.maxFlips != null && flipCount >= content.maxFlips!;

  // ─── Score calculation ─────────────────────────────────────

  int computeFinalXp() {
    final sc = content.scoreConfig;

    // Tính XP cơ bản: mỗi cặp base_xp × difficulty_weight
    var xp = content.pairs.fold<int>(0, (sum, pair) {
      final weight = sc.weightMultiplier ? pair.difficultyWeight : 1;
      return sum + sc.baseXp * weight;
    });

    // Thưởng thời gian
    if (sc.timeBonus && elapsedSec <= sc.timeBonusThresholdSec) {
      xp += sc.timeBonusXp;
    }

    // Phạt lật quá nhiều
    if (sc.flipPenalty && flipCount > sc.flipPenaltyAfter) {
      final excess = flipCount - sc.flipPenaltyAfter;
      xp -= excess * sc.flipPenaltyXp;
    }

    return xp.clamp(0, 9999);
  }

  /// Tính số sao (1–3) dựa trên số lần lật + thời gian
  int computeStars() {
    final minFlips = content.gridSize.pairCount * 2;
    final sc = content.scoreConfig;

    final fastTime = sc.timeBonus && elapsedSec <= sc.timeBonusThresholdSec;
    final lowFlips = flipCount <= (minFlips * 1.5).ceil();
    final medFlips = flipCount <= minFlips * 2;

    if (lowFlips && fastTime) return 3;
    if (medFlips) return 2;
    return 1;
  }

  /// Lấy MemoryFlipPair từ pairId
  MemoryFlipPair pairById(String pairId) =>
      content.pairs.firstWhere((p) => p.id == pairId);
}
