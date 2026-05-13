import 'package:drift/drift.dart';

class Lessons extends Table {
  @override
  String get tableName => 'lessons';

  TextColumn get id => text()();
  TextColumn get topicId => text()();
  TextColumn get titleEn => text()();
  TextColumn get titleVi => text()();
  TextColumn get descriptionVi => text().nullable()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get minXpRequired => integer().withDefault(const Constant(0))();
  BoolColumn get isPublished => boolean().withDefault(const Constant(true))();
  TextColumn get thumbnailUrl => text().nullable()();
  IntColumn get vocabularyCount => integer().withDefault(const Constant(0))();
  IntColumn get questionCount => integer().withDefault(const Constant(0))();
  IntColumn get xpReward => integer().withDefault(const Constant(50))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
