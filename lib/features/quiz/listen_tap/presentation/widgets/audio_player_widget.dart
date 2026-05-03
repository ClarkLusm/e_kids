import 'package:flutter/material.dart';
import '../../domain/models/listen_tap_state.dart';

/// Nút phát audio lớn ở trung tâm màn hình.
/// Hiện animation sóng âm khi đang phát, badge replay limit.
class AudioPlayerWidget extends StatefulWidget {
  final ListenTapStatus status;
  final int replaysRemaining;
  final int replayLimit;
  final VoidCallback onPlay;

  const AudioPlayerWidget({
    required this.status,
    required this.replaysRemaining,
    required this.replayLimit,
    required this.onPlay,
    super.key,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
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
      duration: const Duration(milliseconds: 900),
    );
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 3 vòng sóng với delay khác nhau
    _waveAnims = List.generate(3, (i) {
      final start = i * 0.2;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _waveCtrl,
          curve: Interval(
            start,
            (start + 0.6).clamp(0, 1),
            curve: Curves.easeOut,
          ),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(AudioPlayerWidget old) {
    super.didUpdateWidget(old);
    _syncAnimation();
  }

  void _syncAnimation() {
    final isPlaying = widget.status == ListenTapStatus.playing;
    final isWaiting = widget.status == ListenTapStatus.waitingToPlay;

    if (isPlaying) {
      _waveCtrl.repeat();
      _pulseCtrl.repeat(reverse: true);
    } else {
      _waveCtrl.stop();
      _pulseCtrl.stop();

      if (isWaiting) {
        // Gentle pulse khi chờ tap
        _pulseCtrl.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _waveCtrl.dispose();
    super.dispose();
  }

  bool get _canTap =>
      widget.status == ListenTapStatus.waitingToPlay ||
      widget.status == ListenTapStatus.idle;

  Color get _buttonColor {
    if (!_canTap && widget.status != ListenTapStatus.playing) {
      return Colors.grey.shade300;
    }
    return const Color(0xFF534AB7);
  }

  @override
  Widget build(BuildContext context) {
    _syncAnimation();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sóng âm + nút
        SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Vòng sóng lan toả (3 vòng)
              ...List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: _waveAnims[i],
                  builder: (ctx, _) {
                    final progress = _waveAnims[i].value;
                    final size = 80.0 + progress * 55.0;
                    final opacity = (1 - progress) * 0.5;
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF534AB7).withOpacity(opacity),
                          width: 2,
                        ),
                      ),
                    );
                  },
                );
              }),

              // Nút chính
              ScaleTransition(
                scale: _pulseAnim,
                child: GestureDetector(
                  onTap: _canTap ? widget.onPlay : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _buttonColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF534AB7).withOpacity(
                            widget.status == ListenTapStatus.playing
                                ? 0.45
                                : 0.25,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.status == ListenTapStatus.playing
                          ? Icons.volume_up_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Status text + replay badge
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: widget.status == ListenTapStatus.waitingToPlay
              ? _StatusLabel(
                  text: 'Nhấn để nghe',
                  key: const ValueKey('waiting'),
                  color: const Color(0xFF534AB7),
                  bold: true,
                )
              : widget.status == ListenTapStatus.playing
              ? _StatusLabel(
                  text: 'Đang phát...',
                  key: const ValueKey('playing'),
                  color: const Color(0xFF534AB7),
                )
              : widget.replaysRemaining > 0
              ? _StatusLabel(
                  text: 'Nghe lại (còn ${widget.replaysRemaining})',
                  key: const ValueKey('replay'),
                  color: Colors.grey,
                )
              : _StatusLabel(
                  text: 'Hết lượt nghe lại',
                  key: const ValueKey('no_replay'),
                  color: Colors.grey.shade400,
                ),
        ),
      ],
    );
  }
}

class _StatusLabel extends StatelessWidget {
  final String text;
  final Color color;
  final bool bold;

  const _StatusLabel({
    required this.text,
    required this.color,
    this.bold = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: color,
        fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
