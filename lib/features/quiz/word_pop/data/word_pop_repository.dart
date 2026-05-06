import '../domain/models/word_pop_content.dart';
import '../domain/usecases/word_pop_usecases.dart';

class MockWordPopRepository implements IWordPopRepository {
  @override
  Future<WordPopContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _data[questionId] ?? _data.values.first;
  }

  static final Map<String, WordPopContent> _data = {
    // ── Animals (dễ — 6 bubbles) ───────────────────────────────────
    'wp_animals': WordPopContent(
      instruction: 'Tap all ANIMALS!',
      instructionVi: 'Chạm vào tất cả ĐỘNG VẬT!',
      targetCategory: 'animals',
      spawnIntervalMs: 1400,
      missPenalty: false,
      bubbles: [
        WordPopBubble(word: 'dog', isTarget: true, speed: 1.0),
        WordPopBubble(word: 'pizza', isTarget: false, speed: 0.8),
        WordPopBubble(word: 'cat', isTarget: true, speed: 1.1),
        WordPopBubble(word: 'blue', isTarget: false, speed: 0.9),
        WordPopBubble(word: 'bird', isTarget: true, speed: 1.2),
        WordPopBubble(word: 'table', isTarget: false, speed: 1.0),
      ],
    ),
    // ── Food (trung bình — 8 bubbles) ─────────────────────────────
    'wp_food': WordPopContent(
      instruction: 'Tap all FOOD!',
      instructionVi: 'Chạm vào tất cả THỨC ĂN!',
      targetCategory: 'food',
      spawnIntervalMs: 1200,
      missPenalty: false,
      bubbles: [
        WordPopBubble(word: 'apple', isTarget: true, speed: 1.0),
        WordPopBubble(word: 'lion', isTarget: false, speed: 0.9),
        WordPopBubble(word: 'pizza', isTarget: true, speed: 1.1),
        WordPopBubble(word: 'run', isTarget: false, speed: 1.2),
        WordPopBubble(word: 'banana', isTarget: true, speed: 0.8),
        WordPopBubble(word: 'red', isTarget: false, speed: 1.0),
        WordPopBubble(word: 'mango', isTarget: true, speed: 1.3),
        WordPopBubble(word: 'jump', isTarget: false, speed: 0.9),
      ],
    ),
    // ── Colors (khó — 10 bubbles, có penalty) ─────────────────────
    'wp_colors': WordPopContent(
      instruction: 'Tap all COLORS!',
      instructionVi: 'Chạm vào tất cả MÀU SẮC!',
      targetCategory: 'colors',
      spawnIntervalMs: 1000,
      missPenalty: true,
      bubbles: [
        WordPopBubble(word: 'red', isTarget: true, speed: 1.0),
        WordPopBubble(word: 'elephant', isTarget: false, speed: 1.1),
        WordPopBubble(word: 'blue', isTarget: true, speed: 1.2),
        WordPopBubble(word: 'swim', isTarget: false, speed: 0.9),
        WordPopBubble(word: 'green', isTarget: true, speed: 1.3),
        WordPopBubble(word: 'rice', isTarget: false, speed: 1.0),
        WordPopBubble(word: 'yellow', isTarget: true, speed: 0.8),
        WordPopBubble(word: 'monkey', isTarget: false, speed: 1.1),
        WordPopBubble(word: 'purple', isTarget: true, speed: 1.4),
        WordPopBubble(word: 'giraffe', isTarget: false, speed: 1.0),
      ],
    ),
    // ── Numbers (mixed — 8 bubbles) ────────────────────────────────
    'wp_numbers': WordPopContent(
      instruction: 'Tap all NUMBERS!',
      instructionVi: 'Chạm vào tất cả CON SỐ!',
      targetCategory: 'numbers',
      spawnIntervalMs: 1100,
      missPenalty: false,
      bubbles: [
        WordPopBubble(word: 'one', isTarget: true, speed: 1.0),
        WordPopBubble(word: 'cat', isTarget: false, speed: 1.1),
        WordPopBubble(word: 'two', isTarget: true, speed: 1.2),
        WordPopBubble(word: 'apple', isTarget: false, speed: 0.9),
        WordPopBubble(word: 'three', isTarget: true, speed: 0.8),
        WordPopBubble(word: 'run', isTarget: false, speed: 1.3),
        WordPopBubble(word: 'four', isTarget: true, speed: 1.0),
        WordPopBubble(word: 'blue', isTarget: false, speed: 1.1),
      ],
    ),
  };
}

class MockWordPopAttemptRepository implements IWordPopAttemptRepository {
  final List<WordPopResult> saved = [];

  @override
  Future<void> saveResult(WordPopResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] WordPop: q=${result.questionId}, '
      'hit=${result.targetsHit}/${result.totalTargets}, '
      'score=${result.score}',
    );
  }
}
