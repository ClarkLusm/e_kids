import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/word_pop_repository.dart';
import '../../domain/models/word_pop_state.dart';
import '../../domain/usecases/word_pop_usecases.dart';
import '../../../_shared/data/local/local_quiz_attempt_repository.dart';
import '../../../_shared/domain/models/quiz_xp_input.dart';
import '../../../_shared/domain/usecases/calculate_quiz_xp_usecase.dart';
import '../../../_shared/question_ref.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final wordPopRepoProvider = Provider<IWordPopRepository>(
  (_) => MockWordPopRepository(),
);

final wordPopAttemptRepoProvider = Provider<IWordPopAttemptRepository>(
  (ref) => ref.watch(localWordPopAttemptRepositoryProvider),
);

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchWordPopProvider = Provider<FetchWordPopUseCase>(
  (ref) => FetchWordPopUseCase(ref.read(wordPopRepoProvider)),
);

final saveWordPopProvider = Provider<SaveWordPopResultUseCase>(
  (ref) => SaveWordPopResultUseCase(ref.read(wordPopAttemptRepoProvider)),
);

// ─── Controller ───────────────────────────────────────────────────────────

final wordPopControllerProvider =
    AsyncNotifierProviderFamily<
      WordPopController,
      WordPopState,
      QuizQuestionArgs
    >(WordPopController.new);

class WordPopController
    extends FamilyAsyncNotifier<WordPopState, QuizQuestionArgs> {
  Timer? _countdownTimer;
  Timer? _spawnTimer;
  Timer? _gameTimer;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  Future<WordPopState> build(QuizQuestionArgs args) async {
    // Huỷ timers khi dispose
    ref.onDispose(() {
      _countdownTimer?.cancel();
      _spawnTimer?.cancel();
      _gameTimer?.cancel();
      _stopwatch.stop();
    });

    final content = await ref.read(fetchWordPopProvider).call(args.questionId);
    final gs = WordPopState(content);

    // Bắt đầu đếm ngược
    _startCountdown(gs);
    return gs;
  }

  // ─── Countdown 3-2-1 ─────────────────────────────────────────────

  void _startCountdown(WordPopState gs) {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      gs.countdown--;
      if (gs.countdown <= 0) {
        t.cancel();
        gs.status = WordPopStatus.playing;
        _startGame(gs);
      }
      state = AsyncData(gs);
    });
  }

  // ─── Bắt đầu game ────────────────────────────────────────────────

  void _startGame(WordPopState gs) {
    _stopwatch.start();

    // Spawn bubble đầu tiên ngay lập tức
    gs.spawnNext(_stopwatch.elapsedMilliseconds);
    state = AsyncData(gs);

    // Spawn các bubble tiếp theo
    _spawnTimer = Timer.periodic(
      Duration(milliseconds: gs.content.spawnIntervalMs),
      (t) {
        if (!gs.hasMoreBubbles) {
          t.cancel();
          return;
        }
        gs.spawnNext(_stopwatch.elapsedMilliseconds);
        state = AsyncData(gs);
      },
    );

    // Check kết thúc game mỗi 500ms
    _gameTimer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      final allDone =
          !gs.hasMoreBubbles && gs.activeBubbles.every((b) => !b.isFloating);
      if (allDone || gs.allTargetsHit) {
        t.cancel();
        _finishGame(gs);
      }
    });
  }

  // ─── Tap một bubble ──────────────────────────────────────────────

  void tapBubble(String bubbleId) {
    final gs = state.value;
    if (gs == null || !gs.isPlaying) return;

    gs.tapBubble(bubbleId);
    state = AsyncData(gs);

    // Kết thúc sớm nếu đã chạm hết target
    if (gs.allTargetsHit) {
      _spawnTimer?.cancel();
      _gameTimer?.cancel();
      _finishGame(gs);
    }
  }

  // ─── Bubble bay mất ──────────────────────────────────────────────

  void onBubbleEscaped(String bubbleId) {
    final gs = state.value;
    if (gs == null || !gs.isPlaying) return;
    gs.bubbleEscaped(bubbleId);
    state = AsyncData(gs);
  }

  // ─── Kết thúc game ───────────────────────────────────────────────

  void _finishGame(WordPopState gs) {
    _stopwatch.stop();
    _spawnTimer?.cancel();
    _gameTimer?.cancel();

    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = WordPopStatus.complete;
    gs.xpEarned = _calcXp(gs);
    state = AsyncData(gs);

    _saveResult(gs);
  }

  // ─── Retry ───────────────────────────────────────────────────────

  Future<void> retry() async {
    _countdownTimer?.cancel();
    _spawnTimer?.cancel();
    _gameTimer?.cancel();
    _stopwatch
      ..reset()
      ..stop();

    state = const AsyncLoading();
    final content = await ref.read(fetchWordPopProvider).call(arg.questionId);
    final gs = WordPopState(content);
    _startCountdown(gs);
    state = AsyncData(gs);
  }

  // ─── Helpers ─────────────────────────────────────────────────────

  int _calcXp(WordPopState gs) {
    return const CalculateQuizXpUseCase()(
      QuizXpInput(
        isCorrect: gs.targetsHit == gs.totalTargets,
        // TODO(db): lấy difficulty từ quiz_questions khi nối Drift.
        timeTakenMs: gs.timeTakenMs,
        attemptIndex: gs.wrongTaps + 1,
      ),
    );
  }

  void _saveResult(WordPopState gs) {
    ref
        .read(saveWordPopProvider)
        .call(
          WordPopResult(
            childId: 'mock_child_id',
            lessonId: arg.lessonId,
            questionId: arg.questionId,
            isCorrect: gs.targetsHit == gs.totalTargets,
            score: gs.score,
            targetsHit: gs.targetsHit,
            totalTargets: gs.totalTargets,
            wrongTaps: gs.wrongTaps,
            missedTargets: gs.missedTargets,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
          ),
        );
  }
}
