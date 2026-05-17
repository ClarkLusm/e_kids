import 'package:drift/drift.dart';

class WordMasteryEntries extends Table {
  @override
  String get tableName => 'word_mastery';

  TextColumn get childId => text()();
  TextColumn get wordId => text()();
  TextColumn get word => text().nullable()();
  IntColumn get timesSeen => integer().withDefault(const Constant(0))();
  IntColumn get timesCorrect => integer().withDefault(const Constant(0))();
  IntColumn get timesWrong => integer().withDefault(const Constant(0))();
  RealColumn get masteryScore => real().withDefault(const Constant(0))();
  IntColumn get lastSeenAt => integer().nullable()();
  IntColumn get nextReviewAt => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('learning'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get lastSyncedAt => integer().nullable()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {childId, wordId};
}
