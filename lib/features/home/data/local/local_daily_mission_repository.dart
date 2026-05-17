import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/home_mission.dart';

class LocalDailyMissionRepository {
  const LocalDailyMissionRepository(this._db);

  final db.AppDatabase _db;

  Future<List<HomeMission>> getTodayMissions(String childId) async {
    await _ensureSeedTemplates();

    final date = _todayKey();
    var rows = await _getMissionRows(childId: childId, date: date);

    if (rows.isEmpty) {
      await _createTodayMissions(childId: childId, date: date);
      rows = await _getMissionRows(childId: childId, date: date);
    }

    return rows.map(_toDomain).toList(growable: false);
  }

  Future<List<_MissionRow>> _getMissionRows({
    required String childId,
    required String date,
  }) async {
    final daily = _db.alias(_db.dailyMissions, 'dm');
    final templates = _db.alias(_db.missionTemplates, 'mt');

    final rows =
        await (_db.select(daily).join([
                innerJoin(
                  templates,
                  templates.id.equalsExp(daily.missionTemplateId),
                ),
              ])
              ..where(daily.childId.equals(childId))
              ..where(daily.date.equals(date))
              ..where(daily.deletedAt.isNull())
              ..where(templates.deletedAt.isNull())
              ..orderBy([
                OrderingTerm.asc(daily.slot),
                OrderingTerm.asc(daily.createdAt),
              ]))
            .get();

    return rows
        .map(
          (row) => _MissionRow(
            daily: row.readTable(daily),
            template: row.readTable(templates),
          ),
        )
        .toList(growable: false);
  }

  Future<void> _createTodayMissions({
    required String childId,
    required String date,
  }) async {
    final templates = await _activeTemplatesById();
    final learningDay = await _learningDay(childId);
    final plans = learningDay <= 7
        ? _onboardingPlans(learningDay)
        : await _adaptivePlans(childId: childId, date: date);

    for (final plan in plans) {
      final template = templates[plan.templateId];
      if (template == null) continue;
      await _insertMission(
        childId: childId,
        date: date,
        slot: plan.slot,
        template: template,
        params: plan.params ?? _defaultParamsFor(template),
        targetValue: plan.targetValue ?? template.targetValue,
        xpReward: plan.xpReward ?? template.xpReward,
      );
    }
  }

  Future<Map<String, db.MissionTemplate>> _activeTemplatesById() async {
    final templates =
        await (_db.select(_db.missionTemplates)
              ..where((tbl) => tbl.isActive.equals(true))
              ..where((tbl) => tbl.deletedAt.isNull()))
            .get();

    return {for (final template in templates) template.id: template};
  }

