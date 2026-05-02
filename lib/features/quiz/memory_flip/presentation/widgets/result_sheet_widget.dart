import 'package:flutter/material.dart';

import '../../../_shared/quiz_result_sheet.dart';

class ResultSheetWidget extends StatelessWidget {
  const ResultSheetWidget({
    super.key,
    required this.score,
    required this.flipCount,
    required this.hintsUsed,
    required this.onPrimaryTap,
  });

  final int score;
  final int flipCount;
  final int hintsUsed;
  final VoidCallback onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    return QuizResultSheet(
      title: 'Hoàn thành Memory Flip',
      score: score,
      subtitle: 'Con đã ghép xong các cặp thẻ.',
      primaryLabel: 'Tiếp tục',
      onPrimaryTap: onPrimaryTap,
      metrics: ['Số lần lật: $flipCount', 'Số hint đã dùng: $hintsUsed'],
    );
  }
}
