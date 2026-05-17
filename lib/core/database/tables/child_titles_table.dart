import 'package:drift/drift.dart';

class ChildTitles extends Table {
  @override
  String get tableName => 'child_titles';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get titleId => text()();
  TextColumn get titleType => text()();
  IntColumn get unlockedAt => integer()();
  BoolColumn get isEquipped => boolean().withDefault(const Constant(false))();
  IntColumn get equippedAt => integer().nullable()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {childId, titleId},
  ];
}
