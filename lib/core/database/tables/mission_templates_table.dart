import 'package:drift/drift.dart';

class MissionTemplates extends Table {
  @override
  String get tableName => 'mission_templates';

  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get difficulty => text()();
  TextColumn get topicScope => text().withDefault(const Constant('any'))();
  TextColumn get conditionJson => text().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get targetMetric => text()();
  IntColumn get targetValue => integer()();
  IntColumn get xpReward => integer()();
  IntColumn get durationEstMin => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
