import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/memory_flip_controller.dart';
import '../widgets/flip_card_widget.dart';
import '../widgets/game_header_widget.dart';
import '../widgets/result_sheet_widget.dart';
import '../../domain/models/card_state.dart';

class MemoryFlipScreen extends ConsumerStatefulWidget {
  final String questionId;

  const MemoryFlipScreen({required this.questionId, super.key});

  @override
  ConsumerState<MemoryFlipScreen> createState() => _MemoryFlipScreenState();
}

class _MemoryFlipScreenState extends ConsumerState<MemoryFlipScreen> {
  bool _resultShown = false;

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      memoryFlipControllerProvider(widget.questionId),
    );
    final ctrl = ref.read(
      memoryFlipControllerProvider(widget.questionId).notifier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Memory Flip',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF534AB7),
          ),
        ),
        centerTitle: true,
      ),
      body: asyncState.when(
        loading: () => const _LoadingView(),
        error: (e, st) => _ErrorView(
          error: e,
          onRetry: () {
            ref.invalidate(memoryFlipControllerProvider(widget.questionId));
          },
        ),
        data: (gs) {
          // Hiện result sheet khi game hoàn thành
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (gs.isComplete && !_resultShown) {
              _resultShown = true;
              _showResultSheet(context, gs, ctrl);
            }
          });

          final grid = gs.content.gridSize;

          return Column(
            children: [
              // Header
              GameHeaderWidget(
                matchCount: gs.matchCount,
                totalPairs: grid.pairCount,
                flipCount: gs.flipCount,
                maxFlips: gs.content.maxFlips,
              ),

              // Board
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: grid.cols,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: gs.board.length,
                    itemBuilder: (ctx, i) {
                      final card = gs.board[i];
                      return FlipCardWidget(
                        key: ValueKey('${card.pairId}_${card.isCardA}'),
                        cardState: card,
                        flipDuration: Duration(
                          milliseconds: gs.content.flipDurationMs,
                        ),
                        onTap: card.isInteractable
                            ? () => ctrl.onCardTap(i)
                            : null,
                        showLabelOnBack:
                            gs.content.accessibility.showLabelOnBack,
                        highContrast:
                            gs.content.accessibility.highContrastBorder,
                      );
                    },
                  ),
                ),
              ),

              // Hint text
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  gs.firstFlipped != null
                      ? 'Chọn thẻ thứ hai để ghép cặp!'
                      : 'Lật thẻ để tìm cặp từ!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showResultSheet(BuildContext context, gs, MemoryFlipController ctrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => ResultSheetWidget(
        gameState: gs,
        onReplay: () {
          Navigator.of(context).pop();
          _resultShown = false;
          ctrl.replay();
        },
        onNext: () {
          Navigator.of(context).pop(); // đóng sheet
          Navigator.of(context).pop(); // quay lại lesson
        },
      ),
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
          Text('Đang tải bài...', style: TextStyle(color: Colors.grey)),
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
              'Không tải được bài quiz',
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
