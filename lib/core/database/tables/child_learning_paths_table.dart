import 'package:drift/drift.dart';

class ChildLearningPaths extends Table {
  @override
  String get tableName => 'child_learning_paths';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get pathId => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get currentTopicId => text().nullable()();
  TextColumn get currentLessonId => text().nullable()();
  IntColumn get startedAt => integer()();
  IntColumn get completedAt => integer().nullable()();
  IntColumn get updatedAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {childId, pathId},
  ];
}
