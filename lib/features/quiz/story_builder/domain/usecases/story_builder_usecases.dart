import '../models/story_builder_content.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class IStoryBuilderRepository {
  Future<StoryBuilderContent> fetchById(String questionId);
}

abstract class IStoryBuilderAttemptRepository {
  Future<void> saveResult(StoryBuilderResult result);
}

// ─── DTO ─────────────────────────────────────────────────────────────────

class StoryBuilderResult {
  final String childId;
  final String questionId;
  final bool isCorrect;
  final int correctSentences;
  final int totalSentences;
  final int timeTakenMs;
  final int xpEarned;
  final List<Map<String, dynamic>> sentenceResults;

  const StoryBuilderResult({
    required this.childId,
    required this.questionId,
    required this.isCorrect,
    required this.correctSentences,
    required this.totalSentences,
    required this.timeTakenMs,
    required this.xpEarned,
    required this.sentenceResults,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'question_id': questionId,
    'is_correct': isCorrect,
    'time_taken_ms': timeTakenMs,
    'xp_earned': xpEarned,
    'answer_given': {
      'correct_sentences': correctSentences,
      'total_sentences': totalSentences,
      'sentence_results': sentenceResults,
    },
  };
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchStoryBuilderUseCase {
  final IStoryBuilderRepository _repo;
  const FetchStoryBuilderUseCase(this._repo);
  Future<StoryBuilderContent> call(String id) => _repo.fetchById(id);
}

class SaveStoryBuilderResultUseCase {
  final IStoryBuilderAttemptRepository _repo;
  const SaveStoryBuilderResultUseCase(this._repo);
  Future<void> call(StoryBuilderResult r) => _repo.saveResult(r);
}
