import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/fill_blank_repository.dart';
import '../../domain/models/fill_blank_state.dart';
import '../../domain/usecases/fill_blank_usecases.dart';
import '../../../_shared/data/local/local_quiz_attempt_repository.dart';
import '../../../_shared/domain/models/quiz_xp_input.dart';
import '../../../_shared/domain/usecases/calculate_quiz_xp_usecase.dart';
import '../../../_shared/question_ref.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final fillBlankRepoProvider = Provider<IFillBlankRepository>(
  (_) => MockFillBlankRepository(),
);

final fillBlankAttemptRepoProvider = Provider<IFillBlankAttemptRepository>(
  (ref) => ref.watch(localFillBlankAttemptRepositoryProvider),
);

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchFillBlankProvider = Provider<FetchFillBlankUseCase>(
  (ref) => FetchFillBlankUseCase(ref.read(fillBlankRepoProvider)),
);

final saveFillBlankProvider = Provider<SaveFillBlankResultUseCase>(
  (ref) => SaveFillBlankResultUseCase(ref.read(fillBlankAttemptRepoProvider)),
);

// ─── Controller ───────────────────────────────────────────────────────────

final fillBlankControllerProvider =
    AsyncNotifierProviderFamily<
      FillBlankController,
      FillBlankState,
      QuizQuestionArgs
    >(FillBlankController.new);

class FillBlankController
    extends FamilyAsyncNotifier<FillBlankState, QuizQuestionArgs> {
  late final Stopwatch _stopwatch;

  @override
  Future<FillBlankState> build(QuizQuestionArgs args) async {
    _stopwatch = Stopwatch()..start();
    final content = await ref
        .read(fetchFillBlankProvider)
        .call(args.questionId);
    return FillBlankState(content);
  }

  // ─── Chọn / bỏ chọn từ ────────────────────────────────────────

  void selectWord(String word) {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    // Tap lại từ đang chọn → bỏ chọn (xoá khỏi ô trống)
    if (gs.selectedWord == word) {
      gs.selectedWord = null;
      gs.status = FillBlankStatus.idle;
    } else {
      gs.selectedWord = word;
      gs.status = FillBlankStatus.selected;
    }
    state = AsyncData(gs);
  }

  // ─── Submit đáp án ────────────────────────────────────────────

  Future<void> submitAnswer() async {
    final gs = state.value;
    if (gs == null || gs.selectedWord == null || gs.isAnswered) return;

    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;

    final isCorrect = gs.selectedWord == gs.content.correctAnswer;
    gs.status = isCorrect ? FillBlankStatus.correct : FillBlankStatus.wrong;
    gs.xpEarned = isCorrect ? _calcXp(gs) : 0;

    state = AsyncData(gs);
    await _saveResult(gs, isCorrect);
  }

  // ─── Phát audio câu hoàn chỉnh ────────────────────────────────

  void playSentenceAudio() {
    final url = state.value?.content.audioSentenceUrl;
    if (url != null) _playAudio(url);
  }

  // ─── Hiện / ẩn dịch hint ──────────────────────────────────────

  void toggleHint() {
    final gs = state.value;
    if (gs == null) return;
    if (!gs.content.showTranslationHint) return;
    gs.isShowingHint = !gs.isShowingHint;
    if (!gs.isAnswered) gs.hintsUsed++;
    state = AsyncData(gs);
  }

  // ─── Reveal đáp án (sau khi sai) ─────────────────────────────

  void revealAnswer() {
    final gs = state.value;
    if (gs == null || gs.isCorrect) return;
    gs.status = FillBlankStatus.revealed;
    state = AsyncData(gs);
    // Phát âm câu đúng sau khi reveal
    playSentenceAudio();
  }

  // ─── Retry / Reset ────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final content = await ref.read(fetchFillBlankProvider).call(arg.questionId);
    state = AsyncData(FillBlankState(content));
  }

  // ─── Private helpers ──────────────────────────────────────────

  int _calcXp(FillBlankState gs) {
    return const CalculateQuizXpUseCase()(
      QuizXpInput(
        isCorrect: true,
        // TODO(db): lấy difficulty từ quiz_questions khi nối Drift.
        timeTakenMs: gs.timeTakenMs,
        hintsUsed: gs.hintsUsed,
      ),
    );
  }

  Future<void> _saveResult(FillBlankState gs, bool isCorrect) async {
    await ref
        .read(saveFillBlankProvider)
        .call(
          FillBlankResult(
            childId: 'mock_child_id',
            lessonId: arg.lessonId,
            questionId: arg.questionId,
            isCorrect: isCorrect,
            selectedWord: gs.selectedWord ?? '',
            correctWord: gs.content.correctAnswer,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
            hintsUsed: gs.hintsUsed,
          ),
        );
  }

  void _playAudio(String url) {
    // TODO: inject AudioService
    // ref.read(audioServiceProvider).play(url);
  }
}
