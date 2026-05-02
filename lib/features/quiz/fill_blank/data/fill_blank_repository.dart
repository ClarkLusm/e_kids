import '../domain/models/fill_blank_content.dart';
import '../domain/usecases/fill_blank_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class FillBlankMapper {
  static FillBlankContent fromRow(Map<String, dynamic> row) =>
      FillBlankContent.fromJson(row['content_json'] as Map<String, dynamic>);
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockFillBlankRepository implements IFillBlankRepository {
  @override
  Future<FillBlankContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, FillBlankContent> _mockData = {
    // ── Animals ────────────────────────────────────────────────────
    'fb_cat_sleeping': FillBlankContent(
      sentence: 'The ___ is sleeping.',
      sentenceVi: 'Con ___ đang ngủ.',
      imageUrl: 'assets/images/animals/sleeping_cat.webp',
      audioSentenceUrl: 'assets/audio/the_cat_is_sleeping.mp3',
      correctAnswer: 'cat',
      choices: ['cat', 'dog', 'bird'],
      blankIndex: 1,
      showTranslationHint: true,
    ),
    'fb_elephant_big': FillBlankContent(
      sentence: 'The ___ is very big.',
      sentenceVi: 'Con ___ rất to.',
      imageUrl: 'assets/images/animals/elephant.webp',
      audioSentenceUrl: 'assets/audio/the_elephant_is_very_big.mp3',
      correctAnswer: 'elephant',
      choices: ['elephant', 'cat', 'fish', 'bird'],
      blankIndex: 1,
      showTranslationHint: true,
    ),
    'fb_bird_flying': FillBlankContent(
      sentence: 'The ___ can fly.',
      sentenceVi: 'Con ___ có thể bay.',
      imageUrl: 'assets/images/animals/bird.webp',
      audioSentenceUrl: 'assets/audio/the_bird_can_fly.mp3',
      correctAnswer: 'bird',
      choices: ['bird', 'dog', 'lion'],
      blankIndex: 1,
      showTranslationHint: true,
    ),
    'fb_lion_roar': FillBlankContent(
      sentence: 'The ___ is in the jungle.',
      sentenceVi: 'Con ___ sống trong rừng.',
      imageUrl: 'assets/images/animals/lion.webp',
      audioSentenceUrl: 'assets/audio/the_lion_is_in_the_jungle.mp3',
      correctAnswer: 'lion',
      choices: ['lion', 'elephant', 'fish', 'cat'],
      blankIndex: 1,
      showTranslationHint: false,
    ),

    // ── Food ───────────────────────────────────────────────────────
    'fb_apple_red': FillBlankContent(
      sentence: 'The ___ is red and sweet.',
      sentenceVi: 'Quả ___ màu đỏ và ngọt.',
      imageUrl: 'assets/images/food/apple.webp',
      audioSentenceUrl: 'assets/audio/the_apple_is_red_and_sweet.mp3',
      correctAnswer: 'apple',
      choices: ['apple', 'banana', 'grape'],
      blankIndex: 1,
      showTranslationHint: true,
    ),
    'fb_banana_yellow': FillBlankContent(
      sentence: 'I like to eat ___.',
      sentenceVi: 'Tôi thích ăn ___.',
      imageUrl: 'assets/images/food/banana.webp',
      audioSentenceUrl: 'assets/audio/i_like_to_eat_banana.mp3',
      correctAnswer: 'banana',
      choices: ['banana', 'pizza', 'rice', 'apple'],
      blankIndex: 4,
      showTranslationHint: true,
    ),
    'fb_pizza_yummy': FillBlankContent(
      sentence: 'The ___ is very yummy!',
      sentenceVi: '___ rất ngon!',
      imageUrl: 'assets/images/food/pizza.webp',
      audioSentenceUrl: 'assets/audio/the_pizza_is_very_yummy.mp3',
      correctAnswer: 'pizza',
      choices: ['pizza', 'burger', 'noodle'],
      blankIndex: 1,
      showTranslationHint: false,
    ),

    // ── Colors ─────────────────────────────────────────────────────
    'fb_sky_blue': FillBlankContent(
      sentence: 'The sky is ___.',
      sentenceVi: 'Bầu trời màu ___.',
      imageUrl: 'assets/images/colors/blue_sky.webp',
      audioSentenceUrl: 'assets/audio/the_sky_is_blue.mp3',
      correctAnswer: 'blue',
      choices: ['blue', 'red', 'green'],
      blankIndex: 3,
      showTranslationHint: true,
    ),
    'fb_grass_green': FillBlankContent(
      sentence: 'Grass is ___ in color.',
      sentenceVi: 'Cỏ có màu ___.',
      imageUrl: 'assets/images/colors/green_grass.webp',
      audioSentenceUrl: 'assets/audio/grass_is_green_in_color.mp3',
      correctAnswer: 'green',
      choices: ['green', 'yellow', 'red', 'blue'],
      blankIndex: 2,
      showTranslationHint: true,
    ),

    // ── Body / Actions ─────────────────────────────────────────────
    'fb_run_fast': FillBlankContent(
      sentence: 'I can ___ very fast.',
      sentenceVi: 'Tôi có thể ___ rất nhanh.',
      imageUrl: 'assets/images/actions/running.webp',
      audioSentenceUrl: 'assets/audio/i_can_run_very_fast.mp3',
      correctAnswer: 'run',
      choices: ['run', 'swim', 'fly', 'jump'],
      blankIndex: 2,
      showTranslationHint: true,
    ),
    'fb_swim_water': FillBlankContent(
      sentence: 'Fish can ___ in the water.',
      sentenceVi: 'Cá có thể ___ trong nước.',
      imageUrl: 'assets/images/animals/fish.webp',
      audioSentenceUrl: 'assets/audio/fish_can_swim_in_the_water.mp3',
      correctAnswer: 'swim',
      choices: ['swim', 'run', 'fly'],
      blankIndex: 2,
      showTranslationHint: false,
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockFillBlankAttemptRepository implements IFillBlankAttemptRepository {
  final List<FillBlankResult> saved = [];

  @override
  Future<void> saveResult(FillBlankResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] FillBlank: '
      'q=${result.questionId}, '
      'correct=${result.isCorrect}, '
      'word=${result.selectedWord}, '
      'xp=${result.xpEarned}',
    );
  }
}
