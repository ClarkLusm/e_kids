import 'story_builder_content.dart';

enum SentenceStatus {
  pending, // chưa làm
  active, // đang sắp xếp
  correct, // đúng
  wrong, // sai — cho thử lại
}

/// State của 1 câu trong story
class SentenceState {
  final StorySentence sentence;

  /// Các từ đang được đặt vào ô trả lời (null = ô trống)
  List<String?> answerSlots;

  /// Pool từ chưa dùng
  List<String> wordPool;

  SentenceStatus status;
  int wrongAttempts;

  SentenceState(this.sentence)
    : answerSlots = List.filled(sentence.correctSequence.length, null),
      wordPool = List<String>.from(sentence.shuffledWords),
      status = SentenceStatus.pending,
      wrongAttempts = 0;

  bool get isComplete => !answerSlots.contains(null);

  bool get isAnswered =>
      status == SentenceStatus.correct || status == SentenceStatus.wrong;

  /// Câu hiện tại đang ghép
  String get currentSentence => answerSlots.map((w) => w ?? '___').join(' ');

  bool get isWordCorrect {
    for (var i = 0; i < answerSlots.length; i++) {
      if (answerSlots[i] != sentence.correctSequence[i]) return false;
    }
    return true;
  }
}

enum StoryBuilderStatus {
  playing, // đang làm câu hiện tại
  complete, // tất cả câu đã hoàn thành
}

class StoryBuilderState {
  final StoryBuilderContent content;

  final List<SentenceState> sentenceStates;

  StoryBuilderStatus status;
  int currentSentenceIndex;
  int timeTakenMs;
  int xpEarned;

  StoryBuilderState(this.content)
    : sentenceStates = content.sentences.map((s) => SentenceState(s)).toList(),
      status = StoryBuilderStatus.playing,
      currentSentenceIndex = 0,
      timeTakenMs = 0,
      xpEarned = 0 {
    // Kích hoạt câu đầu tiên
    if (sentenceStates.isNotEmpty) {
      sentenceStates[0].status = SentenceStatus.active;
    }
  }

  // ─── Computed ─────────────────────────────────────────────────────

  bool get isComplete => status == StoryBuilderStatus.complete;

  SentenceState get currentSentence => sentenceStates[currentSentenceIndex];

  int get totalSentences => sentenceStates.length;

  int get correctCount =>
      sentenceStates.where((s) => s.status == SentenceStatus.correct).length;

  double get progress =>
      totalSentences == 0 ? 0 : currentSentenceIndex / totalSentences;

  bool get isLastSentence => currentSentenceIndex == totalSentences - 1;
}
