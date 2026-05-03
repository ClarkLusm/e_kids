import '../domain/models/listen_tap_choice.dart';
import '../domain/models/listen_tap_content.dart';
import '../domain/usecases/listen_tap_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class ListenTapMapper {
  static ListenTapContent fromRow(Map<String, dynamic> row) =>
      ListenTapContent.fromJson(row['content_json'] as Map<String, dynamic>);
}

// ─── Mock AudioPlayerService ───────────────────────────────────────────────

class MockAudioPlayerService implements IAudioPlayerService {
  bool _isPlaying = false;

  @override
  bool get isPlaying => _isPlaying;

  @override
  Future<void> play(String url) async {
    _isPlaying = true;
    // ignore: avoid_print
    print('[MockAudio] Playing: $url');
    // Giả lập thời gian phát âm
    await Future.delayed(const Duration(milliseconds: 800));
    _isPlaying = false;
  }

  @override
  Future<void> stop() async {
    _isPlaying = false;
  }
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockListenTapRepository implements IListenTapRepository {
  @override
  Future<ListenTapContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, ListenTapContent> _mockData = {
    // ── Animals ────────────────────────────────────────────────────
    'lt_cat': ListenTapContent(
      audioUrl: 'assets/audio/cat.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'cat',
          imageUrl: 'assets/images/animals/cat.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'dog',
          imageUrl: 'assets/images/animals/dog.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'bird',
          imageUrl: 'assets/images/animals/bird.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'fish',
          imageUrl: 'assets/images/animals/fish.webp',
          isCorrect: false,
        ),
      ],
    ),
    'lt_elephant': ListenTapContent(
      audioUrl: 'assets/audio/elephant.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'elephant',
          imageUrl: 'assets/images/animals/elephant.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'lion',
          imageUrl: 'assets/images/animals/lion.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'giraffe',
          imageUrl: 'assets/images/animals/giraffe.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'hippo',
          imageUrl: 'assets/images/animals/hippo.webp',
          isCorrect: false,
        ),
      ],
    ),
    'lt_monkey': ListenTapContent(
      audioUrl: 'assets/audio/monkey.mp3',
      replayLimit: 2,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'monkey',
          imageUrl: 'assets/images/animals/monkey.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'rabbit',
          imageUrl: 'assets/images/animals/rabbit.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'bear',
          imageUrl: 'assets/images/animals/bear.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'tiger',
          imageUrl: 'assets/images/animals/tiger.webp',
          isCorrect: false,
        ),
      ],
    ),
    // ── Food ───────────────────────────────────────────────────────
    'lt_apple': ListenTapContent(
      audioUrl: 'assets/audio/apple.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'apple',
          imageUrl: 'assets/images/food/apple.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'orange',
          imageUrl: 'assets/images/food/orange.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'grape',
          imageUrl: 'assets/images/food/grape.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'mango',
          imageUrl: 'assets/images/food/mango.webp',
          isCorrect: false,
        ),
      ],
    ),
    'lt_pizza': ListenTapContent(
      audioUrl: 'assets/audio/pizza.mp3',
      replayLimit: 2,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'pizza',
          imageUrl: 'assets/images/food/pizza.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'burger',
          imageUrl: 'assets/images/food/burger.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'noodle',
          imageUrl: 'assets/images/food/noodle.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'rice',
          imageUrl: 'assets/images/food/rice.webp',
          isCorrect: false,
        ),
      ],
    ),
    'lt_banana': ListenTapContent(
      audioUrl: 'assets/audio/banana.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'banana',
          imageUrl: 'assets/images/food/banana.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'apple',
          imageUrl: 'assets/images/food/apple.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'mango',
          imageUrl: 'assets/images/food/mango.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'grape',
          imageUrl: 'assets/images/food/grape.webp',
          isCorrect: false,
        ),
      ],
    ),
    // ── Colors ─────────────────────────────────────────────────────
    'lt_red': ListenTapContent(
      audioUrl: 'assets/audio/red.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'red',
          imageUrl: 'assets/images/colors/red.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'blue',
          imageUrl: 'assets/images/colors/blue.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'green',
          imageUrl: 'assets/images/colors/green.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'yellow',
          imageUrl: 'assets/images/colors/yellow.webp',
          isCorrect: false,
        ),
      ],
    ),
    'lt_purple': ListenTapContent(
      audioUrl: 'assets/audio/purple.mp3',
      replayLimit: 2,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'purple',
          imageUrl: 'assets/images/colors/purple.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'pink',
          imageUrl: 'assets/images/colors/pink.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'orange',
          imageUrl: 'assets/images/colors/orange.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'brown',
          imageUrl: 'assets/images/colors/brown.webp',
          isCorrect: false,
        ),
      ],
    ),
    // ── Numbers ────────────────────────────────────────────────────
    'lt_three': ListenTapContent(
      audioUrl: 'assets/audio/three.mp3',
      replayLimit: 3,
      showWordAfterAnswer: true,
      choices: [
        ListenTapChoice(
          word: 'three',
          imageUrl: 'assets/images/numbers/three.webp',
          isCorrect: true,
        ),
        ListenTapChoice(
          word: 'five',
          imageUrl: 'assets/images/numbers/five.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'seven',
          imageUrl: 'assets/images/numbers/seven.webp',
          isCorrect: false,
        ),
        ListenTapChoice(
          word: 'nine',
          imageUrl: 'assets/images/numbers/nine.webp',
          isCorrect: false,
        ),
      ],
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockListenTapAttemptRepository implements IListenTapAttemptRepository {
  final List<ListenTapResult> saved = [];

  @override
  Future<void> saveResult(ListenTapResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] ListenTap: '
      'q=${result.questionId}, '
      'correct=${result.isCorrect}, '
      'replays=${result.replayCount}',
    );
  }
}
