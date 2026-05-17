import 'package:drift/drift.dart' as drift;

import '../../../../core/database/app_database.dart' as db;
import '../../../lesson/data/lesson_repository.dart';
import '../../../lesson/domain/models/lesson_models.dart';
import '../../domain/models/path_topic_summary.dart';

class LocalPathTopicRepository {
  LocalPathTopicRepository(this._db)
    : _topicFallback = MockTopicRepository(),
      _lessonFallback = MockLessonRepository();

  final db.AppDatabase _db;
  final MockTopicRepository _topicFallback;
  final MockLessonRepository _lessonFallback;

  Future<List<PathTopicSummary>> getPathTopicSummaries(String childId) async {
    final pathId = await _activePathId(childId);
    final topics = await _topicsForPath(pathId);
    final progressRows =
        await (_db.select(_db.lessonProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final completedLessonIds = progressRows
        .where((row) => row.status == 'completed' || row.status == 'mastered')
        .map((row) => row.lessonId)
        .toSet();

    final summaries = <PathTopicSummary>[];
    for (final topic in topics) {
      final lessons = await _lessonsByTopic(topic.id);
      summaries.add(
        PathTopicSummary(
          topic: topic,
          completedLessons: lessons
              .where((lesson) => completedLessonIds.contains(lesson.id))
              .length,
          totalLessons: lessons.length,
          totalXpReward: lessons.fold(
            0,
            (sum, lesson) => sum + lesson.xpReward,
          ),
        ),
      );
    }

    return summaries;
  }

  Future<String> _activePathId(String childId) async {
    final row =
        await (_db.select(_db.childLearningPaths)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.status.equals('active'))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    return row?.pathId ?? 'path_beginner_6_10';
  }

  Future<List<Topic>> _topicsForPath(String pathId) async {
    final pathRows =
        await (_db.select(_db.pathTopics)
              ..where((tbl) => tbl.pathId.equals(pathId))
              ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.sortOrder)]))
            .get();

    if (pathRows.isNotEmpty) {
      final topics = <Topic>[];
      for (final pathTopic in pathRows) {
        final topic =
            await (_db.select(_db.topics)
                  ..where((tbl) => tbl.id.equals(pathTopic.topicId))
                  ..where((tbl) => tbl.isActive.equals(true))
                  ..limit(1))
                .getSingleOrNull();
        if (topic != null) topics.add(_topicFromDb(topic));
      }
      if (topics.isNotEmpty) return topics;
    }

    final rows =
        await (_db.select(_db.topics)
              ..where((tbl) => tbl.isActive.equals(true))
              ..orderBy([
                (tbl) => drift.OrderingTerm.asc(tbl.sortOrder),
                (tbl) => drift.OrderingTerm.asc(tbl.nameEn),
              ]))
            .get();
    if (rows.isNotEmpty) return rows.map(_topicFromDb).toList(growable: false);

    return _topicFallback.fetchAllTopics();
  }

  Future<List<Lesson>> _lessonsByTopic(String topicId) async {
    final rows =
        await (_db.select(_db.lessons)
              ..where((tbl) => tbl.topicId.equals(topicId))
              ..where((tbl) => tbl.isPublished.equals(true))
              ..orderBy([
                (tbl) => drift.OrderingTerm.asc(tbl.sortOrder),
                (tbl) => drift.OrderingTerm.asc(tbl.titleEn),
              ]))
            .get();

    if (rows.isNotEmpty) return rows.map(_lessonFromDb).toList(growable: false);
    return _lessonFallback.fetchByTopic(topicId);
  }

  Topic _topicFromDb(db.Topic row) {
    return Topic(
      id: row.id,
      nameEn: row.nameEn,
      nameVi: row.nameVi,
      iconUrl: row.iconUrl,
      colorHex: row.colorHex,
      sortOrder: row.sortOrder,
      isActive: row.isActive,
    );
  }

  Lesson _lessonFromDb(db.Lesson row) {
    return Lesson(
      id: row.id,
      topicId: row.topicId,
      titleEn: row.titleEn,
      titleVi: row.titleVi,
      descriptionVi: row.descriptionVi,
      level: row.level,
      sortOrder: row.sortOrder,
      minXpRequired: row.minXpRequired,
      isPublished: row.isPublished,
      thumbnailUrl: row.thumbnailUrl,
      vocabularyCount: row.vocabularyCount,
      questionCount: row.questionCount,
      xpReward: row.xpReward,
    );
  }
}
