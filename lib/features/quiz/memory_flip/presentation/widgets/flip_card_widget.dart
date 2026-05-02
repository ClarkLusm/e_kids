import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/models/card_content.dart';
import '../../domain/models/card_state.dart';

class FlipCardWidget extends StatefulWidget {
  final CardState cardState;
  final Duration flipDuration;
  final VoidCallback? onTap;
  final bool showLabelOnBack;
  final bool highContrast;

  const FlipCardWidget({
    required this.cardState,
    required this.flipDuration,
    this.onTap,
    this.showLabelOnBack = true,
    this.highContrast = false,
    super.key,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.flipDuration);
    _anim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(FlipCardWidget old) {
    super.didUpdateWidget(old);
    final shouldShowFront = widget.cardState.isFaceUp;
    if (shouldShowFront) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMatched = widget.cardState.faceState == CardFaceState.matched;
    final isMismatch = widget.cardState.faceState == CardFaceState.mismatch;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (ctx, _) {
          final angle = _anim.value * pi;
          final showingFront = _anim.value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(showingFront ? pi - (angle - pi) : angle),
            child: AnimatedOpacity(
              opacity: isMatched ? 0.35 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: _CardContainer(
                isMatched: isMatched,
                isMismatch: isMismatch,
                highContrast: widget.highContrast,
                child: showingFront
                    ? _CardFront(content: widget.cardState.content)
                    : _CardBack(
                        showLabel: widget.showLabelOnBack,
                        isMatched: isMatched,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Container ────────────────────────────────────────────────────────────

class _CardContainer extends StatelessWidget {
  final Widget child;
  final bool isMatched;
  final bool isMismatch;
  final bool highContrast;

  const _CardContainer({
    required this.child,
    required this.isMatched,
    required this.isMismatch,
    required this.highContrast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color bg;
    Color border;
    double borderWidth;

    if (isMatched) {
      bg = Colors.grey.shade100;
      border = Colors.grey.shade300;
      borderWidth = 1;
    } else if (isMismatch) {
      bg = const Color(0xFFFCEBEB);
      border = const Color(0xFFE24B4A);
      borderWidth = highContrast ? 2.5 : 2;
    } else {
      bg = theme.colorScheme.surface;
      border = theme.colorScheme.outlineVariant.withOpacity(0.6);
      borderWidth = highContrast ? 2 : 1;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: borderWidth),
        boxShadow: isMatched
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(11), child: child),
    );
  }
}

// ─── Mặt trước — nội dung thẻ ────────────────────────────────────────────

class _CardFront extends StatelessWidget {
  final CardContent content;
  const _CardFront({required this.content});

  @override
  Widget build(BuildContext context) {
    return switch (content.type) {
      CardType.image => _ImageCard(imageUrl: content.imageUrl!),
      CardType.word => _WordCard(
        word: content.word!,
        translationVi: content.translationVi,
      ),
      CardType.audio => _AudioCard(audioUrl: content.audioUrl!),
      CardType.mixed => _MixedCard(
        word: content.word!,
        imageUrl: content.imageUrl!,
      ),
    };
  }
}

class _ImageCard extends StatelessWidget {
  final String imageUrl;
  const _ImageCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Dùng Image.asset cho mock, thay bằng CachedNetworkImage khi có CDN
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey.shade400,
          size: 28,
        ),
      ),
    );
  }
}

class _WordCard extends StatelessWidget {
  final String word;
  final String? translationVi;
  const _WordCard({required this.word, this.translationVi});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEDFE),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            word,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF26215C),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          if (translationVi != null) ...[
            const SizedBox(height: 4),
            Text(
              translationVi!,
              style: const TextStyle(fontSize: 11, color: Color(0xFF534AB7)),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _AudioCard extends StatelessWidget {
  final String audioUrl;
  const _AudioCard({required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6F1FB),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.volume_up_rounded,
              size: 32,
              color: Colors.blue.shade700,
            ),
            const SizedBox(height: 4),
            Text(
              'Nhấn để nghe',
              style: TextStyle(fontSize: 9, color: Colors.blue.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class _MixedCard extends StatelessWidget {
  final String word;
  final String imageUrl;
  const _MixedCard({required this.word, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade100,
              child: Icon(Icons.image, color: Colors.grey.shade400),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: const Color(0xFFEEEDFE),
          child: Text(
            word,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF26215C),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ─── Mặt sau — thẻ đang úp ────────────────────────────────────────────────

class _CardBack extends StatelessWidget {
  final bool showLabel;
  final bool isMatched;
  const _CardBack({required this.showLabel, required this.isMatched});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isMatched
            ? Colors.grey.shade100
            : theme.colorScheme.primaryContainer.withOpacity(0.25),
        borderRadius: BorderRadius.circular(11),
      ),
      child: showLabel && !isMatched
          ? Center(
              child: Icon(
                Icons.question_mark_rounded,
                color: theme.colorScheme.onSurface.withOpacity(0.25),
                size: 28,
              ),
            )
          : null,
    );
  }
}
