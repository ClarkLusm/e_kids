import 'package:flutter/material.dart';
import '../fill_blank/presentation/screens/fill_blank_screen.dart';
import '../letter_scramble/presentation/screens/letter_scramble_screen.dart';
import '../listen_tap/presentation/screens/listen_tap_screen.dart';
import '../memory_flip/presentation/screens/memory_flip_screen.dart';
import '../picture_match/presentation/screens/picture_match_screen.dart';
import '../sort_bucket/presentation/screens/sort_bucket_screen.dart';
import '../speak_word/presentation/screens/speak_word_screen.dart';
import '../story_builder/presentation/screens/story_builder_screen.dart';
import '../word_pop/presentation/screens/word_pop_screen.dart';
import 'question_ref.dart';

/// Enum quiz type khớp với cột quiz_type trong DB

enum QuizType {
  pictureMatch,
  listenTap,
  letterScramble,
  fillBlank,
  speakWord,
  memoryFlip,
  sortBucket,
  wordPop,
  storyBuilder;

  static QuizType fromString(String s) => switch (s) {
    'picture_match' => QuizType.pictureMatch,
    'listen_tap' => QuizType.listenTap,
    'letter_scramble' => QuizType.letterScramble,
    'fill_blank' => QuizType.fillBlank,
    'speak_word' => QuizType.speakWord,
    'memory_flip' => QuizType.memoryFlip,
    'sort_bucket' => QuizType.sortBucket,
    'word_pop' => QuizType.wordPop,
    'story_builder' => QuizType.storyBuilder,
    _ => throw ArgumentError('QuizType không hợp lệ: $s'),
  };
}

// ─── QuizOrchestrator ─────────────────────────────────────────────────────

/// Điểm duy nhất quyết định quiz_type nào → widget nào.
/// [onNext] được gọi khi quiz hoàn thành để QuizRunner chuyển câu tiếp.
class QuizOrchestrator extends StatelessWidget {
  final QuestionRef question;

  /// Callback khi hoàn thành — QuizRunner dùng để next
  final ValueChanged<int>? onNext;

  const QuizOrchestrator({required this.question, this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (QuizType.fromString(question.quizType)) {
      QuizType.pictureMatch => PictureMatchScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.listenTap => ListenTapScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.letterScramble => LetterScrambleScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.fillBlank => FillBlankScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.speakWord => SpeakWordScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.memoryFlip => MemoryFlipScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.sortBucket => SortBucketScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.wordPop => WordPopScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
      QuizType.storyBuilder => StoryBuilderScreen(
        questionId: question.id,
        lessonId: question.lessonId,
        onNext: onNext,
      ),
    };
  }
}

/// Placeholder cho quiz type chưa implement
class _PlaceholderScreen extends StatelessWidget {
  final String label;
  final String questionId;
  const _PlaceholderScreen({required this.label, required this.questionId});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(label)),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.construction_rounded, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(
            '$label\nĐang phát triển...',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'ID: $questionId',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}
