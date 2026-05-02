import 'package:flutter/material.dart';
import '../../domain/models/fill_blank_state.dart';

/// Hiển thị câu tiếng Anh với ô trống (blank slot) ở giữa.
/// Ô trống thay đổi màu/nội dung theo [FillBlankSlotStatus].
class SentenceDisplayWidget extends StatelessWidget {
  final String beforeBlank;
  final String afterBlank;
  final String? filledWord;
  final FillBlankSlotStatus slotStatus;
  final bool showTranslation;
  final String? sentenceVi;
  final VoidCallback? onPlayAudio;

  const SentenceDisplayWidget({
    required this.beforeBlank,
    required this.afterBlank,
    this.filledWord,
    required this.slotStatus,
    this.showTranslation = false,
    this.sentenceVi,
    this.onPlayAudio,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Câu tiếng Anh + ô trống
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Hàng câu
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                runSpacing: 8,
                children: [
                  // Phần trước ___
                  if (beforeBlank.trim().isNotEmpty)
                    _SentenceText(text: beforeBlank.trim()),

                  // Ô trống
                  _BlankSlot(word: filledWord, status: slotStatus),

                  // Phần sau ___
                  if (afterBlank.trim().isNotEmpty)
                    _SentenceText(text: afterBlank.trim()),
                ],
              ),

              // Nút phát âm câu hoàn chỉnh
              if (onPlayAudio != null) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onPlayAudio,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.volume_up_outlined,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Nghe câu',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Dịch tiếng Việt (hint)
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: showTranslation && sentenceVi != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAEEDA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFEF9F27).withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🇻🇳 ', style: TextStyle(fontSize: 14)),
                        Flexible(
                          child: Text(
                            sentenceVi!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF412402),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─── Text thường trong câu ─────────────────────────────────────────────────

class _SentenceText extends StatelessWidget {
  final String text;
  const _SentenceText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A2E),
        height: 1.3,
      ),
    );
  }
}

// ─── Ô trống điền từ ──────────────────────────────────────────────────────

class _BlankSlot extends StatefulWidget {
  final String? word;
  final FillBlankSlotStatus status;
  const _BlankSlot({this.word, required this.status});

  @override
  State<_BlankSlot> createState() => _BlankSlotState();
}

class _BlankSlotState extends State<_BlankSlot>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bounceAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_BlankSlot old) {
    super.didUpdateWidget(old);
    // Bounce khi từ thay đổi
    if (widget.word != old.word && widget.word != null) {
      _bounceCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  Color get _bgColor => switch (widget.status) {
    FillBlankSlotStatus.empty => Colors.grey.shade100,
    FillBlankSlotStatus.selected => const Color(0xFFEEEDFE),
    FillBlankSlotStatus.correct => const Color(0xFFE1F5EE),
    FillBlankSlotStatus.wrong => const Color(0xFFFCEBEB),
    FillBlankSlotStatus.revealed => const Color(0xFFE1F5EE),
  };

  Color get _borderColor => switch (widget.status) {
    FillBlankSlotStatus.empty => Colors.grey.shade300,
    FillBlankSlotStatus.selected => const Color(0xFF534AB7),
    FillBlankSlotStatus.correct => const Color(0xFF1D9E75),
    FillBlankSlotStatus.wrong => const Color(0xFFE24B4A),
    FillBlankSlotStatus.revealed => const Color(0xFF1D9E75),
  };

  Color get _textColor => switch (widget.status) {
    FillBlankSlotStatus.empty => Colors.grey.shade400,
    FillBlankSlotStatus.selected => const Color(0xFF3C3489),
    FillBlankSlotStatus.correct => const Color(0xFF085041),
    FillBlankSlotStatus.wrong => const Color(0xFF791F1F),
    FillBlankSlotStatus.revealed => const Color(0xFF085041),
  };

  @override
  Widget build(BuildContext context) {
    final hasWord = widget.word != null;
    final minWidth = hasWord
        ? (widget.word!.length * 14.0).clamp(60.0, 160.0)
        : 80.0;

    return ScaleTransition(
      scale: _bounceAnim,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: BoxConstraints(minWidth: minWidth),
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _borderColor,
            width: hasWord ? 2 : 1.5,
            style: hasWord ? BorderStyle.solid : BorderStyle.solid,
          ),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            hasWord ? widget.word! : '_ _ _',
            key: ValueKey(widget.word),
            style: TextStyle(
              fontSize: 20,
              fontWeight: hasWord ? FontWeight.w700 : FontWeight.w400,
              color: _textColor,
              letterSpacing: hasWord ? 0.5 : 2,
            ),
          ),
        ),
      ),
    );
  }
}
