import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/hint_button_widget.dart';
import '../../../_shared/question_ref.dart';
import '../../../_shared/quiz_result_sheet.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/fill_blank_state.dart';
import '../../presentation/providers/fill_blank_controller.dart';
import '../../presentation/widgets/sentence_display_widget.dart';
import '../../presentation/widgets/word_chip_bar_widget.dart';
import '../../presentation/widgets/fill_blank_illustration_widget.dart';
import '../../presentation/widgets/fill_blank_feedback_widget.dart';

class FillBlankScreen extends ConsumerStatefulWidget {
  final String questionId;
  final String lessonId;
  final int totalQuestions;
  final int currentIndex;
  final ValueChanged<int>? onNext;

  const FillBlankScreen({
    required this.questionId,
    required this.lessonId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<FillBlankScreen> createState() => _FillBlankScreenState();
}

class _FillBlankScreenState extends ConsumerState<FillBlankScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _sentenceKey = GlobalKey();
  bool _resultShown = false;
  QuizQuestionArgs get _controllerArgs => QuizQuestionArgs(
    questionId: widget.questionId,
    lessonId: widget.lessonId,
  );

  // Confetti animation khi đúng
  late AnimationController _confettiCtrl;

  @override
  void initState() {
    super.initState();
    _confettiCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(fillBlankControllerProvider(_controllerArgs));
    final ctrl = ref.read(
      fillBlankControllerProvider(_controllerArgs).notifier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(context, ctrl, asyncState),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(fillBlankControllerProvider(_controllerArgs)),
        ),
        data: (gs) => _buildBody(context, gs, ctrl),
      ),
    );
  }

  // ─── AppBar ────────────────────────────────────────────────────────

  AppBar _buildAppBar(
    BuildContext context,
    FillBlankController ctrl,
    AsyncValue<FillBlankState> asyncState,
  ) {
    return AppBar(
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
      actions: [
        // Hint: hiện bản dịch tiếng Việt
        if (asyncState.value?.content.showTranslationHint ?? false)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: HintButtonWidget(
              maxHints: 2,
              label: 'Dịch',
              onHint: ctrl.toggleHint,
            ),
          ),
        // Nút phát âm câu
        if (asyncState.value?.content.audioSentenceUrl != null)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              icon: const Icon(
                Icons.volume_up_outlined,
                color: Color(0xFF534AB7),
              ),
              onPressed: ctrl.playSentenceAudio,
              tooltip: 'Nghe câu',
            ),
          ),
      ],
    );
  }

  // ─── Body ──────────────────────────────────────────────────────────

  Widget _buildBody(
    BuildContext context,
    FillBlankState gs,
    FillBlankController ctrl,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Label câu hỏi
            const Text(
              'Điền từ còn thiếu vào chỗ trống',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF534AB7),
              ),
            ),
            const SizedBox(height: 16),

            // Ảnh minh hoạ (nếu có)
            if (gs.content.imageUrl != null) ...[
              FillBlankIllustrationWidget(
                imageUrl: gs.content.imageUrl!,
                height: 130,
              ),
              const SizedBox(height: 16),
            ],

            // Câu + ô trống
            SentenceDisplayWidget(
              key: _sentenceKey,
              beforeBlank: gs.content.beforeBlank,
              afterBlank: gs.content.afterBlank,
              filledWord: gs.displayWord,
              slotStatus: gs.slotStatus,
              showTranslation: gs.isShowingHint,
              sentenceVi: gs.content.sentenceVi,
              onPlayAudio: gs.content.audioSentenceUrl != null
                  ? ctrl.playSentenceAudio
                  : null,
            ),
            const SizedBox(height: 28),

            // Chỉ dẫn
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                gs.hasSelection && !gs.isAnswered
                    ? 'Nhấn "Kiểm tra" khi sẵn sàng'
                    : gs.isAnswered
                    ? ''
                    : 'Chọn một từ bên dưới',
                key: ValueKey(gs.status),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Word chips
            WordChipBarWidget(
              choices: gs.shuffledChoices,
              gameState: gs,
              onChipTap: (word) {
                ctrl.selectWord(word);
              },
            ),

            const Spacer(),

            // Submit / Feedback
            FillBlankFeedbackWidget(
              gameState: gs,
              onSubmit: () async {
                await ctrl.submitAnswer();
                final updatedGs = ref
                    .read(fillBlankControllerProvider(_controllerArgs))
                    .value;
                if (updatedGs != null && updatedGs.isCorrect) {
                  _playCorrectAnimation(context, updatedGs.xpEarned);
                }
              },
              onContinue: () => _handleContinue(context, gs, ctrl),
              onReveal: ctrl.revealAnswer,
            ),
          ],
        ),
      ),
    );
  }

  // ─── XP animation + confetti ──────────────────────────────────────

  void _playCorrectAnimation(BuildContext context, int xp) {
    final box = _sentenceKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final center = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 2),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: center);
    _confettiCtrl.forward(from: 0);
  }

  // ─── Điều hướng tiếp theo ─────────────────────────────────────────

  void _handleContinue(
    BuildContext context,
    FillBlankState gs,
    FillBlankController ctrl,
  ) {
    if (widget.onNext != null) {
      widget.onNext!(gs.xpEarned);
      return;
    }

    if (!_resultShown) {
      _resultShown = true;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => QuizResultSheet(
          stars: _calcStars(gs),
          xpEarned: gs.xpEarned,
          timeTakenSec: gs.timeTakenMs ~/ 1000,
          correctCount: gs.isCorrect ? 1 : 0,
          totalCount: 1,
          learnedWords: [gs.content.correctAnswer],
          onReplay: () {
            Navigator.of(context).pop();
            _resultShown = false;
            ctrl.retry();
          },
          onNext: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  int _calcStars(FillBlankState gs) {
    if (!gs.isCorrect) return 1;
    if (gs.hintsUsed == 0 && gs.timeTakenMs < 8000) return 3;
    if (gs.hintsUsed == 0) return 2;
    return 1;
  }
}

// ─── Progress bar header ──────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

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
