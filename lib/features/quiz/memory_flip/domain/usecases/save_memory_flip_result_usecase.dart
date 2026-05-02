typedef SaveMemoryFlipResultHandler =
    Future<void> Function({
      required String lessonId,
      required String quizId,
      required int score,
      required int flipCount,
      required int hintsUsed,
      required bool completed,
    });

class SaveMemoryFlipResultUseCase {
  const SaveMemoryFlipResultUseCase(this._handler);

  final SaveMemoryFlipResultHandler _handler;

  Future<void> call({
    required String lessonId,
    required String quizId,
    required int score,
    required int flipCount,
    required int hintsUsed,
    required bool completed,
  }) {
    return _handler(
      lessonId: lessonId,
      quizId: quizId,
      score: score,
      flipCount: flipCount,
      hintsUsed: hintsUsed,
      completed: completed,
    );
  }
}
