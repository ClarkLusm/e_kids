import 'package:drift/drift.dart';

import '../../../domain/models/app_user.dart';
import '../app_database.dart';

class ChildProfilesDao {
  const ChildProfilesDao(this._db);

  final AppDatabase _db;

  Stream<AppUser?> watchActiveProfile() {
    return (_db.select(_db.childProfiles)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..limit(1))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _toDomain(row));
  }

  Future<AppUser?> getActiveProfile() async {
    final row =
        await (_db.select(_db.childProfiles)
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<void> upsertProfile({
    required String id,
    required String name,
    required String avatarId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final existing = await (_db.select(
      _db.childProfiles,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (existing == null) {
      await _db
          .into(_db.childProfiles)
          .insert(
            ChildProfilesCompanion.insert(
              id: id,
              name: name,
              avatarId: avatarId,
              createdAt: now,
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
          );
      return;
    }

    await (_db.update(
      _db.childProfiles,
    )..where((tbl) => tbl.id.equals(id))).write(
      ChildProfilesCompanion(
        name: Value(name),
        avatarId: Value(avatarId),
        updatedAt: Value(now),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> clearProfiles() async {
    await _db.delete(_db.childProfiles).go();
  }

  AppUser _toDomain(ChildProfile row) {
    return AppUser(id: row.id, displayName: row.name, avatarId: row.avatarId);
  }
}
