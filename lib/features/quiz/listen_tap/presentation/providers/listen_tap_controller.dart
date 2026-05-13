import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/listen_tap_repository.dart';
import '../../domain/models/listen_tap_state.dart';
import '../../domain/usecases/listen_tap_usecases.dart';
import '../../../_shared/data/local/local_quiz_attempt_repository.dart';
import '../../../_shared/domain/models/quiz_xp_input.dart';
import '../../../_shared/domain/usecases/calculate_quiz_xp_usecase.dart';
import '../../../_shared/question_ref.dart';

// ─── Repository & service providers ──────────────────────────────────────

final listenTapRepoProvider = Provider<IListenTapRepository>(
  (_) => MockListenTapRepository(),
);

final listenTapAttemptRepoProvider = Provider<IListenTapAttemptRepository>(
  (ref) => ref.watch(localListenTapAttemptRepositoryProvider),
);

final audioPlayerServiceProvider = Provider<IAudioPlayerService>(
  (_) => MockAudioPlayerService(),
);

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchListenTapProvider = Provider<FetchListenTapUseCase>(
  (ref) => FetchListenTapUseCase(ref.read(listenTapRepoProvider)),
);

final saveListenTapProvider = Provider<SaveListenTapResultUseCase>(
  (ref) => SaveListenTapResultUseCase(ref.read(listenTapAttemptRepoProvider)),
);

// ─── Controller provider ──────────────────────────────────────────────────

final listenTapControllerProvider =
    AsyncNotifierProviderFamily<
      ListenTapController,
      ListenTapState,
      QuizQuestionArgs
    >(ListenTapController.new);

// ─── Controller ───────────────────────────────────────────────────────────

class ListenTapController
    extends FamilyAsyncNotifier<ListenTapState, QuizQuestionArgs> {
  late final Stopwatch _stopwatch;
  bool _timerStarted = false;

  @override
  Future<ListenTapState> build(QuizQuestionArgs args) async {
    _stopwatch = Stopwatch();
    final content = await ref
        .read(fetchListenTapProvider)
        .call(args.questionId);
    final gs = ListenTapState(content);

    // Auto-play audio khi load xong
    await _playAudio(content.audioUrl, gs);
    return gs;
  }

  // ─── Phát / replay audio ──────────────────────────────────────────

  Future<void> playAudio() async {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;
    if (gs.status == ListenTapStatus.playing) return;
    if (!gs.canReplay) return;

    if (gs.replayCount > 0) gs.replayCount++;
    await _playAudio(gs.content.audioUrl, gs);
  }

  Future<void> _playAudio(String url, ListenTapState gs) async {
    gs.status = ListenTapStatus.playing;
    state = AsyncData(gs);

    // Bắt đầu đếm giờ từ lần nghe đầu tiên
    if (!_timerStarted) {
      _timerStarted = true;
      _stopwatch.start();
    }

    await ref.read(audioPlayerServiceProvider).play(url);

    if (state.value != null && !state.value!.isAnswered) {
      gs.status = ListenTapStatus.idle;
      state = AsyncData(gs);
    }
  }

  // ─── Chọn đáp án ──────────────────────────────────────────────────

  Future<void> selectAnswer(String word) async {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    // Bắt buộc phải nghe ít nhất 1 lần trước khi chọn
    if (gs.status == ListenTapStatus.waitingToPlay) return;
    if (gs.status == ListenTapStatus.playing) return;

    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.selectedWord = word;

    final isCorrect = word == gs.content.correctChoice.word;
    gs.status = isCorrect ? ListenTapStatus.correct : ListenTapStatus.wrong;
    gs.xpEarned = isCorrect ? _calcXp(gs) : 0;

    state = AsyncData(gs);
    await _saveResult(gs, isCorrect);
  }

  // ─── Reveal đáp án ────────────────────────────────────────────────

  void revealAnswer() {
    final gs = state.value;
    if (gs == null || gs.isCorrect) return;

    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = ListenTapStatus.revealed;
    gs.xpEarned = 0;
    state = AsyncData(gs);
    _saveResult(gs, false);
  }

  // ─── Retry ────────────────────────────────────────────────────────

  Future<void> retry() async {
    _timerStarted = false;
    _stopwatch
      ..reset()
      ..stop();
    state = const AsyncLoading();
    final content = await ref.read(fetchListenTapProvider).call(arg.questionId);
    final gs = ListenTapState(content);
    await _playAudio(content.audioUrl, gs);
    state = AsyncData(gs);
  }

  // ─── Helpers ──────────────────────────────────────────────────────

  int _calcXp(ListenTapState gs) {
    return const CalculateQuizXpUseCase()(
      QuizXpInput(
        isCorrect: true,
        // TODO(db): lấy difficulty từ quiz_questions khi nối Drift.
        timeTakenMs: gs.timeTakenMs,
        attemptIndex: gs.replayCount + 1,
      ),
    );
  }

  Future<void> _saveResult(ListenTapState gs, bool isCorrect) async {
    await ref
        .read(saveListenTapProvider)
        .call(
          ListenTapResult(
            childId: 'mock_child_id',
            lessonId: arg.lessonId,
            questionId: arg.questionId,
            isCorrect: isCorrect,
            selectedWord: gs.selectedWord ?? '',
            correctWord: gs.content.correctChoice.word,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
            replayCount: gs.replayCount,
          ),
        );
  }
}
