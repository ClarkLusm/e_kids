import 'package:flutter/material.dart';
import '../../domain/models/speak_word_state.dart';

/// Card hiển thị từ cần phát âm, ảnh minh hoạ, phonetic, và similarity meter.
class SpeakWordCardWidget extends StatelessWidget {
  final SpeakWordState gameState;
  final VoidCallback onPlayAudio;
  final VoidCallback onToggleTranslation;

  const SpeakWordCardWidget({
    required this.gameState,
    required this.onPlayAudio,
    required this.onToggleTranslation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gs = gameState;
    final content = gs.content;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ảnh
          if (content.imageUrl != null)
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    content.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFEEEDFE),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 42,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ),
                  // Gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Audio button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _AudioBtn(onTap: onPlayAudio),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Column(
              children: [
                // Tên từ lớn
                Text(
                  content.displayWord,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 1,
                  ),
                ),

                // Phonetic
                if (content.phonetic != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '/${content.phonetic}/',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF534AB7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],

                // Syllable breakdown (gợi ý)
                if (gs.showSyllableHint &&
                    content.syllableBreakdown.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  _SyllableHint(syllables: content.syllableBreakdown),
                ],

                // Dịch nghĩa
                if (gs.showTranslation && content.translationVi != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAEEDA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '🇻🇳 ${content.translationVi}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF412402),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ] else if (content.translationVi != null) ...[
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: onToggleTranslation,
                    child: Text(
                      'Xem nghĩa tiếng Việt',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],

                // Similarity meter (sau khi thử ít nhất 1 lần)
                if (gs.attempts.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _SimilarityMeter(
                    similarity: gs.bestSimilarity,
                    threshold: content.minSimilarityScore,
                    lastTranscript: gs.lastAttempt?.transcript,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Syllable hint ────────────────────────────────────────────────────────

class _SyllableHint extends StatelessWidget {
  final List<String> syllables;
  const _SyllableHint({required this.syllables});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lightbulb_outline_rounded,
          size: 14,
          color: Colors.amber.shade700,
        ),
        const SizedBox(width: 4),
        Text(
          syllables.join(' · '),
          style: TextStyle(
            fontSize: 14,
            color: Colors.amber.shade800,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// ─── Similarity meter ─────────────────────────────────────────────────────

class _SimilarityMeter extends StatelessWidget {
  final double similarity;
  final double threshold;
  final String? lastTranscript;

  const _SimilarityMeter({
    required this.similarity,
    required this.threshold,
    this.lastTranscript,
  });

  Color get _barColor {
    if (similarity >= threshold) return const Color(0xFF1D9E75);
    if (similarity >= threshold * 0.75) return const Color(0xFFEF9F27);
    return const Color(0xFFE24B4A);
  }

  @override
  Widget build(BuildContext context) {
    final pct = (similarity * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Độ chính xác: ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              '$pct%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _barColor,
              ),
            ),
            const Spacer(),
            if (lastTranscript != null)
              Flexible(
                child: Text(
                  '"$lastTranscript"',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        // Bar
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: similarity,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(_barColor),
              ),
            ),
            // Threshold marker
            Positioned(
              left: MediaQuery.of(context).size.width * threshold - 42,
              top: 0,
              child: Container(
                width: 2,
                height: 8,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          'Cần đạt tối thiểu ${(threshold * 100).round()}%',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
        ),
      ],
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
