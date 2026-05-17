import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/child_profiles_table.dart';
import 'tables/child_learning_paths_table.dart';
import 'tables/child_progress_table.dart';
import 'tables/child_signals_table.dart';
import 'tables/child_titles_table.dart';
import 'tables/lesson_progress_table.dart';
import 'tables/level_definitions_table.dart';
import 'tables/learning_paths_table.dart';
import 'tables/lessons_table.dart';
import 'tables/daily_missions_table.dart';
import 'tables/mission_templates_table.dart';
import 'tables/path_topics_table.dart';
import 'tables/placement_sessions_table.dart';
import 'tables/quiz_questions_table.dart';
import 'tables/quiz_attempts_table.dart';
import 'tables/skill_progress_table.dart';
import 'tables/skill_targets_table.dart';
import 'tables/sync_versions_table.dart';
import 'tables/topics_table.dart';
import 'tables/vocabulary_items_table.dart';
import 'tables/word_mastery_table.dart';
import 'tables/xp_events_table.dart';
import 'tables/titles_table.dart';

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
    MissionTemplates,
    DailyMissions,
    SkillTargets,
    SkillProgressEntries,
    LevelDefinitions,
    WordMasteryEntries,
    ChildProgressEntries,
    ChildSignals,
    XpEvents,
    Titles,
    ChildTitles,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 11;

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
      if (from < 5) {
        await m.createTable(missionTemplates);
        await m.createTable(dailyMissions);
      }
      if (from < 6) {
        await m.createTable(skillTargets);
        await m.createTable(skillProgressEntries);
      }
      if (from < 7) {
        await m.createTable(levelDefinitions);
        await m.createTable(wordMasteryEntries);
      }
      if (from < 8) {
        await m.createTable(childProgressEntries);
        await m.createTable(xpEvents);
      }
      // v9 removes duplicated progress columns from child_profiles and keeps
      // level/xp/streak in child_progress. Drift cannot reliably drop columns
      // across SQLite versions without a table rewrite, so existing installs
      // keep old columns as harmless legacy data until a destructive migration
      // policy is introduced.
      if (from < 10) {
        await m.createTable(titles);
        await m.createTable(childTitles);
      }
      if (from < 11) {
        await m.addColumn(dailyMissions, dailyMissions.slot);
        await m.createTable(childSignals);
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
