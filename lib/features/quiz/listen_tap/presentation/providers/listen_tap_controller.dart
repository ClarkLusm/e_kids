import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/listen_tap_repository.dart';
import '../../domain/models/listen_tap_state.dart';
import '../../domain/usecases/listen_tap_usecases.dart';

// ─── Repository & service providers ──────────────────────────────────────

final listenTapRepoProvider = Provider<IListenTapRepository>(
  (_) => MockListenTapRepository(),
);

final listenTapAttemptRepoProvider = Provider<IListenTapAttemptRepository>(
  (_) => MockListenTapAttemptRepository(),
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
    AsyncNotifierProviderFamily<ListenTapController, ListenTapState, String>(
      ListenTapController.new,
    );

// ─── Controller ───────────────────────────────────────────────────────────

class ListenTapController extends FamilyAsyncNotifier<ListenTapState, String> {
  late final Stopwatch _stopwatch;
  bool _timerStarted = false;

  @override
  Future<ListenTapState> build(String questionId) async {
    _stopwatch = Stopwatch();
    final content = await ref.read(fetchListenTapProvider).call(questionId);
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
    final content = await ref.read(fetchListenTapProvider).call(arg);
    final gs = ListenTapState(content);
    await _playAudio(content.audioUrl, gs);
    state = AsyncData(gs);
  }

  // ─── Helpers ──────────────────────────────────────────────────────

  int _calcXp(ListenTapState gs) {
    const base = 10;
    // Thưởng ít replay: nghe 1 lần +5, nghe 2 lần +2
    final replayBonus = gs.replayCount <= 1
        ? 5
        : gs.replayCount == 2
        ? 2
        : 0;
    // Thưởng tốc độ
    final speedBonus = gs.timeTakenMs < 6000 ? 5 : 0;
    return base + replayBonus + speedBonus;
  }

  Future<void> _saveResult(ListenTapState gs, bool isCorrect) async {
    await ref
        .read(saveListenTapProvider)
        .call(
          ListenTapResult(
            childId: 'mock_child_id',
            questionId: arg,
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
