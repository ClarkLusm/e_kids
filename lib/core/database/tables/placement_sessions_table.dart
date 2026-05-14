import 'package:drift/drift.dart';

class PlacementSessions extends Table {
  @override
  String get tableName => 'placement_sessions';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get status => text().withDefault(const Constant('started'))();
  IntColumn get score => integer().withDefault(const Constant(0))();
  IntColumn get maxScore => integer().withDefault(const Constant(0))();
  TextColumn get recommendedPathId => text().nullable()();
  TextColumn get selectedPathId => text().nullable()();
  TextColumn get answersJson => text().nullable()();
  IntColumn get startedAt => integer()();
  IntColumn get completedAt => integer().nullable()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
