import 'package:drift/drift.dart';

import '../../../features/lesson/domain/models/lesson_models.dart';
import '../app_database.dart';

class LessonProgressStats {
  const LessonProgressStats({
    required this.totalXp,
    required this.completedLessons,
    required this.activeProgressPercent,
  });

  final int totalXp;
  final int completedLessons;
  final double activeProgressPercent;
}

class LessonProgressWrite {
  const LessonProgressWrite({
    required this.childId,
    required this.progress,
    this.completedQuestions = 0,
    this.totalQuestions = 0,
    this.lastQuestionId,
  });

  final String childId;
  final LessonProgress progress;
  final int completedQuestions;
  final int totalQuestions;
  final String? lastQuestionId;
}

class LessonProgressDao {
  const LessonProgressDao(this._db);

  final AppDatabase _db;

  Future<Map<String, LessonProgress>> getProgressByChild(String childId) async {
    final rows =
        await (_db.select(_db.lessonProgressEntries)..where(
              (tbl) => tbl.childId.equals(childId) & tbl.deletedAt.isNull(),
            ))
            .get();

    return {for (final row in rows) row.lessonId: _toDomain(row)};
  }

  Future<LessonProgressStats> getStatsByChild(String childId) async {
    final rows =
        await (_db.select(_db.lessonProgressEntries)..where(
              (tbl) => tbl.childId.equals(childId) & tbl.deletedAt.isNull(),
            ))
            .get();

    var totalXp = 0;
    var completedLessons = 0;
    LessonProgressEntry? activeRow;

    for (final row in rows) {
      totalXp += row.earnedXp;

      final status = row.status;
      if (status == LessonStatus.completed.name ||
          status == LessonStatus.mastered.name) {
        completedLessons++;
      }

      if (status == LessonStatus.inProgress.name &&
          (activeRow == null || row.updatedAt > activeRow.updatedAt)) {
        activeRow = row;
      }
    }

    return LessonProgressStats(
      totalXp: totalXp,
      completedLessons: completedLessons,
      activeProgressPercent: activeRow?.progressPercent ?? 0,
    );
  }

  Future<LessonProgress?> getProgress({
    required String childId,
    required String lessonId,
  }) async {
    final row =
        await (_db.select(_db.lessonProgressEntries)
              ..where(
                (tbl) =>
                    tbl.childId.equals(childId) &
                    tbl.lessonId.equals(lessonId) &
                    tbl.deletedAt.isNull(),
              )
              ..limit(1))
            .getSingleOrNull();

    return row == null ? null : _toDomain(row);
  }

  Future<void> upsertProgress(LessonProgressWrite write) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final progress = write.progress;
    final existing =
        await (_db.select(_db.lessonProgressEntries)
              ..where(
                (tbl) =>
                    tbl.childId.equals(write.childId) &
                    tbl.lessonId.equals(progress.lessonId),
              )
              ..limit(1))
            .getSingleOrNull();

    final completedAt = progress.isDone ? now : null;
    final progressPercent = write.totalQuestions == 0
        ? (progress.isDone ? 100.0 : 0.0)
        : (write.completedQuestions / write.totalQuestions * 100).clamp(
            0.0,
            100.0,
          );

    if (existing == null) {
      await _db
          .into(_db.lessonProgressEntries)
          .insert(
            LessonProgressEntriesCompanion.insert(
              id: '${write.childId}_${progress.lessonId}',
              childId: write.childId,
              lessonId: progress.lessonId,
              updatedAt: now,
              status: Value(progress.status.name),
              progressPercent: Value(progressPercent),
              completedQuestions: Value(write.completedQuestions),
              totalQuestions: Value(write.totalQuestions),
              bestScore: Value(progress.bestScore),
              earnedXp: Value(progress.totalXpEarned),
              stars: Value(progress.stars),
              attempts: Value(progress.attempts),
              lastQuestionId: Value(write.lastQuestionId),
              startedAt: Value(now),
              completedAt: Value(completedAt),
              syncStatus: const Value('pending'),
            ),
          );
      return;
    }

    await (_db.update(
      _db.lessonProgressEntries,
    )..where((tbl) => tbl.id.equals(existing.id))).write(
      LessonProgressEntriesCompanion(
        status: Value(progress.status.name),
        progressPercent: Value(progressPercent),
        completedQuestions: Value(write.completedQuestions),
        totalQuestions: Value(write.totalQuestions),
        bestScore: Value(progress.bestScore),
        earnedXp: Value(progress.totalXpEarned),
        stars: Value(progress.stars),
        attempts: Value(progress.attempts),
        lastQuestionId: Value(write.lastQuestionId),
        completedAt: Value(completedAt),
        updatedAt: Value(now),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  LessonProgress _toDomain(LessonProgressEntry row) {
    return LessonProgress(
      lessonId: row.lessonId,
      status: LessonStatus.values.firstWhere(
        (status) => status.name == row.status,
        orElse: () => LessonStatus.locked,
      ),
      stars: row.stars,
      bestScore: row.bestScore,
      attempts: row.attempts,
      totalXpEarned: row.earnedXp,
    );
  }
}
