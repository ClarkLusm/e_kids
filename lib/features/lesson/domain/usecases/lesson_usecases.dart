import '../models/lesson_models.dart';
import '../../../quiz/_shared/question_ref.dart';

// ─── Repository interfaces ────────────────────────────────────────────────

abstract class ITopicRepository {
  Future<List<Topic>> fetchAllTopics();
}

abstract class ILessonRepository {
  Future<List<Lesson>> fetchByTopic(String topicId);
  Future<Lesson> fetchById(String lessonId);
}

abstract class IVocabularyRepository {
  Future<List<Vocabulary>> fetchByLesson(String lessonId);
}

abstract class IQuestionRefRepository {
  Future<List<QuestionRef>> fetchByLesson(String lessonId);
}

abstract class ILessonProgressRepository {
  Future<Map<String, LessonProgress>> fetchProgressByTopic(
    String topicId,
    String childId,
  );
  Future<LessonProgress?> fetchProgress(String lessonId, String childId);
  Future<void> upsertProgress(String childId, LessonProgress progress);
}

// ─── Use cases ────────────────────────────────────────────────────────────

class FetchTopicsUseCase {
  final ITopicRepository _repo;
  const FetchTopicsUseCase(this._repo);
  Future<List<Topic>> call() => _repo.fetchAllTopics();
}

class FetchLessonsByTopicUseCase {
  final ILessonRepository _repo;
  const FetchLessonsByTopicUseCase(this._repo);
  Future<List<Lesson>> call(String topicId) => _repo.fetchByTopic(topicId);
}

class FetchLessonDetailUseCase {
  final ILessonRepository _lessonRepo;
  final IVocabularyRepository _vocabRepo;
  final IQuestionRefRepository _questionRepo;

  const FetchLessonDetailUseCase(
    this._lessonRepo,
    this._vocabRepo,
    this._questionRepo,
  );

  Future<LessonDetail> call(String lessonId) async {
    final results = await Future.wait([
      _lessonRepo.fetchById(lessonId),
      _vocabRepo.fetchByLesson(lessonId),
      _questionRepo.fetchByLesson(lessonId),
    ]);

    return LessonDetail(
      lesson: results[0] as Lesson,
      vocabulary: results[1] as List<Vocabulary>,
      questions: results[2] as List<QuestionRef>,
    );
  }
}

/// DTO gom lại toàn bộ dữ liệu cần cho 1 lesson
class LessonDetail {
  final Lesson lesson;
  final List<Vocabulary> vocabulary;
  final List<QuestionRef> questions;

  const LessonDetail({
    required this.lesson,
    required this.vocabulary,
    required this.questions,
  });

  int get totalXp => questions.fold(0, (sum, q) => sum + q.xpReward);
}

class FetchLessonProgressUseCase {
  final ILessonProgressRepository _repo;
  const FetchLessonProgressUseCase(this._repo);

  Future<Map<String, LessonProgress>> call(String topicId, String childId) =>
      _repo.fetchProgressByTopic(topicId, childId);
}

class UpdateLessonProgressUseCase {
  final ILessonProgressRepository _repo;
  const UpdateLessonProgressUseCase(this._repo);

  Future<void> call(String childId, LessonProgress progress) =>
      _repo.upsertProgress(childId, progress);
}
