import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/question_ref.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/story_builder_state.dart';
import '../../presentation/providers/story_builder_controller.dart';
import '../../presentation/widgets/sentence_builder_widget.dart';
import '../../presentation/widgets/story_progress_widget.dart';

class StoryBuilderScreen extends ConsumerStatefulWidget {
  final String questionId;
  final String lessonId;
  final int totalQuestions;
  final int currentIndex;
  final ValueChanged<int>? onNext;

  const StoryBuilderScreen({
    required this.questionId,
    required this.lessonId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<StoryBuilderScreen> createState() => _StoryBuilderScreenState();
}

class _StoryBuilderScreenState extends ConsumerState<StoryBuilderScreen> {
  final GlobalKey _contentKey = GlobalKey();
  bool _resultShown = false;
  QuizQuestionArgs get _controllerArgs => QuizQuestionArgs(
    questionId: widget.questionId,
    lessonId: widget.lessonId,
  );

  StoryBuilderController get _ctrl =>
      ref.read(storyBuilderControllerProvider(_controllerArgs).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      storyBuilderControllerProvider(_controllerArgs),
    );

    // Hiện result sheet khi complete
    asyncState.whenData((gs) {
      if (gs.isComplete && !_resultShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showResultSheet(context, gs);
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(storyBuilderControllerProvider(_controllerArgs)),
        ),
        data: (gs) => _buildBody(context, gs),
      ),
    );
  }

  // ─── AppBar ────────────────────────────────────────────────────────

  AppBar _buildAppBar() => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.close_rounded, color: Colors.grey),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: _ProgressBar(
      current: widget.currentIndex,
      total: widget.totalQuestions,
    ),
  );

  // ─── Body ──────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, StoryBuilderState gs) {
    final cur = gs.currentSentence;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Story progress bar
            StoryProgressWidget(gameState: gs),
            const SizedBox(height: 16),

            // Label
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                cur.status == SentenceStatus.correct
                    ? '✅ Câu ${gs.currentSentenceIndex + 1} đúng rồi!'
                    : 'Sắp xếp từ thành câu hoàn chỉnh',
                key: ValueKey(cur.status),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: cur.status == SentenceStatus.correct
                      ? const Color(0xFF085041)
                      : const Color(0xFF534AB7),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Sentence builder
            KeyedSubtree(
              key: _contentKey,
              child: SentenceBuilderWidget(
                sentenceState: cur,
                onWordTap: _ctrl.tapWord,
                onSlotTap: _ctrl.removeWordFromSlot,
                onClear: _ctrl.clearAll,
                onAudioHint: gs.content.allowAudioHint
                    ? _ctrl.playAudioHint
                    : null,
                onContinue:
                    cur.status == SentenceStatus.correct && !gs.isLastSentence
                    ? () => _onNextSentence(context, gs)
                    : cur.status == SentenceStatus.correct && gs.isLastSentence
                    ? () => _finishStory(context, gs)
                    : null,
              ),
            ),

            // Các câu đã hoàn thành phía trên (review)
            if (gs.currentSentenceIndex > 0) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Câu đã hoàn thành',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              ...gs.sentenceStates
                  .take(gs.currentSentenceIndex)
                  .map((ss) => _CompletedPreview(ss: ss)),
            ],
          ],
        ),
      ),
    );
  }

  // ─── Next sentence ────────────────────────────────────────────────

  void _onNextSentence(BuildContext context, StoryBuilderState gs) {
    _showXpAnimation(context, 15); // XP per sentence
    _ctrl.nextSentence();

    // Scroll về đầu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        _contentKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ─── Kết thúc story ──────────────────────────────────────────────

  void _finishStory(BuildContext context, StoryBuilderState gs) {
    _ctrl.nextSentence(); // trigger _finishStory trong controller
  }

  // ─── XP animation ────────────────────────────────────────────────

  void _showXpAnimation(BuildContext context, int xp) {
    if (xp <= 0) return;
    final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 4),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: pos);
  }

  // ─── Result sheet ─────────────────────────────────────────────────

  void _showResultSheet(BuildContext context, StoryBuilderState gs) {
    if (_resultShown) return;
    _resultShown = true;

    _showXpAnimation(context, gs.xpEarned);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => StoryResultSheet(
        gameState: gs,
        onReplay: () {
          Navigator.of(context).pop();
          _resultShown = false;
          _ctrl.retry();
        },
        onNext: () {
          Navigator.of(context).pop();
          if (widget.onNext != null) {
            widget.onNext!(gs.xpEarned);
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

// ─── Preview câu đã hoàn thành ───────────────────────────────────────────

class _CompletedPreview extends StatelessWidget {
  final SentenceState ss;
  const _CompletedPreview({required this.ss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5EE).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text('📝 ', style: TextStyle(fontSize: 13)),
          Expanded(
            child: Text(
              ss.sentence.correctSentence,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF085041),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            size: 14,
            color: Color(0xFF1D9E75),
          ),
        ],
      ),
    );
  }
}

// ─── Progress bar ─────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: current / total,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF534AB7)),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        '$current/$total',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// ─── Loading ──────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: Color(0xFF534AB7)),
        SizedBox(height: 16),
        Text('Đang tải câu chuyện...', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}

// ─── Error ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: Color(0xFFE24B4A),
          ),
          const SizedBox(height: 12),
          Text(
            error.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Thử lại'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF534AB7),
            ),
          ),
        ],
      ),
    ),
  );
}
