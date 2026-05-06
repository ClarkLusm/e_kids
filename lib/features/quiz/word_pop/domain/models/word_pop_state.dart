import 'dart:math';
import 'word_pop_content.dart';

enum WordPopStatus {
  countdown, // đếm ngược 3-2-1 trước khi bắt đầu
  playing, // đang chơi
  complete, // tất cả bubble đã xử lý
}

/// Trạng thái của 1 bubble đang trên màn hình
enum BubbleState {
  floating, // đang nổi lên
  popped, // đã bị chạm (đúng) — bong bóng vỡ
  missed, // đã bay mất hoặc chạm sai
}

/// Một bubble đang active trên màn hình
class ActiveBubble {
  final String id;
  final WordPopBubble data;

  /// Vị trí X (0.0–1.0 theo chiều ngang màn hình)
  double xFraction;

  BubbleState state;

  /// Thời điểm spawn (ms từ khi game bắt đầu)
  final int spawnedAt;

  ActiveBubble({
    required this.id,
    required this.data,
    required this.xFraction,
    required this.spawnedAt,
  }) : state = BubbleState.floating;

  bool get isFloating => state == BubbleState.floating;
}

class WordPopState {
  final WordPopContent content;

  WordPopStatus status;

  /// Bubbles hiện đang trên màn hình
  final List<ActiveBubble> activeBubbles;

  /// Index bubble tiếp theo cần spawn
  int nextBubbleIndex;

  int score; // điểm hiện tại
  int targetsHit; // số target đã chạm đúng
  int wrongTaps; // số lần chạm nhầm
  int missedTargets; // số target đã bay mất
  int timeTakenMs;
  int xpEarned;
  int countdown; // đếm ngược 3→0

  final _rng = Random();

  WordPopState(this.content)
    : status = WordPopStatus.countdown,
      activeBubbles = [],
      nextBubbleIndex = 0,
      score = 0,
      targetsHit = 0,
      wrongTaps = 0,
      missedTargets = 0,
      timeTakenMs = 0,
      xpEarned = 0,
      countdown = 3;

  // ─── Computed ─────────────────────────────────────────────────────

  bool get isComplete => status == WordPopStatus.complete;
  bool get isPlaying => status == WordPopStatus.playing;

  int get totalTargets => content.targetCount;
  bool get allTargetsHit => targetsHit >= totalTargets;

  double get accuracy => totalTargets == 0 ? 0 : targetsHit / totalTargets;

  bool get hasMoreBubbles => nextBubbleIndex < content.bubbles.length;

  /// Spawn bubble tiếp theo — trả về ActiveBubble đã tạo
  ActiveBubble? spawnNext(int elapsedMs) {
    if (!hasMoreBubbles) return null;
    final data = content.bubbles[nextBubbleIndex];
    final bubble = ActiveBubble(
      id: 'bubble_$nextBubbleIndex',
      data: data,
      xFraction: 0.1 + _rng.nextDouble() * 0.8,
      spawnedAt: elapsedMs,
    );
    activeBubbles.add(bubble);
    nextBubbleIndex++;
    return bubble;
  }

  /// Xử lý khi tap một bubble
  TapResult tapBubble(String bubbleId) {
    final idx = activeBubbles.indexWhere((b) => b.id == bubbleId);
    if (idx < 0) return TapResult.notFound;

    final bubble = activeBubbles[idx];
    if (!bubble.isFloating) return TapResult.alreadyHandled;

    if (bubble.data.isTarget) {
      bubble.state = BubbleState.popped;
      targetsHit++;
      score += 10;
      return TapResult.correct;
    } else {
      bubble.state = BubbleState.missed;
      wrongTaps++;
      if (content.missPenalty) score = (score - 5).clamp(0, 9999);
      return TapResult.wrong;
    }
  }

  /// Đánh dấu bubble đã bay mất khỏi màn hình
  void bubbleEscaped(String bubbleId) {
    final bubble = activeBubbles.cast<ActiveBubble?>().firstWhere(
      (b) => b?.id == bubbleId,
      orElse: () => null,
    );
    if (bubble == null || !bubble.isFloating) return;
    bubble.state = BubbleState.missed;
    if (bubble.data.isTarget) missedTargets++;
  }
}

enum TapResult { correct, wrong, notFound, alreadyHandled }
