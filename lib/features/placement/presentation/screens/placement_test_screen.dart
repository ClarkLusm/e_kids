import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/placement/presentation/providers/placement_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlacementTestScreen extends ConsumerStatefulWidget {
  const PlacementTestScreen({super.key});

  @override
  ConsumerState<PlacementTestScreen> createState() =>
      _PlacementTestScreenState();
}

class _PlacementTestScreenState extends ConsumerState<PlacementTestScreen> {
  final Map<String, int> _selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(placementActionControllerProvider);
    final answeredCount = _selectedAnswers.length;
    final canSubmit =
        answeredCount == _questions.length && !actionState.isLoading;

    ref.listen(placementActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Khảo sát lộ trình')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              '$answeredCount/${_questions.length} câu đã trả lời',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: answeredCount / _questions.length),
            const SizedBox(height: 20),
            ..._questions.map(_buildQuestionCard),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: canSubmit ? _submit : null,
              child: actionState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Hoàn tất khảo sát'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(_PlacementQuestion question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.prompt,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ...List.generate(question.options.length, (index) {
              final selected = _selectedAnswers[question.id] == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAnswers[question.id] = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(question.options[index]),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final answers = _questions.map((question) {
      final selectedIndex = _selectedAnswers[question.id]!;
      return {
        'question_id': question.id,
        'selected_index': selectedIndex,
        'is_correct': selectedIndex == question.correctIndex,
      };
    }).toList();

    final score = answers
        .where((answer) => answer['is_correct'] == true)
        .length;

    try {
      final result = await ref
          .read(placementActionControllerProvider.notifier)
          .completePlacement(
            score: score,
            maxScore: _questions.length,
            answers: answers,
          );

      if (mounted) {
        context.go(Routes.placementResult, extra: result);
      }
    } catch (_) {
      // Error is shown by ref.listen above.
    }
  }
}

class _PlacementQuestion {
  const _PlacementQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
}

const _questions = [
  _PlacementQuestion(
    id: 'cat_vi',
    prompt: 'Cat là con gì?',
    options: ['Con chó', 'Con mèo', 'Con chim'],
    correctIndex: 1,
  ),
  _PlacementQuestion(
    id: 'blue_color',
    prompt: 'Blue là màu nào?',
    options: ['Màu xanh dương', 'Màu đỏ', 'Màu vàng'],
    correctIndex: 0,
  ),
  _PlacementQuestion(
    id: 'apple_vi',
    prompt: 'Apple nghĩa là gì?',
    options: ['Quả táo', 'Cái bàn', 'Con cá'],
    correctIndex: 0,
  ),
  _PlacementQuestion(
    id: 'hello_usage',
    prompt: 'Khi gặp bạn, bé có thể nói gì?',
    options: ['Goodbye', 'Hello', 'Sleep'],
    correctIndex: 1,
  ),
  _PlacementQuestion(
    id: 'two_number',
    prompt: 'Two là số mấy?',
    options: ['1', '2', '3'],
    correctIndex: 1,
  ),
];
