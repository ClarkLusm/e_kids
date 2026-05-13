import 'package:drift/drift.dart';

class SyncVersions extends Table {
  @override
  String get tableName => 'sync_versions';

  TextColumn get id => text()();
  TextColumn get syncKey => text()();
  TextColumn get version => text()();
  TextColumn get source => text()();
  IntColumn get appliedAt => integer()();
  IntColumn get lastCheckedAt => integer().nullable()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {syncKey},
  ];
}
