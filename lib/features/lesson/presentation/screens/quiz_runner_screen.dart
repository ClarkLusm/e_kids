import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../quiz/_shared/quiz_orchestrator.dart';
import '../../../quiz/_shared/question_ref.dart';
import '../providers/lesson_providers.dart';
import '../widgets/quiz_list_widget.dart';

/// Màn hình điều phối chạy quiz lần lượt trong 1 lesson.
/// Gọi QuizOrchestrator cho từng câu hỏi theo thứ tự.
class QuizRunnerScreen extends ConsumerStatefulWidget {
  final String lessonId;

  const QuizRunnerScreen({required this.lessonId, super.key});

  @override
  ConsumerState<QuizRunnerScreen> createState() =>
      _QuizRunnerScreenState();
}

class _QuizRunnerScreenState extends ConsumerState<QuizRunnerScreen> {
  late List<QuestionRef> _questions;
  bool _questionsLoaded = false;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(lessonDetailProvider(widget.lessonId));

    return detailAsync.when(
      loading: () => const Scaffold(
        backgroundColor: Color(0xFFF8F7FF),
        body: Center(
            child:
                CircularProgressIndicator(color: Color(0xFF534AB7))),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Lỗi: $e')),
      ),
      data: (detail) {
        if (!_questionsLoaded) {
          _questions = detail.questions;
          _questionsLoaded = true;
        }

        if (_questions.isEmpty) {
          return _NoQuestionsView(
              onBack: () => Navigator.of(context).pop());
        }

        return _RunnerContent(
          lessonId: widget.lessonId,
          lessonTitle: detail.lesson.titleVi,
          questions: _questions,
        );
      },
    );
  }
}

// ─── Runner content ───────────────────────────────────────────────────────

class _RunnerContent extends ConsumerStatefulWidget {
  final String lessonId;
  final String lessonTitle;
  final List<QuestionRef> questions;

  const _RunnerContent({
    required this.lessonId,
    required this.lessonTitle,
    required this.questions,
  });

  @override
  ConsumerState<_RunnerContent> createState() =>
      _RunnerContentState();
}

class _RunnerContentState extends ConsumerState<_RunnerContent> {
  int _currentIndex = 0;
  int _totalEarnedXp = 0;
  bool _showComplete = false;

  QuestionRef get _currentQ => widget.questions[_currentIndex];
  int get _total => widget.questions.length;
  bool get _isLast => _currentIndex == _total - 1;

  void _onQuizNext({int earnedXp = 0}) {
    setState(() => _totalEarnedXp += earnedXp);

    if (_isLast) {
      _finishLesson();
    } else {
      setState(() => _currentIndex++);
    }
  }

  void _finishLesson() {
    // Cập nhật progress
    ref.read(quizRunnerProvider(widget.questions).notifier)
        .onQuizCompleted(
          questionId: _currentQ.id,
          xpEarned: _totalEarnedXp,
        );

    setState(() => _showComplete = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_showComplete) {
      return _LessonCompleteScreen(
        lessonTitle: widget.lessonTitle,
        totalXp: _totalEarnedXp,
        questionCount: _total,
        onBack: () => Navigator.of(context)
          ..pop()
          ..pop(),
        onReplay: () {
          setState(() {
            _currentIndex = 0;
            _totalEarnedXp = 0;
            _showComplete = false;
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: Column(
        children: [
          // Progress header
          SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(children: [
                // Close + progress bar
                Row(children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.grey),
                    onPressed: () => _showExitDialog(context),
                  ),
                  Expanded(
                    child: QuizRunnerProgressBar(
                      current: _currentIndex,
                      total: _total,
                      earnedXp: _totalEarnedXp,
                    ),
                  ),
                ]),
              ]),
            ),
          ),

          // Quiz screen
          Expanded(
            child: QuizOrchestratorWithCallback(
              key: ValueKey(_currentQ.id),
              lessonId: widget.lessonId,
              question: QuestionOrcRef(
                id: _currentQ.id,
                quizType: _currentQ.quizType,
              ),
              onNext: (xp) => _onQuizNext(earnedXp: xp),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('Thoát bài học?'),
        content: const Text(
            'Tiến độ hiện tại sẽ không được lưu nếu bạn thoát giữa chừng.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tiếp tục học'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE24B4A)),
            child: const Text('Thoát'),
          ),
        ],
      ),
    );
  }
}

