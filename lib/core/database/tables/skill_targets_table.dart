import 'package:drift/drift.dart';

class SkillTargets extends Table {
  @override
  String get tableName => 'skill_targets';

  TextColumn get id => text()();
  TextColumn get pathId => text()();
  IntColumn get level => integer()();
  TextColumn get skillKey => text()();
  IntColumn get requiredUnits => integer()();
  TextColumn get unitType => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {pathId, level, skillKey},
  ];
}
