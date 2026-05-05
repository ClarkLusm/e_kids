import 'package:flutter/material.dart';
import '../../domain/models/speak_word_state.dart';

/// Nút mic trung tâm với animation.
/// Pulse khi idle, sóng âm khi listening, spinner khi processing.
class MicButtonWidget extends StatefulWidget {
  final SpeakWordStatus status;
  final int attemptsRemaining;
  final int maxAttempts;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const MicButtonWidget({
    required this.status,
    required this.attemptsRemaining,
    required this.maxAttempts,
    required this.onStart,
    required this.onStop,
    super.key,
  });

  @override
  State<MicButtonWidget> createState() => _MicButtonWidgetState();
}

class _MicButtonWidgetState extends State<MicButtonWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _waveCtrl;
  late Animation<double> _pulseAnim;
  late List<Animation<double>> _waveAnims;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _waveAnims = List.generate(3, (i) {
      final start = i * 0.18;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _waveCtrl,
          curve: Interval(
            start,
            (start + 0.65).clamp(0, 1),
            curve: Curves.easeOut,
          ),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(MicButtonWidget old) {
    super.didUpdateWidget(old);
    _syncAnimations();
  }

  void _syncAnimations() {
    switch (widget.status) {
      case SpeakWordStatus.idle:
      case SpeakWordStatus.wrong:
        _waveCtrl.stop();
        _pulseCtrl.repeat(reverse: true);
      case SpeakWordStatus.listening:
        _pulseCtrl.stop();
        _waveCtrl.repeat();
      default:
        _pulseCtrl.stop();
        _waveCtrl.stop();
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _waveCtrl.dispose();
    super.dispose();
  }

  bool get _isListening => widget.status == SpeakWordStatus.listening;
  bool get _isProcessing => widget.status == SpeakWordStatus.processing;
  bool get _canTap =>
      widget.status == SpeakWordStatus.idle ||
      widget.status == SpeakWordStatus.wrong ||
      widget.status == SpeakWordStatus.listening;

  Color get _btnColor {
    if (_isListening) return const Color(0xFFE24B4A);
    if (!_canTap) return Colors.grey.shade300;
    return const Color(0xFF534AB7);
  }

  Color get _waveColor =>
      _isListening ? const Color(0xFFE24B4A) : const Color(0xFF534AB7);

  @override
  Widget build(BuildContext context) {
    _syncAnimations();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Sóng âm khi đang nghe
              ...List.generate(
                3,
                (i) => AnimatedBuilder(
                  animation: _waveAnims[i],
                  builder: (_, __) {
                    final p = _waveAnims[i].value;
                    return Container(
                      width: 88.0 + p * 58.0,
                      height: 88.0 + p * 58.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _waveColor.withOpacity((1 - p) * 0.55),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Nút mic chính
              ScaleTransition(
                scale: _pulseAnim,
                child: GestureDetector(
                  onTap: _canTap
                      ? (_isListening ? widget.onStop : widget.onStart)
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: _btnColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _btnColor.withOpacity(
                            _isListening ? 0.5 : 0.3,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: _isProcessing
                        ? const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Icon(
                            _isListening
                                ? Icons.stop_rounded
                                : Icons.mic_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Status text
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            _statusText,
            key: ValueKey(widget.status),
            style: TextStyle(
              fontSize: 13,
              color: _statusColor,
              fontWeight: _isListening ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Attempt counter dots
        if (!widget.status.isAnswered)
          _AttemptDots(
            used: widget.maxAttempts - widget.attemptsRemaining,
            total: widget.maxAttempts,
          ),
      ],
    );
  }

  String get _statusText => switch (widget.status) {
    SpeakWordStatus.idle => 'Nhấn mic để nói',
    SpeakWordStatus.listening => '🎙 Đang nghe...',
    SpeakWordStatus.processing => 'Đang nhận diện...',
    SpeakWordStatus.wrong => 'Thử lại nào!',
    SpeakWordStatus.correct => 'Phát âm đúng! 🎉',
    SpeakWordStatus.maxReached => 'Hết lượt thử',
    SpeakWordStatus.revealed => 'Hãy luyện thêm nhé!',
  };

  Color get _statusColor => switch (widget.status) {
    SpeakWordStatus.correct => const Color(0xFF085041),
    SpeakWordStatus.listening => const Color(0xFFE24B4A),
    SpeakWordStatus.wrong => const Color(0xFF791F1F),
    SpeakWordStatus.maxReached => Colors.grey,
    _ => const Color(0xFF534AB7),
  };
}

// ─── Attempt dots indicator ───────────────────────────────────────────────

class _AttemptDots extends StatelessWidget {
  final int used;
  final int total;
  const _AttemptDots({required this.used, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isUsed = i < used;
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUsed ? const Color(0xFFE24B4A) : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}

extension on SpeakWordStatus {
  bool get isAnswered =>
      this == SpeakWordStatus.correct ||
      this == SpeakWordStatus.maxReached ||
      this == SpeakWordStatus.revealed;
}