  Future<int> _learningDay(String childId) async {
    final profile =
        await (_db.select(_db.childProfiles)
              ..where((tbl) => tbl.id.equals(childId))
              ..limit(1))
            .getSingleOrNull();

    final createdAt =
        profile?.createdAt ?? DateTime.now().millisecondsSinceEpoch;
    final createdDate = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final now = DateTime.now();
    final firstDay = DateTime(
      createdDate.year,
      createdDate.month,
      createdDate.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    return today.difference(firstDay).inDays + 1;
  }

  List<_MissionPlan> _onboardingPlans(int learningDay) {
    return switch (learningDay) {
      1 => const [
        _MissionPlan(
          slot: 1,
          templateId: 'mission_onboarding_day1_placement',
          params: {'n': 5},
        ),
      ],
      2 => const [
        _MissionPlan(
          slot: 1,
          templateId: 'mission_onboarding_day2_animals_vocab',
          params: {'n': 5, 'topic': 'Animals'},
        ),
      ],
      3 => const [
        _MissionPlan(
          slot: 1,
          templateId: 'mission_onboarding_day3_animals_quiz',
          params: {'n': 5, 'topic': 'Animals'},
        ),
        _MissionPlan(
          slot: 2,
          templateId: 'mission_onboarding_day3_new_words',
          params: {'n': 3},
        ),
      ],
      4 => const [
        _MissionPlan(
          slot: 1,
          templateId: 'mission_onboarding_day4_matching',
          params: {'topic': 'Animals'},
        ),
        _MissionPlan(
          slot: 2,
          templateId: 'mission_onboarding_day4_listen',
          params: {'topic': 'Animals'},
        ),
      ],
      _ => const [
        _MissionPlan(
          slot: 1,
          templateId: 'mission_onboarding_day5_review',
          params: {'topic': 'tuần đầu'},
        ),
      ],
    };
  }

  Future<List<_MissionPlan>> _adaptivePlans({
    required String childId,
    required String date,
  }) async {
    final signals = await _readSignals(childId);
    final previousTypes = await _previousMissionTypes(childId, date);
    final plans = <_MissionPlan>[
      _slot1Plan(signals),
      _slot2Plan(signals),
      _slot3Plan(signals),
      _slot4Plan(signals),
    ];

    final rotated = plans
        .map((plan) => _rotateIfNeeded(plan, previousTypes))
        .toList(growable: false);
    return _capTotalDuration(rotated);
  }

  Future<_ChildSignalSnapshot> _readSignals(String childId) async {
    final row =
        await (_db.select(_db.childSignals)
              ..where((tbl) => tbl.childId.equals(childId))
              ..limit(1))
            .getSingleOrNull();

    if (row != null) return _ChildSignalSnapshot.fromRow(row);

    final progress =
        await (_db.select(_db.childProgressEntries)
              ..where((tbl) => tbl.childId.equals(childId))
              ..limit(1))
            .getSingleOrNull();

    return _ChildSignalSnapshot(
      accuracy7d: progress?.accuracy7d ?? 0,
      accuracyByTopic: const {},
      accuracyByType: const {},
      avgResponseSec: 0,
      weakTopics: const [],
      dueForReview: const [],
      daysSinceNewWords: 0,
      streakDays: progress?.streakDays ?? 0,
      streakAtRisk: true,
      missionCompletion7d: 0,
      preferredMissionTypes: const ['vocabulary', 'quiz'],
      preferredHour: 19,
    );
  }

  Future<Set<String>> _previousMissionTypes(String childId, String date) async {
    final previousDate = _shiftDateKey(date, -1);
    final rows = await _getMissionRows(childId: childId, date: previousDate);
    return rows.map((row) => row.template.type).toSet();
  }

  _MissionPlan _slot1Plan(_ChildSignalSnapshot signals) {
    if (signals.streakAtRisk) {
      return const _MissionPlan(
        slot: 1,
        templateId: 'mission_slot1_keep_streak',
        params: {'n': 3, 'topic': 'bất kỳ'},
      );
    }

    final topic = signals.bestTopic ?? 'bất kỳ';
    final preferredType =
        signals.preferredMissionTypes.firstOrNull ?? 'vocabulary';
    final templateId = preferredType == 'quiz'
        ? 'mission_slot1_easy_quiz'
        : 'mission_slot1_easy_success';
    return _MissionPlan(
      slot: 1,
      templateId: templateId,
      params: {'n': 5, 'topic': topic},
    );
  }

  _MissionPlan _slot2Plan(_ChildSignalSnapshot signals) {
    final topic =
        signals.weakTopics.firstOrNull ?? signals.worstTopic ?? 'Animals';
    final accuracy = signals.accuracyByTopic[topic] ?? signals.accuracy7d;

    if (accuracy < 0.5) {
      return _MissionPlan(
        slot: 2,
        templateId: 'mission_slot2_flashcard_weak',
        params: {'n': 4, 'topic': topic},
        targetValue: 4,
      );
    }
    if (accuracy < 0.65) {
      return _MissionPlan(
        slot: 2,
        templateId: 'mission_slot2_quiz_weak',
        params: {'n': 4, 'topic': topic},
        targetValue: 4,
      );
    }
    return _MissionPlan(
      slot: 2,
      templateId: 'mission_slot2_fill_blank_weak',
      params: {'n': 4, 'topic': topic},
      targetValue: 4,
    );
  }

  _MissionPlan _slot3Plan(_ChildSignalSnapshot signals) {
    if (signals.dueForReview.length >= 5) {
      return _MissionPlan(
        slot: 3,
        templateId: 'mission_slot3_review_due',
        params: {'n': signals.dueForReview.length.clamp(5, 8)},
        targetValue: signals.dueForReview.length.clamp(5, 8),
      );
    }

    if (signals.daysSinceNewWords >= 2) {
      return const _MissionPlan(
        slot: 3,
        templateId: 'mission_slot3_new_words',
        params: {'n': 4},
        targetValue: 4,
      );
    }

    return const _MissionPlan(
      slot: 3,
      templateId: 'mission_slot3_review_due',
      params: {'n': 5},
      targetValue: 5,
    );
  }

  _MissionPlan _slot4Plan(_ChildSignalSnapshot signals) {
    if (signals.accuracy7d >= 0.8) {
      return _MissionPlan(
        slot: 4,
        templateId: 'mission_slot4_hard_challenge',
        params: {'topic': signals.bestTopic ?? 'bất kỳ'},
      );
    }
    if (signals.accuracy7d >= 0.6) {
      return const _MissionPlan(
        slot: 4,
        templateId: 'mission_slot4_new_type',
        params: {'topic': 'bất kỳ'},
      );
    }
    return const _MissionPlan(
      slot: 4,
      templateId: 'mission_slot4_encourage',
      params: {'n': 3},
      targetValue: 3,
    );
  }

  _MissionPlan _rotateIfNeeded(_MissionPlan plan, Set<String> previousTypes) {
    final type = _typeForTemplateId(plan.templateId);
    if (!previousTypes.contains(type)) return plan;

    final rotatedId = switch (type) {
      'quiz' => 'mission_slot2_flashcard_weak',
      'matching' => 'mission_slot1_easy_quiz',
      'review' => 'mission_slot3_new_words',
      _ => null,
    };

    if (rotatedId == null) return plan;
    return plan.copyWith(templateId: rotatedId);
  }

  List<_MissionPlan> _capTotalDuration(List<_MissionPlan> plans) {
    final total = plans.fold<int>(
      0,
      (sum, plan) => sum + _durationFor(plan.templateId),
    );
    if (total <= 20) return plans;

    final longest = plans.reduce(
      (a, b) =>
          _durationFor(a.templateId) >= _durationFor(b.templateId) ? a : b,
    );
    return plans
        .map(
          (plan) => plan == longest
              ? plan.copyWith(
                  targetValue: ((plan.targetValue ?? 5) * 0.7).ceil().clamp(
                    1,
                    99,
                  ),
                )
              : plan,
        )
        .toList(growable: false);
  }

  Future<void> _insertMission({
    required String childId,
    required String date,
    required int slot,
    required db.MissionTemplate template,
    required Map<String, Object?> params,
    required int targetValue,
    required int xpReward,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db
        .into(_db.dailyMissions)
        .insertOnConflictUpdate(
          db.DailyMissionsCompanion.insert(
            id: '${childId}_${date}_slot_$slot',
            childId: childId,
            date: date,
            slot: Value(slot),
            missionTemplateId: template.id,
            paramsJson: Value(jsonEncode(params)),
            status: const Value('pending'),
            progressValue: const Value(0),
            targetValue: targetValue,
            xpReward: xpReward,
            createdAt: now,
            updatedAt: now,
            syncStatus: const Value('pending'),
          ),
        );
  }

  Future<void> _ensureSeedTemplates() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final templates = [
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day1_placement',
        type: 'placement',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"phase":"week_1","day":1}'),
        title: 'Làm placement test ngắn',
        description: const Value('5 câu ngắn để xác định trình độ ban đầu.'),
        targetMetric: 'placement_questions',
        targetValue: 5,
        xpReward: 40,
        durationEstMin: 5,
        sortOrder: const Value(1),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day2_animals_vocab',
        type: 'vocabulary',
        difficulty: 'easy',
        topicScope: const Value('animals'),
        conditionJson: const Value('{"phase":"week_1","day":2}'),
        title: 'Học {n} từ chủ đề {topic}',
        description: const Value('Animals là chủ đề dễ để bé bắt đầu.'),
        targetMetric: 'new_words',
        targetValue: 5,
        xpReward: 20,
        durationEstMin: 5,
        sortOrder: const Value(2),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day3_animals_quiz',
        type: 'quiz',
        difficulty: 'easy',
        topicScope: const Value('animals'),
        conditionJson: const Value('{"phase":"week_1","day":3}'),
        title: 'Quiz {n} từ {topic} vừa học',
        description: const Value('Kiểm tra nhanh từ đã học hôm trước.'),
        targetMetric: 'quiz_words',
        targetValue: 5,
        xpReward: 30,
        durationEstMin: 5,
        sortOrder: const Value(3),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day3_new_words',
        type: 'vocabulary',
        difficulty: 'easy',
        topicScope: const Value('animals'),
        conditionJson: const Value('{"phase":"week_1","day":3}'),
        title: 'Học thêm {n} từ mới',
        description: const Value('Tăng nhẹ lượng từ mới sau khi đã quen.'),
        targetMetric: 'new_words',
        targetValue: 3,
        xpReward: 15,
        durationEstMin: 3,
        sortOrder: const Value(4),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day4_matching',
        type: 'matching',
        difficulty: 'easy',
        topicScope: const Value('animals'),
        conditionJson: const Value('{"phase":"week_1","day":4}'),
        title: 'Chơi matching game chủ đề {topic}',
        description: const Value('Ghép từ và hình để củng cố ghi nhớ.'),
        targetMetric: 'matching_count',
        targetValue: 1,
        xpReward: 25,
        durationEstMin: 4,
        sortOrder: const Value(5),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day4_listen',
        type: 'listen_tap',
        difficulty: 'easy',
        topicScope: const Value('animals'),
        conditionJson: const Value('{"phase":"week_1","day":4}'),
        title: 'Nghe phát âm và chọn hình đúng',
        description: const Value('Luyện nghe phát âm từ đã học.'),
        targetMetric: 'listen_count',
        targetValue: 1,
        xpReward: 25,
        durationEstMin: 4,
        sortOrder: const Value(6),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_onboarding_day5_review',
        type: 'review',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"phase":"week_1","day":5}'),
        title: 'Ôn tập tổng hợp {topic}',
        description: const Value(
          'Tổng hợp dữ liệu tuần đầu để chuẩn bị cá nhân hóa.',
        ),
        targetMetric: 'review_count',
        targetValue: 1,
        xpReward: 50,
        durationEstMin: 8,
        sortOrder: const Value(7),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_vocab_easy_001',
        type: 'vocabulary',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value(null),
        title: 'Học {n} từ mới',
        description: const Value('Luyện từ vựng ngắn trong vài phút.'),
        targetMetric: 'new_words',
        targetValue: 5,
        xpReward: 20,
        durationEstMin: 3,
        sortOrder: const Value(0),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_quiz_easy_001',
        type: 'quiz',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value(null),
        title: 'Làm quiz hôm nay',
        description: const Value('Hoàn thành một bài quiz ngắn.'),
        targetMetric: 'quiz_count',
        targetValue: 1,
        xpReward: 30,
        durationEstMin: 5,
        sortOrder: const Value(1),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_speaking_easy_001',
        type: 'challenge',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value(null),
        title: 'Nói {n} câu',
        description: const Value('Luyện phát âm một câu đơn giản.'),
        targetMetric: 'speaking_count',
        targetValue: 1,
        xpReward: 25,
        durationEstMin: 3,
        sortOrder: const Value(2),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot1_keep_streak',
        type: 'streak',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":1,"when":"streak_at_risk"}'),
        title: 'Học {n} từ bất kỳ để giữ streak 🔥',
        description: const Value('Mission dễ nhất để bé không mất streak.'),
        targetMetric: 'new_words',
        targetValue: 3,
        xpReward: 20,
        durationEstMin: 3,
        sortOrder: const Value(10),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot1_easy_success',
        type: 'vocabulary',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":1,"intent":"easy_success"}'),
        title: 'Luyện {n} từ chủ đề {topic}',
        description: const Value('Bài dễ để tạo cảm giác thành công.'),
        targetMetric: 'practice_words',
        targetValue: 5,
        xpReward: 20,
        durationEstMin: 4,
        sortOrder: const Value(11),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot1_easy_quiz',
        type: 'quiz',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":1,"intent":"easy_success"}'),
        title: 'Quiz nhanh {n} từ chủ đề {topic}',
        description: const Value('Bài quiz ngắn dựa trên topic bé làm tốt.'),
        targetMetric: 'quiz_words',
        targetValue: 5,
        xpReward: 25,
        durationEstMin: 5,
        sortOrder: const Value(12),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot2_flashcard_weak',
        type: 'flashcard',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":2,"accuracy_lt":0.5}'),
        title: 'Học lại {n} từ chủ đề {topic}',
        description: const Value('Bài ngắn hơn để không làm bé nản.'),
        targetMetric: 'review_words',
        targetValue: 4,
        xpReward: 20,
        durationEstMin: 4,
        sortOrder: const Value(20),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot2_quiz_weak',
        type: 'quiz',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":2,"accuracy_between":[0.5,0.65]}'),
        title: 'Luyện quiz {n} từ chủ đề {topic}',
        description: const Value('Luyện thêm điểm yếu bằng quiz ngắn.'),
        targetMetric: 'quiz_words',
        targetValue: 4,
        xpReward: 25,
        durationEstMin: 5,
        sortOrder: const Value(21),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot2_fill_blank_weak',
        type: 'fill_blank',
        difficulty: 'medium',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":2,"accuracy_between":[0.65,0.75]}'),
        title: 'Điền từ còn thiếu chủ đề {topic}',
        description: const Value('Củng cố topic đã gần đạt.'),
        targetMetric: 'fill_blank_count',
        targetValue: 4,
        xpReward: 30,
        durationEstMin: 5,
        sortOrder: const Value(22),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot3_review_due',
        type: 'review',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":3,"source":"due_for_review"}'),
        title: 'Ôn lại {n} từ trước khi quên',
        description: const Value('Spaced repetition cho từ sắp quên.'),
        targetMetric: 'review_words',
        targetValue: 5,
        xpReward: 25,
        durationEstMin: 5,
        sortOrder: const Value(30),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot3_new_words',
        type: 'vocabulary',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value(
          '{"slot":3,"when":"days_since_new_words_gte_2"}',
        ),
        title: 'Học {n} từ mới hôm nay',
        description: const Value('Thêm từ mới khi bé đã lâu chưa học từ.'),
        targetMetric: 'new_words',
        targetValue: 4,
        xpReward: 20,
        durationEstMin: 4,
        sortOrder: const Value(31),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot4_hard_challenge',
        type: 'challenge',
        difficulty: 'hard',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":4,"accuracy_7d_gte":0.8}'),
        title: 'Thử thách level cao hơn: {topic}',
        description: const Value('Cho bé thử bài cao hơn một bậc.'),
        targetMetric: 'challenge_count',
        targetValue: 1,
        xpReward: 50,
        durationEstMin: 6,
        sortOrder: const Value(40),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot4_new_type',
        type: 'challenge',
        difficulty: 'medium',
        topicScope: const Value('any'),
        conditionJson: const Value(
          '{"slot":4,"accuracy_7d_between":[0.6,0.8]}',
        ),
        title: 'Thử dạng bài mới hôm nay',
        description: const Value('Đúng level hiện tại nhưng đổi dạng bài.'),
        targetMetric: 'challenge_count',
        targetValue: 1,
        xpReward: 40,
        durationEstMin: 6,
        sortOrder: const Value(41),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
      db.MissionTemplatesCompanion.insert(
        id: 'mission_slot4_encourage',
        type: 'encouragement',
        difficulty: 'easy',
        topicScope: const Value('any'),
        conditionJson: const Value('{"slot":4,"accuracy_7d_lt":0.6}'),
        title: 'Hôm nay cố thêm {n} từ nhé 💪',
        description: const Value('Mission động viên thay cho thử thách khó.'),
        targetMetric: 'practice_words',
        targetValue: 3,
        xpReward: 20,
        durationEstMin: 3,
        sortOrder: const Value(42),
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value('pending'),
      ),
    ];

