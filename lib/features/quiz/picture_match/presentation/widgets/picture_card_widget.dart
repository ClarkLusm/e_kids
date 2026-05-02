import 'package:flutter/material.dart';

/// Widget hiển thị hình ảnh câu hỏi + nút phát âm thanh.
class PictureCardWidget extends StatefulWidget {
  final String imageUrl;
  final String? translationVi;
  final bool showTranslation;
  final VoidCallback? onPlayAudio;

  const PictureCardWidget({
    required this.imageUrl,
    this.translationVi,
    this.showTranslation = false,
    this.onPlayAudio,
    super.key,
  });

  @override
  State<PictureCardWidget> createState() => _PictureCardWidgetState();
}

class _PictureCardWidgetState extends State<PictureCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleCtrl;
  late Animation<double> _rippleAnim;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rippleAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _rippleCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    super.dispose();
  }

  void _handlePlayAudio() {
    if (_isPlaying) return;
    setState(() => _isPlaying = true);
    _rippleCtrl.forward().then((_) => _rippleCtrl.reverse()).then((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
    widget.onPlayAudio?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _rippleAnim,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ── Ảnh ────────────────────────────────────────────────
              Positioned.fill(
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFEEEDFE),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Gradient overlay phía dưới ─────────────────────────
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.35),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // ── Nút phát âm ────────────────────────────────────────
              if (widget.onPlayAudio != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _handlePlayAudio,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _isPlaying
                            ? const Color(0xFF534AB7)
                            : Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying
                            ? Icons.volume_up_rounded
                            : Icons.volume_up_outlined,
                        size: 20,
                        color: _isPlaying
                            ? Colors.white
                            : const Color(0xFF534AB7),
                      ),
                    ),
                  ),
                ),

              // ── Dịch tiếng Việt (khi reveal) ──────────────────────
              if (widget.showTranslation && widget.translationVi != null)
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: AnimatedOpacity(
                    opacity: widget.showTranslation ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.translationVi!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
