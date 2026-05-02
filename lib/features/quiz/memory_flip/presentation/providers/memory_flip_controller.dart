import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/memory_flip_mapper.dart';
import '../../domain/models/card_state.dart';
import '../../domain/models/card_content.dart';
import '../../domain/models/memory_flip_game_state.dart';
import '../../domain/usecases/fetch_memory_flip_usecase.dart';
import '../../domain/usecases/save_memory_flip_result_usecase.dart';

// ─── Repository Providers ─────────────────────────────────────────────────

final memoryFlipRepoProvider = Provider<IMemoryFlipRepository>(
  (_) => MockMemoryFlipRepository(),
);

final quizAttemptRepoProvider = Provider<IQuizAttemptRepository>(
  (_) => MockQuizAttemptRepository(),
);

// ─── UseCase Providers ────────────────────────────────────────────────────

final fetchMemoryFlipUseCaseProvider =
    Provider<FetchMemoryFlipUseCase>((ref) {
  return FetchMemoryFlipUseCase(ref.read(memoryFlipRepoProvider));
});

final saveMemoryFlipResultUseCaseProvider =
    Provider<SaveMemoryFlipResultUseCase>((ref) {
  return SaveMemoryFlipResultUseCase(ref.read(quizAttemptRepoProvider));
});

// ─── Controller ───────────────────────────────────────────────────────────

/// Riverpod family: mỗi questionId có 1 instance controller riêng
final memoryFlipControllerProvider = AsyncNotifierProviderFamily<
    MemoryFlipController, MemoryFlipGameState, String>(
  MemoryFlipController.new,
);

class MemoryFlipController
    extends FamilyAsyncNotifier<MemoryFlipGameState, String> {
  bool _isProcessing = false;

  @override
  Future<MemoryFlipGameState> build(String questionId) async {
    return _initGame(questionId);
  }

  // ─── Init ─────────────────────────────────────────────────

  Future<MemoryFlipGameState> _initGame(String qId) async {
    final useCase = ref.read(fetchMemoryFlipUseCaseProvider);
    final content = await useCase.call(qId);
    final gs = MemoryFlipGameState(content);

    // Preview: lật hết tất cả thẻ trước khi bắt đầu
    if (content.previewDurationMs > 0) {
      for (final card in gs.board) {
        card.faceState = CardFaceState.faceUp;
      }
      state = AsyncData(gs);
      await Future.delayed(
          Duration(milliseconds: content.previewDurationMs));
      for (final card in gs.board) {
        card.faceState = CardFaceState.faceDown;
      }
    }

    gs.startTimer();
    return gs;
  }

  // ─── Card tap ─────────────────────────────────────────────

  Future<void> onCardTap(int boardIndex) async {
    if (_isProcessing) return;

    final gs = state.value;
    if (gs == null) return;

    final tapped = gs.board[boardIndex];
    if (!tapped.isInteractable) return;

    // Kiểm tra giới hạn flip
    if (gs.isFlipLimitReached) return;

    gs.flipCount++;
    tapped.faceState = CardFaceState.faceUp;
    state = AsyncData(gs);

    // Phát audio nếu thẻ loại audio + accessibility.autoReadOnFlip
    if (tapped.content.type == CardType.audio ||
        (tapped.content.audioUrl != null &&
            gs.content.accessibility.autoReadOnFlip)) {
      _playAudio(tapped.content.audioUrl);
    }

    // Lần lật đầu tiên — chờ lật thứ hai
    if (gs.firstFlipped == null) {
      gs.firstFlipped = tapped;
      state = AsyncData(gs);
      return;
    }

    // Lần lật thứ hai — so sánh cặp
    _isProcessing = true;
    final first = gs.firstFlipped!;
    gs.firstFlipped = null;

    if (_isPaired(first, tapped)) {
      await _handleMatch(gs, first, tapped);
    } else {
      await _handleMismatch(gs, first, tapped);
    }

    _isProcessing = false;
  }

  // ─── Match logic ──────────────────────────────────────────

  bool _isPaired(CardState a, CardState b) {
    // Cùng pairId nhưng khác vị trí (isCardA khác nhau)
    return a.pairId == b.pairId && a.isCardA != b.isCardA;
  }

  Future<void> _handleMatch(
    MemoryFlipGameState gs,
    CardState a,
    CardState b,
  ) async {
    a.faceState = CardFaceState.matched;
    b.faceState = CardFaceState.matched;
    gs.matchCount++;

    // Phát âm thanh "đúng" của cặp
    final pair = gs.pairById(a.pairId);
    if (pair.audioOnMatch != null) {
      _playAudio(pair.audioOnMatch);
    }

    state = AsyncData(gs);

    // Game kết thúc khi tất cả cặp đã khớp
    if (gs.isComplete) {
      await _finishGame(gs);
    }
  }

  Future<void> _handleMismatch(
    MemoryFlipGameState gs,
    CardState a,
    CardState b,
  ) async {
    a.faceState = CardFaceState.mismatch;
    b.faceState = CardFaceState.mismatch;
    state = AsyncData(gs);

    // Đợi mismatch_hide_ms rồi úp lại
    await Future.delayed(
        Duration(milliseconds: gs.content.mismatchHideMs));

    a.faceState = CardFaceState.faceDown;
    b.faceState = CardFaceState.faceDown;
    state = AsyncData(gs);
  }

  Future<void> _finishGame(MemoryFlipGameState gs) async {
    gs.stopTimer();
    gs.earnedXp = gs.computeFinalXp();
    state = AsyncData(gs);

    // Lưu kết quả lên DB
    final saveUseCase = ref.read(saveMemoryFlipResultUseCaseProvider);
    await saveUseCase.call(MemoryFlipResult(
      childId: 'mock_child_id', // thay bằng currentChildProvider sau
      questionId: arg,
      flipCount: gs.flipCount,
      elapsedSec: gs.elapsedSec,
      xpEarned: gs.earnedXp,
      stars: gs.computeStars(),
      isComplete: gs.isComplete,
    ));
  }

  // ─── Replay ───────────────────────────────────────────────

  Future<void> replay() async {
    _isProcessing = false;
    state = const AsyncLoading();
    state = AsyncData(await _initGame(arg));
  }

  // ─── Helpers ──────────────────────────────────────────────

  void _playAudio(String? url) {
    if (url == null) return;
    // TODO: inject AudioService và gọi play(url)
    // ref.read(audioServiceProvider).play(url);
  }
}
