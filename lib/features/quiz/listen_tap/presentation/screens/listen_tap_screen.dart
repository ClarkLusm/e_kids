import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/question_ref.dart';
import '../../../_shared/quiz_result_sheet.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/listen_tap_state.dart';
import '../../presentation/providers/listen_tap_controller.dart';
import '../../presentation/widgets/audio_player_widget.dart';
import '../../presentation/widgets/image_choice_grid_widget.dart';
import '../../presentation/widgets/listen_tap_feedback_widget.dart';

class ListenTapScreen extends ConsumerStatefulWidget {
  final String questionId;
  final String lessonId;
  final int totalQuestions;
  final int currentIndex;
  final ValueChanged<int>? onNext;

  const ListenTapScreen({
    required this.questionId,
    required this.lessonId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<ListenTapScreen> createState() => _ListenTapScreenState();
}

class _ListenTapScreenState extends ConsumerState<ListenTapScreen> {
  final GlobalKey _gridKey = GlobalKey();
  bool _resultShown = false;
  QuizQuestionArgs get _controllerArgs => QuizQuestionArgs(
    questionId: widget.questionId,
    lessonId: widget.lessonId,
  );

  ListenTapController get _ctrl =>
      ref.read(listenTapControllerProvider(_controllerArgs).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(listenTapControllerProvider(_controllerArgs));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(listenTapControllerProvider(_controllerArgs)),
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

  Widget _buildBody(BuildContext context, ListenTapState gs) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            // Label + chỉ dẫn
            _InstructionBanner(status: gs.status),
            const SizedBox(height: 20),

            // Nút audio trung tâm
            AudioPlayerWidget(
              status: gs.status,
              replaysRemaining: gs.replaysRemaining,
              replayLimit: gs.content.replayLimit,
              onPlay: _ctrl.playAudio,
            ),
            const SizedBox(height: 24),

            // Grid 4 ảnh
            Expanded(
              child: ImageChoiceGridWidget(
                key: _gridKey,
                choices: gs.shuffledChoices,
                gameState: gs,
                onChoiceTap: (word) async {
                  await _ctrl.selectAnswer(word);
                  final updated = ref
                      .read(listenTapControllerProvider(_controllerArgs))
                      .value;
                  if (updated != null && updated.isCorrect) {
                    _showXpAnimation(context, updated.xpEarned);
                  }
                },
              ),
            ),
            const SizedBox(height: 14),

            // Feedback banner
            ListenTapFeedbackWidget(
              gameState: gs,
              onContinue: () => _handleContinue(context, gs),
              onReveal: _ctrl.revealAnswer,
            ),
          ],
        ),
      ),
    );
  }

  // ─── XP animation ──────────────────────────────────────────────────

  void _showXpAnimation(BuildContext context, int xp) {
    if (xp <= 0) return;
    final box = _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final center = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 3),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: center);
  }

  // ─── Điều hướng ────────────────────────────────────────────────────

  void _handleContinue(BuildContext context, ListenTapState gs) {
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
          learnedWords: [gs.content.correctChoice.word],
          onReplay: () {
            Navigator.of(context).pop();
            _resultShown = false;
            _ctrl.retry();
          },
          onNext: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  int _calcStars(ListenTapState gs) {
    if (!gs.isCorrect) return 1;
    final onePlay = gs.replayCount <= 1;
    final fast = gs.timeTakenMs < 6000;
    if (onePlay && fast) return 3;
    if (onePlay) return 2;
    return 1;
  }
}

// ─── Instruction banner ───────────────────────────────────────────────────

class _InstructionBanner extends StatelessWidget {
  final ListenTapStatus status;
  const _InstructionBanner({required this.status});

  String get _text => switch (status) {
    ListenTapStatus.waitingToPlay => 'Nghe và chọn hình ảnh đúng',
    ListenTapStatus.playing => 'Đang phát âm thanh...',
    ListenTapStatus.idle => 'Chọn hình ảnh phù hợp',
    ListenTapStatus.correct => 'Tuyệt vời! 🎉',
    ListenTapStatus.wrong => 'Chưa đúng — thử lại!',
    ListenTapStatus.revealed => 'Đây là đáp án đúng',
  };

  Color get _color => switch (status) {
    ListenTapStatus.correct => const Color(0xFF085041),
    ListenTapStatus.wrong => const Color(0xFF791F1F),
    ListenTapStatus.revealed => const Color(0xFF085041),
    _ => const Color(0xFF534AB7),
  };

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Text(
        _text,
        key: ValueKey(status),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _color,
        ),
        textAlign: TextAlign.center,
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
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: Color(0xFF534AB7)),
        SizedBox(height: 16),
        Text('Đang tải âm thanh...', style: TextStyle(color: Colors.grey)),
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
