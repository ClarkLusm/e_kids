import '../domain/models/letter_scramble_content.dart';
import '../domain/usecases/letter_scramble_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class LetterScrambleMapper {
  static LetterScrambleContent fromRow(Map<String, dynamic> row) =>
      LetterScrambleContent.fromJson(
        row['content_json'] as Map<String, dynamic>,
      );
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockLetterScrambleRepository implements ILetterScrambleRepository {
  @override
  Future<LetterScrambleContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, LetterScrambleContent> _mockData = {
    // ── Animals (3–5 chữ cái — dễ) ────────────────────────────────
    'ls_cat': LetterScrambleContent(
      word: 'cat',
      imageUrl: 'assets/images/animals/cat.webp',
      audioUrl: 'assets/audio/cat.mp3',
      scrambledLetters: const ['T', 'C', 'A'],
      lockedPositions: const [],
      maxHints: 2,
      translationVi: 'con mèo',
      phonetic: 'kæt',
    ),
    'ls_dog': LetterScrambleContent(
      word: 'dog',
      imageUrl: 'assets/images/animals/dog.webp',
      audioUrl: 'assets/audio/dog.mp3',
      scrambledLetters: const ['O', 'D', 'G'],
      lockedPositions: const [],
      maxHints: 2,
      translationVi: 'con chó',
      phonetic: 'dɒɡ',
    ),
    'ls_bird': LetterScrambleContent(
      word: 'bird',
      imageUrl: 'assets/images/animals/bird.webp',
      audioUrl: 'assets/audio/bird.mp3',
      scrambledLetters: const ['R', 'B', 'D', 'I'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'con chim',
      phonetic: 'bɜːd',
    ),
    'ls_fish': LetterScrambleContent(
      word: 'fish',
      imageUrl: 'assets/images/animals/fish.webp',
      audioUrl: 'assets/audio/fish.mp3',
      scrambledLetters: const ['I', 'F', 'H', 'S'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'con cá',
      phonetic: 'fɪʃ',
    ),

    // ── Animals (6–8 chữ cái — trung bình) ────────────────────────
    'ls_rabbit': LetterScrambleContent(
      word: 'rabbit',
      imageUrl: 'assets/images/animals/rabbit.webp',
      audioUrl: 'assets/audio/rabbit.mp3',
      scrambledLetters: const ['A', 'R', 'B', 'T', 'B', 'I'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'con thỏ',
      phonetic: 'ˈræb.ɪt',
    ),
    'ls_monkey': LetterScrambleContent(
      word: 'monkey',
      imageUrl: 'assets/images/animals/monkey.webp',
      audioUrl: 'assets/audio/monkey.mp3',
      scrambledLetters: const ['O', 'M', 'E', 'N', 'Y', 'K'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'con khỉ',
      phonetic: 'ˈmʌŋ.ki',
    ),
    'ls_elephant': LetterScrambleContent(
      word: 'elephant',
      imageUrl: 'assets/images/animals/elephant.webp',
      audioUrl: 'assets/audio/elephant.mp3',
      scrambledLetters: const ['L', 'E', 'P', 'H', 'A', 'N', 'T', 'E'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'con voi',
      phonetic: 'ˈel.ɪ.fənt',
    ),
    'ls_giraffe': LetterScrambleContent(
      word: 'giraffe',
      imageUrl: 'assets/images/animals/giraffe.webp',
      audioUrl: 'assets/audio/giraffe.mp3',
      scrambledLetters: const ['I', 'G', 'A', 'F', 'R', 'E', 'F'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'hươu cao cổ',
      phonetic: 'dʒɪˈrɑːf',
    ),

    // ── Food ───────────────────────────────────────────────────────
    'ls_rice': LetterScrambleContent(
      word: 'rice',
      imageUrl: 'assets/images/food/rice.webp',
      audioUrl: 'assets/audio/rice.mp3',
      scrambledLetters: const ['C', 'R', 'E', 'I'],
      lockedPositions: const [],
      maxHints: 2,
      translationVi: 'cơm / gạo',
      phonetic: 'raɪs',
    ),
    'ls_apple': LetterScrambleContent(
      word: 'apple',
      imageUrl: 'assets/images/food/apple.webp',
      audioUrl: 'assets/audio/apple.mp3',
      scrambledLetters: const ['P', 'A', 'L', 'E', 'P'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'quả táo',
      phonetic: 'ˈæp.əl',
    ),
    'ls_mango': LetterScrambleContent(
      word: 'mango',
      imageUrl: 'assets/images/food/mango.webp',
      audioUrl: 'assets/audio/mango.mp3',
      scrambledLetters: const ['A', 'M', 'G', 'O', 'N'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'quả xoài',
      phonetic: 'ˈmæŋ.ɡoʊ',
    ),

    // ── Colors ─────────────────────────────────────────────────────
    'ls_blue': LetterScrambleContent(
      word: 'blue',
      imageUrl: 'assets/images/colors/blue.webp',
      audioUrl: 'assets/audio/blue.mp3',
      scrambledLetters: const ['L', 'B', 'E', 'U'],
      lockedPositions: const [],
      maxHints: 2,
      translationVi: 'màu xanh dương',
      phonetic: 'bluː',
    ),
    'ls_green': LetterScrambleContent(
      word: 'green',
      imageUrl: 'assets/images/colors/green.webp',
      audioUrl: 'assets/audio/green.mp3',
      scrambledLetters: const ['E', 'G', 'N', 'E', 'R'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'màu xanh lá',
      phonetic: 'ɡriːn',
    ),
    'ls_yellow': LetterScrambleContent(
      word: 'yellow',
      imageUrl: 'assets/images/colors/yellow.webp',
      audioUrl: 'assets/audio/yellow.mp3',
      scrambledLetters: const ['E', 'Y', 'L', 'O', 'W', 'L'],
      lockedPositions: const [0],
      maxHints: 2,
      translationVi: 'màu vàng',
      phonetic: 'ˈjel.oʊ',
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockLetterScrambleAttemptRepository
    implements ILetterScrambleAttemptRepository {
  final List<LetterScrambleResult> saved = [];

  @override
  Future<void> saveResult(LetterScrambleResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] LetterScramble: '
      'q=${result.questionId}, '
      'correct=${result.isCorrect}, '
      'word=${result.submittedWord}, '
      'hints=${result.hintsUsed}',
    );
  }
}
