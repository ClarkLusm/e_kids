import 'package:drift/drift.dart';

import '../app_database.dart';

class PlacementSessionsDao {
  const PlacementSessionsDao(this._db);

  final AppDatabase _db;

  Future<void> insertSkipped({
    required String id,
    required String childId,
    required String selectedPathId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db
        .into(_db.placementSessions)
        .insert(
          PlacementSessionsCompanion.insert(
            id: id,
            childId: childId,
            status: const Value('skipped'),
            selectedPathId: Value(selectedPathId),
            recommendedPathId: Value(selectedPathId),
            startedAt: now,
            completedAt: Value(now),
            updatedAt: now,
          ),
        );
  }

  Future<void> insertCompleted({
    required String id,
    required String childId,
    required int score,
    required int maxScore,
    required String selectedPathId,
    required String answersJson,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db
        .into(_db.placementSessions)
        .insert(
          PlacementSessionsCompanion.insert(
            id: id,
            childId: childId,
            status: const Value('completed'),
            score: Value(score),
            maxScore: Value(maxScore),
            selectedPathId: Value(selectedPathId),
            recommendedPathId: Value(selectedPathId),
            answersJson: Value(answersJson),
            startedAt: now,
            completedAt: Value(now),
            updatedAt: now,
          ),
        );
  }
}
