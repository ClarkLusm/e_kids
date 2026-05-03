import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/quiz_result_sheet.dart';
import '../../../_shared/xp_animation_widget.dart';
import '../../domain/models/letter_scramble_state.dart';
import '../../presentation/providers/letter_scramble_controller.dart';
import '../../presentation/widgets/answer_slots_widget.dart';
import '../../presentation/widgets/scramble_feedback_widget.dart';
import '../../presentation/widgets/source_tiles_widget.dart';
import '../../presentation/widgets/word_image_card.dart';

class LetterScrambleScreen extends ConsumerStatefulWidget {
  final String questionId;
  final int totalQuestions;
  final int currentIndex;
  final VoidCallback? onNext;

  const LetterScrambleScreen({
    required this.questionId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<LetterScrambleScreen> createState() =>
      _LetterScrambleScreenState();
}

class _LetterScrambleScreenState extends ConsumerState<LetterScrambleScreen> {
  final GlobalKey _slotsKey = GlobalKey();
  bool _resultShown = false;

  LetterScrambleController get _ctrl =>
      ref.read(letterScrambleControllerProvider(widget.questionId).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      letterScrambleControllerProvider(widget.questionId),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: _buildAppBar(),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () => ref.invalidate(
            letterScrambleControllerProvider(widget.questionId),
          ),
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
      IconButton(
        icon: const Icon(Icons.volume_up_outlined, color: Color(0xFF534AB7)),
        onPressed: _ctrl.playWordAudio,
        tooltip: 'Phát âm từ',
      ),
    ],
  );

  // ─── Body ──────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, LetterScrambleState gs) {
    final hintsRemaining = gs.content.maxHints - gs.hintsUsed;

    return DragTarget<String>(
      // Drop vào vùng source (trả tile về pool)
      onAcceptWithDetails: (details) => _ctrl.dragTileToSource(details.data),
      builder: (ctx, _, __) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              // Label
              const Text(
                'Xếp chữ cái thành từ đúng',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF534AB7),
                ),
              ),
              const SizedBox(height: 14),

              // Ảnh + phonetic
              WordImageCard(
                imageUrl: gs.content.imageUrl,
                phonetic: gs.content.phonetic,
                translationVi: gs.content.translationVi,
                showTranslation: gs.isAnswered,
                onPlayAudio: gs.content.audioUrl != null
                    ? _ctrl.playWordAudio
                    : null,
              ),
              const SizedBox(height: 20),

              // Ô đáp án
              AnswerSlotsWidget(
                key: _slotsKey,
                slots: gs.answerSlots,
                gameState: gs,
                onSlotTap: _ctrl.tapAnswerSlot,
                onDrop: _ctrl.dragTileToSlot,
              ),
              const SizedBox(height: 8),

              // Độ dài từ hint
              Text(
                '${gs.content.word.length} chữ cái',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 20),

              // Divider ngăn source / answer
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      gs.isAnswered ? '' : 'Chọn chữ cái',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                ],
              ),
              const SizedBox(height: 16),

              // Source tiles pool
              SourceTilesWidget(
                tiles: gs.sourceTiles,
                isAnswered: gs.isAnswered,
                onTileTap: _ctrl.tapSourceTile,
              ),

              const Spacer(),

              // Feedback / toolbar
              ScrambleFeedbackWidget(
                gameState: gs,
                hintsRemaining: hintsRemaining,
                onHint: () {
                  _ctrl.useHint();
                },
                onClear: _ctrl.clearAll,
                onReveal: _ctrl.revealAnswer,
                onContinue: () => _handleContinue(context, gs),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── XP animation ──────────────────────────────────────────────────

  void _showXpAnimation(BuildContext context, int xp) {
    final box = _slotsKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final center = box.localToGlobal(
      Offset(box.size.width / 2, box.size.height / 2),
    );
    XpOverlayHelper.show(context, xpAmount: xp, startOffset: center);
  }

  // ─── Điều hướng tiếp theo ─────────────────────────────────────────

  void _handleContinue(BuildContext context, LetterScrambleState gs) {
    if (gs.status == LetterScrambleStatus.correct && gs.xpEarned > 0) {
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
          correctCount: gs.status == LetterScrambleStatus.correct ? 1 : 0,
          totalCount: 1,
          learnedWords: [gs.content.word],
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

  int _calcStars(LetterScrambleState gs) {
    if (gs.status != LetterScrambleStatus.correct) return 1;
    final perfect = gs.hintsUsed == 0 && gs.wrongAttempts == 0;
    final good = gs.hintsUsed == 0 || gs.wrongAttempts == 0;
    if (perfect) return 3;
    if (good) return 2;
    return 1;
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
