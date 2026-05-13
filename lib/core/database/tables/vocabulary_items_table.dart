import 'package:drift/drift.dart';

class VocabularyItems extends Table {
  @override
  String get tableName => 'vocabulary_items';

  TextColumn get id => text()();
  TextColumn get lessonId => text()();
  TextColumn get word => text()();
  TextColumn get phonetic => text().nullable()();
  TextColumn get translationVi => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get partOfSpeech => text().nullable()();
  BoolColumn get isKeyWord => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
