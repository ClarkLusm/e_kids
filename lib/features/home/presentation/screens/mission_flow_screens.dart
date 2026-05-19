import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/home/domain/models/home_mission.dart';
import 'package:e_kids/features/home/domain/models/mission_content.dart';
import 'package:e_kids/features/home/presentation/providers/daily_mission_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MissionBriefScreen extends ConsumerWidget {
  const MissionBriefScreen({required this.mission, super.key});

  final HomeMission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderHour = ref.watch(preferredMissionReminderHourProvider);
    final contentAsync = ref.watch(missionContentProvider(mission));
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8FF),
      appBar: AppBar(
        title: const Text('Nhiệm vụ hôm nay'),
        backgroundColor: mission.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _MissionHeroCard(mission: mission),
            const SizedBox(height: 18),
            const Text(
              '📋 Bạn sẽ làm gì?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            contentAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(),
              ),
              error: (error, _) => Text(
                'Không tải được nội dung mission: $error',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
              data: (content) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in content.summaryLines)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '• $line',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  if (!content.hasAuthoredContent)
                    const Text(
                      '• Nội dung chi tiết chưa có trong DB, app dùng flow tạm để hoàn thành mission.',
                      style: TextStyle(color: Colors.black54, height: 1.35),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _RewardRow(
              durationEstMin: mission.durationEstMin,
              xpReward: mission.xpReward,
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: () {
                final content = contentAsync.valueOrNull;
                final needsWarmUp =
                    content?.hasWarmUpWords == true || mission.needsWarmUp;
                final nextRoute = needsWarmUp
                    ? Routes.missionWarmUp
                    : Routes.missionActivity;
                context.push(nextRoute, extra: mission);
              },
              style: FilledButton.styleFrom(
                backgroundColor: mission.color,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Bắt đầu! 🚀',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () =>
                  _showLaterDialog(context, reminderHour.valueOrNull ?? 19),
              child: const Text(
                'Để sau',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLaterDialog(BuildContext context, int reminderHour) async {
    final parentContext = context;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Nhớ quay lại nhé! 🔔'),
        content: Text('Mình sẽ nhắc bạn lúc ${reminderHour}h.'),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              parentContext.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class MissionWarmUpScreen extends ConsumerWidget {
  const MissionWarmUpScreen({required this.mission, super.key});

  final HomeMission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(missionContentProvider(mission));
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7D6),
      appBar: AppBar(
        title: const Text('Warm-up'),
        backgroundColor: mission.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Nhìn nhanh trước khi làm bài nhé! 👀',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            contentAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const _WarmUpFallback(),
              data: (content) {
                if (content.warmUpWords.isEmpty) {
                  return const _WarmUpFallback();
                }
                return Column(
                  children: [
                    for (final word in content.warmUpWords) ...[
                      _WarmUpWordCard(word: word, color: mission.color),
                      const SizedBox(height: 12),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () =>
                  context.push(Routes.missionActivity, extra: mission),
              style: FilledButton.styleFrom(
                backgroundColor: mission.color,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Tôi đã nhớ, vào làm thôi!',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MissionActivityScreen extends ConsumerWidget {
  const MissionActivityScreen({required this.mission, super.key});

  final HomeMission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(missionActionProvider);
    final contentAsync = ref.watch(missionContentProvider(mission));
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        title: Text(mission.title),
        backgroundColor: mission.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: contentAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) =>
                      _ActivityPlaceholder(mission: mission, content: null),
                  data: (content) =>
                      _ActivityPlaceholder(mission: mission, content: content),
                ),
              ),
              FilledButton(
                onPressed: actionState.isLoading
                    ? null
                    : () async {
                        await ref
                            .read(missionActionProvider.notifier)
                            .completeMission(mission.id);
                        if (!context.mounted) return;
                        context.pushReplacement(
                          Routes.missionResult,
                          extra: mission,
                        );
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: mission.color,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: actionState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Hoàn thành nhiệm vụ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionResultScreen extends StatelessWidget {
  const MissionResultScreen({required this.mission, super.key});

  final HomeMission mission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7D6),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('✅', style: TextStyle(fontSize: 82)),
                const SizedBox(height: 12),
                const Text(
                  'Hoàn thành nhiệm vụ!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Text(
                  '+${mission.xpReward} XP',
                  style: TextStyle(
                    color: mission.color,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: () => context.go(Routes.home),
                  style: FilledButton.styleFrom(
                    backgroundColor: mission.color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Về Home',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MissionHeroCard extends StatelessWidget {
  const _MissionHeroCard({required this.mission});

  final HomeMission mission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: mission.color.withValues(alpha: 0.22),
          width: 2,
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Row(
        children: [
          Text(mission.icon, style: const TextStyle(fontSize: 54)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _flavorText(mission),
                  style: const TextStyle(color: Colors.black54, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _flavorText(HomeMission mission) {
    if (mission.topicLabel.toLowerCase().contains('animal')) {
      return 'Khám phá thế giới động vật hoang dã!';
    }
    return 'Một nhiệm vụ ngắn để bé tiến bộ hôm nay!';
  }
}

class _RewardRow extends StatelessWidget {
  const _RewardRow({required this.durationEstMin, required this.xpReward});

  final int durationEstMin;
  final int xpReward;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoPill(icon: '⏱', label: 'Khoảng $durationEstMin phút'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _InfoPill(icon: '⭐', label: 'Nhận $xpReward XP'),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        '$icon $label',
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _WarmUpWordCard extends StatelessWidget {
  const _WarmUpWordCard({required this.word, required this.color});

  final MissionVocabularyItem word;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.18), width: 2),
      ),
      child: Row(
        children: [
          Text(word.displayEmoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  word.phonetic ?? '',
                  style: const TextStyle(color: Colors.black54),
                ),
                Text(
                  word.translationVi,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WarmUpFallback extends StatelessWidget {
  const _WarmUpFallback();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _FallbackWordCard('🦁', 'LION', '/ˈlaɪən/', 'Con sư tử'),
        SizedBox(height: 12),
        _FallbackWordCard('🐘', 'ELEPHANT', '/ˈelɪfənt/', 'Con voi'),
        SizedBox(height: 12),
        _FallbackWordCard('🐵', 'MONKEY', '/ˈmʌŋki/', 'Con khỉ'),
      ],
    );
  }
}

class _FallbackWordCard extends StatelessWidget {
  const _FallbackWordCard(this.emoji, this.word, this.phonetic, this.meaning);

  final String emoji;
  final String word;
  final String phonetic;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(phonetic, style: const TextStyle(color: Colors.black54)),
                Text(
                  meaning,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityPlaceholder extends StatelessWidget {
  const _ActivityPlaceholder({required this.mission, required this.content});

  final HomeMission mission;
  final MissionContent? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: mission.color.withValues(alpha: 0.18),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mission.icon, style: const TextStyle(fontSize: 86)),
          const SizedBox(height: 16),
          Text(
            mission.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Text(
            _activityDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, height: 1.4),
          ),
          if (content != null && content!.quizQuestions.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Đã resolve ${content!.quizQuestions.length} câu từ quiz_questions.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
          if (content != null && content!.warmUpWords.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Đã resolve ${content!.warmUpWords.length} từ từ vocabulary_items.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ],
      ),
    );
  }

  String get _activityDescription {
    final resolved = content;
    if (resolved == null || !resolved.hasAuthoredContent) {
      return 'Chưa có nội dung phù hợp trong DB, app dùng activity tạm để hoàn thành mission.';
    }
    return 'MissionContentResolver đã lấy nội dung từ DB. Bước sau sẽ render quiz/flashcard thật theo activityType = ${resolved.activityType}.';
  }
}
