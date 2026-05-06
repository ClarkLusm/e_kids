import 'package:flutter/material.dart';
import '../../domain/models/story_builder_state.dart';

/// Widget xây dựng 1 câu: ô trả lời + pool từ bên dưới.
class SentenceBuilderWidget extends StatelessWidget {
  final SentenceState sentenceState;
  final void Function(String word) onWordTap;
  final void Function(int slotIndex) onSlotTap;
  final VoidCallback onClear;
  final VoidCallback? onAudioHint;
  final VoidCallback? onContinue;

  const SentenceBuilderWidget({
    required this.sentenceState,
    required this.onWordTap,
    required this.onSlotTap,
    required this.onClear,
    this.onAudioHint,
    this.onContinue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ss = sentenceState;
    final isAnswered = ss.isAnswered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ảnh minh hoạ (nếu có)
        if (ss.sentence.imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              ss.sentence.imageUrl!,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 130,
                color: const Color(0xFFEEEDFE),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 36,
                    color: Color(0xFF534AB7),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Ô trả lời (slots)
        _AnswerRow(
          slots: ss.answerSlots,
          status: ss.status,
          onSlotTap: isAnswered ? (_) {} : onSlotTap,
        ),
        const SizedBox(height: 8),

        // Dịch nghĩa (nếu đã đúng)
        if (ss.status == SentenceStatus.correct &&
            ss.sentence.translationVi != null) ...[
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5EE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text('🇻🇳 ', style: TextStyle(fontSize: 14)),
                  Flexible(
                    child: Text(
                      ss.sentence.translationVi!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF085041),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],

        // Feedback khi sai
        if (ss.status == SentenceStatus.wrong) ...[
          _WrongFeedback(wrongAttempts: ss.wrongAttempts),
          const SizedBox(height: 8),
        ],

        // Actions
        if (!isAnswered) ...[
          Row(
            children: [
              // Audio hint
              if (onAudioHint != null)
                _ActionBtn(
                  icon: Icons.volume_up_outlined,
                  label: 'Nghe',
                  color: const Color(0xFF534AB7),
                  onTap: onAudioHint!,
                ),
              if (onAudioHint != null) const SizedBox(width: 8),
              // Clear
              _ActionBtn(
                icon: Icons.refresh_rounded,
                label: 'Xoá',
                color: Colors.grey,
                onTap: onClear,
              ),
            ],
          ),
        ] else if (ss.status == SentenceStatus.correct &&
            onContinue != null) ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onContinue,
              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
              label: const Text('Câu tiếp theo →'),
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

        const SizedBox(height: 16),

        // Pool từ
        if (!isAnswered || ss.status == SentenceStatus.wrong) ...[
          const Text(
            'Chọn từ để điền',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ss.wordPool.map((word) {
              return _WordChip(word: word, onTap: () => onWordTap(word));
            }).toList(),
          ),
        ],
      ],
    );
  }
}

// ─── Hàng ô trả lời ──────────────────────────────────────────────────────

class _AnswerRow extends StatelessWidget {
  final List<String?> slots;
  final SentenceStatus status;
  final void Function(int) onSlotTap;

  const _AnswerRow({
    required this.slots,
    required this.status,
    required this.onSlotTap,
  });

  Color get _borderColor => switch (status) {
    SentenceStatus.correct => const Color(0xFF1D9E75),
    SentenceStatus.wrong => const Color(0xFFE24B4A),
    _ => const Color(0xFF534AB7),
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List.generate(slots.length, (i) {
        final word = slots[i];
        final isEmpty = word == null;

        return GestureDetector(
          onTap: isEmpty ? null : () => onSlotTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            constraints: BoxConstraints(minWidth: isEmpty ? 44 : 0),
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isEmpty
                  ? Colors.grey.shade100
                  : status == SentenceStatus.correct
                  ? const Color(0xFFE1F5EE)
                  : status == SentenceStatus.wrong
                  ? const Color(0xFFFCEBEB)
                  : const Color(0xFFEEEDFE),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isEmpty ? Colors.grey.shade300 : _borderColor,
                width: isEmpty ? 1.5 : 2,
                style: isEmpty ? BorderStyle.solid : BorderStyle.solid,
              ),
            ),
            alignment: Alignment.center,
            child: isEmpty
                ? null
                : Text(
                    word,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: status == SentenceStatus.correct
                          ? const Color(0xFF085041)
                          : status == SentenceStatus.wrong
                          ? const Color(0xFF791F1F)
                          : const Color(0xFF26215C),
                    ),
                  ),
          ),
        );
      }),
    );
  }
}

// ─── Word chip trong pool ─────────────────────────────────────────────────

class _WordChip extends StatefulWidget {
  final String word;
  final VoidCallback onTap;
  const _WordChip({required this.word, required this.onTap});

  @override
  State<_WordChip> createState() => _WordChipState();
}

class _WordChipState extends State<_WordChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0DEFC), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF534AB7).withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            widget.word,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF26215C),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Wrong feedback ───────────────────────────────────────────────────────

class _WrongFeedback extends StatelessWidget {
  final int wrongAttempts;
  const _WrongFeedback({required this.wrongAttempts});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE24B4A).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Text('😅 ', style: TextStyle(fontSize: 14)),
          const Expanded(
            child: Text(
              'Thứ tự chưa đúng! Thử lại nhé.',
              style: TextStyle(fontSize: 13, color: Color(0xFF791F1F)),
            ),
          ),
          if (wrongAttempts >= 2)
            const Text(
              '💡 Xem dịch nghĩa',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF534AB7),
                decoration: TextDecoration.underline,
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Action button nhỏ ───────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
