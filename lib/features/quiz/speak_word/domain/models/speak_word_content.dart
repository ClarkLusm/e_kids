import 'package:equatable/equatable.dart';

/// Model cho quiz speak_word — đọc to từ, nhận diện giọng nói.
///
/// JSON mẫu:
/// ```json
/// {
///   "target_word": "butterfly",
///   "image_url": "cdn/img/butterfly.webp",
///   "reference_audio_url": "cdn/audio/butterfly_native.mp3",
///   "phonetic": "ˈbʌt.ə.flaɪ",
///   "translation_vi": "con bướm",
///   "accepted_variants": ["butterfly", "butterflay"],
///   "min_similarity_score": 0.70,
///   "max_attempts": 3,
///   "syllable_breakdown": ["but", "ter", "fly"]
/// }
/// ```
class SpeakWordContent extends Equatable {
  /// Từ cần phát âm (lowercase)
  final String targetWord;

  /// Ảnh minh hoạ
  final String? imageUrl;

  /// Audio giọng bản ngữ để trẻ nghe mẫu
  final String? referenceAudioUrl;

  /// Phiên âm IPA
  final String? phonetic;

  /// Nghĩa tiếng Việt
  final String? translationVi;

  /// Các biến thể phát âm được chấp nhận (bao gồm lỗi phổ biến của trẻ VN)
  final List<String> acceptedVariants;

  /// Ngưỡng similarity tối thiểu (0.0–1.0)
  final double minSimilarityScore;

  /// Số lần thử tối đa
  final int maxAttempts;

  /// Breakdown từng âm tiết — hiện làm gợi ý khi sai 2 lần liên tiếp
  final List<String> syllableBreakdown;

  const SpeakWordContent({
    required this.targetWord,
    this.imageUrl,
    this.referenceAudioUrl,
    this.phonetic,
    this.translationVi,
    required this.acceptedVariants,
    this.minSimilarityScore = 0.70,
    this.maxAttempts = 3,
    this.syllableBreakdown = const [],
  }) : assert(
         minSimilarityScore >= 0.0 && minSimilarityScore <= 1.0,
         'minSimilarityScore phải từ 0.0–1.0',
       );

  factory SpeakWordContent.fromJson(Map<String, dynamic> json) {
    final variants = List<String>.from(
      (json['accepted_variants'] as List).map((e) => e.toString()),
    );
    final syllables = List<String>.from(
      (json['syllable_breakdown'] as List? ?? []).map((e) => e.toString()),
    );

    return SpeakWordContent(
      targetWord: (json['target_word'] as String).toLowerCase(),
      imageUrl: json['image_url'] as String?,
      referenceAudioUrl: json['reference_audio_url'] as String?,
      phonetic: json['phonetic'] as String?,
      translationVi: json['translation_vi'] as String?,
      acceptedVariants: variants,
      minSimilarityScore:
          (json['min_similarity_score'] as num?)?.toDouble() ?? 0.70,
      maxAttempts: json['max_attempts'] as int? ?? 3,
      syllableBreakdown: syllables,
    );
  }

  static SpeakWordContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'speak_word');
    return SpeakWordContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'target_word': targetWord,
    if (imageUrl != null) 'image_url': imageUrl,
    if (referenceAudioUrl != null) 'reference_audio_url': referenceAudioUrl,
    if (phonetic != null) 'phonetic': phonetic,
    if (translationVi != null) 'translation_vi': translationVi,
    'accepted_variants': acceptedVariants,
    'min_similarity_score': minSimilarityScore,
    'max_attempts': maxAttempts,
    'syllable_breakdown': syllableBreakdown,
  };

  /// Hiển thị từ dạng title-case cho UI
  String get displayWord =>
      targetWord[0].toUpperCase() + targetWord.substring(1);

  /// Breakdown hiển thị dạng "but · ter · fly"
  String get syllableDisplay => syllableBreakdown.join(' · ');

  @override
  List<Object?> get props => [
    targetWord,
    imageUrl,
    referenceAudioUrl,
    phonetic,
    translationVi,
    acceptedVariants,
    minSimilarityScore,
    maxAttempts,
    syllableBreakdown,
  ];
}
