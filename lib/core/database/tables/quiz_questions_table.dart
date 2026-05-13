import 'package:drift/drift.dart';

class QuizQuestions extends Table {
  @override
  String get tableName => 'quiz_questions';

  TextColumn get id => text()();
  TextColumn get lessonId => text()();
  TextColumn get quizType => text()();
  TextColumn get prompt => text().nullable()();
  TextColumn get contentJson => text()();
  IntColumn get difficulty => integer().withDefault(const Constant(1))();
  IntColumn get xpReward => integer().withDefault(const Constant(10))();
  IntColumn get timeLimitSec => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
