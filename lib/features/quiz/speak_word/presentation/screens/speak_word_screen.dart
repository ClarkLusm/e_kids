import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/quiz_result_sheet.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/speak_word_state.dart';
import '../../presentation/providers/speak_word_controller.dart';
import '../../presentation/widgets/mic_button_widget.dart';
import '../../presentation/widgets/speak_word_card_widget.dart';
import '../../presentation/widgets/speak_word_feedback_widget.dart';

class SpeakWordScreen extends ConsumerStatefulWidget {
  final String questionId;
  final int totalQuestions;
  final int currentIndex;
  final VoidCallback? onNext;

  const SpeakWordScreen({
    required this.questionId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<SpeakWordScreen> createState() => _SpeakWordScreenState();
}

class _SpeakWordScreenState extends ConsumerState<SpeakWordScreen> {
  final GlobalKey _cardKey = GlobalKey();
  bool _resultShown = false;

  SpeakWordController get _ctrl =>
      ref.read(speakWordControllerProvider(widget.questionId).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      speakWordControllerProvider(widget.questionId),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(speakWordControllerProvider(widget.questionId)),
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
    actions: [
      // Nút nghe audio mẫu
      IconButton(
        icon: const Icon(Icons.hearing_rounded, color: Color(0xFF534AB7)),
        onPressed: _ctrl.playReferenceAudio,
        tooltip: 'Nghe phát âm mẫu',
      ),
    ],
  );

  // ─── Body ──────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, SpeakWordState gs) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            // Label
            _InstructionLabel(status: gs.status),
            const SizedBox(height: 14),

            // Card từ + ảnh + phonetic + similarity meter
            SpeakWordCardWidget(
              key: _cardKey,
              gameState: gs,
              onPlayAudio: _ctrl.playReferenceAudio,
              onToggleTranslation: _ctrl.toggleTranslation,
            ),
            const SizedBox(height: 22),

            // Mic button trung tâm
            MicButtonWidget(
              status: gs.status,
              attemptsRemaining: gs.attemptsRemaining,
              maxAttempts: gs.content.maxAttempts,
              onStart: _ctrl.startListening,
              onStop: _ctrl.stopListening,
            ),

            const Spacer(),

            // Feedback / toolbar
            SpeakWordFeedbackWidget(
              gameState: gs,
              onRevealHint: _ctrl.revealHint,
              onRevealAnswer: _ctrl.revealAnswer,
              onContinue: () => _handleContinue(context, gs),
            ),
          ],
        ),
      ),
    );
  }

  // ─── XP animation ──────────────────────────────────────────────────

  void _showXpAnimation(BuildContext context, int xp) {
    if (xp <= 0) return;
    final box = _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final center = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 3),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: center);
  }

  // ─── Điều hướng ────────────────────────────────────────────────────

  void _handleContinue(BuildContext context, SpeakWordState gs) {
    if (gs.isCorrect && gs.xpEarned > 0) {
      _showXpAnimation(context, gs.xpEarned);
    }

    if (widget.onNext != null) {
      widget.onNext!();
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
          learnedWords: [gs.content.targetWord],
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

  int _calcStars(SpeakWordState gs) {
    if (!gs.isCorrect) return 1;
    final firstTry = gs.attemptCount == 1;
    final highSim = gs.bestSimilarity >= 0.9;
    if (firstTry && highSim) return 3;
    if (firstTry) return 2;
    return 1;
  }
}

// ─── Instruction label ────────────────────────────────────────────────────

class _InstructionLabel extends StatelessWidget {
  final SpeakWordStatus status;
  const _InstructionLabel({required this.status});

  String get _text => switch (status) {
    SpeakWordStatus.idle => 'Nhìn tranh và đọc to từ này',
    SpeakWordStatus.listening => 'Đang nghe giọng của bạn...',
    SpeakWordStatus.processing => 'Đang nhận diện...',
    SpeakWordStatus.wrong => 'Chưa đạt — thử lại nhé!',
    SpeakWordStatus.correct => 'Phát âm chuẩn! 🎉',
    SpeakWordStatus.maxReached => 'Hết lượt — xem gợi ý nhé',
    SpeakWordStatus.revealed => 'Hãy luyện thêm từ này',
  };

  Color get _color => switch (status) {
    SpeakWordStatus.correct => const Color(0xFF085041),
    SpeakWordStatus.wrong ||
    SpeakWordStatus.maxReached => const Color(0xFF791F1F),
    SpeakWordStatus.listening => const Color(0xFFE24B4A),
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
          fontSize: 15,
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
        Text('Đang tải bài quiz...', style: TextStyle(color: Colors.grey)),
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
