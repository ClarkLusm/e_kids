import 'dart:convert';
import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../../gamification/data/local/local_title_repository.dart';
import '../../domain/models/home_learning_summary.dart';

class LocalLevelProgressRepository {
  const LocalLevelProgressRepository(this._db);

  final db.AppDatabase _db;

  Future<HomeLearningSummary> getSummary(String childId) async {
    await _ensureDefaultLevelDefinitions();

    final definitions = await _activeLevelDefinitions();
    final attempts =
        await (_db.select(_db.quizAttempts)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final lessonRows =
        await (_db.select(_db.lessonProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final existingProgress = await _getChildProgress(childId);

    final totalXp = await _totalXp(childId, attempts, existingProgress);
    final completedLessons = lessonRows.where((row) {
      return row.status == 'completed' || row.status == 'mastered';
    }).length;
    final accuracy7Days = _accuracy7Days(attempts);
    final masteredWords = await _masteredWordCount(childId);

    final current = _currentDefinition(
      definitions: definitions,
      totalXp: totalXp,
      accuracy7Days: accuracy7Days,
      masteredWords: masteredWords,
    );
    final next = definitions
        .where((definition) => definition.level > current.level)
        .firstOrNull;
    final masteryBlocked =
        next != null &&
        totalXp >= next.xpRequired &&
        (accuracy7Days < next.minAccuracy || masteredWords < next.minWords);
    final currentXp = math.max(0, totalXp - current.xpRequired);
    final xpToNextLevel = next?.xpDelta ?? 0;
    final progressPercent = next == null
        ? 100
        : _progressToNextLevel(
            current: current,
            next: next,
            totalXp: totalXp,
            accuracy7Days: accuracy7Days,
            masteredWords: masteredWords,
          );

    await _upsertChildProgress(
      childId: childId,
      currentLevel: current.level,
      currentXp: currentXp,
      totalXp: totalXp,
      xpToNextLevel: xpToNextLevel,
      accuracy7Days: accuracy7Days,
      wordsMastered: masteredWords,
      masteryBlocked: masteryBlocked,
    );
    await LocalTitleRepository(_db).evaluateAndUnlock(childId);

    return HomeLearningSummary(
      totalXp: totalXp,
      completedLessons: completedLessons,
      currentLevel: current.level,
      nextLevel: next?.level ?? current.level,
      levelTitle: current.title,
      nextLevelTitle: next?.title,
      levelProgressPercent: progressPercent,
      accuracy7Days: accuracy7Days,
      masteredWords: masteredWords,
    );
  }

  Future<void> recordQuizAttempt({
    required String childId,
    required String quizType,
    required bool isCorrect,
    required int xpEarned,
    required Map<String, dynamic> answer,
  }) async {
    final word = _extractTrackedWord(answer);
    if (word != null) {
      await _upsertWordMastery(
        childId: childId,
        word: word,
        isCorrect: isCorrect,
      );
    }

    if (xpEarned > 0) {
      await _insertXpEvent(
        childId: childId,
        sourceType: 'quiz',
        sourceId: _readString(answer, const ['question_id']) ?? quizType,
        xpAmount: xpEarned,
        metadata: {
          'quiz_type': quizType,
          'is_correct': isCorrect,
          'answer': answer,
        },
      );
    }

    await getSummary(childId);
  }

  int calculateLessonXp({
    required int lessonBaseXp,
    required double accuracy,
    required int streakDays,
    required int firstTryCorrectCount,
  }) {
    final xp =
        lessonBaseXp *
        _accuracyMultiplier(accuracy) *
        _streakMultiplier(streakDays);
    return xp.round() + firstTryCorrectCount * 5;
  }

  int calculateDailyMissionXp({
    required int templateXpReward,
    required bool completedOnDate,
    required bool completedAllMissionsToday,
  }) {
    final base = completedOnDate ? templateXpReward : 0;
    return base + (completedAllMissionsToday ? 50 : 0);
  }

  int? streakMilestoneXp(int streakDays) {
    return switch (streakDays) {
      3 => 30,
      7 => 100,
      14 => 250,
      30 => 500,
      _ => null,
    };
  }

  Future<List<db.LevelDefinition>> _activeLevelDefinitions() async {
    final rows =
        await (_db.select(_db.levelDefinitions)
              ..where((tbl) => tbl.isActive.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.level)]))
            .get();

    if (rows.isNotEmpty) return rows;
    await _ensureDefaultLevelDefinitions();
    return (_db.select(_db.levelDefinitions)
          ..where((tbl) => tbl.isActive.equals(true))
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.level)]))
        .get();
  }

  Future<void> _ensureDefaultLevelDefinitions() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    var totalXpRequired = 0;

    for (var level = 1; level <= 21; level++) {
      final xpDelta = level == 1 ? 0 : _xpDeltaForTransition(level - 1);
      totalXpRequired += xpDelta;
      final gate = _masteryGateForLevel(level);

      await _db
          .into(_db.levelDefinitions)
          .insert(
            db.LevelDefinitionsCompanion.insert(
              level: Value(level),
              xpRequired: totalXpRequired,
              xpDelta: xpDelta,
              minAccuracy: Value(gate.minAccuracy),
              minWords: Value(gate.minWords),
              title: _titleForLevel(level),
              createdAt: now,
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  int _xpDeltaForTransition(int fromLevel) {
    // Product examples are gentler than the pasted formula. Keep this curve
    // quadratic and close to the provided samples: 1->2 = 150, 2->3 = 250.
    return 25 * fromLevel * fromLevel + 25 * fromLevel + 100;
  }

  _MasteryGate _masteryGateForLevel(int level) {
    if (level >= 21) return const _MasteryGate(0.75, 500);
    if (level >= 11) return const _MasteryGate(0.70, 200);
    if (level >= 6) return const _MasteryGate(0.65, 80);
    if (level >= 4) return const _MasteryGate(0.60, 45);
    if (level >= 3) return const _MasteryGate(0.55, 25);
    if (level >= 2) return const _MasteryGate(0.50, 10);
    return const _MasteryGate(0, 0);
  }

  String _titleForLevel(int level) {
    if (level >= 21) return 'Legend';
    if (level >= 11) return 'Champion';
    if (level >= 6) return 'Star';
    if (level >= 3) return 'Explorer';
    return 'Beginner';
  }

  db.LevelDefinition _currentDefinition({
    required List<db.LevelDefinition> definitions,
    required int totalXp,
    required double accuracy7Days,
    required int masteredWords,
  }) {
    final ordered =
        definitions.isEmpty
              ? <db.LevelDefinition>[]
              : List<db.LevelDefinition>.from(definitions)
          ..sort((a, b) => a.level.compareTo(b.level));
    if (ordered.isEmpty) {
      throw StateError('level_definitions is empty after default seed.');
    }

    var current = ordered.first;
    for (final definition in ordered) {
      final canReach =
          totalXp >= definition.xpRequired &&
          accuracy7Days >= definition.minAccuracy &&
          masteredWords >= definition.minWords;
      if (canReach) current = definition;
    }
    return current;
  }

  int _progressToNextLevel({
    required db.LevelDefinition current,
    required db.LevelDefinition next,
    required int totalXp,
    required double accuracy7Days,
    required int masteredWords,
  }) {
    final xpRange = next.xpRequired - current.xpRequired;
    final xpProgress = xpRange <= 0
        ? 1.0
        : ((totalXp - current.xpRequired) / xpRange).clamp(0.0, 1.0);
    final accuracyProgress = next.minAccuracy <= 0
        ? 1.0
        : (accuracy7Days / next.minAccuracy).clamp(0.0, 1.0);
    final wordsProgress = next.minWords <= 0
        ? 1.0
        : (masteredWords / next.minWords).clamp(0.0, 1.0);

    final gatedProgress = ([
      xpProgress,
      accuracyProgress,
      wordsProgress,
    ]..sort()).first;
    return (gatedProgress * 100).round();
  }

  Future<int> _totalXp(
    String childId,
    List<db.QuizAttempt> attempts,
    db.ChildProgressEntry? existingProgress,
  ) async {
    final events =
        await (_db.select(_db.xpEvents)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final eventXp = events.fold<int>(0, (sum, row) => sum + row.xpAmount);
    final attemptXp = attempts.fold<int>(0, (sum, row) => sum + row.xpEarned);
    return [
      eventXp,
      attemptXp,
      existingProgress?.totalXp ?? 0,
    ].reduce(math.max);
  }

  double _accuracy7Days(List<db.QuizAttempt> attempts) {
    final since = DateTime.now()
        .subtract(const Duration(days: 7))
        .millisecondsSinceEpoch;
    final recent = attempts
        .where((attempt) => attempt.createdAt >= since && attempt.isCompleted)
        .toList(growable: false);
    if (recent.isEmpty) return 0;
    final correct = recent.where((attempt) => attempt.isCorrect).length;
    return correct / recent.length;
  }

  Future<int> _masteredWordCount(String childId) async {
    final rows =
        await (_db.select(_db.wordMasteryEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.status.equals('mastered'))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    return rows.length;
  }

  Future<void> _insertXpEvent({
    required String childId,
    required String sourceType,
    required String sourceId,
    required int xpAmount,
    required Map<String, dynamic> metadata,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db
        .into(_db.xpEvents)
        .insert(
          db.XpEventsCompanion.insert(
            id: '${childId}_${sourceType}_${sourceId}_$now',
            childId: childId,
            sourceType: sourceType,
            sourceId: sourceId,
            xpAmount: xpAmount,
            metadataJson: Value(jsonEncode(metadata)),
            createdAt: now,
            syncStatus: const Value('pending'),
          ),
        );
  }

  Future<void> _upsertWordMastery({
    required String childId,
    required String word,
    required bool isCorrect,
  }) async {
    final normalizedWord = _normalizeWord(word);
    if (normalizedWord == null) return;

    final wordId = await _resolveWordId(normalizedWord);
    final existing =
        await (_db.select(_db.wordMasteryEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.wordId.equals(wordId))
              ..limit(1))
            .getSingleOrNull();
    final now = DateTime.now().millisecondsSinceEpoch;

    final timesSeen = (existing?.timesSeen ?? 0) + 1;
    final timesCorrect = (existing?.timesCorrect ?? 0) + (isCorrect ? 1 : 0);
    final timesWrong = (existing?.timesWrong ?? 0) + (isCorrect ? 0 : 1);
    final masteryScore = _masteryScore(
      timesSeen: timesSeen,
      timesCorrect: timesCorrect,
      previousLastSeenAt: existing?.lastSeenAt,
      now: now,
    );
    final status = _masteryStatus(
      previousStatus: existing?.status,
      timesSeen: timesSeen,
      masteryScore: masteryScore,
    );
    final nextReviewAt = _nextReviewAt(now, masteryScore, status);

    if (existing == null) {
      await _db
          .into(_db.wordMasteryEntries)
          .insert(
            db.WordMasteryEntriesCompanion.insert(
              childId: childId,
              wordId: wordId,
              word: Value(normalizedWord),
              timesSeen: Value(timesSeen),
              timesCorrect: Value(timesCorrect),
              timesWrong: Value(timesWrong),
              masteryScore: Value(masteryScore),
              lastSeenAt: Value(now),
              nextReviewAt: Value(nextReviewAt),
              status: Value(status),
              syncStatus: const Value('pending'),
            ),
          );
      return;
    }

    await (_db.update(_db.wordMasteryEntries)
          ..where((tbl) => tbl.childId.equals(childId))
          ..where((tbl) => tbl.wordId.equals(wordId)))
        .write(
          db.WordMasteryEntriesCompanion(
            word: Value(normalizedWord),
            timesSeen: Value(timesSeen),
            timesCorrect: Value(timesCorrect),
            timesWrong: Value(timesWrong),
            masteryScore: Value(masteryScore),
            lastSeenAt: Value(now),
            nextReviewAt: Value(nextReviewAt),
            status: Value(status),
            deletedAt: const Value(null),
            syncStatus: const Value('pending'),
          ),
        );
  }

  Future<String> _resolveWordId(String normalizedWord) async {
    final rows = await (_db.select(_db.vocabularyItems)).get();
    for (final row in rows) {
      if (_normalizeWord(row.word) == normalizedWord) return row.id;
    }
    return 'word:$normalizedWord';
  }

  double _masteryScore({
    required int timesSeen,
    required int timesCorrect,
    required int? previousLastSeenAt,
    required int now,
  }) {
    if (timesSeen <= 0) return 0;
    return (timesCorrect / timesSeen * _decayFactor(previousLastSeenAt, now))
        .clamp(0.0, 1.0);
  }

  double _decayFactor(int? previousLastSeenAt, int now) {
    if (previousLastSeenAt == null) return 1;
    final diff = DateTime.fromMillisecondsSinceEpoch(
      now,
    ).difference(DateTime.fromMillisecondsSinceEpoch(previousLastSeenAt));
    if (diff <= const Duration(hours: 24)) return 1;
    if (diff <= const Duration(days: 3)) return 0.9;
    if (diff <= const Duration(days: 7)) return 0.7;
    return 0.5;
  }

  String _masteryStatus({
    required String? previousStatus,
    required int timesSeen,
    required double masteryScore,
  }) {
    if (previousStatus == 'mastered' && masteryScore <= 0.5) return 'forgotten';
    if (masteryScore >= 0.8 && timesSeen >= 3) return 'mastered';
    return 'learning';
  }

  int _nextReviewAt(int now, double masteryScore, String status) {
    final duration = switch (status) {
      'mastered' => const Duration(days: 7),
      'forgotten' => const Duration(hours: 12),
      _ when masteryScore >= 0.6 => const Duration(days: 3),
      _ => const Duration(days: 1),
    };
    return DateTime.fromMillisecondsSinceEpoch(
      now,
    ).add(duration).millisecondsSinceEpoch;
  }

  Future<db.ChildProgressEntry?> _getChildProgress(String childId) {
    return (_db.select(_db.childProgressEntries)
          ..where((tbl) => tbl.childId.equals(childId))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> _upsertChildProgress({
    required String childId,
    required int currentLevel,
    required int currentXp,
    required int totalXp,
    required int xpToNextLevel,
    required double accuracy7Days,
    required int wordsMastered,
    required bool masteryBlocked,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final existing = await _getChildProgress(childId);
    final companion = db.ChildProgressEntriesCompanion(
      currentLevel: Value(currentLevel),
      currentXp: Value(currentXp),
      totalXp: Value(totalXp),
      xpToNextLevel: Value(xpToNextLevel),
      accuracy7d: Value(accuracy7Days),
      wordsMastered: Value(wordsMastered),
      streakDays: Value(existing?.streakDays ?? 0),
      masteryBlocked: Value(masteryBlocked),
      updatedAt: Value(now),
      deletedAt: const Value(null),
      syncStatus: const Value('pending'),
    );

    if (existing == null) {
      await _db
          .into(_db.childProgressEntries)
          .insert(
            db.ChildProgressEntriesCompanion.insert(
              childId: childId,
              currentLevel: Value(currentLevel),
              currentXp: Value(currentXp),
              totalXp: Value(totalXp),
              xpToNextLevel: Value(xpToNextLevel),
              accuracy7d: Value(accuracy7Days),
              wordsMastered: Value(wordsMastered),
              streakDays: const Value(0),
              masteryBlocked: Value(masteryBlocked),
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
          );
      return;
    }

    await (_db.update(
      _db.childProgressEntries,
    )..where((tbl) => tbl.childId.equals(childId))).write(companion);
  }

  double _accuracyMultiplier(double accuracy) {
    if (accuracy >= 0.9) return 1.5;
    if (accuracy >= 0.7) return 1.0;
    if (accuracy >= 0.5) return 0.7;
    return 0.5;
  }

  double _streakMultiplier(int streakDays) {
    if (streakDays >= 14) return 1.5;
    if (streakDays >= 7) return 1.25;
    if (streakDays >= 3) return 1.1;
    return 1.0;
  }

  String? _extractTrackedWord(Map<String, dynamic> answer) {
    final direct = _readString(answer, const [
      'word_id',
      'target_word',
      'correct_word',
      'word',
    ]);
    if (direct != null) return direct;

    final nested = answer['answer_given'];
    if (nested is Map<String, dynamic>) {
      return _readString(nested, const [
        'word_id',
        'target_word',
        'correct_word',
        'word',
      ]);
    }

    return null;
  }

  String? _readString(Map<String, dynamic> source, List<String> keys) {
    for (final key in keys) {
      final value = source[key];
      if (value is String && value.trim().isNotEmpty) return value;
    }
    return null;
  }

  String? _normalizeWord(String word) {
    final normalized = word.trim().toLowerCase();
    if (normalized.isEmpty) return null;
    return normalized.replaceAll(RegExp(r'\s+'), ' ');
  }
}

class _MasteryGate {
  const _MasteryGate(this.minAccuracy, this.minWords);

  final double minAccuracy;
  final int minWords;
}
