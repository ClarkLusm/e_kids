import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/child_profiles_table.dart';
import 'tables/lesson_progress_table.dart';
import 'tables/quiz_attempts_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ChildProfiles, LessonProgressEntries, QuizAttempts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(lessonProgressEntries);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'e_kids.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
