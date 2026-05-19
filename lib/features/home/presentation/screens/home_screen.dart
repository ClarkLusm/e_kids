import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:e_kids/features/home/domain/models/home_learning_summary.dart';
import 'package:e_kids/features/home/domain/models/home_mission.dart';
import 'package:e_kids/features/home/domain/models/path_topic_summary.dart';
import 'package:e_kids/features/home/domain/models/skill_progress_summary.dart';
import 'package:e_kids/features/home/presentation/providers/daily_mission_providers.dart';
import 'package:e_kids/features/home/presentation/providers/learning_summary_providers.dart';
import 'package:e_kids/features/home/presentation/providers/path_topic_providers.dart';
import 'package:e_kids/features/home/presentation/providers/skill_progress_providers.dart';
import 'package:e_kids/features/lesson/domain/models/lesson_models.dart';
import 'package:e_kids/features/lesson/presentation/providers/lesson_providers.dart';
import 'package:e_kids/features/lesson/presentation/screens/topic_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _skyTop = Color(0xFF16B4FF);
  static const _skyBottom = Color(0xFF86E7FF);
  static const _navy = Color(0xFF063B82);
  static const _yellow = Color(0xFFFFD22E);
  static const _orange = Color(0xFFFF7A18);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final childName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'Bạn';
    final avatar = _avatarEmoji(user?.avatarId);
    final summary =
        ref.watch(homeLearningSummaryProvider).valueOrNull ??
        HomeLearningSummary.empty;
    final topicsAsync = ref.watch(topicListProvider);
    final missionsAsync = ref.watch(todayMissionsProvider);
    final skillProgressAsync = ref.watch(homeSkillProgressProvider);
    final pathTopicsAsync = ref.watch(homePathTopicSummariesProvider);

    return Scaffold(
      backgroundColor: _skyTop,
      body: Stack(
        children: [
          const _HomeBackdrop(),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 112, 18, 120),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      _HeroLevelPanel(summary: summary),
                      const SizedBox(height: 16),
                      _QuickActions(
                        missionsAsync: missionsAsync,
                        onMissionTap: (mission) {
                          final route = mission.isCompleted
                              ? Routes.missionResult
                              : Routes.missionBrief;
                          context.push(route, extra: mission);
                        },
                      ),
                      const SizedBox(height: 14),
                      _LearningProgressCard(skillsAsync: skillProgressAsync),
                      const SizedBox(height: 14),
                      _TodayLessonCard(
                        topicsAsync: topicsAsync,
                        onOpenTopic: (topic) => _openTopic(context, topic),
                        topicEmoji: _topicEmoji,
                      ),
                      const SizedBox(height: 18),
                      _PathTopicProgressSection(
                        summariesAsync: pathTopicsAsync,
                        onOpenTopic: (topic) => _openTopic(context, topic),
                        topicEmoji: _topicEmoji,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            bottom: false,
            child: _StickyHeaderBar(
              childName: childName,
              avatar: avatar,
              totalXp: summary.totalXp,
              coins: summary.completedLessons * 50,
            ),
          ),
        ],
      ),
    );
  }

  void _openTopic(BuildContext context, Topic topic) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => TopicScreen(topic: topic)));
  }

  String _avatarEmoji(String? avatarId) {
    return switch (avatarId) {
      'lion' => '🦁',
      'rabbit' => '🐰',
      'cat' => '🐱',
      'panda' => '🐼',
      'fox' => '🦊',
      'bear' => '🐻',
      _ => '🐶',
    };
  }

  static String _topicEmoji(Topic topic) {
    final key = '${topic.id} ${topic.nameEn} ${topic.nameVi}'.toLowerCase();
    if (key.contains('animal') || key.contains('động vật')) return '🐾';
    if (key.contains('food') || key.contains('thức ăn')) return '🍎';
    if (key.contains('color') || key.contains('màu')) return '🎨';
    if (key.contains('number') || key.contains('số')) return '🔢';
    if (key.contains('body') || key.contains('cơ thể')) return '🧍';
    if (key.contains('home') || key.contains('house') || key.contains('nhà')) {
      return '🏠';
    }
    if (key.contains('family') || key.contains('gia đình')) return '👨‍👩‍👧';
    if (key.contains('vehicle') || key.contains('xe')) return '🚗';
    return '⭐';
  }
}

