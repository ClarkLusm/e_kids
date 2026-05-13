import 'package:drift/drift.dart';

class Topics extends Table {
  @override
  String get tableName => 'topics';

  TextColumn get id => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameVi => text()();
  TextColumn get iconUrl => text().nullable()();
  TextColumn get colorHex => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