// ─── QuizOrchestratorWithCallback ─────────────────────────────────────────
// Wrap QuizOrchestrator để intercept onNext và truyền XP về runner

class QuizOrchestratorWithCallback extends StatelessWidget {
  final String lessonId;
  final QuestionOrcRef question;
  final void Function(int xp) onNext;

  const QuizOrchestratorWithCallback({
    required this.lessonId,
    required this.question,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dùng QuizOrchestrator gốc với callback onNext
    return QuizOrchestrator(
      question: QuestionRef(
        id: question.id,
        quizType: question.quizType,
        lessonId: lessonId,
      ),
      // onNext: () => onNext(question.estimatedXp),
    );
  }
}

/// Model nhỏ cho orchestrator
class QuestionOrcRef {
  final String id;
  final String quizType;
  const QuestionOrcRef({required this.id, required this.quizType});

  int get estimatedXp => switch (quizType) {
        'memory_flip'    => 20,
        'speak_word'     => 25,
        'sort_bucket'    => 20,
        'story_builder'  => 20,
        'word_pop'       => 15,
        'letter_scramble' => 15,
        'fill_blank'     => 15,
        _                => 10,
      };
}

// ─── Lesson complete screen ───────────────────────────────────────────────

class _LessonCompleteScreen extends StatefulWidget {
  final String lessonTitle;
  final int totalXp;
  final int questionCount;
  final VoidCallback onBack;
  final VoidCallback onReplay;

  const _LessonCompleteScreen({
    required this.lessonTitle,
    required this.totalXp,
    required this.questionCount,
    required this.onBack,
    required this.onReplay,
  });

  @override
  State<_LessonCompleteScreen> createState() =>
      _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<_LessonCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _scaleAnim = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.15), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: 1.15, end: 1.0), weight: 5),
    ]).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _fadeAnim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF534AB7),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Trophy
                ScaleTransition(
                  scale: _scaleAnim,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF9F27),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFEF9F27).withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text('🏆',
                        style: TextStyle(fontSize: 52)),
                  ),
                ),
                const SizedBox(height: 28),

                const Text(
                  'Hoàn thành bài học!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.lessonTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                // XP card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        emoji: '⚡',
                        value: '+${widget.totalXp}',
                        label: 'XP kiếm được',
                      ),
                      Container(
                          width: 1, height: 48,
                          color: Colors.white24),
                      _StatItem(
                        emoji: '✅',
                        value: '${widget.questionCount}',
                        label: 'Bài tập đã làm',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Buttons
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.home_rounded, size: 20),
                    label: const Text(
                      'Về trang chủ',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF534AB7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: widget.onReplay,
                    icon: const Icon(Icons.replay_rounded, size: 18),
                    label: const Text('Làm lại bài học'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(
                          color: Colors.white54, width: 1.5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
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

class _StatItem extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const _StatItem(
      {required this.emoji,
      required this.value,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 24)),
      const SizedBox(height: 4),
      Text(value,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white)),
      const SizedBox(height: 2),
      Text(label,
          style: const TextStyle(
              fontSize: 11, color: Colors.white60)),
    ]);
  }
}

class _NoQuestionsView extends StatelessWidget {
  final VoidCallback onBack;
  const _NoQuestionsView({required this.onBack});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.quiz_outlined,
                size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text('Bài học chưa có câu hỏi.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onBack,
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF534AB7)),
              child: const Text('Quay lại'),
            ),
          ]),
        ),
      );
}
