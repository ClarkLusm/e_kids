import 'package:drift/drift.dart';

class XpEvents extends Table {
  @override
  String get tableName => 'xp_events';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();
  IntColumn get xpAmount => integer()();
  IntColumn get baseXp => integer().withDefault(const Constant(0))();
  RealColumn get accuracyMultiplier => real().withDefault(const Constant(1))();
  RealColumn get streakMultiplier => real().withDefault(const Constant(1))();
  IntColumn get firstTryBonus => integer().withDefault(const Constant(0))();
  TextColumn get metadataJson => text().nullable()();
  IntColumn get createdAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
