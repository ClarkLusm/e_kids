import '../domain/models/speak_word_content.dart';
import '../domain/models/speech_recognition_service.dart';
import '../domain/usecases/speak_word_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class SpeakWordMapper {
  static SpeakWordContent fromRow(Map<String, dynamic> row) =>
      SpeakWordContent.fromJson(row['content_json'] as Map<String, dynamic>);
}

// ─── Mock Speech Recognition ───────────────────────────────────────────────

/// Mock service giả lập STT — thực tế dùng speech_to_text package.
/// Trả về transcript ngẫu nhiên gần đúng với target word để test.
class MockSpeechRecognitionService implements ISpeechRecognitionService {
  bool _isListening = false;

  @override
  bool get isListening => _isListening;

  @override
  Future<bool> initialize() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<String?> listen({required Duration timeout, String? localeId}) async {
    _isListening = true;
    // Giả lập thời gian nghe
    await Future.delayed(const Duration(seconds: 2));
    _isListening = false;

    // Mock: trả về transcript ngẫu nhiên (80% đúng, 20% sai)
    // Trong thực tế đây là output từ speech_to_text package
    return null; // null → caller sẽ dùng fallback
  }

  @override
  Future<void> stop() async {
    _isListening = false;
  }
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockSpeakWordRepository implements ISpeakWordRepository {
  @override
  Future<SpeakWordContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, SpeakWordContent> _mockData = {
    // ── Dễ (3–4 âm) ────────────────────────────────────────────────
    'sw_cat': const SpeakWordContent(
      targetWord: 'cat',
      imageUrl: 'assets/images/animals/cat.webp',
      referenceAudioUrl: 'assets/audio/cat_native.mp3',
      phonetic: 'kæt',
      translationVi: 'con mèo',
      acceptedVariants: ['cat', 'kat', 'cet'],
      minSimilarityScore: 0.65,
      maxAttempts: 3,
      syllableBreakdown: ['cat'],
    ),
    'sw_dog': const SpeakWordContent(
      targetWord: 'dog',
      imageUrl: 'assets/images/animals/dog.webp',
      referenceAudioUrl: 'assets/audio/dog_native.mp3',
      phonetic: 'dɒɡ',
      translationVi: 'con chó',
      acceptedVariants: ['dog', 'dok', 'dug'],
      minSimilarityScore: 0.65,
      maxAttempts: 3,
      syllableBreakdown: ['dog'],
    ),
    'sw_fish': const SpeakWordContent(
      targetWord: 'fish',
      imageUrl: 'assets/images/animals/fish.webp',
      referenceAudioUrl: 'assets/audio/fish_native.mp3',
      phonetic: 'fɪʃ',
      translationVi: 'con cá',
      acceptedVariants: ['fish', 'fis', 'fesh'],
      minSimilarityScore: 0.65,
      maxAttempts: 3,
      syllableBreakdown: ['fish'],
    ),
    'sw_bird': const SpeakWordContent(
      targetWord: 'bird',
      imageUrl: 'assets/images/animals/bird.webp',
      referenceAudioUrl: 'assets/audio/bird_native.mp3',
      phonetic: 'bɜːd',
      translationVi: 'con chim',
      acceptedVariants: ['bird', 'berd', 'burd'],
      minSimilarityScore: 0.65,
      maxAttempts: 3,
      syllableBreakdown: ['bird'],
    ),
    // ── Trung bình (5–6 âm) ─────────────────────────────────────────
    'sw_apple': const SpeakWordContent(
      targetWord: 'apple',
      imageUrl: 'assets/images/food/apple.webp',
      referenceAudioUrl: 'assets/audio/apple_native.mp3',
      phonetic: 'ˈæp.əl',
      translationVi: 'quả táo',
      acceptedVariants: ['apple', 'aple', 'appel', 'aepple'],
      minSimilarityScore: 0.70,
      maxAttempts: 3,
      syllableBreakdown: ['ap', 'ple'],
    ),
    'sw_rabbit': const SpeakWordContent(
      targetWord: 'rabbit',
      imageUrl: 'assets/images/animals/rabbit.webp',
      referenceAudioUrl: 'assets/audio/rabbit_native.mp3',
      phonetic: 'ˈræb.ɪt',
      translationVi: 'con thỏ',
      acceptedVariants: ['rabbit', 'rabit', 'rabbet', 'rabiit'],
      minSimilarityScore: 0.70,
      maxAttempts: 3,
      syllableBreakdown: ['rab', 'bit'],
    ),
    'sw_mango': const SpeakWordContent(
      targetWord: 'mango',
      imageUrl: 'assets/images/food/mango.webp',
      referenceAudioUrl: 'assets/audio/mango_native.mp3',
      phonetic: 'ˈmæŋ.ɡoʊ',
      translationVi: 'quả xoài',
      acceptedVariants: ['mango', 'maango', 'manggo'],
      minSimilarityScore: 0.70,
      maxAttempts: 3,
      syllableBreakdown: ['man', 'go'],
    ),
    'sw_yellow': const SpeakWordContent(
      targetWord: 'yellow',
      imageUrl: 'assets/images/colors/yellow.webp',
      referenceAudioUrl: 'assets/audio/yellow_native.mp3',
      phonetic: 'ˈjel.oʊ',
      translationVi: 'màu vàng',
      acceptedVariants: ['yellow', 'yelo', 'yelow', 'jellow'],
      minSimilarityScore: 0.70,
      maxAttempts: 3,
      syllableBreakdown: ['yel', 'low'],
    ),
    // ── Khó (7+ âm) ──────────────────────────────────────────────────
    'sw_elephant': const SpeakWordContent(
      targetWord: 'elephant',
      imageUrl: 'assets/images/animals/elephant.webp',
      referenceAudioUrl: 'assets/audio/elephant_native.mp3',
      phonetic: 'ˈel.ɪ.fənt',
      translationVi: 'con voi',
      acceptedVariants: [
        'elephant',
        'elefant',
        'elephent',
        'elifant',
        'eliphant',
      ],
      minSimilarityScore: 0.68,
      maxAttempts: 4,
      syllableBreakdown: ['el', 'e', 'phant'],
    ),
    'sw_butterfly': const SpeakWordContent(
      targetWord: 'butterfly',
      imageUrl: 'assets/images/animals/butterfly.webp',
      referenceAudioUrl: 'assets/audio/butterfly_native.mp3',
      phonetic: 'ˈbʌt.ə.flaɪ',
      translationVi: 'con bướm',
      acceptedVariants: ['butterfly', 'butterflay', 'buterfly', 'butterflai'],
      minSimilarityScore: 0.68,
      maxAttempts: 4,
      syllableBreakdown: ['but', 'ter', 'fly'],
    ),
    'sw_crocodile': const SpeakWordContent(
      targetWord: 'crocodile',
      imageUrl: 'assets/images/animals/crocodile.webp',
      referenceAudioUrl: 'assets/audio/crocodile_native.mp3',
      phonetic: 'ˈkrɒk.ə.daɪl',
      translationVi: 'cá sấu',
      acceptedVariants: ['crocodile', 'crocadile', 'crokedile', 'crocadail'],
      minSimilarityScore: 0.65,
      maxAttempts: 4,
      syllableBreakdown: ['croc', 'o', 'dile'],
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockSpeakWordAttemptRepository implements ISpeakWordAttemptRepository {
  final List<SpeakWordResult> saved = [];

  @override
  Future<void> saveResult(SpeakWordResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] SpeakWord: '
      'q=${result.questionId}, '
      'correct=${result.isCorrect}, '
      'similarity=${result.bestSimilarity.toStringAsFixed(2)}, '
      'attempts=${result.attemptCount}',
    );
  }
}
