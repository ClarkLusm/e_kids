import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:e_kids/features/home/domain/models/home_learning_summary.dart';
import 'package:e_kids/features/home/domain/models/home_mission.dart';
import 'package:e_kids/features/home/domain/models/skill_progress_summary.dart';
import 'package:e_kids/features/home/presentation/providers/daily_mission_providers.dart';
import 'package:e_kids/features/home/presentation/providers/learning_summary_providers.dart';
import 'package:e_kids/features/home/presentation/providers/skill_progress_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ParentDashboardScreen extends ConsumerWidget {
  const ParentDashboardScreen({super.key});

  static const _blue = Color(0xFF05A7F2);
  static const _navy = Color(0xFF063B82);
  static const _orange = Color(0xFFFF8A00);
  static const _green = Color(0xFF22C55E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final summaryAsync = ref.watch(homeLearningSummaryProvider);
    final missionsAsync = ref.watch(todayMissionsProvider);
    final skillsAsync = ref.watch(homeSkillProgressProvider);
    final childName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'Bạn nhỏ';

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        backgroundColor: _blue,
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () => context.go(Routes.home),
            icon: const Icon(Icons.child_care, color: Colors.white),
            label: const Text(
              'Về khu bé',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(homeLearningSummaryProvider);
            ref.invalidate(todayMissionsProvider);
            ref.invalidate(homeSkillProgressProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            children: [
              summaryAsync.when(
                loading: () => _HeaderCard.loading(childName),
                error: (error, _) =>
                    _ErrorCard(message: 'Không tải được tổng quan: $error'),
                data: (summary) =>
                    _HeaderCard(childName: childName, summary: summary),
              ),
              const SizedBox(height: 14),
              _QuickActions(
                onSkillGoals: () => context.push(Routes.parentSkillGoals),
                onSettings: () => context.push(Routes.settings),
              ),
              const SizedBox(height: 18),
              _SectionTitle(
                title: 'Nhiệm vụ hôm nay',
                actionLabel: 'Làm mới',
                onAction: () => ref.invalidate(todayMissionsProvider),
              ),
              const SizedBox(height: 10),
              missionsAsync.when(
                loading: () => const _LoadingCard(),
                error: (error, _) =>
                    _ErrorCard(message: 'Không tải được nhiệm vụ: $error'),
                data: (missions) => _MissionOverview(missions: missions),
              ),
              const SizedBox(height: 18),
              _SectionTitle(
                title: 'Mục tiêu phụ huynh giao',
                actionLabel: 'Thiết lập',
                onAction: () => context.push(Routes.parentSkillGoals),
              ),
              const SizedBox(height: 10),
              skillsAsync.when(
                loading: () => const _LoadingCard(),
                error: (error, _) =>
                    _ErrorCard(message: 'Không tải được mục tiêu: $error'),
                data: (skills) => _SkillGoalOverview(skills: skills),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.childName, required this.summary});

  const _HeaderCard.loading(String childName)
    : this(childName: childName, summary: HomeLearningSummary.empty);

  final String childName;
  final HomeLearningSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5E9), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [BoxShadow(color: Color(0x220EA5E9), blurRadius: 16)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tổng quan của $childName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${summary.levelTitle} • Level ${summary.currentLevel}',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: summary.levelProgress,
              color: const Color(0xFFFFD22E),
              backgroundColor: Colors.white24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${summary.levelProgressPercent}% tới level ${summary.nextLevel}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MetricPill(
                  label: 'XP',
                  value: '${summary.totalXp}',
                  icon: Icons.star,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricPill(
                  label: 'Accuracy 7d',
                  value: '${(summary.accuracy7Days * 100).round()}%',
                  icon: Icons.track_changes,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricPill(
                  label: 'Từ mastered',
                  value: '${summary.masteredWords}',
                  icon: Icons.menu_book,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onSkillGoals, required this.onSettings});

  final VoidCallback onSkillGoals;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            title: 'Giao mục tiêu',
            subtitle: 'Cá nhân hoá bài học',
            icon: Icons.flag,
            color: ParentDashboardScreen._orange,
            onTap: onSkillGoals,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            title: 'Cài đặt',
            subtitle: 'Âm thanh, hồ sơ',
            icon: Icons.settings,
            color: ParentDashboardScreen._green,
            onTap: onSettings,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withValues(alpha: 0.22), width: 2),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.14),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: ParentDashboardScreen._navy,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        TextButton(onPressed: onAction, child: Text(actionLabel)),
      ],
    );
  }
}

class _MissionOverview extends StatelessWidget {
  const _MissionOverview({required this.missions});

  final List<HomeMission> missions;

  @override
  Widget build(BuildContext context) {
    if (missions.isEmpty) {
      return const _EmptyCard(message: 'Chưa có nhiệm vụ hôm nay.');
    }

    return Column(
      children: [
        for (final mission in missions) ...[
          _MissionRow(mission: mission),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _MissionRow extends StatelessWidget {
  const _MissionRow({required this.mission});

  final HomeMission mission;

  @override
  Widget build(BuildContext context) {
    final progress = mission.targetValue <= 0
        ? 0.0
        : (mission.progressValue / mission.targetValue).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Text(mission.icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: progress,
                    color: mission.color,
                    backgroundColor: mission.color.withValues(alpha: 0.13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '+${mission.xpReward} XP',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _SkillGoalOverview extends StatelessWidget {
  const _SkillGoalOverview({required this.skills});

  final List<SkillProgressSummary> skills;

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return const _EmptyCard(
        message:
            'Chưa có mục tiêu do phụ huynh giao. Bé vẫn học theo lộ trình chính.',
      );
    }

    return Column(
      children: [
        for (final skill in skills.take(4)) ...[
          _SkillRow(skill: skill),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({required this.skill});

  final SkillProgressSummary skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: skill.color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Text(skill.icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.label,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: skill.progress,
                    color: skill.color,
                    backgroundColor: skill.color.withValues(alpha: 0.12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${skill.progressPercent.round()}%',
            style: TextStyle(color: skill.color, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 96,
      child: Card(child: Center(child: CircularProgressIndicator())),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(message, style: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF1F2),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(message, style: const TextStyle(color: Color(0xFFBE123C))),
      ),
    );
  }
}
