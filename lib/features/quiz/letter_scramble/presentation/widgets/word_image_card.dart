import 'package:flutter/material.dart';

/// Card ảnh minh hoạ kèm phonetic và nút phát âm.
/// Dùng kích thước compact vì phần chính là ô chữ.
class WordImageCard extends StatelessWidget {
  final String? imageUrl;
  final String? phonetic;
  final String? translationVi;
  final bool showTranslation;
  final VoidCallback? onPlayAudio;

  const WordImageCard({
    this.imageUrl,
    this.phonetic,
    this.translationVi,
    this.showTranslation = false,
    this.onPlayAudio,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ảnh
          if (imageUrl != null)
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFEEEDFE),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.25),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Nút phát âm
                  if (onPlayAudio != null)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _AudioButton(onTap: onPlayAudio!),
                    ),
                ],
              ),
            ),

          // Phonetic + dịch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (phonetic != null) ...[
                  Text(
                    '/$phonetic/',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF534AB7),
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
                if (phonetic != null &&
                    showTranslation &&
                    translationVi != null)
                  const Text(' · ', style: TextStyle(color: Colors.grey)),
                if (showTranslation && translationVi != null)
                  Text(
                    translationVi!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF633806),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AudioButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AudioButton({required this.onTap});

  @override
  State<_AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<_AudioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = Tween(
      begin: 1.0,
      end: 1.12,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_playing) return;
    setState(() => _playing = true);
    _ctrl.forward().then((_) => _ctrl.reverse()).then((_) {
      if (mounted) setState(() => _playing = false);
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _playing
                ? const Color(0xFF534AB7)
                : Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6),
            ],
          ),
          child: Icon(
            _playing ? Icons.volume_up_rounded : Icons.volume_up_outlined,
            size: 18,
            color: _playing ? Colors.white : const Color(0xFF534AB7),
          ),
        ),
      ),
    );
  }
}
