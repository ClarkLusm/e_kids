import 'package:drift/drift.dart';

class SkillProgressEntries extends Table {
  @override
  String get tableName => 'skill_progress';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get pathId => text()();
  IntColumn get level => integer()();
  TextColumn get skillKey => text()();
  IntColumn get completedUnits => integer().withDefault(const Constant(0))();
  IntColumn get requiredUnits => integer()();
  RealColumn get progressPercent => real().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  IntColumn get earnedXp => integer().withDefault(const Constant(0))();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {childId, pathId, level, skillKey},
  ];
}
