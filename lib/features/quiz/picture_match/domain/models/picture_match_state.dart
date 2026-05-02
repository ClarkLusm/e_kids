import 'picture_match_content.dart';
import 'picture_match_choice.dart';

enum PictureMatchStatus {
  idle, // chưa chọn gì
  correct, // chọn đúng
  wrong, // chọn sai
  revealed, // đã hiện đáp án đúng
}

class PictureMatchState {
  final PictureMatchContent content;

  /// Danh sách choices đã shuffle — client side
  final List<PictureMatchChoice> shuffledChoices;

  PictureMatchStatus status;
  String? selectedWord;
  int timeTakenMs;
  int xpEarned;

  PictureMatchState(this.content)
    : shuffledChoices = List<PictureMatchChoice>.from(content.choices)
        ..shuffle(),
      status = PictureMatchStatus.idle,
      timeTakenMs = 0,
      xpEarned = 0;

  bool get isAnswered =>
      status == PictureMatchStatus.correct ||
      status == PictureMatchStatus.wrong ||
      status == PictureMatchStatus.revealed;

  bool get isCorrect => status == PictureMatchStatus.correct;

  bool isSelected(String word) => selectedWord == word;

  bool isCorrectChoice(String word) => word == content.correctWord;

  ChoiceResult resultOf(String word) {
    if (!isAnswered) return ChoiceResult.none;
    if (word == content.correctWord) return ChoiceResult.correct;
    if (word == selectedWord) return ChoiceResult.wrong;
    return ChoiceResult.none;
  }
}

enum ChoiceResult { none, correct, wrong }
