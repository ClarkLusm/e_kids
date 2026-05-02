import '../domain/models/picture_match_choice.dart';
import '../domain/models/picture_match_content.dart';
import '../domain/usecases/picture_match_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class PictureMatchMapper {
  static PictureMatchContent fromRow(Map<String, dynamic> row) {
    return PictureMatchContent.fromJson(
      row['content_json'] as Map<String, dynamic>,
    );
  }
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockPictureMatchRepository implements IPictureMatchRepository {
  @override
  Future<PictureMatchContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, PictureMatchContent> _mockData = {
    // ── Chủ đề Animals ─────────────────────────────────────────────
    'pm_cat': PictureMatchContent(
      imageUrl: 'assets/images/animals/cat.webp',
      correctWord: 'cat',
      imageAudioUrl: 'assets/audio/cat.mp3',
      translationVi: 'con mèo',
      choices: const [
        PictureMatchChoice(word: 'cat', audioUrl: 'assets/audio/cat.mp3'),
        PictureMatchChoice(word: 'dog', audioUrl: 'assets/audio/dog.mp3'),
        PictureMatchChoice(word: 'bird', audioUrl: 'assets/audio/bird.mp3'),
        PictureMatchChoice(word: 'fish', audioUrl: 'assets/audio/fish.mp3'),
      ],
    ),
    'pm_elephant': PictureMatchContent(
      imageUrl: 'assets/images/animals/elephant.webp',
      correctWord: 'elephant',
      imageAudioUrl: 'assets/audio/elephant.mp3',
      translationVi: 'con voi',
      choices: const [
        PictureMatchChoice(
          word: 'elephant',
          audioUrl: 'assets/audio/elephant.mp3',
        ),
        PictureMatchChoice(word: 'lion', audioUrl: 'assets/audio/lion.mp3'),
        PictureMatchChoice(
          word: 'giraffe',
          audioUrl: 'assets/audio/giraffe.mp3',
        ),
        PictureMatchChoice(word: 'hippo', audioUrl: 'assets/audio/hippo.mp3'),
      ],
    ),
    'pm_lion': PictureMatchContent(
      imageUrl: 'assets/images/animals/lion.webp',
      correctWord: 'lion',
      imageAudioUrl: 'assets/audio/lion.mp3',
      translationVi: 'sư tử',
      choices: const [
        PictureMatchChoice(word: 'lion', audioUrl: 'assets/audio/lion.mp3'),
        PictureMatchChoice(word: 'tiger', audioUrl: 'assets/audio/tiger.mp3'),
        PictureMatchChoice(word: 'bear', audioUrl: 'assets/audio/bear.mp3'),
        PictureMatchChoice(word: 'wolf', audioUrl: 'assets/audio/wolf.mp3'),
      ],
    ),
    // ── Chủ đề Food ────────────────────────────────────────────────
    'pm_apple': PictureMatchContent(
      imageUrl: 'assets/images/food/apple.webp',
      correctWord: 'apple',
      imageAudioUrl: 'assets/audio/apple.mp3',
      translationVi: 'quả táo',
      choices: const [
        PictureMatchChoice(word: 'apple', audioUrl: 'assets/audio/apple.mp3'),
        PictureMatchChoice(word: 'banana', audioUrl: 'assets/audio/banana.mp3'),
        PictureMatchChoice(word: 'orange', audioUrl: 'assets/audio/orange.mp3'),
        PictureMatchChoice(word: 'grape', audioUrl: 'assets/audio/grape.mp3'),
      ],
    ),
    'pm_pizza': PictureMatchContent(
      imageUrl: 'assets/images/food/pizza.webp',
      correctWord: 'pizza',
      imageAudioUrl: 'assets/audio/pizza.mp3',
      translationVi: 'pizza',
      choices: const [
        PictureMatchChoice(word: 'pizza', audioUrl: 'assets/audio/pizza.mp3'),
        PictureMatchChoice(word: 'burger', audioUrl: 'assets/audio/burger.mp3'),
        PictureMatchChoice(word: 'noodle', audioUrl: 'assets/audio/noodle.mp3'),
        PictureMatchChoice(word: 'rice', audioUrl: 'assets/audio/rice.mp3'),
      ],
    ),
    // ── Chủ đề Colors ──────────────────────────────────────────────
    'pm_red': PictureMatchContent(
      imageUrl: 'assets/images/colors/red.webp',
      correctWord: 'red',
      imageAudioUrl: 'assets/audio/red.mp3',
      translationVi: 'màu đỏ',
      choices: const [
        PictureMatchChoice(word: 'red', audioUrl: 'assets/audio/red.mp3'),
        PictureMatchChoice(word: 'blue', audioUrl: 'assets/audio/blue.mp3'),
        PictureMatchChoice(word: 'green', audioUrl: 'assets/audio/green.mp3'),
        PictureMatchChoice(word: 'yellow', audioUrl: 'assets/audio/yellow.mp3'),
      ],
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockPictureMatchAttemptRepository
    implements IPictureMatchAttemptRepository {
  final List<PictureMatchResult> saved = [];

  @override
  Future<void> saveResult(PictureMatchResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] PictureMatch saved: '
      'q=${result.questionId}, '
      'correct=${result.isCorrect}, '
      'xp=${result.xpEarned}',
    );
  }
}
