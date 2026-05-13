import '../../../../core/database/daos/lesson_progress_dao.dart';
import '../../domain/models/lesson_models.dart';
import '../../domain/usecases/lesson_usecases.dart';

class LocalLessonProgressRepository implements ILessonProgressRepository {
  const LocalLessonProgressRepository(this._dao);

  final LessonProgressDao _dao;

  @override
  Future<Map<String, LessonProgress>> fetchProgressByTopic(
    String topicId,
    String childId,
  ) {
    // Progress table stores progress by lesson. The caller already scopes
    // lessons by topic and reads the needed keys from this map.
    return _dao.getProgressByChild(childId);
  }

  @override
  Future<LessonProgress?> fetchProgress(String lessonId, String childId) {
    return _dao.getProgress(childId: childId, lessonId: lessonId);
  }

  @override
  Future<void> upsertProgress(String childId, LessonProgress progress) {
    return _dao.upsertProgress(
      LessonProgressWrite(
        childId: childId,
        progress: progress,
        completedQuestions: progress.isDone ? 1 : 0,
        totalQuestions: progress.isDone ? 1 : 0,
      ),
    );
  }

  Future<void> upsertLessonCompletion({
    required String childId,
    required LessonProgress progress,
    required int completedQuestions,
    required int totalQuestions,
    required String? lastQuestionId,
  }) {
    return _dao.upsertProgress(
      LessonProgressWrite(
        childId: childId,
        progress: progress,
        completedQuestions: completedQuestions,
        totalQuestions: totalQuestions,
        lastQuestionId: lastQuestionId,
      ),
    );
  }
}
