import 'package:equatable/equatable.dart';

/// Một câu trong story_builder — cần sắp xếp thứ tự từ đúng.
class StorySentence extends Equatable {
  final int order;
  final List<String> correctSequence;
  final List<String> shuffledWords;
  final String? imageUrl;
  final String? audioUrl;
  final String? translationVi;

  const StorySentence({
    required this.order,
    required this.correctSequence,
    required this.shuffledWords,
    this.imageUrl,
    this.audioUrl,
    this.translationVi,
  });

  factory StorySentence.fromJson(Map<String, dynamic> json) {
    return StorySentence(
      order: json['order'] as int,
      correctSequence: List<String>.from(json['correct_sequence'] as List),
      shuffledWords: List<String>.from(json['shuffled_words'] as List),
      imageUrl: json['image_url'] as String?,
      audioUrl: json['audio_url'] as String?,
      translationVi: json['translation_vi'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'order': order,
    'correct_sequence': correctSequence,
    'shuffled_words': shuffledWords,
    if (imageUrl != null) 'image_url': imageUrl,
    if (audioUrl != null) 'audio_url': audioUrl,
    if (translationVi != null) 'translation_vi': translationVi,
  };

  String get correctSentence => correctSequence.join(' ');

  @override
  List<Object?> get props => [
    order,
    correctSequence,
    shuffledWords,
    imageUrl,
    audioUrl,
    translationVi,
  ];
}

/// Model cho quiz story_builder — sắp xếp từ thành câu hoàn chỉnh.
///
/// JSON mẫu:
/// ```json
/// {
///   "sentences": [
///     {
///       "order": 1,
///       "correct_sequence": ["The", "cat", "is", "sleeping"],
///       "shuffled_words": ["sleeping", "The", "is", "cat"],
///       "image_url": "cdn/img/sleeping_cat.webp",
///       "audio_url": "cdn/audio/the_cat_is_sleeping.mp3",
///       "translation_vi": "Con mèo đang ngủ."
///     }
///   ],
///   "story_image_url": "cdn/img/story_cover.webp",
///   "story_title_vi": "Chú mèo lười biếng",
///   "allow_audio_hint": true
/// }
/// ```
class StoryBuilderContent extends Equatable {
  final List<StorySentence> sentences;
  final String? storyImageUrl;
  final String? storyTitleVi;
  final bool allowAudioHint;

  const StoryBuilderContent({
    required this.sentences,
    this.storyImageUrl,
    this.storyTitleVi,
    this.allowAudioHint = true,
  }) : assert(
         sentences.length >= 1 && sentences.length <= 5,
         'Số câu phải từ 1–5',
       );

  factory StoryBuilderContent.fromJson(Map<String, dynamic> json) {
    final sentences =
        (json['sentences'] as List)
            .map((s) => StorySentence.fromJson(s as Map<String, dynamic>))
            .toList()
          ..sort((a, b) => a.order.compareTo(b.order));

    return StoryBuilderContent(
      sentences: sentences,
      storyImageUrl: json['story_image_url'] as String?,
      storyTitleVi: json['story_title_vi'] as String?,
      allowAudioHint: json['allow_audio_hint'] as bool? ?? true,
    );
  }

  static StoryBuilderContent fromQuestion(Map<String, dynamic> q) {
    assert(q['quiz_type'] == 'story_builder');
    return StoryBuilderContent.fromJson(
      q['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'sentences': sentences.map((s) => s.toJson()).toList(),
    if (storyImageUrl != null) 'story_image_url': storyImageUrl,
    if (storyTitleVi != null) 'story_title_vi': storyTitleVi,
    'allow_audio_hint': allowAudioHint,
  };

  @override
  List<Object?> get props => [
    sentences,
    storyImageUrl,
    storyTitleVi,
    allowAudioHint,
  ];
}
