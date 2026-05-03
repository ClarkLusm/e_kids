import 'listen_tap_content.dart';
import 'listen_tap_choice.dart';

enum ListenTapStatus {
  waitingToPlay, // chưa nghe lần nào — nút play nổi bật
  playing, // đang phát audio
  idle, // đã nghe, chờ chọn
  correct, // chọn đúng
  wrong, // chọn sai
  revealed, // đã hiện đáp án
}

/// Trạng thái hiển thị của mỗi card lựa chọn
enum ChoiceCardStatus {
  normal, // mặc định
  correct, // đáp án đúng sau khi answered
  wrong, // đáp án sai đã chọn
  dimmed, // lựa chọn không liên quan sau khi answered
}

class ListenTapState {
  final ListenTapContent content;

  /// Choices đã shuffle để hiển thị ngẫu nhiên
  final List<ListenTapChoice> shuffledChoices;

  ListenTapStatus status;
  String? selectedWord;
  int replayCount; // số lần đã replay
  int timeTakenMs;
  int xpEarned;

  ListenTapState(this.content)
    : shuffledChoices = List<ListenTapChoice>.from(content.choices)..shuffle(),
      status = ListenTapStatus.waitingToPlay,
      replayCount = 0,
      timeTakenMs = 0,
      xpEarned = 0;

  // ─── Computed ──────────────────────────────────────────────────────

  bool get isAnswered =>
      status == ListenTapStatus.correct ||
      status == ListenTapStatus.wrong ||
      status == ListenTapStatus.revealed;

  bool get isCorrect => status == ListenTapStatus.correct;

  bool get canReplay =>
      content.replayLimit == 0 || replayCount < content.replayLimit;

  bool get hasListened =>
      status != ListenTapStatus.waitingToPlay &&
      status != ListenTapStatus.playing;

  int get replaysRemaining =>
      content.replayLimit == 0 ? 99 : content.replayLimit - replayCount;

  /// Trạng thái hiển thị của từng card
  ChoiceCardStatus cardStatusOf(String word) {
    if (!isAnswered) {
      return word == selectedWord
          ? ChoiceCardStatus
                .correct // highlight khi đang hover/select
          : ChoiceCardStatus.normal;
    }
    if (word == content.correctChoice.word) return ChoiceCardStatus.correct;
    if (word == selectedWord) return ChoiceCardStatus.wrong;
    return ChoiceCardStatus.dimmed;
  }
}
