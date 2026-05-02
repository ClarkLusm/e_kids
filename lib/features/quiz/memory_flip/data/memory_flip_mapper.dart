import '../domain/models/memory_flip_content.dart';
import '../domain/models/memory_flip_pair.dart';
import '../domain/models/card_content.dart';
import '../domain/models/score_config.dart';
import '../domain/usecases/fetch_memory_flip_usecase.dart';
import '../domain/usecases/save_memory_flip_result_usecase.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class MemoryFlipMapper {
  /// Map từ Supabase/DB row sang domain model
  static MemoryFlipContent fromRow(Map<String, dynamic> row) {
    return MemoryFlipContent.fromJson(
      row['content_json'] as Map<String, dynamic>,
    );
  }
}

// ─── Mock Repository (dùng cho Phase 1 khi chưa có backend) ───────────────

class MockMemoryFlipRepository implements IMemoryFlipRepository {
  @override
  Future<MemoryFlipContent> fetchById(String questionId) async {
    // Giả lập độ trễ mạng
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockData[questionId] ?? _defaultMock();
  }

  static final Map<String, MemoryFlipContent> _mockData = {
    'mf_animals_easy': MemoryFlipContent(
      gridSize: GridSize.g3x2,
      theme: 'animals',
      flipDurationMs: 600,
      previewDurationMs: 1500,
      mismatchHideMs: 1000,
      pairs: [
        MemoryFlipPair(
          id: 'p1',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/cat.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'cat',
            audioUrl: 'assets/audio/cat.mp3',
            translationVi: 'con mèo',
          ),
        ),
        MemoryFlipPair(
          id: 'p2',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/dog.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'dog',
            audioUrl: 'assets/audio/dog.mp3',
            translationVi: 'con chó',
          ),
        ),
        MemoryFlipPair(
          id: 'p3',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/bird.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'bird',
            audioUrl: 'assets/audio/bird.mp3',
            translationVi: 'con chim',
          ),
        ),
      ],
      scoreConfig: const ScoreConfig(
        baseXp: 10,
        weightMultiplier: false,
        timeBonus: true,
        timeBonusThresholdSec: 60,
        timeBonusXp: 20,
        flipPenalty: false,
      ),
      accessibility: const AccessibilityConfig(
        showLabelOnBack: true,
        autoReadOnFlip: true,
      ),
    ),
    'mf_animals_medium': MemoryFlipContent(
      gridSize: GridSize.g4x3,
      theme: 'animals',
      flipDurationMs: 700,
      mismatchHideMs: 900,
      maxFlips: 24,
      pairs: [
        MemoryFlipPair(
          id: 'p1',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/elephant.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'elephant',
            audioUrl: 'assets/audio/elephant.mp3',
            translationVi: 'con voi',
          ),
          difficultyWeight: 2,
        ),
        MemoryFlipPair(
          id: 'p2',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/lion.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'lion',
            audioUrl: 'assets/audio/lion.mp3',
            translationVi: 'sư tử',
          ),
          difficultyWeight: 1,
        ),
        MemoryFlipPair(
          id: 'p3',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/giraffe.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'giraffe',
            audioUrl: 'assets/audio/giraffe.mp3',
            translationVi: 'hươu cao cổ',
          ),
          difficultyWeight: 2,
        ),
        MemoryFlipPair(
          id: 'p4',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/hippo.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'hippo',
            audioUrl: 'assets/audio/hippo.mp3',
            translationVi: 'hà mã',
          ),
          difficultyWeight: 2,
        ),
        MemoryFlipPair(
          id: 'p5',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/zebra.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'zebra',
            audioUrl: 'assets/audio/zebra.mp3',
            translationVi: 'ngựa vằn',
          ),
          difficultyWeight: 1,
        ),
        MemoryFlipPair(
          id: 'p6',
          cardA: const CardContent(
            type: CardType.image,
            imageUrl: 'assets/images/animals/tiger.webp',
          ),
          cardB: const CardContent(
            type: CardType.word,
            word: 'tiger',
            audioUrl: 'assets/audio/tiger.mp3',
            translationVi: 'con hổ',
          ),
          difficultyWeight: 1,
        ),
      ],
      scoreConfig: const ScoreConfig(
        baseXp: 10,
        weightMultiplier: true,
        timeBonus: true,
        timeBonusThresholdSec: 90,
        timeBonusXp: 25,
        flipPenalty: false,
      ),
    ),
  };

  static MemoryFlipContent _defaultMock() => _mockData['mf_animals_easy']!;
}

// ─── Mock QuizAttempt Repository ──────────────────────────────────────────

class MockQuizAttemptRepository implements IQuizAttemptRepository {
  final List<MemoryFlipResult> savedResults = [];

  @override
  Future<void> saveResult(MemoryFlipResult result) async {
    await Future.delayed(const Duration(milliseconds: 200));
    savedResults.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] Saved result: questionId=${result.questionId}, '
      'xp=${result.xpEarned}, stars=${result.stars}',
    );
  }
}
