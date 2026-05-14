import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/daos/lesson_progress_dao.dart';
import '../../../../core/database/database_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/local/local_lesson_progress_repository.dart';
import '../../data/local/local_topic_repository.dart';
import '../../data/lesson_repository.dart';
import '../../domain/models/lesson_models.dart';
import '../../../quiz/_shared/question_ref.dart';
import '../../domain/usecases/lesson_usecases.dart';

// ─── Repository providers ─────────────────────────────────────────────────

final topicRepoProvider = Provider<ITopicRepository>(
  (ref) => LocalTopicRepository(ref.watch(appDatabaseProvider)),
);

final lessonRepoProvider = Provider<ILessonRepository>(
  (_) => MockLessonRepository(),
);

final vocabularyRepoProvider = Provider<IVocabularyRepository>(
  (_) => MockVocabularyRepository(),
);

final questionRefRepoProvider = Provider<IQuestionRefRepository>(
  (_) => MockQuestionRefRepository(),
);

final lessonProgressRepoProvider = Provider<ILessonProgressRepository>(
  (ref) => ref.watch(localLessonProgressRepositoryProvider),
);

final lessonProgressDaoProvider = Provider<LessonProgressDao>(
  (ref) => LessonProgressDao(ref.watch(appDatabaseProvider)),
);

final localLessonProgressRepositoryProvider =
    Provider<LocalLessonProgressRepository>(
      (ref) =>
          LocalLessonProgressRepository(ref.watch(lessonProgressDaoProvider)),
    );

final currentChildIdProvider = Provider<String>((ref) {
  return ref.watch(authStateProvider).valueOrNull?.id ?? 'mock_child_id';
});

// ─── UseCase providers ────────────────────────────────────────────────────

final fetchTopicsProvider = Provider<FetchTopicsUseCase>(
  (ref) => FetchTopicsUseCase(ref.read(topicRepoProvider)),
);

final fetchLessonsByTopicProvider = Provider<FetchLessonsByTopicUseCase>(
  (ref) => FetchLessonsByTopicUseCase(ref.read(lessonRepoProvider)),
);

final fetchLessonDetailProvider = Provider<FetchLessonDetailUseCase>((ref) {
  return FetchLessonDetailUseCase(
    ref.read(lessonRepoProvider),
    ref.read(vocabularyRepoProvider),
    ref.read(questionRefRepoProvider),
  );
});

final fetchProgressProvider = Provider<FetchLessonProgressUseCase>(
  (ref) => FetchLessonProgressUseCase(ref.read(lessonProgressRepoProvider)),
);

final updateProgressProvider = Provider<UpdateLessonProgressUseCase>(
  (ref) => UpdateLessonProgressUseCase(ref.read(lessonProgressRepoProvider)),
);

// ─── Topic list provider ──────────────────────────────────────────────────

final topicListProvider = FutureProvider<List<Topic>>((ref) async {
  return ref.read(fetchTopicsProvider).call();
});

// ─── Lessons by topic provider ────────────────────────────────────────────

final lessonsByTopicProvider = FutureProviderFamily<List<Lesson>, String>((
  ref,
  topicId,
) async {
  return ref.read(fetchLessonsByTopicProvider).call(topicId);
});

// ─── Lesson detail provider ───────────────────────────────────────────────

final lessonDetailProvider = FutureProviderFamily<LessonDetail, String>((
  ref,
  lessonId,
) async {
  return ref.read(fetchLessonDetailProvider).call(lessonId);
});

// ─── Lesson progress map provider ────────────────────────────────────────

final lessonProgressMapProvider =
    FutureProviderFamily<Map<String, LessonProgress>, String>((
      ref,
      topicId,
    ) async {
      final childId = ref.watch(currentChildIdProvider);
      return ref.read(fetchProgressProvider).call(topicId, childId);
    });

// ─── Quiz Runner Controller ───────────────────────────────────────────────

/// State cho việc chạy quiz lần lượt trong 1 lesson
class QuizRunnerState {
  final List<QuestionRef> questions;
  final int currentIndex;
  final Map<String, int> earnedXpMap; // questionId → xp
  final bool isComplete;

  const QuizRunnerState({
    required this.questions,
    this.currentIndex = 0,
    this.earnedXpMap = const {},
    this.isComplete = false,
  });

  QuestionRef? get currentQuestion =>
      currentIndex < questions.length ? questions[currentIndex] : null;

  int get totalEarnedXp => earnedXpMap.values.fold(0, (sum, xp) => sum + xp);

  int get completedCount => currentIndex;

  double get progress =>
      questions.isEmpty ? 0 : currentIndex / questions.length;

  QuizRunnerState copyWith({
    int? currentIndex,
    Map<String, int>? earnedXpMap,
    bool? isComplete,
  }) => QuizRunnerState(
    questions: questions,
    currentIndex: currentIndex ?? this.currentIndex,
    earnedXpMap: earnedXpMap ?? this.earnedXpMap,
    isComplete: isComplete ?? this.isComplete,
  );
}

final quizRunnerProvider =
    NotifierProviderFamily<
      QuizRunnerNotifier,
      QuizRunnerState,
      List<QuestionRef>
    >(QuizRunnerNotifier.new);

class QuizRunnerNotifier
    extends FamilyNotifier<QuizRunnerState, List<QuestionRef>> {
  @override
  QuizRunnerState build(List<QuestionRef> questions) =>
      QuizRunnerState(questions: questions);

  void onQuizCompleted({required String questionId, required int xpEarned}) {
    final updated = Map<String, int>.from(state.earnedXpMap);
    updated[questionId] = xpEarned;

    final nextIndex = state.currentIndex + 1;
    final isDone = nextIndex >= state.questions.length;

    state = state.copyWith(
      currentIndex: nextIndex,
      earnedXpMap: updated,
      isComplete: isDone,
    );

    // Cập nhật lesson progress nếu xong
    if (isDone) {
      _saveLessonProgress();
    }
  }

  void _saveLessonProgress() {
    if (state.questions.isEmpty) return;
    final lessonId = state.questions.first.lessonId;
    final totalXp = state.totalEarnedXp;
    final maxXp = state.questions.fold(0, (s, q) => s + q.xpReward);
    final score = maxXp == 0 ? 0 : (totalXp / maxXp * 100).round();
    final stars = score >= 100
        ? 3
        : score >= 80
        ? 2
        : 1;

    final progress = LessonProgress(
      lessonId: lessonId,
      status: LessonStatus.completed,
      stars: stars,
      bestScore: score,
      attempts: 1,
      totalXpEarned: totalXp,
    );

    ref
        .read(updateProgressProvider)
        .call(ref.read(currentChildIdProvider), progress);
  }
}
