import 'package:drift/drift.dart';

class ChildProgressEntries extends Table {
  @override
  String get tableName => 'child_progress';

  TextColumn get childId => text()();
  IntColumn get currentLevel => integer().withDefault(const Constant(1))();
  IntColumn get currentXp => integer().withDefault(const Constant(0))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get xpToNextLevel => integer().withDefault(const Constant(150))();
  RealColumn get accuracy7d => real().withDefault(const Constant(0))();
  IntColumn get wordsMastered => integer().withDefault(const Constant(0))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  BoolColumn get masteryBlocked =>
      boolean().withDefault(const Constant(false))();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {childId};
}
