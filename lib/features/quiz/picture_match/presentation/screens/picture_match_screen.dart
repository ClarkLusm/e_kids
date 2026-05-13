import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../_shared/hint_button_widget.dart';
import '../../../_shared/question_ref.dart';
import '../../../_shared/quiz_result_sheet.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/picture_match_state.dart';
import '../../presentation/widgets/picture_card_widget.dart';
import '../../presentation/widgets/choice_grid_widget.dart';
import '../../presentation/widgets/answer_feedback_widget.dart';
import '../providers/picture_match_controller.dart';

class PictureMatchScreen extends ConsumerStatefulWidget {
  final String questionId;
  final String lessonId;

  /// Bao nhiêu câu trong session hiện tại (hiện progress bar)
  final int totalQuestions;
  final int currentIndex;
  final ValueChanged<int>? onNext;

  const PictureMatchScreen({
    required this.questionId,
    required this.lessonId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<PictureMatchScreen> createState() => _PictureMatchScreenState();
}

class _PictureMatchScreenState extends ConsumerState<PictureMatchScreen> {
  final GlobalKey _imageKey = GlobalKey();
  bool _resultShown = false;
  QuizQuestionArgs get _controllerArgs => QuizQuestionArgs(
    questionId: widget.questionId,
    lessonId: widget.lessonId,
  );

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      pictureMatchControllerProvider(_controllerArgs),
    );
    final ctrl = ref.read(
      pictureMatchControllerProvider(_controllerArgs).notifier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(context),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(pictureMatchControllerProvider(_controllerArgs)),
        ),
        data: (gs) => _buildBody(context, gs, ctrl),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close_rounded, color: Colors.grey),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: _ProgressHeader(
        current: widget.currentIndex,
        total: widget.totalQuestions,
      ),
      actions: [
        // Hint: phát âm ảnh khi bấm
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: HintButtonWidget(
            maxHints: 2,
            label: 'Nghe',
            onHint: () => ref
                .read(pictureMatchControllerProvider(_controllerArgs).notifier)
                .playImageAudio(),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
    BuildContext context,
    PictureMatchState gs,
    PictureMatchController ctrl,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Câu hỏi
            const Text(
              'Đây là gì?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),

            // Ảnh
            PictureCardWidget(
              key: _imageKey,
              imageUrl: gs.content.imageUrl,
              translationVi: gs.content.translationVi,
              showTranslation: gs.isAnswered,
              onPlayAudio: gs.content.imageAudioUrl != null
                  ? ctrl.playImageAudio
                  : null,
            ),
            const SizedBox(height: 24),

            // Grid 4 lựa chọn
            ChoiceGridWidget(
              gameState: gs,
              onChoiceTap: (word) {
                ctrl.selectAnswer(word);
                if (word == gs.content.correctWord) {
                  _showXpAnimation(context, gs.xpEarned);
                }
              },
              onChoiceAudioTap: ctrl.playChoiceAudio,
            ),
            const SizedBox(height: 16),

            // Feedback banner
            if (gs.isAnswered) ...[
              AnswerFeedbackWidget(
                gameState: gs,
                onContinue: () {
                  if (gs.isCorrect) {
                    _handleNext(context, gs);
                  } else {
                    ctrl.revealAnswer();
                  }
                },
              ),
            ] else
              const Spacer(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showXpAnimation(BuildContext context, int xp) {
    if (xp <= 0) return;
    final box = _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 2),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: pos);
  }

  void _handleNext(BuildContext context, PictureMatchState gs) {
    if (widget.onNext != null) {
      widget.onNext!(gs.xpEarned);
      return;
    }
    // Nếu không có callback next → hiện result sheet và pop
    if (!_resultShown) {
      _resultShown = true;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => QuizResultSheet(
          stars: gs.isCorrect ? 3 : 1,
          xpEarned: gs.xpEarned,
          timeTakenSec: gs.timeTakenMs ~/ 1000,
          correctCount: gs.isCorrect ? 1 : 0,
          totalCount: 1,
          learnedWords: [gs.content.correctWord],
          onReplay: () {
            Navigator.of(context).pop();
            _resultShown = false;
            ref
                .read(pictureMatchControllerProvider(_controllerArgs).notifier)
                .retry();
          },
          onNext: () {
            Navigator.of(context).pop(); // đóng sheet
            Navigator.of(context).pop(); // quay lại lesson
          },
        ),
      );
    }
  }
}

// ─── Progress header ──────────────────────────────────────────────────────

class _ProgressHeader extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressHeader({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: current / total,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF534AB7),
              ),
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
}

// ─── Loading ──────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Color(0xFF534AB7)),
          SizedBox(height: 16),
          Text('Đang tải câu hỏi...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            const Text(
              'Không tải được câu hỏi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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
}
