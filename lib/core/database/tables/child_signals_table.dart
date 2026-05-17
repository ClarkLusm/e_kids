import 'package:drift/drift.dart';

class ChildSignals extends Table {
  @override
  String get tableName => 'child_signals';

  TextColumn get childId => text()();
  RealColumn get accuracy7d => real().withDefault(const Constant(0))();
  TextColumn get accuracyByTopic => text().withDefault(const Constant('{}'))();
  TextColumn get accuracyByType => text().withDefault(const Constant('{}'))();
  RealColumn get avgResponseSec => real().withDefault(const Constant(0))();
  TextColumn get weakTopics => text().withDefault(const Constant('[]'))();
  TextColumn get dueForReview => text().withDefault(const Constant('[]'))();
  IntColumn get daysSinceNewWords => integer().withDefault(const Constant(0))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  BoolColumn get streakAtRisk => boolean().withDefault(const Constant(false))();
  RealColumn get missionCompletion7d => real().withDefault(const Constant(0))();
  TextColumn get preferredMissionTypes =>
      text().withDefault(const Constant('[]'))();
  IntColumn get preferredHour => integer().withDefault(const Constant(19))();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {childId};
}
