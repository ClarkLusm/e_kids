import 'package:flutter/material.dart';
import '../fill_blank/presentation/screens/fill_blank_screen.dart';
import '../letter_scramble/presentation/screens/letter_scramble_screen.dart';
import '../listen_tap/presentation/screens/listen_tap_screen.dart';
import '../memory_flip/presentation/screens/memory_flip_screen.dart';
import '../picture_match/presentation/screens/picture_match_screen.dart';
import '../sort_bucket/presentation/screens/sort_bucket_screen.dart';
import '../speak_word/presentation/screens/speak_word_screen.dart';

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

  static QuizType fromString(String s) {
    return switch (s) {
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
}

/// Model tối giản đại diện cho 1 câu hỏi từ DB
class QuestionRef {
  final String id;
  final QuizType quizType;

  const QuestionRef({required this.id, required this.quizType});

  factory QuestionRef.fromRow(Map<String, dynamic> row) => QuestionRef(
    id: row['id'] as String,
    quizType: QuizType.fromString(row['quiz_type'] as String),
  );
}

/// Điểm duy nhất quyết định quiz_type nào → widget nào.
/// Thêm quiz type mới chỉ cần thêm 1 case vào switch.
class QuizOrchestrator extends StatelessWidget {
  final QuestionRef question;

  const QuizOrchestrator({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (question.quizType) {
      QuizType.memoryFlip => MemoryFlipScreen(questionId: question.id),

      // ── Implemented screens ──────────────────────────────────────
      QuizType.pictureMatch => PictureMatchScreen(questionId: question.id),

      // ── Placeholder screens ── sẽ implement ở các sprint tiếp theo
      QuizType.listenTap => ListenTapScreen(questionId: question.id),
      QuizType.letterScramble => LetterScrambleScreen(questionId: question.id),
      QuizType.fillBlank => FillBlankScreen(questionId: question.id),
      QuizType.speakWord => SpeakWordScreen(questionId: question.id),
      QuizType.sortBucket => SortBucketScreen(questionId: question.id),
      QuizType.wordPop => _PlaceholderScreen(
        label: 'Word Pop',
        questionId: question.id,
      ),
      QuizType.storyBuilder => _PlaceholderScreen(
        label: 'Story Builder',
        questionId: question.id,
      ),
    };
  }
}

/// Placeholder tạm thời cho các quiz chưa implement
class _PlaceholderScreen extends StatelessWidget {
  final String label;
  final String questionId;

  const _PlaceholderScreen({required this.label, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.construction_rounded,
              size: 48,
              color: Colors.grey,
            ),
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
}
