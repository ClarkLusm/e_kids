import 'package:drift/drift.dart' as drift;

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/lesson_models.dart';
import '../../domain/usecases/lesson_usecases.dart';
import '../lesson_repository.dart';

class LocalTopicRepository implements ITopicRepository {
  LocalTopicRepository(this._db, {ITopicRepository? fallback})
    : _fallback = fallback ?? MockTopicRepository();

  final db.AppDatabase _db;
  final ITopicRepository _fallback;

  @override
  Future<List<Topic>> fetchAllTopics() async {
    final rows =
        await (_db.select(_db.topics)
              ..where((tbl) => tbl.isActive.equals(true))
              ..orderBy([
                (tbl) => drift.OrderingTerm.asc(tbl.sortOrder),
                (tbl) => drift.OrderingTerm.asc(tbl.nameEn),
              ]))
            .get();

    if (rows.isEmpty) {
      return _fallback.fetchAllTopics();
    }

    return rows.map(_toDomain).toList(growable: false);
  }

  Topic _toDomain(db.Topic row) {
    return Topic(
      id: row.id,
      nameEn: row.nameEn,
      nameVi: row.nameVi,
      iconUrl: row.iconUrl,
      colorHex: row.colorHex,
      sortOrder: row.sortOrder,
      isActive: row.isActive,
    );
  }
}
