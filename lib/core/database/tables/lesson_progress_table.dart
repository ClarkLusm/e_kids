import 'package:drift/drift.dart';

class LessonProgressEntries extends Table {
  @override
  String get tableName => 'lesson_progress';

  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get lessonId => text()();
  TextColumn get status => text().withDefault(const Constant('locked'))();
  RealColumn get progressPercent => real().withDefault(const Constant(0))();
  IntColumn get completedQuestions =>
      integer().withDefault(const Constant(0))();
  IntColumn get totalQuestions => integer().withDefault(const Constant(0))();
  IntColumn get bestScore => integer().withDefault(const Constant(0))();
  IntColumn get earnedXp => integer().withDefault(const Constant(0))();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastQuestionId => text().nullable()();
  IntColumn get startedAt => integer().nullable()();
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
    {childId, lessonId},
  ];
}