class _HomeBackdrop extends StatelessWidget {
  const _HomeBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HomeScreen._skyTop,
                HomeScreen._skyBottom,
                Color(0xFFFFD34F),
                Color(0xFFFF8A1C),
              ],
              stops: [0, 0.42, 0.62, 1],
            ),
          ),
        ),
        const Positioned(
          left: -30,
          top: 110,
          child: _Cloud(width: 140, height: 56),
        ),
        const Positioned(
          right: -36,
          top: 96,
          child: _Cloud(width: 160, height: 62),
        ),
        Positioned(
          left: -60,
          right: -60,
          top: 240,
          child: Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43D966), Color(0xFF16A34A)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(120)),
            ),
          ),
        ),
        Positioned(
          left: -40,
          right: -40,
          top: 310,
          child: Container(
            height: 260,
            decoration: const BoxDecoration(
              color: Color(0xFFFCD93B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(90)),
            ),
          ),
        ),
      ],
    );
  }
}

class _Cloud extends StatelessWidget {
  const _Cloud({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _StickyHeaderBar extends StatelessWidget {
  const _StickyHeaderBar({
    required this.childName,
    required this.avatar,
    required this.totalXp,
    required this.coins,
  });

  final String childName;
  final String avatar;
  final int totalXp;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HomeScreen._skyTop,
            HomeScreen._skyTop.withValues(alpha: 0.94),
            HomeScreen._skyTop.withValues(alpha: 0.1),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22003477),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: _HeaderBar(
        childName: childName,
        avatar: avatar,
        totalXp: totalXp,
        coins: coins,
        onAvatarTap: () => context.go(Routes.profile),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({
    required this.childName,
    required this.avatar,
    required this.totalXp,
    required this.coins,
    required this.onAvatarTap,
  });

  final String childName;
  final String avatar;
  final int totalXp;
  final int coins;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onAvatarTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFB12A),
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x5500367A),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(avatar, style: const TextStyle(fontSize: 42)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Hi, $childName!',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Color(0xAA004A96),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        _CurrencyPill(icon: '⭐', value: totalXp),
        const SizedBox(width: 6),
        _CurrencyPill(icon: '🪙', value: coins),
      ],
    );
  }
}

class _CurrencyPill extends StatelessWidget {
  const _CurrencyPill({required this.icon, required this.value});

  final String icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0C69D8), Color(0xFF054BA8)],
        ),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x55003477), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 19)),
          const SizedBox(width: 3),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroLevelPanel extends StatelessWidget {
  const _HeroLevelPanel({required this.summary});

  final HomeLearningSummary summary;

  @override
  Widget build(BuildContext context) {
    final progress = summary.levelProgress == 0 ? 0.05 : summary.levelProgress;

    return SizedBox(
      height: 285,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Positioned(left: 2, bottom: 12, child: _MascotBear()),
          Positioned(
            top: 4,
            child: Container(
              width: 238,
              height: 238,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66003477),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 238,
                    height: 238,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 18,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Colors.white,
                      color: HomeScreen._yellow,
                    ),
                  ),
                  Container(
                    width: 198,
                    height: 198,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0xFF0F79F2), Color(0xFF0646A8)],
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Level',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 0.9,
                          ),
                        ),
                        Text(
                          '${summary.level}',
                          style: const TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        Text(
                          '${summary.levelProgressPercent}% Complete',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(right: 8, top: 40, child: _Confetti()),
        ],
      ),
    );
  }
}

