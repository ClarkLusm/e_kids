import 'package:drift/drift.dart';

class QuizAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get sessionId => text().nullable()();
  TextColumn get lessonId => text()();
  TextColumn get questionId => text()();
  TextColumn get quizType => text()();
  IntColumn get attemptIndex => integer().withDefault(const Constant(1))();
  BoolColumn get isCorrect => boolean()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(true))();
  IntColumn get score => integer().withDefault(const Constant(0))();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  IntColumn get timeTakenMs => integer().withDefault(const Constant(0))();
  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();
  TextColumn get answerJson => text().nullable()();
  IntColumn get createdAt => integer()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
