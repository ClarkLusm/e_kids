import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/lesson_models.dart';
import '../providers/lesson_providers.dart';
import '../widgets/lesson_card.dart';
import 'lesson_detail_screen.dart';

/// Màn hình danh sách bài học theo chủ đề.
class TopicScreen extends ConsumerWidget {
  final Topic topic;

  const TopicScreen({required this.topic, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(lessonsByTopicProvider(topic.id));
    final progressAsync = ref.watch(lessonProgressMapProvider(topic.id));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar với màu topic
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: topic.color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                topic.nameVi,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [topic.color, topic.color.withOpacity(0.6)],
                  ),
                ),
                child: Center(
                  child: Text(
                    topic.nameEn,
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Colors.black.withOpacity(0.06),
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Stats bar
          SliverToBoxAdapter(
            child: lessonsAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (lessons) {
                final progressMap = progressAsync.value ?? {};
                final doneCount = lessons
                    .where((l) => progressMap[l.id]?.isDone ?? false)
                    .length;
                return _TopicStatsBar(
                  totalLessons: lessons.length,
                  doneLessons: doneCount,
                  color: topic.color,
                );
              },
            ),
          ),

          // Lesson list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            sliver: lessonsAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF534AB7)),
                ),
              ),
              error: (e, _) =>
                  SliverFillRemaining(child: Center(child: Text('Lỗi: $e'))),
              data: (lessons) {
                if (lessons.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Chưa có bài học nào.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                final progressMap = progressAsync.value ?? {};

                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, i) {
                    final lesson = lessons[i];
                    final progress = progressMap[lesson.id];
                    return LessonCard(
                      lesson: lesson,
                      progress: progress,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LessonDetailScreen(
                            lessonId: lesson.id,
                            topicId: topic.id,
                          ),
                        ),
                      ),
                    );
                  }, childCount: lessons.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats bar ────────────────────────────────────────────────────────────

class _TopicStatsBar extends StatelessWidget {
  final int totalLessons;
  final int doneLessons;
  final Color color;

  const _TopicStatsBar({
    required this.totalLessons,
    required this.doneLessons,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final pct = totalLessons == 0 ? 0.0 : doneLessons / totalLessons;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$doneLessons / $totalLessons bài hoàn thành',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color.computeLuminance() > 0.5
                      ? const Color(0xFF1A1A2E)
                      : const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                '${(pct * 100).round()}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF534AB7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 7,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                pct == 1.0 ? const Color(0xFF1D9E75) : const Color(0xFF534AB7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
