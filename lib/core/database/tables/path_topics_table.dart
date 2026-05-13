import 'package:drift/drift.dart';

class PathTopics extends Table {
  @override
  String get tableName => 'path_topics';

  TextColumn get id => text()();
  TextColumn get pathId => text()();
  TextColumn get topicId => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isRequired => boolean().withDefault(const Constant(true))();
  TextColumn get unlockRuleJson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {pathId, topicId},
  ];
}
