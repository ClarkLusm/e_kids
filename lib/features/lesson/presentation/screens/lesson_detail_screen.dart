import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/lesson_models.dart';
import '../../domain/usecases/lesson_usecases.dart';
import '../providers/lesson_providers.dart';
import '../widgets/quiz_list_widget.dart';
import 'vocabulary_intro_screen.dart';
import 'quiz_runner_screen.dart';

class LessonDetailWithStartButton extends ConsumerWidget {
  final String lessonId;
  final String? topicId;

  const LessonDetailWithStartButton({
    required this.lessonId,
    this.topicId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(lessonDetailProvider(lessonId));
    final progress = topicId != null
        ? ref.watch(lessonProgressMapProvider(topicId!)).value![lessonId]
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF534AB7)),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lỗi: $e'),
              TextButton(
                onPressed: () => ref.invalidate(lessonDetailProvider(lessonId)),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (detail) => _LessonBody(
          detail: detail,
          progress: progress,
          onLearnVocab: () => _goVocabIntro(context),
          onStartQuiz: () => _goQuiz(context),
        ),
      ),
    );
  }

  void _goVocabIntro(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VocabularyIntroScreen(
          lessonId: lessonId,
          onStartQuiz: () {
            Navigator.of(context).pop();
            _goQuiz(context);
          },
        ),
      ),
    );
  }

  void _goQuiz(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => QuizRunnerScreen(lessonId: lessonId)),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────

class _LessonBody extends StatelessWidget {
  final LessonDetail detail;
  final LessonProgress? progress;
  final VoidCallback onLearnVocab;
  final VoidCallback onStartQuiz;

  const _LessonBody({
    required this.detail,
    this.progress,
    required this.onLearnVocab,
    required this.onStartQuiz,
  });

  bool get _isDone => progress?.isDone ?? false;

  @override
  Widget build(BuildContext context) {
    final lesson = detail.lesson;
    final vocab = detail.vocabulary;
    final questions = detail.questions;

    return CustomScrollView(
      slivers: [
        // App bar với hero gradient
        SliverAppBar(
          expandedHeight: 190,
          pinned: true,
          backgroundColor: const Color(0xFF534AB7),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              lesson.titleVi,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF534AB7), Color(0xFF3C3489)],
                ),
              ),
              child: lesson.thumbnailUrl != null
                  ? Image.asset(
                      lesson.thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    )
                  : null,
            ),
          ),
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Meta pills
              _MetaRow(lesson: lesson, progress: progress),
              const SizedBox(height: 14),

              // Description
              if (lesson.descriptionVi != null) ...[
                Text(
                  lesson.descriptionVi!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 18),
              ],

              // Kết quả cũ
              if (_isDone && progress != null) ...[
                _PrevResult(progress: progress!),
                const SizedBox(height: 18),
              ],

              // Vocab preview
              if (vocab.isNotEmpty) ...[
                _SectionTitle(
                  icon: Icons.book_outlined,
                  title: 'Từ vựng (${vocab.length} từ)',
                  actionLabel: 'Xem tất cả',
                  onAction: onLearnVocab,
                ),
                const SizedBox(height: 10),
                _VocabChips(vocab: vocab),
                const SizedBox(height: 20),
              ],

              // Quiz list
              QuizListWidget(questions: questions, currentIndex: 0),
            ]),
          ),
        ),
      ],
    );
  }
}

// ─── Bottom bar ───────────────────────────────────────────────────────────

// Để dùng, wrap LessonDetailWithStartButton với Scaffold và bottomNavigationBar
// Hoặc dùng trực tiếp FloatingActionButton. Ta dùng BottomAppBar:
class LessonDetailScreen extends ConsumerWidget {
  final String lessonId;
  final String? topicId;

