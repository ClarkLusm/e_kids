import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/lesson_models.dart';
import '../../presentation/providers/lesson_providers.dart';
import '../../presentation/widgets/vocabulary_flashcard.dart';

/// Màn hình giới thiệu từ vựng — lướt qua các flashcard trước khi bắt đầu quiz.
class VocabularyIntroScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final VoidCallback onStartQuiz;

  const VocabularyIntroScreen({
    required this.lessonId,
    required this.onStartQuiz,
    super.key,
  });

  @override
  ConsumerState<VocabularyIntroScreen> createState() =>
      _VocabularyIntroScreenState();
}

class _VocabularyIntroScreenState extends ConsumerState<VocabularyIntroScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _nextPage(int total) {
    if (_currentPage < total - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageCtrl.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(lessonDetailProvider(widget.lessonId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Từ vựng bài học',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: true,
      ),
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF534AB7)),
        ),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (detail) {
          final vocab = detail.vocabulary;
          if (vocab.isEmpty) {
            return _EmptyVocab(onStartQuiz: widget.onStartQuiz);
          }
          return _buildContent(context, vocab, detail.lesson);
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Vocabulary> vocab,
    Lesson lesson,
  ) {
    final total = vocab.length;
    final isLast = _currentPage == total - 1;

    return SafeArea(
      child: Column(
        children: [
          // Progress dots
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(total, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _currentPage ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _currentPage
                            ? const Color(0xFF534AB7)
                            : i < _currentPage
                            ? const Color(0xFF1D9E75)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_currentPage + 1} / $total từ',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          // Flashcard PageView
          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: total,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: VocabularyFlashcard(
                    vocab: vocab[i],
                    onPlayAudio: vocab[i].audioUrl != null
                        ? () {
                            // TODO: inject AudioService
                          }
                        : null,
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Row(
              children: [
                // Prev
                if (_currentPage > 0)
                  IconButton(
                    onPressed: _prevPage,
                    icon: const Icon(Icons.chevron_left_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.grey.shade700,
                    ),
                  )
                else
                  const SizedBox(width: 48),

                const SizedBox(width: 10),

                // Tiếp / Bắt đầu
                Expanded(
                  child: isLast
                      ? FilledButton.icon(
                          onPressed: widget.onStartQuiz,
                          icon: const Icon(Icons.play_arrow_rounded, size: 20),
                          label: const Text(
                            'Bắt đầu làm bài!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF534AB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        )
                      : FilledButton.icon(
                          onPressed: () => _nextPage(total),
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                          ),
                          label: const Text('Từ tiếp theo'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF534AB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                ),

                const SizedBox(width: 10),

                // Skip tất cả
                if (!isLast)
                  TextButton(
                    onPressed: widget.onStartQuiz,
                    child: Text(
                      'Bỏ qua',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyVocab extends StatelessWidget {
  final VoidCallback onStartQuiz;
  const _EmptyVocab({required this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.book_outlined, size: 48, color: Color(0xFF534AB7)),
            const SizedBox(height: 16),
            const Text(
              'Bài học này không có từ vựng riêng.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onStartQuiz,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF534AB7),
              ),
              child: const Text('Bắt đầu làm bài!'),
            ),
          ],
        ),
      ),
    );
  }
}
