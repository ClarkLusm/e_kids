import 'package:drift/drift.dart';

class DailyMissions extends Table {
  @override
  String get tableName => 'daily_missions';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get date => text()();
  IntColumn get slot => integer().withDefault(const Constant(0))();
  TextColumn get missionTemplateId => text()();
  TextColumn get paramsJson => text().withDefault(const Constant('{}'))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get progressValue => integer().withDefault(const Constant(0))();
  IntColumn get targetValue => integer()();
  IntColumn get xpReward => integer()();
  IntColumn get completedAt => integer().nullable()();
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
    {childId, date, missionTemplateId},
  ];
}