class _MascotBear extends StatelessWidget {
  const _MascotBear();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('🐻', style: TextStyle(fontSize: 94)),
        Text(
          'Let’s go!',
          style: TextStyle(
            color: Color(0xFF81420B),
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _Confetti extends StatelessWidget {
  const _Confetti();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 86,
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          Text('🟨'),
          Text('🟦'),
          Text('🟥'),
          Text('⭐'),
          Text('🟩'),
          Text('🟧'),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.missionsAsync,
    required this.onMissionTap,
  });

  final AsyncValue<List<HomeMission>> missionsAsync;
  final ValueChanged<HomeMission> onMissionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4B8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: missionsAsync.when(
        loading: () => const SizedBox(
          height: 132,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => SizedBox(
          height: 132,
          child: Center(
            child: Text(
              'Không tải được nhiệm vụ',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        data: (missions) {
          if (missions.isEmpty) {
            return const SizedBox(
              height: 132,
              child: Center(
                child: Text(
                  'Chưa có nhiệm vụ hôm nay',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            );
          }

          final useHorizontalScroll = missions.length > 3;
          final cardWidth = useHorizontalScroll
              ? 132.0
              : (MediaQuery.sizeOf(context).width - 36 - 20 - 16) /
                    missions.length;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                for (var i = 0; i < missions.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  SizedBox(
                    width: cardWidth,
                    child: _QuickActionCard(
                      mission: missions[i],
                      onTap: () => onMissionTap(missions[i]),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.mission, required this.onTap});

  final HomeMission mission;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = mission.targetValue == 0
        ? 0.0
        : (mission.progressValue / mission.targetValue).clamp(0.0, 1.0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 132,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: mission.isCompleted
                ? [const Color(0xFF16A34A), const Color(0xFF15803D)]
                : [mission.color.withValues(alpha: 0.86), mission.color],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 8)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  mission.isCompleted ? '✅' : mission.icon,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _compactTitle(mission.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      height: 1,
                      shadows: [
                        Shadow(
                          color: Color(0x66000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: mission.isCompleted ? 1 : progress,
                minHeight: 7,
                color: Colors.white,
                backgroundColor: Colors.black.withValues(alpha: 0.18),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: mission.isCompleted
                    ? const Color(0xFFE7FBEA)
                    : Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                mission.isCompleted ? 'Hoàn thành' : 'Chưa làm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mission.isCompleted
                      ? const Color(0xFF15803D)
                      : const Color(0xFFF97316),
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _compactTitle(String title) {
    final words = title.split(' ');
    if (words.length <= 2) return title;
    final midpoint = (words.length / 2).ceil();
    return '${words.take(midpoint).join(' ')}\n${words.skip(midpoint).join(' ')}';
  }
}

class _LearningProgressCard extends StatelessWidget {
  const _LearningProgressCard({required this.skillsAsync});

  final AsyncValue<List<SkillProgressSummary>> skillsAsync;

  @override
  Widget build(BuildContext context) {
    final loadedSkills = skillsAsync.valueOrNull;
    if (loadedSkills != null && loadedSkills.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9D6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 10)],
      ),
      child: Column(
        children: [
          const Text(
            'Tiến Trình Học',
            style: TextStyle(
              color: HomeScreen._navy,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 10),
          skillsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: CircularProgressIndicator(),
            ),
            error: (error, _) => Text(
              'Không tải được tiến trình học',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w900,
              ),
            ),
            data: (skills) => Column(
              children: [
                for (var i = 0; i < skills.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _ProgressTrack(skill: skills[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressTrack extends StatelessWidget {
  const _ProgressTrack({required this.skill});

  final SkillProgressSummary skill;

  @override
  Widget build(BuildContext context) {
    final percent = skill.progressPercent.round();
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [skill.color, skill.color.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Text(skill.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          SizedBox(
            width: 95,
            child: Text(
              skill.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: skill.progress,
                minHeight: 16,
                color: HomeScreen._yellow,
                backgroundColor: Colors.black.withValues(alpha: 0.18),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percent%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayLessonCard extends StatelessWidget {
  const _TodayLessonCard({
    required this.topicsAsync,
    required this.onOpenTopic,
    required this.topicEmoji,
  });

  final AsyncValue<List<Topic>> topicsAsync;
  final ValueChanged<Topic> onOpenTopic;
  final String Function(Topic topic) topicEmoji;

  @override
  Widget build(BuildContext context) {
    final topic = topicsAsync.valueOrNull?.firstOrNull;
    final title = topic?.nameEn ?? 'Animals';
    final emoji = topic == null ? '🐾' : topicEmoji(topic);

    return Container(
      height: 116,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE9FFE5), Color(0xFFBFF5FF)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 5),
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 62)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bài học hôm nay:',
                  style: TextStyle(
                    color: HomeScreen._navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: HomeScreen._navy,
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: topic == null ? null : () => onOpenTopic(topic),
            style: ElevatedButton.styleFrom(
              backgroundColor: HomeScreen._yellow,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              side: const BorderSide(color: HomeScreen._orange, width: 3),
            ),
            child: const Text(
              'Mở',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _PathTopicProgressSection extends StatelessWidget {
  const _PathTopicProgressSection({
    required this.summariesAsync,
    required this.onOpenTopic,
    required this.topicEmoji,
  });

  final AsyncValue<List<PathTopicSummary>> summariesAsync;
  final ValueChanged<Topic> onOpenTopic;
  final String Function(Topic topic) topicEmoji;

  @override
  Widget build(BuildContext context) {
    return summariesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(
        'Không tải được lộ trình: $error',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      data: (summaries) {
        if (summaries.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: summaries.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final summary = summaries[index];
              final topic = summary.topic;
              return InkWell(
                onTap: () => onOpenTopic(topic),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 156,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: topic.color.withValues(alpha: 0.55),
                      width: 4,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0x22000000), blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            topicEmoji(topic),
                            style: const TextStyle(fontSize: 30),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              topic.nameVi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: HomeScreen._navy,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: summary.progress,
                          minHeight: 10,
                          color: HomeScreen._yellow,
                          backgroundColor: topic.color.withValues(alpha: 0.35),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${summary.completedLessons}/${summary.totalLessons} bài học',
                        style: const TextStyle(
                          color: HomeScreen._navy,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tối đa ${summary.totalXpReward} XP',
                        style: const TextStyle(
                          color: Color(0xFF0F766E),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
