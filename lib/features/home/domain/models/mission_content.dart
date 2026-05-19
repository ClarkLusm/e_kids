class MissionContent {
  const MissionContent({
    required this.missionId,
    required this.activityType,
    required this.summaryLines,
    required this.warmUpWords,
    required this.quizQuestions,
    required this.hasAuthoredContent,
  });

  final String missionId;
  final String activityType;
  final List<String> summaryLines;
  final List<MissionVocabularyItem> warmUpWords;
  final List<MissionQuizQuestion> quizQuestions;
  final bool hasAuthoredContent;

  bool get hasWarmUpWords => warmUpWords.isNotEmpty;
}

class MissionVocabularyItem {
  const MissionVocabularyItem({
    required this.id,
    required this.word,
    required this.translationVi,
    required this.phonetic,
    required this.imageUrl,
    required this.audioUrl,
  });

  final String id;
  final String word;
  final String translationVi;
  final String? phonetic;
  final String? imageUrl;
  final String? audioUrl;

  String get displayEmoji {
    final key = word.toLowerCase();
    if (key.contains('lion')) return '🦁';
    if (key.contains('elephant')) return '🐘';
    if (key.contains('monkey')) return '🐵';
    if (key.contains('cat')) return '🐱';
    if (key.contains('dog')) return '🐶';
    if (key.contains('apple')) return '🍎';
    return '⭐';
  }
}

class MissionQuizQuestion {
  const MissionQuizQuestion({
    required this.id,
    required this.lessonId,
    required this.quizType,
    required this.prompt,
    required this.contentJson,
    required this.xpReward,
  });

  final String id;
  final String lessonId;
  final String quizType;
  final String? prompt;
  final String contentJson;
  final int xpReward;
}
