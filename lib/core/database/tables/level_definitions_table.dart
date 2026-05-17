import 'package:drift/drift.dart';

class LevelDefinitions extends Table {
  @override
  String get tableName => 'level_definitions';

  IntColumn get level => integer()();
  IntColumn get xpRequired => integer()();
  IntColumn get xpDelta => integer()();
  RealColumn get minAccuracy => real().withDefault(const Constant(0))();
  IntColumn get minWords => integer().withDefault(const Constant(0))();
  TextColumn get title => text()();
  TextColumn get badgeRewardId => text().nullable()();
  TextColumn get unlockFeature => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {level};
}