  const LessonDetailScreen({required this.lessonId, this.topicId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(lessonDetailProvider(lessonId));
    final progress = topicId != null
        ? ref.watch(lessonProgressMapProvider(topicId!)).value![lessonId]
        : null;
    final isDone = progress?.isDone ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: LessonDetailWithStartButton(lessonId: lessonId, topicId: topicId),
      bottomNavigationBar: detailAsync.maybeWhen(
        data: (detail) => _BottomBar(
          lesson: detail.lesson,
          progress: progress,
          isDone: isDone,
          onLearnVocab: () => _goVocabIntro(context),
          onStartQuiz: () => _goQuiz(context),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  void _goVocabIntro(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VocabularyIntroScreen(
          lessonId: lessonId,
          onStartQuiz: () {
            Navigator.of(context).pop();
            _goQuiz(context);
          },
        ),
      ),
    );
  }

  void _goQuiz(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => QuizRunnerScreen(lessonId: lessonId)),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress? progress;
  final bool isDone;
  final VoidCallback onLearnVocab;
  final VoidCallback onStartQuiz;

  const _BottomBar({
    required this.lesson,
    required this.progress,
    required this.isDone,
    required this.onLearnVocab,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: onLearnVocab,
            icon: const Icon(Icons.book_outlined, size: 16),
            label: const Text('Học từ'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              side: const BorderSide(color: Color(0xFF534AB7)),
              foregroundColor: const Color(0xFF534AB7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: onStartQuiz,
              icon: Icon(
                isDone ? Icons.replay_rounded : Icons.play_arrow_rounded,
                size: 18,
              ),
              label: Text(
                isDone ? 'Làm lại (+${lesson.xpReward} XP)' : 'Bắt đầu học!',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                backgroundColor: const Color(0xFF534AB7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Supporting widgets ───────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress? progress;
  const _MetaRow({required this.lesson, this.progress});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Pill(
          Icons.book_outlined,
          '${lesson.vocabularyCount} từ',
          const Color(0xFF534AB7),
        ),
        _Pill(
          Icons.quiz_outlined,
          '${lesson.questionCount} bài tập',
          const Color(0xFF1D9E75),
        ),
        _Pill(
          Icons.bolt_rounded,
          '+${lesson.xpReward} XP',
          const Color(0xFFEF9F27),
        ),
        _Pill(
          Icons.signal_cellular_alt_rounded,
          'Cấp ${lesson.level}',
          Colors.grey.shade600,
        ),
        if (progress != null && progress!.attempts > 0)
          _Pill(
            Icons.replay_rounded,
            '${progress!.attempts} lần thử',
            Colors.grey.shade600,
          ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Pill(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrevResult extends StatelessWidget {
  final LessonProgress progress;
  const _PrevResult({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAEEDA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEF9F27).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Text('🏆 ', style: TextStyle(fontSize: 22)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kết quả tốt nhất',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF633806),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    ...List.generate(
                      3,
                      (i) => Icon(
                        i < progress.stars
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: i < progress.stars
                            ? const Color(0xFFEF9F27)
                            : Colors.grey.shade300,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${progress.bestScore}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF412402),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '+${progress.totalXpEarned} XP',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF534AB7),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF534AB7)),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const Spacer(),
        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF534AB7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class _VocabChips extends StatelessWidget {
  final List<Vocabulary> vocab;
  const _VocabChips({required this.vocab});

  @override
  Widget build(BuildContext context) {
    final preview = vocab.take(6).toList();
    final rem = vocab.length - preview.length;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...preview.map(
          (v) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: v.isKeyWord ? const Color(0xFFEEEDFE) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: v.isKeyWord
                    ? const Color(0xFF534AB7).withOpacity(0.4)
                    : Colors.grey.shade200,
              ),
            ),
            child: Text(
              v.word,
              style: TextStyle(
                fontSize: 12,
                fontWeight: v.isKeyWord ? FontWeight.w700 : FontWeight.normal,
                color: v.isKeyWord
                    ? const Color(0xFF3C3489)
                    : Colors.grey.shade700,
              ),
            ),
          ),
        ),
        if (rem > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+$rem từ nữa',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
      ],
    );
  }
}