    for (final template in templates) {
      await _db.into(_db.missionTemplates).insertOnConflictUpdate(template);
    }
  }

  HomeMission _toDomain(_MissionRow row) {
    final params = _decodeParams(row.daily.paramsJson);
    final title = _renderTitle(row.template.title, params);
    return HomeMission(
      id: row.daily.id,
      templateId: row.template.id,
      type: row.template.type,
      title: title,
      cta: _ctaForType(row.template.type),
      icon: _iconForType(row.template.type),
      color: _colorForType(row.template.type),
      status: row.daily.status,
      progressValue: row.daily.progressValue,
      targetValue: row.daily.targetValue,
      xpReward: row.daily.xpReward,
      durationEstMin: row.template.durationEstMin,
    );
  }

  Map<String, Object?> _defaultParamsFor(db.MissionTemplate template) {
    return {
      'n': template.targetValue,
      'topic': template.topicScope == 'any' ? 'bất kỳ' : template.topicScope,
    };
  }

  Map<String, Object?> _decodeParams(String json) {
    final decoded = jsonDecode(json);
    if (decoded is Map<String, Object?>) return decoded;
    return const {};
  }

  String _renderTitle(String title, Map<String, Object?> params) {
    var result = title;
    for (final entry in params.entries) {
      result = result.replaceAll('{${entry.key}}', '${entry.value}');
    }
    return result;
  }

  String _todayKey() {
    final now = DateTime.now();
    String two(int value) => value.toString().padLeft(2, '0');
    return '${now.year}-${two(now.month)}-${two(now.day)}';
  }

  String _shiftDateKey(String date, int days) {
    final parts = date.split('-').map(int.parse).toList(growable: false);
    final shifted = DateTime(
      parts[0],
      parts[1],
      parts[2],
    ).add(Duration(days: days));
    String two(int value) => value.toString().padLeft(2, '0');
    return '${shifted.year}-${two(shifted.month)}-${two(shifted.day)}';
  }

  String _typeForTemplateId(String templateId) {
    if (templateId.contains('quiz')) return 'quiz';
    if (templateId.contains('matching')) return 'matching';
    if (templateId.contains('review')) return 'review';
    if (templateId.contains('flashcard')) return 'flashcard';
    if (templateId.contains('fill_blank')) return 'fill_blank';
    if (templateId.contains('streak')) return 'streak';
    if (templateId.contains('challenge')) return 'challenge';
    return 'vocabulary';
  }

  int _durationFor(String templateId) {
    if (templateId.contains('hard_challenge')) return 6;
    if (templateId.contains('new_type')) return 6;
    if (templateId.contains('quiz')) return 5;
    if (templateId.contains('review')) return 5;
    if (templateId.contains('fill_blank')) return 5;
    return 4;
  }

  String _ctaForType(String type) {
    return switch (type) {
      'vocabulary' => 'Quick Practice',
      'placement' => 'Start Test',
      'quiz' => 'Daily Quiz',
      'flashcard' => 'Review Cards',
      'fill_blank' => 'Fill Blank',
      'matching' => 'Match',
      'listen_tap' => 'Listen',
      'encouragement' => 'Try Now',
      'challenge' => 'Speaking',
      'streak' => 'Keep Streak',
      'review' => 'Review',
      'speed' => 'Speed Run',
      _ => 'Start',
    };
  }

  String _iconForType(String type) {
    return switch (type) {
      'vocabulary' => '🐰',
      'placement' => '🎯',
      'quiz' => '❓',
      'flashcard' => '🃏',
      'fill_blank' => '✏️',
      'matching' => '🧩',
      'listen_tap' => '👂',
      'encouragement' => '💪',
      'challenge' => '🎙️',
      'streak' => '🔥',
      'review' => '🔁',
      'speed' => '⚡',
      _ => '⭐',
    };
  }

  Color _colorForType(String type) {
    return switch (type) {
      'vocabulary' => const Color(0xFF08A5E8),
      'placement' => const Color(0xFF6366F1),
      'quiz' => const Color(0xFF36BF14),
      'flashcard' => const Color(0xFF14B8A6),
      'fill_blank' => const Color(0xFFF97316),
      'matching' => const Color(0xFF8B5CF6),
      'listen_tap' => const Color(0xFF0EA5E9),
      'encouragement' => const Color(0xFFFF9F1C),
      'challenge' => const Color(0xFFFF4F60),
      'streak' => const Color(0xFFFF9F1C),
      'review' => const Color(0xFF7C3AED),
      'speed' => const Color(0xFFEF4444),
      _ => const Color(0xFF0EA5E9),
    };
  }
}

