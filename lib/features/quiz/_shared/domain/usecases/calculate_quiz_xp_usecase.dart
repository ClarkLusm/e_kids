import '../models/quiz_xp_input.dart';

class CalculateQuizXpUseCase {
  const CalculateQuizXpUseCase();

  int call(QuizXpInput input) {
    if (!input.isCorrect) {
      return 0;
    }

    final baseXp = switch (input.difficulty) {
      1 => 10,
      2 => 15,
      3 => 20,
      _ => 10,
    };

    final speedBonus = input.timeTakenMs <= 5000
        ? 5
        : input.timeTakenMs <= 10000
        ? 2
        : 0;
    final noHintBonus = input.hintsUsed == 0 ? 5 : 0;
    final firstTryBonus = input.attemptIndex == 1 ? 5 : 0;
    final penalty = input.hintsUsed * 2;

    return (baseXp + speedBonus + noHintBonus + firstTryBonus - penalty).clamp(
      0,
      100,
    );
  }
}
