import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;

class LocalTitleRepository {
  const LocalTitleRepository(this._db);

  final db.AppDatabase _db;

  Future<List<db.Title>> evaluateAndUnlock(String childId) async {
    await _ensureDefaultTitles();

    final progress =
        await (_db.select(_db.childProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (progress == null) return const [];

    final titles =
        await (_db.select(_db.titles)
              ..where((tbl) => tbl.isActive.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.priority)]))
            .get();
    final unlocked =
        await (_db.select(_db.childTitles)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    final unlockedIds = unlocked.map((row) => row.titleId).toSet();

    final newlyUnlocked = <db.Title>[];
    for (final title in titles) {
      if (unlockedIds.contains(title.id)) continue;
      final canUnlock = await _matchesCondition(
        childId: childId,
        title: title,
        progress: progress,
      );
      if (!canUnlock) continue;

      await _unlockAndMaybeEquip(childId: childId, title: title);
      newlyUnlocked.add(title);
    }

    return newlyUnlocked;
  }

  Future<void> equipTitle({
    required String childId,
    required String titleId,
  }) async {
    final title =
        await (_db.select(_db.titles)
              ..where((tbl) => tbl.id.equals(titleId))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (title == null) return;

    final childTitle =
        await (_db.select(_db.childTitles)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.titleId.equals(titleId))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (childTitle == null) return;

    await _db.transaction(() {
      return _equipUnlockedTitle(
        childId: childId,
        childTitleId: childTitle.id,
        titleType: title.type,
      );
    });
  }

  Future<void> _ensureDefaultTitles() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final seeds = [
      _TitleSeed.main(
        id: 'title_main_level_2',
        code: 'tan_binh',
        name: 'Tân binh',
        tier: 2,
        priority: 20,
        colorHex: '#38BDF8',
        description: 'Bắt đầu hành trình học tiếng Anh.',
        flavorText: 'Mỗi ngày một chút, giỏi lên từng chút!',
        condition: {'type': 'level', 'value': 2},
      ),
      _TitleSeed.main(
        id: 'title_main_level_5',
        code: 'nha_tham_hiem',
        name: 'Nhà thám hiểm',
        tier: 5,
        priority: 50,
        colorHex: '#22C55E',
        description: 'Chinh phục nhiều bài học đầu tiên.',
        flavorText: 'Đi xa hơn hôm qua là đã thắng rồi!',
        condition: {'type': 'level', 'value': 5},
      ),
      _TitleSeed.main(
        id: 'title_main_level_10',
        code: 'trang_nguyen',
        name: 'Trạng nguyên',
        tier: 10,
        priority: 100,
        colorHex: '#F59E0B',
        description: 'Đỗ đầu thiên hạ.',
        flavorText: 'Học chắc, nhớ lâu, càng ngày càng sáng!',
        condition: {'type': 'level', 'value': 10},
      ),
      _TitleSeed.sub(
        id: 'title_sub_streak_7',
        code: 'tho_con_cham_chi',
        name: 'Thỏ con chăm chỉ',
        priority: 70,
        colorHex: '#EC4899',
        description: 'Học đều 7 ngày.',
        flavorText: 'Ngày nào cũng học, tai thỏ nghe siêu rõ!',
        condition: {'type': 'streak', 'value': 7},
      ),
      _TitleSeed.sub(
        id: 'title_sub_accuracy_85',
        code: 'mat_cu_tinh_anh',
        name: 'Mắt cú tinh anh',
        priority: 85,
        colorHex: '#8B5CF6',
        description: 'Accuracy 7 ngày đạt ít nhất 85%.',
        flavorText: 'Nhìn phát biết ngay đáp án đúng!',
        condition: {'type': 'accuracy_7d', 'value': 0.85},
      ),
      _TitleSeed.sub(
        id: 'title_sub_speed_30',
        code: 'tho_con_nhanh_nhen',
        name: 'Thỏ con nhanh nhẹn',
        priority: 90,
        colorHex: '#F97316',
        description: 'Ít nhất 30% lượt làm quiz đúng và nhanh.',
        flavorText: 'Nhanh như chớp, vẫn đúng từng câu!',
        condition: {'type': 'speed_pct', 'value': 0.30},
      ),
      _TitleSeed.sub(
        id: 'title_sub_mission_days_5',
        code: 'nguoi_giu_loi_hua',
        name: 'Người giữ lời hứa',
        priority: 95,
        colorHex: '#14B8A6',
        description: 'Hoàn thành nhiệm vụ trong 5 ngày.',
        flavorText: 'Hứa là làm, học là vui!',
        condition: {'type': 'mission_days', 'value': 5},
      ),
    ];

    for (final seed in seeds) {
      await _db
          .into(_db.titles)
          .insert(
            db.TitlesCompanion.insert(
              id: seed.id,
              code: seed.code,
              name: seed.name,
              type: seed.type,
              tier: Value(seed.tier),
              colorHex: Value(seed.colorHex),
              description: Value(seed.description),
              flavorText: Value(seed.flavorText),
              unlockConditionJson: jsonEncode(seed.condition),
              priority: Value(seed.priority),
              createdAt: now,
              updatedAt: now,
              syncStatus: const Value('pending'),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<bool> _matchesCondition({
    required String childId,
    required db.Title title,
    required db.ChildProgressEntry progress,
  }) async {
    final decoded = jsonDecode(title.unlockConditionJson);
    if (decoded is! Map<String, dynamic>) return false;
    return _matchesConditionMap(
      childId: childId,
      condition: decoded,
      progress: progress,
    );
  }

  Future<bool> _matchesConditionMap({
    required String childId,
    required Map<String, dynamic> condition,
    required db.ChildProgressEntry progress,
  }) async {
    final all = condition['all'];
    if (all is List) {
      for (final item in all) {
        if (item is! Map<String, dynamic>) return false;
        final matched = await _matchesConditionMap(
          childId: childId,
          condition: item,
          progress: progress,
        );
        if (!matched) return false;
      }
      return true;
    }

    final type = condition['type'] as String?;
    final value = condition['value'];
    return switch (type) {
      'level' => progress.currentLevel >= _asInt(value),
      'streak' => progress.streakDays >= _asInt(value),
      'accuracy_7d' => progress.accuracy7d >= _asDouble(value),
      'speed_pct' => await _speedPct(childId) >= _asDouble(value),
      'mission_days' => await _completedMissionDays(childId) >= _asInt(value),
      _ => false,
    };
  }

  Future<double> _speedPct(String childId) async {
    final attempts =
        await (_db.select(_db.quizAttempts)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.isCompleted.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    if (attempts.isEmpty) return 0;
    final fastCorrect = attempts.where((attempt) {
      return attempt.isCorrect && attempt.timeTakenMs <= 5000;
    }).length;
    return fastCorrect / attempts.length;
  }

  Future<int> _completedMissionDays(String childId) async {
    final missions =
        await (_db.select(_db.dailyMissions)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.status.equals('completed'))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();
    return missions.map((mission) => mission.date).toSet().length;
  }

  Future<void> _unlockAndMaybeEquip({
    required String childId,
    required db.Title title,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final childTitleId = '${childId}_${title.id}';

    await _db.transaction(() async {
      await _db
          .into(_db.childTitles)
          .insert(
            db.ChildTitlesCompanion.insert(
              id: childTitleId,
              childId: childId,
              titleId: title.id,
              titleType: title.type,
              unlockedAt: now,
              syncStatus: const Value('pending'),
            ),
            mode: InsertMode.insertOrIgnore,
          );

      final shouldEquip =
          title.type == 'main' ||
          await _shouldAutoEquipSubTitle(childId: childId, title: title);
      if (!shouldEquip) return;

      await _equipUnlockedTitle(
        childId: childId,
        childTitleId: childTitleId,
        titleType: title.type,
      );
    });
  }

  Future<bool> _shouldAutoEquipSubTitle({
    required String childId,
    required db.Title title,
  }) async {
    final equipped =
        await (_db.select(_db.childTitles)
              ..where((tbl) => tbl.childId.equals(childId))
              ..where((tbl) => tbl.titleType.equals('sub'))
              ..where((tbl) => tbl.isEquipped.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (equipped == null) return true;

    final equippedTitle =
        await (_db.select(_db.titles)
              ..where((tbl) => tbl.id.equals(equipped.titleId))
              ..limit(1))
            .getSingleOrNull();
    return title.priority >= (equippedTitle?.priority ?? 0);
  }

  Future<void> _equipUnlockedTitle({
    required String childId,
    required String childTitleId,
    required String titleType,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.childTitles)
          ..where((tbl) => tbl.childId.equals(childId))
          ..where((tbl) => tbl.titleType.equals(titleType)))
        .write(
          const db.ChildTitlesCompanion(
            isEquipped: Value(false),
            equippedAt: Value(null),
            syncStatus: Value('pending'),
          ),
        );

    await (_db.update(
      _db.childTitles,
    )..where((tbl) => tbl.id.equals(childTitleId))).write(
      db.ChildTitlesCompanion(
        isEquipped: const Value(true),
        equippedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  int _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.round();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  double _asDouble(Object? value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}

class _TitleSeed {
  const _TitleSeed({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.priority,
    required this.colorHex,
    required this.description,
    required this.flavorText,
    required this.condition,
    this.tier,
  });

  factory _TitleSeed.main({
    required String id,
    required String code,
    required String name,
    required int tier,
    required int priority,
    required String colorHex,
    required String description,
    required String flavorText,
    required Map<String, Object> condition,
  }) {
    return _TitleSeed(
      id: id,
      code: code,
      name: name,
      type: 'main',
      tier: tier,
      priority: priority,
      colorHex: colorHex,
      description: description,
      flavorText: flavorText,
      condition: condition,
    );
  }

  factory _TitleSeed.sub({
    required String id,
    required String code,
    required String name,
    required int priority,
    required String colorHex,
    required String description,
    required String flavorText,
    required Map<String, Object> condition,
  }) {
    return _TitleSeed(
      id: id,
      code: code,
      name: name,
      type: 'sub',
      priority: priority,
      colorHex: colorHex,
      description: description,
      flavorText: flavorText,
      condition: condition,
    );
  }

  final String id;
  final String code;
  final String name;
  final String type;
  final int priority;
  final String colorHex;
  final String description;
  final String flavorText;
  final Map<String, Object> condition;
  final int? tier;
}