class _MissionRow {
  const _MissionRow({required this.daily, required this.template});

  final db.DailyMission daily;
  final db.MissionTemplate template;
}

class _MissionPlan {
  const _MissionPlan({
    required this.slot,
    required this.templateId,
    this.params,
    this.targetValue,
    this.xpReward,
  });

  final int slot;
  final String templateId;
  final Map<String, Object?>? params;
  final int? targetValue;
  final int? xpReward;

  _MissionPlan copyWith({String? templateId, int? targetValue, int? xpReward}) {
    return _MissionPlan(
      slot: slot,
      templateId: templateId ?? this.templateId,
      params: params,
      targetValue: targetValue ?? this.targetValue,
      xpReward: xpReward ?? this.xpReward,
    );
  }
}

class _ChildSignalSnapshot {
  const _ChildSignalSnapshot({
    required this.accuracy7d,
    required this.accuracyByTopic,
    required this.accuracyByType,
    required this.avgResponseSec,
    required this.weakTopics,
    required this.dueForReview,
    required this.daysSinceNewWords,
    required this.streakDays,
    required this.streakAtRisk,
    required this.missionCompletion7d,
    required this.preferredMissionTypes,
    required this.preferredHour,
  });

  factory _ChildSignalSnapshot.fromRow(db.ChildSignal row) {
    return _ChildSignalSnapshot(
      accuracy7d: row.accuracy7d,
      accuracyByTopic: _decodeDoubleMap(row.accuracyByTopic),
      accuracyByType: _decodeDoubleMap(row.accuracyByType),
      avgResponseSec: row.avgResponseSec,
      weakTopics: _decodeStringList(row.weakTopics),
      dueForReview: _decodeStringList(row.dueForReview),
      daysSinceNewWords: row.daysSinceNewWords,
      streakDays: row.streakDays,
      streakAtRisk: row.streakAtRisk,
      missionCompletion7d: row.missionCompletion7d,
      preferredMissionTypes: _decodeStringList(row.preferredMissionTypes),
      preferredHour: row.preferredHour,
    );
  }

  final double accuracy7d;
  final Map<String, double> accuracyByTopic;
  final Map<String, double> accuracyByType;
  final double avgResponseSec;
  final List<String> weakTopics;
  final List<String> dueForReview;
  final int daysSinceNewWords;
  final int streakDays;
  final bool streakAtRisk;
  final double missionCompletion7d;
  final List<String> preferredMissionTypes;
  final int preferredHour;

  String? get bestTopic {
    if (accuracyByTopic.isEmpty) return null;
    return accuracyByTopic.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  String? get worstTopic {
    if (accuracyByTopic.isEmpty) return null;
    return accuracyByTopic.entries
        .reduce((a, b) => a.value <= b.value ? a : b)
        .key;
  }

  static Map<String, double> _decodeDoubleMap(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return const {};
      return decoded.map((key, value) {
        final parsed = value is num
            ? value.toDouble()
            : double.tryParse('$value') ?? 0;
        return MapEntry('$key', parsed);
      });
    } catch (_) {
      return const {};
    }
  }

  static List<String> _decodeStringList(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded.map((value) => '$value').toList(growable: false);
    } catch (_) {
      return const [];
    }
  }
}
