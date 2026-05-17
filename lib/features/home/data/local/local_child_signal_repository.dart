import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;

class LocalChildSignalRepository {
  const LocalChildSignalRepository(this._db);

  final db.AppDatabase _db;

  Future<void> recomputeAfterQuizAttempt(String childId) async {
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;
    final since7dMs = now
        .subtract(const Duration(days: 7))
        .millisecondsSinceEpoch;
    final todayKey = _dateKey(now);

    final attempts =
        await (_db.select(_db.quizAttempts)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(since7dMs))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();

    final lessonTopicById = await _lessonTopicById(
      attempts.map((attempt) => attempt.lessonId).toSet(),
    );
    final accuracyByTopic = _accuracyByTopic(attempts, lessonTopicById);
    final accuracyByType = _accuracyByType(attempts);
    final weakTopics = accuracyByTopic.entries
        .where((entry) => entry.value < 0.65)
        .map((entry) => entry.key)
        .toList(growable: false);

    final progress =
        await (_db.select(_db.childProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..limit(1))
            .getSingleOrNull();
    final dueForReview = await _dueForReview(childId, nowMs);
    final completion7d = await _missionCompletion7d(childId, now);
    final preferredTypes = _preferredTypes(attempts);
    final preferredHour = _preferredHour(attempts) ?? 19;
    final todayAttempts = attempts.where((attempt) {
      return _dateKey(DateTime.fromMillisecondsSinceEpoch(attempt.createdAt)) ==
          todayKey;
    }).length;

    await _db
        .into(_db.childSignals)
        .insertOnConflictUpdate(
          db.ChildSignalsCompanion.insert(
            childId: childId,
            accuracy7d: Value(_accuracy(attempts)),
            accuracyByTopic: Value(jsonEncode(accuracyByTopic)),
            accuracyByType: Value(jsonEncode(accuracyByType)),
            avgResponseSec: Value(_avgResponseSec(attempts)),
            weakTopics: Value(jsonEncode(weakTopics)),
            dueForReview: Value(jsonEncode(dueForReview)),
            daysSinceNewWords: const Value(0),
            streakDays: Value(progress?.streakDays ?? 0),
            streakAtRisk: Value(todayAttempts == 0),
            missionCompletion7d: Value(completion7d),
            preferredMissionTypes: Value(jsonEncode(preferredTypes)),
            preferredHour: Value(preferredHour),
            updatedAt: nowMs,
          ),
        );
  }

  Future<Map<String, String>> _lessonTopicById(Set<String> lessonIds) async {
    if (lessonIds.isEmpty) return const {};
    final lessons = await (_db.select(
      _db.lessons,
    )..where((tbl) => tbl.id.isIn(lessonIds))).get();
    return {for (final lesson in lessons) lesson.id: lesson.topicId};
  }

  Future<List<String>> _dueForReview(String childId, int nowMs) async {
    final tomorrowMs = nowMs + const Duration(days: 1).inMilliseconds;
    final rows =
        await (_db.select(_db.wordMasteryEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where(
                (tbl) => tbl.nextReviewAt.isSmallerOrEqualValue(tomorrowMs),
              )
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(20))
            .get();
    return rows.map((row) => row.wordId).toList(growable: false);
  }

  Future<double> _missionCompletion7d(String childId, DateTime now) async {
    final dates = List.generate(7, (index) {
      return _dateKey(now.subtract(Duration(days: index)));
    });
    final rows =
        await (_db.select(_db.dailyMissions)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.date.isIn(dates))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    if (rows.isEmpty) return 0;
    final completed = rows.where((row) => row.status == 'completed').length;
    return completed / rows.length;
  }

  Map<String, double> _accuracyByTopic(
    List<db.QuizAttempt> attempts,
    Map<String, String> lessonTopicById,
  ) {
    final grouped = <String, List<db.QuizAttempt>>{};
    for (final attempt in attempts) {
      final topicId = lessonTopicById[attempt.lessonId] ?? 'unknown';
      grouped.putIfAbsent(topicId, () => []).add(attempt);
    }
    return grouped.map((topic, rows) => MapEntry(topic, _accuracy(rows)));
  }

  Map<String, double> _accuracyByType(List<db.QuizAttempt> attempts) {
    final grouped = <String, List<db.QuizAttempt>>{};
    for (final attempt in attempts) {
      grouped.putIfAbsent(attempt.quizType, () => []).add(attempt);
    }
    return grouped.map((type, rows) => MapEntry(type, _accuracy(rows)));
  }

  List<String> _preferredTypes(List<db.QuizAttempt> attempts) {
    final counts = <String, int>{};
    for (final attempt in attempts.where((attempt) => attempt.isCompleted)) {
      counts.update(attempt.quizType, (value) => value + 1, ifAbsent: () => 1);
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).map((entry) => entry.key).toList(growable: false);
  }

  int? _preferredHour(List<db.QuizAttempt> attempts) {
    if (attempts.isEmpty) return null;
    final counts = <int, int>{};
    for (final attempt in attempts) {
      final hour = DateTime.fromMillisecondsSinceEpoch(attempt.createdAt).hour;
      counts.update(hour, (value) => value + 1, ifAbsent: () => 1);
    }
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  double _accuracy(List<db.QuizAttempt> attempts) {
    if (attempts.isEmpty) return 0;
    final completed = attempts.where((attempt) => attempt.isCompleted).toList();
    if (completed.isEmpty) return 0;
    final correct = completed.where((attempt) => attempt.isCorrect).length;
    return correct / completed.length;
  }

  double _avgResponseSec(List<db.QuizAttempt> attempts) {
    if (attempts.isEmpty) return 0;
    final totalMs = attempts.fold<int>(
      0,
      (sum, attempt) => sum + attempt.timeTakenMs,
    );
    return totalMs / attempts.length / 1000;
  }

  String _dateKey(DateTime date) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }
}
