class QuizXpInput {
  const QuizXpInput({
    required this.isCorrect,
    this.difficulty = 1,
    this.timeTakenMs = 0,
    this.hintsUsed = 0,
    this.attemptIndex = 1,
  });

  final bool isCorrect;
  final int difficulty;
  final int timeTakenMs;
  final int hintsUsed;
  final int attemptIndex;
}
