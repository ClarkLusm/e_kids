import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/home_mission.dart';
import '../../domain/models/mission_content.dart';

class MissionContentResolver {
  const MissionContentResolver(this._db);

  final db.AppDatabase _db;

  Future<MissionContent> resolve({
    required String childId,
    required HomeMission mission,
  }) async {
    final targetCount = _targetCount(mission);
    final lessonIds = await _lessonIdsForTopic(mission.topicLabel);
    final words = await _resolveVocabulary(
      childId: childId,
      mission: mission,
      lessonIds: lessonIds,
      limit: targetCount,
    );
    final questions = await _resolveQuestions(
      mission: mission,
      lessonIds: lessonIds,
      limit: targetCount,
    );

    return MissionContent(
      missionId: mission.id,
      activityType: _activityTypeFor(mission),
      summaryLines: _summaryLines(mission, words, questions),
      warmUpWords: _needsWarmUp(mission)
          ? words.take(3).toList(growable: false)
          : const [],
      quizQuestions: questions,
      hasAuthoredContent: words.isNotEmpty || questions.isNotEmpty,
    );
  }

  Future<List<String>> _lessonIdsForTopic(String topicLabel) async {
    final normalizedTopic = topicLabel.trim().toLowerCase();
    if (normalizedTopic.isEmpty || normalizedTopic == 'bất kỳ') {
      return const [];
    }

    final topics = await _db.select(_db.topics).get();
    final matchedTopicIds = topics
        .where((topic) {
          final haystack = '${topic.id} ${topic.nameEn} ${topic.nameVi}'
              .toLowerCase();
          return haystack.contains(normalizedTopic);
        })
        .map((topic) => topic.id)
        .toSet();

    if (matchedTopicIds.isEmpty) return const [];

    final lessons =
        await (_db.select(_db.lessons)
              ..where((tbl) => tbl.topicId.isIn(matchedTopicIds))
              ..where((tbl) => tbl.isPublished.equals(true))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)]))
            .get();
    return lessons.map((lesson) => lesson.id).toList(growable: false);
  }

  Future<List<MissionVocabularyItem>> _resolveVocabulary({
    required String childId,
    required HomeMission mission,
    required List<String> lessonIds,
    required int limit,
  }) async {
    if (mission.type == 'review') {
      final due = await _dueReviewWords(childId, limit);
      if (due.isNotEmpty) return due;
    }

    final words = await _vocabularyByLessons(lessonIds, limit: limit);
    if (mission.type != 'vocabulary' && mission.type != 'flashcard') {
      return words;
    }

    final masteryRows = await (_db.select(
      _db.wordMasteryEntries,
    )..where((tbl) => tbl.childId.equals(childId))).get();
    final seenWordIds = masteryRows.map((row) => row.wordId).toSet();
    final unseen = words
        .where((word) => !seenWordIds.contains(word.id))
        .take(limit)
        .toList(growable: false);
    return unseen.isNotEmpty
        ? unseen
        : words.take(limit).toList(growable: false);
  }

  Future<List<MissionVocabularyItem>> _dueReviewWords(
    String childId,
    int limit,
  ) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final masteryRows =
        await (_db.select(_db.wordMasteryEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..orderBy([
                (tbl) => OrderingTerm.asc(tbl.nextReviewAt),
                (tbl) => OrderingTerm.asc(tbl.masteryScore),
              ]))
            .get();
    final dueIds = masteryRows
        .where((row) {
          final nextReviewAt = row.nextReviewAt;
          return row.status == 'forgotten' ||
              nextReviewAt == null ||
              nextReviewAt <= now;
        })
        .map((row) => row.wordId)
        .take(limit)
        .toList(growable: false);
    if (dueIds.isEmpty) return const [];

    final vocab = await (_db.select(
      _db.vocabularyItems,
    )..where((tbl) => tbl.id.isIn(dueIds))).get();
    return vocab.map(_toVocabularyItem).toList(growable: false);
  }

  Future<List<MissionVocabularyItem>> _vocabularyByLessons(
    List<String> lessonIds, {
    required int limit,
  }) async {
    final query = _db.select(_db.vocabularyItems)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)])
      ..limit(limit);
    if (lessonIds.isNotEmpty) {
      query.where((tbl) => tbl.lessonId.isIn(lessonIds));
    }
    final rows = await query.get();
    return rows.map(_toVocabularyItem).toList(growable: false);
  }

  Future<List<MissionQuizQuestion>> _resolveQuestions({
    required HomeMission mission,
    required List<String> lessonIds,
    required int limit,
  }) async {
    final quizTypes = _quizTypesFor(mission);
    if (quizTypes.isEmpty) return const [];

    final query = _db.select(_db.quizQuestions)
      ..where((tbl) => tbl.isActive.equals(true))
      ..where((tbl) => tbl.quizType.isIn(quizTypes))
      ..orderBy([
        (tbl) => OrderingTerm.asc(tbl.difficulty),
        (tbl) => OrderingTerm.asc(tbl.sortOrder),
      ])
      ..limit(limit);
    if (lessonIds.isNotEmpty) {
      query.where((tbl) => tbl.lessonId.isIn(lessonIds));
    }

    var rows = await query.get();
    if (rows.isEmpty && lessonIds.isNotEmpty) {
      rows =
          await (_db.select(_db.quizQuestions)
                ..where((tbl) => tbl.isActive.equals(true))
                ..where((tbl) => tbl.quizType.isIn(quizTypes))
                ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)])
                ..limit(limit))
              .get();
    }

    return rows.map(_toQuizQuestion).toList(growable: false);
  }

  List<String> _summaryLines(
    HomeMission mission,
    List<MissionVocabularyItem> words,
    List<MissionQuizQuestion> questions,
  ) {
    if (mission.type == 'vocabulary' || mission.type == 'flashcard') {
      return [
        'Học ${words.length} từ mới',
        'Nghe phát âm và xem nghĩa tiếng Việt',
        if (questions.isNotEmpty) 'Trả lời ${questions.length} câu hỏi',
      ];
    }
    if (mission.type == 'review') {
      return [
        'Ôn lại ${words.length} từ sắp quên',
        if (questions.isNotEmpty) 'Làm ${questions.length} câu ôn tập nhanh',
      ];
    }
    if (questions.isNotEmpty) {
      return [
        'Trả lời ${questions.length} câu ${mission.type}',
        if (words.isNotEmpty) 'Warm-up ${words.length} từ liên quan',
      ];
    }
    return ['Hoàn thành bài ngắn', 'Nhận ${mission.xpReward} XP sau khi xong'];
  }

  List<String> _quizTypesFor(HomeMission mission) {
    return switch (mission.type) {
      'placement' => const [
        'picture_match',
        'listen_tap',
        'letter_scramble',
        'fill_blank',
      ],
      'quiz' => const ['picture_match', 'listen_tap', 'letter_scramble'],
      'matching' => const ['picture_match', 'memory_flip'],
      'listen_tap' => const ['listen_tap'],
      'fill_blank' => const ['fill_blank'],
      'challenge' => const ['speak_word', 'sort_bucket', 'story_builder'],
      _ => const [],
    };
  }

  String _activityTypeFor(HomeMission mission) {
    if (mission.type == 'flashcard' || mission.type == 'vocabulary') {
      return 'flashcard';
    }
    if (mission.type == 'review') return 'review';
    return mission.type;
  }

  bool _needsWarmUp(HomeMission mission) {
    return mission.needsWarmUp;
  }

  int _targetCount(HomeMission mission) {
    final raw = mission.params['n'];
    if (raw is int) return raw.clamp(1, 20);
    if (raw is num) return raw.toInt().clamp(1, 20);
    return mission.targetValue.clamp(1, 20);
  }

  MissionVocabularyItem _toVocabularyItem(db.VocabularyItem row) {
    return MissionVocabularyItem(
      id: row.id,
      word: row.word,
      translationVi: row.translationVi,
      phonetic: row.phonetic,
      imageUrl: row.imageUrl,
      audioUrl: row.audioUrl,
    );
  }

  MissionQuizQuestion _toQuizQuestion(db.QuizQuestion row) {
    return MissionQuizQuestion(
      id: row.id,
      lessonId: row.lessonId,
      quizType: row.quizType,
      prompt: row.prompt,
      contentJson: row.contentJson,
      xpReward: row.xpReward,
    );
  }
}
