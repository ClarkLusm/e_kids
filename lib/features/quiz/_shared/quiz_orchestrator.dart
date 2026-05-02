import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../memory_flip/presentation/providers/memory_flip_providers.dart';
import '../memory_flip/presentation/screens/memory_flip_screen.dart';

class QuizOrchestrator extends StatelessWidget {
  const QuizOrchestrator({
    super.key,
    required this.quizType,
    required this.lessonId,
    required this.quizId,
  });

  final String quizType;
  final String lessonId;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    final normalizedType = quizType.trim().toLowerCase();

    switch (normalizedType) {
      case 'memory_flip':
        return ProviderScope(
          overrides: [
            memoryFlipLessonIdProvider.overrideWithValue(lessonId),
            memoryFlipQuizIdProvider.overrideWithValue(quizId),
          ],
          child: const MemoryFlipScreen(),
        );
      default:
        return _UnsupportedQuizWidget(quizType: quizType);
    }
  }
}

class _UnsupportedQuizWidget extends StatelessWidget {
  const _UnsupportedQuizWidget({required this.quizType});

  final String quizType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('Quiz type "$quizType" chưa được implement.'),
      ),
    );
  }
}
