import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/picture_match_repository.dart';
import '../../domain/models/picture_match_state.dart';
import '../../domain/models/picture_match_choice.dart';
import '../../domain/usecases/picture_match_usecases.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final pictureMatchRepoProvider = Provider<IPictureMatchRepository>(
  (_) => MockPictureMatchRepository(),
);

final pictureMatchAttemptRepoProvider =
    Provider<IPictureMatchAttemptRepository>(
      (_) => MockPictureMatchAttemptRepository(),
    );

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchPictureMatchProvider = Provider<FetchPictureMatchUseCase>((ref) {
  return FetchPictureMatchUseCase(ref.read(pictureMatchRepoProvider));
});

final savePictureMatchProvider = Provider<SavePictureMatchResultUseCase>((ref) {
  return SavePictureMatchResultUseCase(
    ref.read(pictureMatchAttemptRepoProvider),
  );
});

// ─── Controller provider ──────────────────────────────────────────────────

final pictureMatchControllerProvider =
    AsyncNotifierProviderFamily<
      PictureMatchController,
      PictureMatchState,
      String
    >(PictureMatchController.new);

// ─── Controller ───────────────────────────────────────────────────────────

class PictureMatchController
    extends FamilyAsyncNotifier<PictureMatchState, String> {
  late final Stopwatch _stopwatch;

  @override
  Future<PictureMatchState> build(String questionId) async {
    _stopwatch = Stopwatch()..start();
    final useCase = ref.read(fetchPictureMatchProvider);
    final content = await useCase.call(questionId);
    return PictureMatchState(content);
  }

  // ─── Chọn đáp án ──────────────────────────────────────────────

  Future<void> selectAnswer(String word) async {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.selectedWord = word;

    final isCorrect = word == gs.content.correctWord;

    if (isCorrect) {
      gs.status = PictureMatchStatus.correct;
      gs.xpEarned = _calcXp(gs.timeTakenMs);
    } else {
      gs.status = PictureMatchStatus.wrong;
      gs.xpEarned = 0;
    }

    state = AsyncData(gs);

    // Ghi kết quả lên DB
    await _saveResult(gs, isCorrect);
  }

  // ─── Xem đáp án đúng (sau khi sai) ───────────────────────────

  void revealAnswer() {
    final gs = state.value;
    if (gs == null) return;
    gs.status = PictureMatchStatus.revealed;
    state = AsyncData(gs);
  }

  // ─── Phát âm thanh gợi ý ──────────────────────────────────────

  void playImageAudio() {
    final url = state.value?.content.imageAudioUrl;
    if (url == null) return;
    _playAudio(url);
  }

  void playChoiceAudio(String word) {
    final gs = state.value;
    if (gs == null) return;
    final choice = gs.content.choices.firstWhere(
      (c) => c.word == word,
      orElse: () => PictureMatchChoice(word: word),
    );
    if (choice.audioUrl != null) _playAudio(choice.audioUrl!);
  }

  // ─── Reset / Retry ────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final useCase = ref.read(fetchPictureMatchProvider);
    final content = await useCase.call(arg);
    state = AsyncData(PictureMatchState(content));
  }

  // ─── Private helpers ──────────────────────────────────────────

  int _calcXp(int timeTakenMs) {
    const baseXp = 10;
    // Thưởng tốc độ: trả lời trong 5 giây được +5 XP
    final bonus = timeTakenMs < 5000 ? 5 : 0;
    return baseXp + bonus;
  }

  Future<void> _saveResult(PictureMatchState gs, bool isCorrect) async {
    final saveUseCase = ref.read(savePictureMatchProvider);
    await saveUseCase.call(
      PictureMatchResult(
        childId: 'mock_child_id',
        questionId: arg,
        isCorrect: isCorrect,
        selectedWord: gs.selectedWord ?? '',
        correctWord: gs.content.correctWord,
        timeTakenMs: gs.timeTakenMs,
        xpEarned: gs.xpEarned,
      ),
    );
  }

  void _playAudio(String url) {
    // TODO: inject AudioService
    // ref.read(audioServiceProvider).play(url);
  }
}
