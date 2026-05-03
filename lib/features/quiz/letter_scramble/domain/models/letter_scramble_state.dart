import 'letter_scramble_content.dart';
import 'letter_tile.dart';

enum LetterScrambleStatus {
  playing, // đang chơi
  correct, // ghép đúng
  wrong, // submit sai
  revealed, // đã reveal đáp án
}

class LetterScrambleState {
  final LetterScrambleContent content;

  /// Pool chữ cái chưa dùng (phía dưới)
  List<LetterTile> sourceTiles;

  /// Ô đáp án trên cùng — null = ô trống, LetterTile = đã điền
  List<LetterTile?> answerSlots;

  LetterScrambleStatus status;
  int hintsUsed;
  int timeTakenMs;
  int xpEarned;
  int wrongAttempts;

  LetterScrambleState(this.content)
    : status = LetterScrambleStatus.playing,
      hintsUsed = 0,
      timeTakenMs = 0,
      xpEarned = 0,
      wrongAttempts = 0,
      sourceTiles = _buildSourceTiles(content),
      answerSlots = _buildAnswerSlots(content);

  // ─── Factory helpers ─────────────────────────────────────────────

  static List<LetterTile> _buildSourceTiles(LetterScrambleContent c) {
    final tiles = <LetterTile>[];
    for (var i = 0; i < c.scrambledLetters.length; i++) {
      // Bỏ qua các vị trí bị khóa — chúng đã nằm sẵn trong answerSlots
      if (c.isLocked(i)) continue;
      tiles.add(
        LetterTile(
          id: 'src_$i',
          letter: c.scrambledLetters[i].toUpperCase(),
          isLocked: false,
        ),
      );
    }
    return tiles;
  }

  static List<LetterTile?> _buildAnswerSlots(LetterScrambleContent c) {
    final slots = List<LetterTile?>.filled(c.word.length, null);
    // Điền sẵn các ô bị khóa
    for (final lockedIdx in c.lockedPositions) {
      if (lockedIdx < c.word.length) {
        slots[lockedIdx] = LetterTile(
          id: 'locked_$lockedIdx',
          letter: c.word[lockedIdx].toUpperCase(),
          isLocked: true,
        );
      }
    }
    return slots;
  }

  // ─── Computed ────────────────────────────────────────────────────

  bool get isComplete => !answerSlots.contains(null);

  bool get isAnswered =>
      status == LetterScrambleStatus.correct ||
      status == LetterScrambleStatus.wrong ||
      status == LetterScrambleStatus.revealed;

  /// Từ hiện tại đang ghép (null nếu còn ô trống)
  String? get currentWord {
    if (!isComplete) return null;
    return answerSlots.map((t) => t!.letter).join().toLowerCase();
  }

  bool get isWordCorrect => currentWord == content.word.toLowerCase();

  /// Trạng thái hiển thị của từng slot đáp án
  SlotDisplayState slotStateAt(int index) {
    final tile = answerSlots[index];
    if (tile == null) return SlotDisplayState.empty;
    if (tile.isLocked) return SlotDisplayState.locked;

    return switch (status) {
      LetterScrambleStatus.correct => SlotDisplayState.correct,
      LetterScrambleStatus.wrong => SlotDisplayState.wrong,
      LetterScrambleStatus.revealed => SlotDisplayState.revealed,
      LetterScrambleStatus.playing => SlotDisplayState.filled,
    };
  }

  /// Số ô trống còn lại
  int get emptySlotCount => answerSlots.where((t) => t == null).length;

  /// Index ô trống đầu tiên (để tap-to-place)
  int? get firstEmptySlotIndex {
    for (var i = 0; i < answerSlots.length; i++) {
      if (answerSlots[i] == null) return i;
    }
    return null;
  }
}

enum SlotDisplayState {
  empty, // ô trắng chờ điền
  filled, // có chữ, chưa submit
  locked, // chữ cái gợi ý cố định
  correct, // đúng
  wrong, // sai
  revealed, // hiện đáp án
}
