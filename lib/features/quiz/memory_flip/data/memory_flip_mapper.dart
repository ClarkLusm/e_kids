import '../domain/models/memory_flip_content.dart';

class MemoryFlipMapper {
  const MemoryFlipMapper();

  MemoryFlipContent fromQuizRow(Map<String, dynamic> row) {
    final rawContent = row['content_json'];
    final contentJson = rawContent is Map<String, dynamic>
        ? rawContent
        : <String, dynamic>{};

    return MemoryFlipContent.fromJson({
      ...contentJson,
      'quiz_id': row['id'] ?? contentJson['quiz_id'],
    });
  }

  Map<String, dynamic> toAttemptRow({
    required String lessonId,
    required String quizId,
    required int score,
    required int flipCount,
    required int hintsUsed,
    required bool completed,
  }) {
    return {
      'lesson_id': lessonId,
      'quiz_id': quizId,
      'score': score,
      'meta': {
        'flip_count': flipCount,
        'hints_used': hintsUsed,
        'completed': completed,
      },
    };
  }
}
