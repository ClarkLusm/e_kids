import 'package:flutter/material.dart';
import '../../domain/models/story_builder_state.dart';

/// Thanh tiến độ câu chuyện — hiện số câu đã hoàn thành.
class StoryProgressWidget extends StatelessWidget {
  final StoryBuilderState gameState;

  const StoryProgressWidget({required this.gameState, super.key});

  @override
  Widget build(BuildContext context) {
    final gs = gameState;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Story title + câu số mấy
          Row(
            children: [
              if (gs.content.storyTitleVi != null) ...[
                const Text('📖 ', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Text(
                    gs.content.storyTitleVi!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ] else
                const Expanded(
                  child: Text(
                    'Xây dựng câu chuyện',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEDFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Câu ${gs.currentSentenceIndex + 1}/${gs.totalSentences}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF534AB7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Dot progress per sentence
          Row(
            children: List.generate(gs.totalSentences, (i) {
              final isActive = i == gs.currentSentenceIndex;
              final isDone =
                  i < gs.currentSentenceIndex ||
                  (i == gs.currentSentenceIndex &&
                      gs.currentSentence.status == SentenceStatus.correct);
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 6,
                    decoration: BoxDecoration(
                      color: isDone
                          ? const Color(0xFF1D9E75)
                          : isActive
                          ? const Color(0xFF534AB7)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet kết quả sau khi hoàn thành toàn bộ story.
class StoryResultSheet extends StatefulWidget {
  final StoryBuilderState gameState;
  final VoidCallback onReplay;
  final VoidCallback onNext;

  const StoryResultSheet({
    required this.gameState,
    required this.onReplay,
    required this.onNext,
    super.key,
  });

  @override
  State<StoryResultSheet> createState() => _StoryResultSheetState();
}

class _StoryResultSheetState extends State<StoryResultSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int get _stars {
    final gs = widget.gameState;
    final allCorrect = gs.correctCount == gs.totalSentences;
    final noWrong = gs.sentenceStates.every((s) => s.wrongAttempts == 0);
    if (allCorrect && noWrong) return 3;
    if (allCorrect) return 2;
    return 1;
  }

  String _formatTime(int ms) {
    final s = ms ~/ 1000;
    final m = s ~/ 60;
    return m > 0 ? '${m}p ${s % 60}s' : '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;
    final stars = _stars;
    final allCorrect = gs.correctCount == gs.totalSentences;

    return SlideTransition(
      position: _slideAnim,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),

              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      i < stars
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: i < stars
                          ? const Color(0xFFEF9F27)
                          : Colors.grey.shade300,
                      size: 42,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                '+${gs.xpEarned} XP',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF534AB7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                allCorrect
                    ? 'Câu chuyện hoàn chỉnh! 🎉'
                    : '${gs.correctCount}/${gs.totalSentences} câu đúng',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // Stats
              Row(
                children: [
                  _StatBox(
                    icon: Icons.check_circle_outline_rounded,
                    value: '${gs.correctCount}/${gs.totalSentences}',
                    label: 'Câu đúng',
                    color: const Color(0xFF1D9E75),
                  ),
                  const SizedBox(width: 8),
                  _StatBox(
                    icon: Icons.timer_outlined,
                    value: _formatTime(gs.timeTakenMs),
                    label: 'Thời gian',
                    color: const Color(0xFF534AB7),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Toàn bộ câu đã hoàn thành
              ...gs.sentenceStates
                  .where((s) => s.status == SentenceStatus.correct)
                  .map((s) => _CompletedSentenceRow(sentenceState: s)),

              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.onReplay,
                      icon: const Icon(Icons.replay_rounded, size: 16),
                      label: const Text('Chơi lại'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                        foregroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: widget.onNext,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      label: const Text('Tiếp theo'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xFF534AB7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Câu đã hoàn thành ────────────────────────────────────────────────────

class _CompletedSentenceRow extends StatelessWidget {
  final SentenceState sentenceState;
  const _CompletedSentenceRow({required this.sentenceState});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1D9E75).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 16,
            color: Color(0xFF1D9E75),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              sentenceState.sentence.correctSentence,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF085041),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat box ────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatBox({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
