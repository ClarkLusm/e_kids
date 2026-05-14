import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/placement_sessions_dao.dart';
import '../../domain/models/placement_result.dart';

class PlacementPathAssignmentService {
  PlacementPathAssignmentService(this._db)
    : _sessionsDao = PlacementSessionsDao(_db);

  final AppDatabase _db;
  final PlacementSessionsDao _sessionsDao;
  final _uuid = const Uuid();

  static const defaultPathId = 'path_beginner_6_10';

  Future<void> skipPlacement({required String childId}) async {
    await _db.transaction(() async {
      await _ensureSeedPaths();
      await _assignPath(childId: childId, pathId: defaultPathId);
      await _sessionsDao.insertSkipped(
        id: _uuid.v4(),
        childId: childId,
        selectedPathId: defaultPathId,
      );
    });
  }

  Future<PlacementResult> completePlacement({
    required String childId,
    required int score,
    required int maxScore,
    required List<Map<String, Object?>> answers,
  }) async {
    late final PlacementResult result;

    await _db.transaction(() async {
      await _ensureSeedPaths();
      result = _resultForScore(score: score, maxScore: maxScore);
      await _assignPath(childId: childId, pathId: result.pathId);
      await _sessionsDao.insertCompleted(
        id: _uuid.v4(),
        childId: childId,
        score: score,
        maxScore: maxScore,
        selectedPathId: result.pathId,
        answersJson: jsonEncode(answers),
      );
    });

    return result;
  }

  PlacementResult _resultForScore({required int score, required int maxScore}) {
    final ratio = maxScore <= 0 ? 0 : score / maxScore;

    if (ratio >= 0.8) {
      return PlacementResult(
        pathId: 'path_confident_6_10',
        pathTitle: 'Tự tin khám phá',
        pathDescription: 'Bé sẽ bắt đầu với các chủ đề giàu từ vựng hơn.',
        levelLabel: 'Tự tin',
        levelDescription: 'Bé đã quen với các câu hỏi tiếng Anh đơn giản.',
        score: score,
        maxScore: maxScore,
      );
    }

    if (ratio >= 0.45) {
      return PlacementResult(
        pathId: 'path_foundation_6_10',
        pathTitle: 'Nền tảng chắc chắn',
        pathDescription: 'Bé sẽ ôn và mở rộng các từ vựng cơ bản.',
        levelLabel: 'Có nền tảng',
        levelDescription: 'Bé đã biết một số từ tiếng Anh quen thuộc.',
        score: score,
        maxScore: maxScore,
      );
    }

    return PlacementResult(
      pathId: defaultPathId,
      pathTitle: 'Khởi đầu vui vẻ',
      pathDescription: 'Bé sẽ học chậm rãi từ những từ đầu tiên.',
      levelLabel: 'Mới bắt đầu',
      levelDescription: 'Bé phù hợp với lộ trình nhẹ nhàng, nhiều hình ảnh.',
      score: score,
      maxScore: maxScore,
    );
  }

