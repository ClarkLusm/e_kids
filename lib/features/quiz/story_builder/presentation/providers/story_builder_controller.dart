import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/story_builder_repository.dart';
import '../../domain/models/story_builder_state.dart';
import '../../domain/usecases/story_builder_usecases.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final storyBuilderRepoProvider = Provider<IStoryBuilderRepository>(
  (_) => MockStoryBuilderRepository(),
);

final storyBuilderAttemptRepoProvider =
    Provider<IStoryBuilderAttemptRepository>(
      (_) => MockStoryBuilderAttemptRepository(),
    );

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchStoryBuilderProvider = Provider<FetchStoryBuilderUseCase>(
  (ref) => FetchStoryBuilderUseCase(ref.read(storyBuilderRepoProvider)),
);

final saveStoryBuilderProvider = Provider<SaveStoryBuilderResultUseCase>(
  (ref) =>
      SaveStoryBuilderResultUseCase(ref.read(storyBuilderAttemptRepoProvider)),
);

// ─── Controller ───────────────────────────────────────────────────────────

final storyBuilderControllerProvider =
    AsyncNotifierProviderFamily<
      StoryBuilderController,
      StoryBuilderState,
      String
    >(StoryBuilderController.new);

class StoryBuilderController
    extends FamilyAsyncNotifier<StoryBuilderState, String> {
  final Stopwatch _stopwatch = Stopwatch();

  @override
  Future<StoryBuilderState> build(String questionId) async {
    _stopwatch.start();
    final content = await ref.read(fetchStoryBuilderProvider).call(questionId);
    return StoryBuilderState(content);
  }

  // ─── Tap word từ pool → đặt vào slot trống đầu tiên ─────────────

  void tapWord(String word) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final cur = gs.currentSentence;
    if (cur.isAnswered) return;

    // Tìm slot trống đầu tiên
    final slotIdx = cur.answerSlots.indexOf(null);
    if (slotIdx < 0) return;

    cur.answerSlots[slotIdx] = word;
    cur.wordPool.remove(word);

    state = AsyncData(gs);

    // Auto-check khi đủ từ
    if (cur.isComplete) _checkSentence(gs);
  }

  // ─── Tap slot đã điền → trả về pool ─────────────────────────────

  void removeWordFromSlot(int slotIndex) {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final cur = gs.currentSentence;
    if (cur.isAnswered) return;

    final word = cur.answerSlots[slotIndex];
    if (word == null) return;

    cur.answerSlots[slotIndex] = null;
    cur.wordPool.add(word);

    // Reset nếu đang sai
    if (cur.status == SentenceStatus.wrong) {
      cur.status = SentenceStatus.active;
    }

    state = AsyncData(gs);
  }

  // ─── Clear tất cả slots → trả về pool ───────────────────────────

  void clearAll() {
    final gs = state.value;
    if (gs == null || gs.isComplete) return;

    final cur = gs.currentSentence;
    if (cur.isAnswered) return;

    for (var i = 0; i < cur.answerSlots.length; i++) {
      final w = cur.answerSlots[i];
      if (w != null) {
        cur.wordPool.add(w);
        cur.answerSlots[i] = null;
      }
    }
    if (cur.status == SentenceStatus.wrong) {
      cur.status = SentenceStatus.active;
    }
    state = AsyncData(gs);
  }

  // ─── Hint: phát âm câu đúng ──────────────────────────────────────

  void playAudioHint() {
    final gs = state.value;
    if (gs == null) return;
    final url = gs.currentSentence.sentence.audioUrl;
    if (url == null) return;
    // TODO: inject AudioService
    // ref.read(audioServiceProvider).play(url);
  }

  // ─── Check đáp án câu hiện tại ───────────────────────────────────

  void _checkSentence(StoryBuilderState gs) {
    final cur = gs.currentSentence;
    if (cur.isWordCorrect) {
      cur.status = SentenceStatus.correct;
    } else {
      cur.status = SentenceStatus.wrong;
      cur.wrongAttempts++;
    }
    state = AsyncData(gs);
  }

  // ─── Tiếp tục sang câu tiếp theo (sau khi correct) ──────────────

  void nextSentence() {
    final gs = state.value;
    if (gs == null) return;

    final cur = gs.currentSentence;
    if (cur.status != SentenceStatus.correct) return;

    if (gs.isLastSentence) {
      _finishStory(gs);
    } else {
      gs.currentSentenceIndex++;
      gs.sentenceStates[gs.currentSentenceIndex].status = SentenceStatus.active;
      state = AsyncData(gs);
    }
  }

  // ─── Kết thúc toàn bộ story ──────────────────────────────────────

  void _finishStory(StoryBuilderState gs) {
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = StoryBuilderStatus.complete;
    gs.xpEarned = _calcXp(gs);
    state = AsyncData(gs);
    _saveResult(gs);
  }

  // ─── Retry ───────────────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final content = await ref.read(fetchStoryBuilderProvider).call(arg);
    state = AsyncData(StoryBuilderState(content));
  }

  // ─── Helpers ─────────────────────────────────────────────────────

  int _calcXp(StoryBuilderState gs) {
    const perSentence = 15;
    var xp = gs.correctCount * perSentence;

    // Bonus: không sai câu nào
    final noWrong = gs.sentenceStates.every((s) => s.wrongAttempts == 0);
    if (noWrong) xp += 20;

    return xp;
  }

  void _saveResult(StoryBuilderState gs) {
    final sentenceResults = gs.sentenceStates
        .map(
          (s) => {
            'order': s.sentence.order,
            'is_correct': s.status == SentenceStatus.correct,
            'wrong_attempts': s.wrongAttempts,
            'submitted': s.currentSentence,
            'correct': s.sentence.correctSentence,
          },
        )
        .toList();

    ref
        .read(saveStoryBuilderProvider)
        .call(
          StoryBuilderResult(
            childId: 'mock_child_id',
            questionId: arg,
            isCorrect: gs.correctCount == gs.totalSentences,
            correctSentences: gs.correctCount,
            totalSentences: gs.totalSentences,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
            sentenceResults: sentenceResults,
          ),
        );
  }
}
