import 'fill_blank_content.dart';

enum FillBlankStatus {
  idle, // chưa chọn, ô trống đang rỗng
  selected, // đã chọn 1 từ, chưa submit
  correct, // trả lời đúng
  wrong, // trả lời sai
  revealed, // đã hiện đáp án đúng (sau khi sai)
}

class FillBlankState {
  final FillBlankContent content;

  /// Choices đã shuffle — order ngẫu nhiên
  final List<String> shuffledChoices;

  FillBlankStatus status;

  /// Từ đang được chọn (đặt vào ô trống)
  String? selectedWord;

  /// Có đang hiện bản dịch hint không
  bool isShowingHint;

  int timeTakenMs;
  int xpEarned;
  int hintsUsed;

  FillBlankState(this.content)
    : shuffledChoices = List<String>.from(content.choices)..shuffle(),
      status = FillBlankStatus.idle,
      isShowingHint = false,
      timeTakenMs = 0,
      xpEarned = 0,
      hintsUsed = 0;

  // ─── Computed properties ──────────────────────────────────────────

  bool get isAnswered =>
      status == FillBlankStatus.correct ||
      status == FillBlankStatus.wrong ||
      status == FillBlankStatus.revealed;

  bool get isCorrect => status == FillBlankStatus.correct;

  bool get hasSelection => selectedWord != null;

  /// Từ hiển thị trong ô trống: đã chọn hoặc đáp án đúng (nếu revealed)
  String? get displayWord {
    if (status == FillBlankStatus.revealed) return content.correctAnswer;
    return selectedWord;
  }

  /// Màu ô trống theo trạng thái
  FillBlankSlotStatus get slotStatus {
    return switch (status) {
      FillBlankStatus.correct => FillBlankSlotStatus.correct,
      FillBlankStatus.wrong => FillBlankSlotStatus.wrong,
      FillBlankStatus.revealed => FillBlankSlotStatus.revealed,
      FillBlankStatus.selected => FillBlankSlotStatus.selected,
      FillBlankStatus.idle => FillBlankSlotStatus.empty,
    };
  }

  /// Trạng thái của từng chip lựa chọn
  ChipStatus statusOf(String word) {
    if (!isAnswered) {
      if (word == selectedWord) return ChipStatus.selected;
      return ChipStatus.normal;
    }
    if (word == content.correctAnswer) return ChipStatus.correct;
    if (word == selectedWord && !isCorrect) return ChipStatus.wrong;
    return ChipStatus.dimmed;
  }
}

enum FillBlankSlotStatus { empty, selected, correct, wrong, revealed }

enum ChipStatus { normal, selected, correct, wrong, dimmed }
