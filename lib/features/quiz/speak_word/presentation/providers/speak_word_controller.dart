import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/speak_word_repository.dart';
import '../../domain/models/speak_word_state.dart';
import '../../domain/models/speech_recognition_service.dart';
import '../../domain/usecases/speak_word_usecases.dart';

// ─── Repository & service providers ──────────────────────────────────────

final speakWordRepoProvider = Provider<ISpeakWordRepository>(
  (_) => MockSpeakWordRepository(),
);

final speakWordAttemptRepoProvider = Provider<ISpeakWordAttemptRepository>(
  (_) => MockSpeakWordAttemptRepository(),
);

final speechRecognitionProvider = Provider<ISpeechRecognitionService>(
  (_) => MockSpeechRecognitionService(),
);

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchSpeakWordProvider = Provider<FetchSpeakWordUseCase>(
  (ref) => FetchSpeakWordUseCase(ref.read(speakWordRepoProvider)),
);

final saveSpeakWordProvider = Provider<SaveSpeakWordResultUseCase>(
  (ref) => SaveSpeakWordResultUseCase(ref.read(speakWordAttemptRepoProvider)),
);

// ─── Controller ───────────────────────────────────────────────────────────

final speakWordControllerProvider =
    AsyncNotifierProviderFamily<SpeakWordController, SpeakWordState, String>(
      SpeakWordController.new,
    );

class SpeakWordController extends FamilyAsyncNotifier<SpeakWordState, String> {
  late final Stopwatch _stopwatch;
  bool _sttInitialized = false;

  @override
  Future<SpeakWordState> build(String questionId) async {
    _stopwatch = Stopwatch()..start();
    final content = await ref.read(fetchSpeakWordProvider).call(questionId);

    // Khởi tạo STT ngầm khi load xong
    _initStt();

    return SpeakWordState(content);
  }

  Future<void> _initStt() async {
    if (_sttInitialized) return;
    final stt = ref.read(speechRecognitionProvider);
    _sttInitialized = await stt.initialize();
  }

  // ─── Bắt đầu ghi âm ──────────────────────────────────────────────

  Future<void> startListening() async {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;
    if (gs.status == SpeakWordStatus.listening) return;

    gs.status = SpeakWordStatus.listening;
    state = AsyncData(gs);

    final stt = ref.read(speechRecognitionProvider);

    try {
      // Lắng nghe tối đa 5 giây
      final transcript = await stt.listen(
        timeout: const Duration(seconds: 5),
        localeId: 'en_US',
      );

      await _processTranscript(gs, transcript);
    } catch (e) {
      // Lỗi microphone → về idle
      gs.status = SpeakWordStatus.idle;
      state = AsyncData(gs);
    }
  }

  // ─── Dừng ghi âm thủ công ────────────────────────────────────────

  Future<void> stopListening() async {
    final stt = ref.read(speechRecognitionProvider);
    await stt.stop();

    final gs = state.value;
    if (gs != null && gs.status == SpeakWordStatus.listening) {
      gs.status = SpeakWordStatus.processing;
      state = AsyncData(gs);
    }
  }

  // ─── Xử lý transcript từ STT ─────────────────────────────────────

  Future<void> _processTranscript(SpeakWordState gs, String? transcript) async {
    gs.status = SpeakWordStatus.processing;
    state = AsyncData(gs);

    // Ngắn delay để UI hiện processing
    await Future.delayed(const Duration(milliseconds: 500));

    final text = transcript?.trim() ?? '';
    final similarity = SimilarityCalculator.calculate(
      text,
      gs.content.acceptedVariants,
    );

    final passed = similarity >= gs.content.minSimilarityScore;

    final attempt = SpeakAttempt(
      transcript: text.isEmpty ? '(không nhận được giọng)' : text,
      similarity: similarity,
      passed: passed,
    );
    gs.attempts.add(attempt);

    if (passed) {
      _handleCorrect(gs);
    } else if (gs.attemptCount >= gs.content.maxAttempts) {
      _handleMaxReached(gs);
    } else {
      gs.status = SpeakWordStatus.wrong;
      // Hiện syllable hint sau khi sai 2 lần
      if (gs.attemptCount >= 2 && gs.content.syllableBreakdown.isNotEmpty) {
        gs.showSyllableHint = true;
      }
      state = AsyncData(gs);
    }
  }

  // ─── Xử lý đúng ──────────────────────────────────────────────────

  void _handleCorrect(SpeakWordState gs) {
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = SpeakWordStatus.correct;
    gs.xpEarned = _calcXp(gs);
    state = AsyncData(gs);
    _saveResult(gs);
  }

  // ─── Xử lý hết lượt ──────────────────────────────────────────────

  void _handleMaxReached(SpeakWordState gs) {
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = SpeakWordStatus.maxReached;
    gs.xpEarned = 0;
    state = AsyncData(gs);
    _saveResult(gs);
  }

  // ─── Phát audio mẫu ──────────────────────────────────────────────

  void playReferenceAudio() {
    final url = state.value?.content.referenceAudioUrl;
    if (url == null) return;
    // TODO: inject AudioService
    // ref.read(audioServiceProvider).play(url);
  }

  // ─── Toggle dịch nghĩa ───────────────────────────────────────────

  void toggleTranslation() {
    final gs = state.value;
    if (gs == null) return;
    gs.showTranslation = !gs.showTranslation;
    state = AsyncData(gs);
  }

  // ─── Reveal hint ─────────────────────────────────────────────────

  void revealHint() {
    final gs = state.value;
    if (gs == null) return;
    gs.showSyllableHint = true;
    gs.showTranslation = true;
    state = AsyncData(gs);
  }

  // ─── Reveal answer (bỏ cuộc) ─────────────────────────────────────

  void revealAnswer() {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = SpeakWordStatus.revealed;
    gs.xpEarned = 0;
    gs.showSyllableHint = true;
    gs.showTranslation = true;
    state = AsyncData(gs);
    _saveResult(gs);
  }

  // ─── Retry ───────────────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final content = await ref.read(fetchSpeakWordProvider).call(arg);
    state = AsyncData(SpeakWordState(content));
  }

  // ─── Helpers ─────────────────────────────────────────────────────

  int _calcXp(SpeakWordState gs) {
    const base = 20;
    // Thưởng ít lần thử
    final attemptBonus = gs.attemptCount == 1
        ? 10
        : gs.attemptCount == 2
        ? 5
        : 0;
    // Thưởng similarity cao
    final simBonus = gs.lastAttempt != null && gs.lastAttempt!.similarity >= 0.9
        ? 5
        : 0;
    return base + attemptBonus + simBonus;
  }

  void _saveResult(SpeakWordState gs) {
    ref
        .read(saveSpeakWordProvider)
        .call(
          SpeakWordResult(
            childId: 'mock_child_id',
            questionId: arg,
            isCorrect: gs.isCorrect,
            targetWord: gs.content.targetWord,
            bestTranscript: gs.lastAttempt?.transcript,
            bestSimilarity: gs.bestSimilarity,
            attemptCount: gs.attemptCount,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
          ),
        );
  }
}
