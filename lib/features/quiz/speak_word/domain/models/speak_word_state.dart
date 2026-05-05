import 'speak_word_content.dart';

enum SpeakWordStatus {
  idle, // chưa bắt đầu, chờ nhấn mic
  listening, // đang ghi âm
  processing, // đang so sánh kết quả
  correct, // phát âm đúng
  wrong, // phát âm chưa đạt
  maxReached, // hết lượt thử
  revealed, // đã hiện phiên âm gợi ý
}

/// Kết quả của 1 lần thử nói
class SpeakAttempt {
  final String transcript; // văn bản speech-to-text nhận diện được
  final double similarity; // điểm giống (0.0–1.0)
  final bool passed; // similarity >= minSimilarityScore

  const SpeakAttempt({
    required this.transcript,
    required this.similarity,
    required this.passed,
  });
}

class SpeakWordState {
  final SpeakWordContent content;

  SpeakWordStatus status;
  List<SpeakAttempt> attempts;
  int timeTakenMs;
  int xpEarned;

  /// Hiển thị breakdown âm tiết sau khi sai ≥ 2 lần
  bool showSyllableHint;

  /// Hiển thị dịch nghĩa
  bool showTranslation;

  SpeakWordState(this.content)
    : status = SpeakWordStatus.idle,
      attempts = [],
      timeTakenMs = 0,
      xpEarned = 0,
      showSyllableHint = false,
      showTranslation = false;

  // ─── Computed ─────────────────────────────────────────────────────

  bool get isAnswered =>
      status == SpeakWordStatus.correct ||
      status == SpeakWordStatus.maxReached ||
      status == SpeakWordStatus.revealed;

  bool get isCorrect => status == SpeakWordStatus.correct;

  int get attemptCount => attempts.length;

  int get attemptsRemaining => content.maxAttempts - attemptCount;

  bool get canTryAgain =>
      status == SpeakWordStatus.wrong && attemptCount < content.maxAttempts;

  /// Lần thử cuối cùng
  SpeakAttempt? get lastAttempt => attempts.isEmpty ? null : attempts.last;

  /// Điểm similarity tốt nhất đạt được
  double get bestSimilarity => attempts.isEmpty
      ? 0.0
      : attempts.map((a) => a.similarity).reduce((a, b) => a > b ? a : b);

  /// Phần trăm để hiển thị progress
  int get bestSimilarityPct => (bestSimilarity * 100).round();
}
