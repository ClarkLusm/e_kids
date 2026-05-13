import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ─── Topic ────────────────────────────────────────────────────────────────

class Topic extends Equatable {
  final String id;
  final String nameEn;
  final String nameVi;
  final String? iconUrl;
  final String? colorHex;
  final int sortOrder;
  final bool isActive;

  const Topic({
    required this.id,
    required this.nameEn,
    required this.nameVi,
    this.iconUrl,
    this.colorHex,
    this.sortOrder = 0,
    this.isActive = true,
  });

  factory Topic.fromJson(Map<String, dynamic> j) => Topic(
    id: j['id'] as String,
    nameEn: j['name_en'] as String,
    nameVi: j['name_vi'] as String,
    iconUrl: j['icon_url'] as String?,
    colorHex: j['color_hex'] as String?,
    sortOrder: j['sort_order'] as int? ?? 0,
    isActive: j['is_active'] as bool? ?? true,
  );

  Color get color {
    if (colorHex == null) return const Color(0xFFEEEDFE);
    final hex = colorHex!.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  List<Object?> get props => [
    id,
    nameEn,
    nameVi,
    iconUrl,
    colorHex,
    sortOrder,
    isActive,
  ];
}

// ─── Lesson ───────────────────────────────────────────────────────────────

class Lesson extends Equatable {
  final String id;
  final String topicId;
  final String titleEn;
  final String titleVi;
  final String? descriptionVi;
  final int level;
  final int sortOrder;
  final int minXpRequired;
  final bool isPublished;
  final String? thumbnailUrl;
  final int vocabularyCount;
  final int questionCount;
  final int xpReward;

  const Lesson({
    required this.id,
    required this.topicId,
    required this.titleEn,
    required this.titleVi,
    this.descriptionVi,
    this.level = 1,
    this.sortOrder = 0,
    this.minXpRequired = 0,
    this.isPublished = true,
    this.thumbnailUrl,
    this.vocabularyCount = 0,
    this.questionCount = 0,
    this.xpReward = 50,
  });

  factory Lesson.fromJson(Map<String, dynamic> j) => Lesson(
    id: j['id'] as String,
    topicId: j['topic_id'] as String,
    titleEn: j['title_en'] as String,
    titleVi: j['title_vi'] as String,
    descriptionVi: j['description_vi'] as String?,
    level: j['level'] as int? ?? 1,
    sortOrder: j['sort_order'] as int? ?? 0,
    minXpRequired: j['min_xp_required'] as int? ?? 0,
    isPublished: j['is_published'] as bool? ?? true,
    thumbnailUrl: j['thumbnail_url'] as String?,
    vocabularyCount: j['vocabulary_count'] as int? ?? 0,
    questionCount: j['question_count'] as int? ?? 0,
    xpReward: j['xp_reward'] as int? ?? 50,
  );

  @override
  List<Object?> get props => [id, topicId, titleEn, titleVi, level];
}

// ─── Vocabulary ───────────────────────────────────────────────────────────

class Vocabulary extends Equatable {
  final String id;
  final String lessonId;
  final String word;
  final String? phonetic;
  final String translationVi;
  final String? imageUrl;
  final String? audioUrl;
  final String? partOfSpeech;
  final bool isKeyWord;

  const Vocabulary({
    required this.id,
    required this.lessonId,
    required this.word,
    this.phonetic,
    required this.translationVi,
    this.imageUrl,
    this.audioUrl,
    this.partOfSpeech,
    this.isKeyWord = false,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> j) => Vocabulary(
    id: j['id'] as String,
    lessonId: j['lesson_id'] as String,
    word: j['word'] as String,
    phonetic: j['phonetic'] as String?,
    translationVi: j['translation_vi'] as String,
    imageUrl: j['image_url'] as String?,
    audioUrl: j['audio_url'] as String?,
    partOfSpeech: j['part_of_speech'] as String?,
    isKeyWord: j['is_key_word'] as bool? ?? false,
  );

  String get displayWord => word[0].toUpperCase() + word.substring(1);

  @override
  List<Object?> get props => [id, lessonId, word, translationVi, imageUrl];
}

// ─── LessonProgress ───────────────────────────────────────────────────────

enum LessonStatus { locked, unlocked, inProgress, completed, mastered }

class LessonProgress extends Equatable {
  final String lessonId;
  final LessonStatus status;
  final int stars; // 0–3
  final int bestScore; // 0–100
  final int attempts;
  final int totalXpEarned;

  const LessonProgress({
    required this.lessonId,
    this.status = LessonStatus.locked,
    this.stars = 0,
    this.bestScore = 0,
    this.attempts = 0,
    this.totalXpEarned = 0,
  });

  factory LessonProgress.fromJson(Map<String, dynamic> j) => LessonProgress(
    lessonId: j['lesson_id'] as String,
    status: LessonStatus.values.firstWhere(
      (s) => s.name == (j['status'] as String? ?? 'locked'),
      orElse: () => LessonStatus.locked,
    ),
    stars: j['stars'] as int? ?? 0,
    bestScore: j['best_score'] as int? ?? 0,
    attempts: j['attempts'] as int? ?? 0,
    totalXpEarned: j['total_xp_earned'] as int? ?? 0,
  );

  bool get isAccessible => status != LessonStatus.locked;

  bool get isDone =>
      status == LessonStatus.completed || status == LessonStatus.mastered;

  @override
  List<Object?> get props => [lessonId, status, stars, bestScore, attempts];
}