  Future<void> _assignPath({
    required String childId,
    required String pathId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final firstTopicId = _firstTopicIdForPath(pathId);
    final firstLessonId = _firstLessonIdForTopic(firstTopicId);

    await (_db.update(
      _db.childLearningPaths,
    )..where((tbl) => tbl.childId.equals(childId))).write(
      ChildLearningPathsCompanion(
        status: const Value('inactive'),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );

    await _db
        .into(_db.childLearningPaths)
        .insertOnConflictUpdate(
          ChildLearningPathsCompanion.insert(
            id: 'child_path_${childId}_$pathId',
            childId: childId,
            pathId: pathId,
            status: const Value('active'),
            currentTopicId: Value(firstTopicId),
            currentLessonId: Value(firstLessonId),
            startedAt: now,
            updatedAt: now,
            syncStatus: const Value('pending'),
          ),
        );
  }

  String _firstTopicIdForPath(String pathId) {
    switch (pathId) {
      case 'path_confident_6_10':
        return 'topic_animals';
      case 'path_foundation_6_10':
      case defaultPathId:
      default:
        return 'topic_colors';
    }
  }

  String _firstLessonIdForTopic(String topicId) {
    switch (topicId) {
      case 'topic_animals':
        return 'lesson_animals_01';
      case 'topic_colors':
      default:
        return 'lesson_colors_01';
    }
  }

  Future<void> _ensureSeedPaths() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db
        .into(_db.learningPaths)
        .insertOnConflictUpdate(
          LearningPathsCompanion.insert(
            id: defaultPathId,
            title: 'Khởi đầu vui vẻ',
            description: const Value(
              'Lộ trình mặc định cho bé mới bắt đầu học tiếng Anh.',
            ),
            ageMin: const Value(6),
            ageMax: const Value(10),
            level: const Value('beginner'),
            sortOrder: const Value(0),
            createdAt: now,
            updatedAt: now,
          ),
        );

    await _db
        .into(_db.learningPaths)
        .insertOnConflictUpdate(
          LearningPathsCompanion.insert(
            id: 'path_foundation_6_10',
            title: 'Nền tảng chắc chắn',
            description: const Value(
              'Dành cho bé đã biết một số từ vựng cơ bản.',
            ),
            ageMin: const Value(6),
            ageMax: const Value(10),
            level: const Value('foundation'),
            sortOrder: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );

    await _db
        .into(_db.learningPaths)
        .insertOnConflictUpdate(
          LearningPathsCompanion.insert(
            id: 'path_confident_6_10',
            title: 'Tự tin khám phá',
            description: const Value(
              'Dành cho bé đã quen với câu hỏi đơn giản.',
            ),
            ageMin: const Value(6),
            ageMax: const Value(10),
            level: const Value('confident'),
            sortOrder: const Value(2),
            createdAt: now,
            updatedAt: now,
          ),
        );

    await _db
        .into(_db.topics)
        .insertOnConflictUpdate(
          TopicsCompanion.insert(
            id: 'topic_colors',
            nameEn: 'Colors',
            nameVi: 'Màu sắc',
            colorHex: const Value('#F6C85F'),
            sortOrder: const Value(0),
          ),
        );

    await _db
        .into(_db.topics)
        .insertOnConflictUpdate(
          TopicsCompanion.insert(
            id: 'topic_animals',
            nameEn: 'Animals',
            nameVi: 'Động vật',
            colorHex: const Value('#8BC34A'),
            sortOrder: const Value(1),
          ),
        );

    await _db
        .into(_db.pathTopics)
        .insertOnConflictUpdate(
          PathTopicsCompanion.insert(
            id: 'path_topic_${defaultPathId}_colors',
            pathId: defaultPathId,
            topicId: 'topic_colors',
            sortOrder: const Value(0),
          ),
        );

    await _db
        .into(_db.pathTopics)
        .insertOnConflictUpdate(
          PathTopicsCompanion.insert(
            id: 'path_topic_path_foundation_6_10_colors',
            pathId: 'path_foundation_6_10',
            topicId: 'topic_colors',
            sortOrder: const Value(0),
          ),
        );

    await _db
        .into(_db.pathTopics)
        .insertOnConflictUpdate(
          PathTopicsCompanion.insert(
            id: 'path_topic_path_confident_6_10_animals',
            pathId: 'path_confident_6_10',
            topicId: 'topic_animals',
            sortOrder: const Value(0),
          ),
        );

    await _db
        .into(_db.lessons)
        .insertOnConflictUpdate(
          LessonsCompanion.insert(
            id: 'lesson_colors_01',
            topicId: 'topic_colors',
            titleEn: 'Hello Colors',
            titleVi: 'Làm quen màu sắc',
            descriptionVi: const Value('Nhận biết các màu quen thuộc.'),
            level: const Value(1),
            sortOrder: const Value(0),
            vocabularyCount: const Value(6),
            questionCount: const Value(6),
            xpReward: const Value(50),
          ),
        );

    await _db
        .into(_db.lessons)
        .insertOnConflictUpdate(
          LessonsCompanion.insert(
            id: 'lesson_animals_01',
            topicId: 'topic_animals',
            titleEn: 'Cute Animals',
            titleVi: 'Động vật đáng yêu',
            descriptionVi: const Value('Học các con vật quen thuộc.'),
            level: const Value(1),
            sortOrder: const Value(0),
            vocabularyCount: const Value(6),
            questionCount: const Value(6),
            xpReward: const Value(50),
          ),
        );
  }
}
