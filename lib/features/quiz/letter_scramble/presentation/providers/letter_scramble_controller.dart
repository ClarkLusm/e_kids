import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/letter_scramble_repository.dart';
import '../../domain/models/letter_scramble_state.dart';
import '../../domain/models/letter_tile.dart';
import '../../domain/usecases/letter_scramble_usecases.dart';
import '../../../_shared/data/local/local_quiz_attempt_repository.dart';
import '../../../_shared/domain/models/quiz_xp_input.dart';
import '../../../_shared/domain/usecases/calculate_quiz_xp_usecase.dart';
import '../../../_shared/question_ref.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final letterScrambleRepoProvider = Provider<ILetterScrambleRepository>(
  (_) => MockLetterScrambleRepository(),
);

final letterScrambleAttemptRepoProvider =
    Provider<ILetterScrambleAttemptRepository>(
      (ref) => ref.watch(localLetterScrambleAttemptRepositoryProvider),
    );

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchLetterScrambleProvider = Provider<FetchLetterScrambleUseCase>(
  (ref) => FetchLetterScrambleUseCase(ref.read(letterScrambleRepoProvider)),
);

final saveLetterScrambleProvider = Provider<SaveLetterScrambleResultUseCase>(
  (ref) => SaveLetterScrambleResultUseCase(
    ref.read(letterScrambleAttemptRepoProvider),
  ),
);

// ─── Controller ───────────────────────────────────────────────────────────

final letterScrambleControllerProvider =
    AsyncNotifierProviderFamily<
      LetterScrambleController,
      LetterScrambleState,
      QuizQuestionArgs
    >(LetterScrambleController.new);

