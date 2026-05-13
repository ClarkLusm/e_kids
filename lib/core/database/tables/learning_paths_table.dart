import 'package:drift/drift.dart';

class LearningPaths extends Table {
  @override
  String get tableName => 'learning_paths';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get ageMin => integer().nullable()();
  IntColumn get ageMax => integer().nullable()();
  TextColumn get level => text().withDefault(const Constant('beginner'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
