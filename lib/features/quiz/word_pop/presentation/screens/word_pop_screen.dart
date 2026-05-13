import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_shared/question_ref.dart';
import '../../domain/models/word_pop_state.dart';
import '../../presentation/providers/word_pop_controller.dart';
import '../../presentation/widgets/bubble_widget.dart';
import '../../presentation/widgets/word_pop_hud_widget.dart';

class WordPopScreen extends ConsumerStatefulWidget {
  final String questionId;
  final String lessonId;
  final int totalQuestions;
  final int currentIndex;
  final ValueChanged<int>? onNext;

  const WordPopScreen({
    required this.questionId,
    required this.lessonId,
    this.totalQuestions = 1,
    this.currentIndex = 1,
    this.onNext,
    super.key,
  });

  @override
  ConsumerState<WordPopScreen> createState() => _WordPopScreenState();
}

class _WordPopScreenState extends ConsumerState<WordPopScreen> {
  // Pop effects overlay
  final List<Widget> _popEffects = [];
  QuizQuestionArgs get _controllerArgs => QuizQuestionArgs(
    questionId: widget.questionId,
    lessonId: widget.lessonId,
  );

  WordPopController get _ctrl =>
      ref.read(wordPopControllerProvider(_controllerArgs).notifier);

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(wordPopControllerProvider(_controllerArgs));

    return Scaffold(
      backgroundColor: const Color(0xFFF0EEFF),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, _) => _ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(wordPopControllerProvider(_controllerArgs)),
        ),
        data: (gs) => _buildGame(context, gs),
      ),
    );
  }

  Widget _buildGame(BuildContext context, WordPopState gs) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background gradient
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFFEEEDFE), const Color(0xFFF8F7FF)],
              ),
            ),
          ),
        ),

        // Bubbles
        ...gs.activeBubbles.where((b) => b.isFloating).map((bubble) {
          return BubbleWidget(
            key: ValueKey(bubble.id),
            bubble: bubble,
            screenWidth: size.width,
            screenHeight: size.height,
            onTap: () => _onBubbleTap(bubble, size),
            onEscaped: () => _ctrl.onBubbleEscaped(bubble.id),
          );
        }),

        // Pop effects
        ..._popEffects,

        // HUD phía trên
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Column(
              children: [
                // Back + progress
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: widget.currentIndex / widget.totalQuestions,
                            minHeight: 5,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF534AB7),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.currentIndex}/${widget.totalQuestions}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                WordPopHudWidget(gameState: gs),
              ],
            ),
          ),
        ),

        // Countdown overlay
        if (gs.status == WordPopStatus.countdown)
          CountdownOverlay(count: gs.countdown),

        // Result banner
        if (gs.isComplete)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: WordPopResultBanner(
                gameState: gs,
                onReplay: _ctrl.retry,
                onContinue: () {
                  if (widget.onNext != null) {
                    widget.onNext!(gs.xpEarned);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  void _onBubbleTap(ActiveBubble bubble, Size size) {
    _ctrl.tapBubble(bubble.id);

    // Hiện pop effect
    final xPx = bubble.xFraction * size.width;
    final effect = BubblePopEffect(
      key: UniqueKey(),
      position: Offset(xPx, size.height * 0.5),
      isCorrect: bubble.data.isTarget,
    );

    setState(() => _popEffects.add(effect));

    // Xoá effect sau 500ms
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _popEffects.remove(effect));
    });
  }
}

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
            style: const TextStyle(fontSize: 13, color: Colors.grey),
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
