import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/child_profiles_table.dart';
import 'tables/child_learning_paths_table.dart';
import 'tables/lesson_progress_table.dart';
import 'tables/learning_paths_table.dart';
import 'tables/lessons_table.dart';
import 'tables/path_topics_table.dart';
import 'tables/placement_sessions_table.dart';
import 'tables/quiz_questions_table.dart';
import 'tables/quiz_attempts_table.dart';
import 'tables/sync_versions_table.dart';
import 'tables/topics_table.dart';
import 'tables/vocabulary_items_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    ChildProfiles,
    SyncVersions,
    LearningPaths,
    Topics,
    PathTopics,
    ChildLearningPaths,
    PlacementSessions,
    Lessons,
    QuizQuestions,
    VocabularyItems,
    LessonProgressEntries,
    QuizAttempts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(lessonProgressEntries);
      }
      if (from < 3) {
        await m.createTable(syncVersions);
        await m.createTable(learningPaths);
        await m.createTable(topics);
        await m.createTable(pathTopics);
        await m.createTable(childLearningPaths);
        await m.createTable(lessons);
        await m.createTable(quizQuestions);
        await m.createTable(vocabularyItems);
      }
      if (from < 4) {
        await m.createTable(placementSessions);
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
