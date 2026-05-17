import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/skill_progress_summary.dart';

class LocalSkillProgressRepository {
  const LocalSkillProgressRepository(this._db);

  final db.AppDatabase _db;

  Future<List<SkillProgressSummary>> getSkillProgress(String childId) async {
    final scope = await _resolveScope(childId);
    await _ensureProgressRows(childId: childId, scope: scope);
    return _getProgressRows(childId: childId, scope: scope);
  }

  Future<List<SkillProgressSummary>> getOrCreateSkillProgress(
    String childId,
  ) async {
    final scope = await _resolveScope(childId);
    await _ensureDefaultTargets(scope.pathId, scope.level);
    await _ensureProgressRows(childId: childId, scope: scope);
    return _getProgressRows(childId: childId, scope: scope);
  }

  Future<List<SkillProgressSummary>> _getProgressRows({
    required String childId,
    required _SkillScope scope,
  }) async {
    final rows =
        await (_db.select(_db.skillProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.pathId.equals(scope.pathId))
              ..where((tbl) => tbl.level.equals(scope.level))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.skillKey)]))
            .get();
    final ordered = [_skillVocabulary, _skillListening, _skillSpeaking];
    return ordered
        .map(
          (skillKey) =>
              rows.where((row) => row.skillKey == skillKey).firstOrNull,
        )
        .whereType<db.SkillProgressEntry>()
        .map(_toSummary)
        .toList(growable: false);
  }

  Future<void> updateTarget({
    required String childId,
    required String pathId,
    required int level,
    required String skillKey,
    required int requiredUnits,
  }) async {
    final safeRequiredUnits = requiredUnits.clamp(1, 999).toInt();
    final now = DateTime.now().millisecondsSinceEpoch;
    final targetId = _targetId(pathId, level, skillKey);
    final progressId = _progressId(childId, pathId, level, skillKey);

    await _db.transaction(() async {
      await (_db.update(
        _db.skillTargets,
      )..where((tbl) => tbl.id.equals(targetId))).write(
        db.SkillTargetsCompanion(
          requiredUnits: Value(safeRequiredUnits),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );

      final progress =
          await (_db.select(_db.skillProgressEntries)
                ..where((tbl) => tbl.id.equals(progressId))
                ..limit(1))
              .getSingleOrNull();

      if (progress == null) return;

      await (_db.update(
        _db.skillProgressEntries,
      )..where((tbl) => tbl.id.equals(progressId))).write(
        db.SkillProgressEntriesCompanion(
          requiredUnits: Value(safeRequiredUnits),
          progressPercent: Value(
            _progressPercent(progress.completedUnits, safeRequiredUnits),
          ),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<void> recordQuizAttempt({
    required String childId,
    required String quizType,
    required bool isCorrect,
    required int xpEarned,
  }) async {
    final skillKey = _primarySkillForQuiz(quizType);
    if (skillKey == null) return;

    final scope = await _resolveScope(childId);
    await _ensureProgressRows(childId: childId, scope: scope);

    final progressId = _progressId(
      childId,
      scope.pathId,
      scope.level,
      skillKey,
    );
    final row =
        await (_db.select(_db.skillProgressEntries)
              ..where((tbl) => tbl.id.equals(progressId))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return;

    final completedUnits = row.completedUnits + (isCorrect ? 1 : 0);
    final correctCount = row.correctCount + (isCorrect ? 1 : 0);
    final attemptCount = row.attemptCount + 1;
    final earnedXp = row.earnedXp + xpEarned;
    final now = DateTime.now().millisecondsSinceEpoch;

    await (_db.update(
      _db.skillProgressEntries,
    )..where((tbl) => tbl.id.equals(progressId))).write(
      db.SkillProgressEntriesCompanion(
        completedUnits: Value(completedUnits),
        correctCount: Value(correctCount),
        attemptCount: Value(attemptCount),
        earnedXp: Value(earnedXp),
        progressPercent: Value(
          _progressPercent(completedUnits, row.requiredUnits),
        ),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<_SkillScope> _resolveScope(String childId) async {
    final activePath =
        await (_db.select(_db.childLearningPaths)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.status.equals('active'))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    final progress =
        await (_db.select(_db.childProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();

    return _SkillScope(
      pathId: activePath?.pathId ?? 'path_beginner_6_10',
      level: progress?.currentLevel ?? 1,
    );
  }

  Future<void> _ensureDefaultTargets(String pathId, int level) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final defaults = [
      _SkillSeed(_skillVocabulary, 30, 'words'),
      _SkillSeed(_skillListening, 20, 'questions'),
      _SkillSeed(_skillSpeaking, 10, 'utterances'),
    ];

    for (final seed in defaults) {
      await _db
          .into(_db.skillTargets)
          .insert(
            db.SkillTargetsCompanion.insert(
              id: _targetId(pathId, level, seed.skillKey),
              pathId: pathId,
              level: level,
              skillKey: seed.skillKey,
              requiredUnits: seed.requiredUnits,
              unitType: seed.unitType,
              createdAt: now,
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<void> _ensureProgressRows({
    required String childId,
    required _SkillScope scope,
  }) async {
    final targets =
        await (_db.select(_db.skillTargets)
              ..where((tbl) => tbl.pathId.equals(scope.pathId))
              ..where((tbl) => tbl.level.equals(scope.level))
              ..where((tbl) => tbl.isActive.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final now = DateTime.now().millisecondsSinceEpoch;

    for (final target in targets) {
      final existing =
          await (_db.select(_db.skillProgressEntries)
                ..where(
                  (tbl) => tbl.id.equals(
                    _progressId(
                      childId,
                      scope.pathId,
                      scope.level,
                      target.skillKey,
                    ),
                  ),
                )
                ..limit(1))
              .getSingleOrNull();

      if (existing == null) {
        await _db
            .into(_db.skillProgressEntries)
            .insert(
              db.SkillProgressEntriesCompanion.insert(
                id: _progressId(
                  childId,
                  scope.pathId,
                  scope.level,
                  target.skillKey,
                ),
                childId: childId,
                pathId: scope.pathId,
                level: scope.level,
                skillKey: target.skillKey,
                requiredUnits: target.requiredUnits,
                progressPercent: const Value(0),
                updatedAt: now,
                syncStatus: const Value('pending'),
              ),
            );
        continue;
      }

      if (existing.requiredUnits != target.requiredUnits) {
        await (_db.update(
          _db.skillProgressEntries,
        )..where((tbl) => tbl.id.equals(existing.id))).write(
          db.SkillProgressEntriesCompanion(
            requiredUnits: Value(target.requiredUnits),
            progressPercent: Value(
              _progressPercent(existing.completedUnits, target.requiredUnits),
            ),
            updatedAt: Value(now),
          ),
        );
      }
    }
  }

  SkillProgressSummary _toSummary(db.SkillProgressEntry row) {
    return SkillProgressSummary(
      childId: row.childId,
      pathId: row.pathId,
      level: row.level,
      skillKey: row.skillKey,
      label: _labelFor(row.skillKey),
      icon: _iconFor(row.skillKey),
      color: _colorFor(row.skillKey),
      completedUnits: row.completedUnits,
      requiredUnits: row.requiredUnits,
      unitType: _unitTypeFor(row.skillKey),
      progressPercent: row.progressPercent,
    );
  }

  double _progressPercent(int completedUnits, int requiredUnits) {
    if (requiredUnits <= 0) return 0;
    return (completedUnits / requiredUnits * 100).clamp(0, 100).toDouble();
  }

  String _targetId(String pathId, int level, String skillKey) =>
      '${pathId}_level_${level}_$skillKey';

  String _progressId(
    String childId,
    String pathId,
    int level,
    String skillKey,
  ) => '${childId}_${pathId}_level_${level}_$skillKey';

  String _labelFor(String skillKey) {
    return switch (skillKey) {
      _skillVocabulary => 'Vocabulary',
      _skillListening => 'Listening',
      _skillSpeaking => 'Speaking',
      _ => skillKey,
    };
  }

  String _iconFor(String skillKey) {
    return switch (skillKey) {
      _skillVocabulary => '✅',
      _skillListening => '💎',
      _skillSpeaking => '🔶',
      _ => '⭐',
    };
  }

  Color _colorFor(String skillKey) {
    return switch (skillKey) {
      _skillVocabulary => const Color(0xFF29C315),
      _skillListening => const Color(0xFF0368D9),
      _skillSpeaking => const Color(0xFFFF3E28),
      _ => const Color(0xFF0EA5E9),
    };
  }

  String _unitTypeFor(String skillKey) {
    return switch (skillKey) {
      _skillVocabulary => 'words',
      _skillListening => 'questions',
      _skillSpeaking => 'utterances',
      _ => 'units',
    };
  }

  String? _primarySkillForQuiz(String quizType) {
    return switch (quizType) {
      'picture_match' => _skillVocabulary,
      'listen_tap' => _skillListening,
      'letter_scramble' => _skillVocabulary,
      'fill_blank' => _skillVocabulary,
      'speak_word' => _skillSpeaking,
      'memory_flip' => _skillVocabulary,
      'sort_bucket' => _skillVocabulary,
      'word_pop' => _skillVocabulary,
      'story_builder' => _skillSpeaking,
      _ => null,
    };
  }
}

const _skillVocabulary = 'vocabulary';
const _skillListening = 'listening';
const _skillSpeaking = 'speaking';

class _SkillScope {
  const _SkillScope({required this.pathId, required this.level});

  final String pathId;
  final int level;
}

class _SkillSeed {
  const _SkillSeed(this.skillKey, this.requiredUnits, this.unitType);

  final String skillKey;
  final int requiredUnits;
  final String unitType;
}