class LetterScrambleController
    extends FamilyAsyncNotifier<LetterScrambleState, QuizQuestionArgs> {
  late final Stopwatch _stopwatch;

  @override
  Future<LetterScrambleState> build(QuizQuestionArgs args) async {
    _stopwatch = Stopwatch()..start();
    final content = await ref
        .read(fetchLetterScrambleProvider)
        .call(args.questionId);
    return LetterScrambleState(content);
  }

  // ─── Tap source tile → đặt vào slot trống đầu tiên ──────────────

  void tapSourceTile(String tileId) {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    final tileIndex = gs.sourceTiles.indexWhere((t) => t.id == tileId);
    if (tileIndex < 0) return;

    final slotIndex = gs.firstEmptySlotIndex;
    if (slotIndex == null) return; // tất cả slot đã đầy

    final tile = gs.sourceTiles[tileIndex];
    gs.sourceTiles.removeAt(tileIndex);
    gs.answerSlots[slotIndex] = tile;

    state = AsyncData(gs);

    // Auto-submit khi đủ chữ
    if (gs.isComplete) _autoSubmit(gs);
  }

  // ─── Tap answer slot → trả tile về source ────────────────────────

  void tapAnswerSlot(int slotIndex) {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    final tile = gs.answerSlots[slotIndex];
    if (tile == null || tile.isLocked) return;

    gs.answerSlots[slotIndex] = null;
    gs.sourceTiles.add(tile);

    // Reset status nếu đang wrong (cho thử lại)
    if (gs.status == LetterScrambleStatus.wrong) {
      gs.status = LetterScrambleStatus.playing;
    }

    state = AsyncData(gs);
  }

  // ─── Drag source → slot cụ thể ───────────────────────────────────

  void dragTileToSlot(String tileId, int targetSlotIndex) {
    // TODO: Đã sửa {required ...}
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    final targetSlot = gs.answerSlots[targetSlotIndex];
    if (targetSlot?.isLocked ?? false) return;

    // Tìm tile trong source
    final srcIndex = gs.sourceTiles.indexWhere((t) => t.id == tileId);

    if (srcIndex >= 0) {
      // Tile từ source → slot
      final tile = gs.sourceTiles[srcIndex];
      // Nếu slot đã có tile → đẩy tile đó về source
      if (targetSlot != null) {
        gs.sourceTiles.add(targetSlot);
      }
      gs.sourceTiles.removeAt(srcIndex);
      gs.answerSlots[targetSlotIndex] = tile;
    } else {
      // Tile từ answer slot khác → swap
      final fromSlotIndex = gs.answerSlots.indexWhere((t) => t?.id == tileId);
      if (fromSlotIndex < 0) return;

      final fromTile = gs.answerSlots[fromSlotIndex];
      gs.answerSlots[fromSlotIndex] = targetSlot; // có thể null
      gs.answerSlots[targetSlotIndex] = fromTile;
    }

    state = AsyncData(gs);
    if (gs.isComplete) _autoSubmit(gs);
  }

  // ─── Drag answer tile → source zone ──────────────────────────────

  void dragTileToSource(String tileId) {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    final slotIndex = gs.answerSlots.indexWhere((t) => t?.id == tileId);
    if (slotIndex < 0) return;

    final tile = gs.answerSlots[slotIndex];
    if (tile == null || tile.isLocked) return;

    gs.answerSlots[slotIndex] = null;
    gs.sourceTiles.add(tile);
    state = AsyncData(gs);
  }

  // ─── Auto submit khi đủ chữ ──────────────────────────────────────

  void _autoSubmit(LetterScrambleState gs) {
    if (!gs.isComplete) return;

    final isCorrect = gs.isWordCorrect;
    if (isCorrect) {
      _handleCorrect(gs);
    } else {
      gs.status = LetterScrambleStatus.wrong;
      gs.wrongAttempts++;
      state = AsyncData(gs);
    }
  }

  void _handleCorrect(LetterScrambleState gs) {
    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = LetterScrambleStatus.correct;
    gs.xpEarned = _calcXp(gs);
    state = AsyncData(gs);
    _playAudio(gs.content.audioUrl);
    _saveResult(gs);
  }

  // ─── Manual submit ────────────────────────────────────────────────

  Future<void> submitAnswer() async {
    final gs = state.value;
    if (gs == null || !gs.isComplete || gs.isAnswered) return;
    _autoSubmit(gs);
  }

  // ─── Hint: reveal chữ cái đúng tiếp theo ─────────────────────────

  void useHint() {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;
    if (gs.hintsUsed >= gs.content.maxHints) return;

    // Tìm slot trống hoặc sai đầu tiên
    for (var i = 0; i < gs.answerSlots.length; i++) {
      if (gs.content.isLocked(i)) continue;
      final correctLetter = gs.content.word[i].toUpperCase();
      final currentLetter = gs.answerSlots[i]?.letter;

      if (currentLetter != correctLetter) {
        // Trả tile sai về source (nếu có)
        if (gs.answerSlots[i] != null && !gs.answerSlots[i]!.isLocked) {
          gs.sourceTiles.add(gs.answerSlots[i]!);
          gs.answerSlots[i] = null;
        }

        // Tìm tile đúng trong source
        final srcIndex = gs.sourceTiles.indexWhere(
          (t) => t.letter == correctLetter,
        );
        if (srcIndex >= 0) {
          gs.answerSlots[i] = gs.sourceTiles[srcIndex].copyWith(
            isLocked: true,
          ); // khóa tile hint
          gs.sourceTiles.removeAt(srcIndex);
          gs.hintsUsed++;
          state = AsyncData(gs);

          if (gs.isComplete) _autoSubmit(gs);
          return;
        }
      }
    }
  }

  // ─── Clear all: trả tất cả về source ─────────────────────────────

  void clearAll() {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    for (var i = 0; i < gs.answerSlots.length; i++) {
      final tile = gs.answerSlots[i];
      if (tile != null && !tile.isLocked) {
        gs.sourceTiles.add(tile);
        gs.answerSlots[i] = null;
      }
    }

    if (gs.status == LetterScrambleStatus.wrong) {
      gs.status = LetterScrambleStatus.playing;
    }
    state = AsyncData(gs);
  }

  // ─── Reveal answer ────────────────────────────────────────────────

  void revealAnswer() {
    final gs = state.value;
    if (gs == null || gs.isAnswered) return;

    _stopwatch.stop();
    gs.timeTakenMs = _stopwatch.elapsedMilliseconds;
    gs.status = LetterScrambleStatus.revealed;
    gs.xpEarned = 0;

    // Hiện đáp án đúng trong các slot
    for (var i = 0; i < gs.answerSlots.length; i++) {
      gs.answerSlots[i] = LetterTile(
        id: 'revealed_$i',
        letter: gs.content.word[i].toUpperCase(),
        isLocked: true,
      );
    }
    gs.sourceTiles.clear();

    state = AsyncData(gs);
    _playAudio(gs.content.audioUrl);
    _saveResult(gs);
  }

  // ─── Retry ───────────────────────────────────────────────────────

  Future<void> retry() async {
    _stopwatch
      ..reset()
      ..start();
    state = const AsyncLoading();
    final content = await ref
        .read(fetchLetterScrambleProvider)
        .call(arg.questionId);
    state = AsyncData(LetterScrambleState(content));
  }

  // ─── Phát âm ─────────────────────────────────────────────────────

  void playWordAudio() => _playAudio(state.value?.content.audioUrl);

  // ─── Helpers ─────────────────────────────────────────────────────

  int _calcXp(LetterScrambleState gs) {
    return const CalculateQuizXpUseCase()(
      QuizXpInput(
        isCorrect: true,
        // TODO(db): lấy difficulty từ quiz_questions khi nối Drift.
        timeTakenMs: gs.timeTakenMs,
        hintsUsed: gs.hintsUsed,
        attemptIndex: gs.wrongAttempts + 1,
      ),
    );
  }

  void _saveResult(LetterScrambleState gs) {
    ref
        .read(saveLetterScrambleProvider)
        .call(
          LetterScrambleResult(
            childId: 'mock_child_id',
            lessonId: arg.lessonId,
            questionId: arg.questionId,
            isCorrect: gs.status == LetterScrambleStatus.correct,
            submittedWord: gs.currentWord ?? '',
            correctWord: gs.content.word,
            timeTakenMs: gs.timeTakenMs,
            xpEarned: gs.xpEarned,
            hintsUsed: gs.hintsUsed,
            wrongAttempts: gs.wrongAttempts,
          ),
        );
  }

  void _playAudio(String? url) {
    if (url == null) return;
    // TODO: inject AudioService
    // ref.read(audioServiceProvider).play(url);
  }
}
