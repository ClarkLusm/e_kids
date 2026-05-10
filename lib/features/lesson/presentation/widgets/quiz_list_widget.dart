import 'package:flutter/material.dart';
import '../../../quiz/_shared/question_ref.dart';

/// Thanh tiến độ hiển thị đã làm bao nhiêu quiz trong bài học.
class QuizRunnerProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final int earnedXp;

  const QuizRunnerProgressBar({
    required this.current,
    required this.total,
    required this.earnedXp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0.0 : current / total;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$current / $total câu hỏi',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF534AB7),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEDFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⚡ ', style: TextStyle(fontSize: 11)),
                    Text(
                      '+$earnedXp XP',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF534AB7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 7,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                pct == 1.0 ? const Color(0xFF1D9E75) : const Color(0xFF534AB7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Danh sách các quiz trong bài học — hiện trong LessonDetailScreen.
class QuizListWidget extends StatelessWidget {
  final List<QuestionRef> questions;
  final int currentIndex;

  const QuizListWidget({
    required this.questions,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Các bài tập trong bài học',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(questions.length, (i) {
          final q = questions[i];
          final isDone = i < currentIndex;
          final isActive = i == currentIndex;
          final isLocked = i > currentIndex;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFEEEDFE)
                  : isDone
                  ? const Color(0xFFE1F5EE)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive
                    ? const Color(0xFF534AB7)
                    : isDone
                    ? const Color(0xFF1D9E75)
                    : Colors.grey.shade200,
                width: isActive ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                // Icon trạng thái
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF534AB7)
                        : isDone
                        ? const Color(0xFF1D9E75)
                        : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: isDone
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : isActive
                      ? const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 18,
                        )
                      : Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade500,
                          ),
                        ),
                ),
                const SizedBox(width: 10),

                // Tên quiz
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${q.quizTypeIcon} ${q.quizTypeLabel}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isLocked
                              ? Colors.grey.shade400
                              : const Color(0xFF1A1A2E),
                        ),
                      ),
                      Text(
                        'Độ khó: ${'★' * q.difficulty}${'☆' * (5 - q.difficulty)}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // XP
                Text(
                  '+${q.xpReward} XP',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isLocked
                        ? Colors.grey.shade300
                        : const Color(0xFF534AB7),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
