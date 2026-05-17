import 'package:drift/drift.dart';

class Titles extends Table {
  @override
  String get tableName => 'titles';

  TextColumn get id => text()();
  TextColumn get code => text().unique()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get tier => integer().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get animation => text().nullable()();
  TextColumn get colorHex => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get flavorText => text().nullable()();
  TextColumn get unlockConditionJson => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
