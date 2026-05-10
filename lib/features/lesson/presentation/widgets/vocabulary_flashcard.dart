import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/models/lesson_models.dart';

/// Flashcard flip 3D giới thiệu từ vựng trước khi vào quiz.
/// Mặt trước: ảnh + từ. Mặt sau: dịch nghĩa + phonetic.
class VocabularyFlashcard extends StatefulWidget {
  final Vocabulary vocab;
  final VoidCallback? onPlayAudio;

  const VocabularyFlashcard({required this.vocab, this.onPlayAudio, super.key});

  @override
  State<VocabularyFlashcard> createState() => _VocabularyFlashcardState();
}

class _VocabularyFlashcardState extends State<VocabularyFlashcard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _anim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _flip() {
    if (_showFront) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
    setState(() => _showFront = !_showFront);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (ctx, _) {
          final angle = _anim.value * pi;
          final showFront = _anim.value <= 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(showFront ? angle : pi - angle),
            child: showFront
                ? _FrontFace(
                    vocab: widget.vocab,
                    onPlayAudio: widget.onPlayAudio,
                  )
                : _BackFace(vocab: widget.vocab),
          );
        },
      ),
    );
  }
}

// ─── Mặt trước ────────────────────────────────────────────────────────────

class _FrontFace extends StatelessWidget {
  final Vocabulary vocab;
  final VoidCallback? onPlayAudio;

  const _FrontFace({required this.vocab, this.onPlayAudio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ảnh
          if (vocab.imageUrl != null)
            Stack(
              children: [
                Image.asset(
                  vocab.imageUrl!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: const Color(0xFFEEEDFE),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 42,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ),
                ),
                // Audio button
                if (onPlayAudio != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _AudioBtn(onTap: onPlayAudio!),
                  ),
                // Key word badge
                if (vocab.isKeyWord)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF534AB7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '⭐ Từ khóa',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

          // Word + part of speech
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              children: [
                Text(
                  vocab.displayWord,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 0.5,
                  ),
                ),
                if (vocab.partOfSpeech != null) ...[
                  const SizedBox(height: 4),
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
                      vocab.partOfSpeech!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF534AB7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  'Nhấn để xem nghĩa →',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontStyle: FontStyle.italic,
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

// ─── Mặt sau ──────────────────────────────────────────────────────────────

class _BackFace extends StatelessWidget {
  final Vocabulary vocab;

  const _BackFace({required this.vocab});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF534AB7), Color(0xFF7F77DD)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF534AB7).withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Từ nhỏ hơn ở trên
            Text(
              vocab.displayWord,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),

            // Phonetic
            if (vocab.phonetic != null) ...[
              const SizedBox(height: 6),
              Text(
                '/${vocab.phonetic}/',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Dịch nghĩa lớn
            Text(
              vocab.translationVi,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Hint
            Text(
              '← Nhấn để lật lại',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Audio button ─────────────────────────────────────────────────────────

class _AudioBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _AudioBtn({required this.onTap});

  @override
  State<_AudioBtn> createState() => _AudioBtnState();
}

class _AudioBtnState extends State<_AudioBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _tap() {
    if (_playing) return;
    setState(() => _playing = true);
    _ctrl.forward().then((_) => _ctrl.reverse()).then((_) {
      if (mounted) setState(() => _playing = false);
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _playing
              ? const Color(0xFF534AB7)
              : Colors.white.withOpacity(0.88),
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
    );
  }
}
