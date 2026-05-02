import 'package:equatable/equatable.dart';

/// Đại diện cho 1 câu fill-in-the-blank từ DB.
///
/// JSON mẫu:
/// ```json
/// {
///   "sentence": "The ___ is sleeping.",
///   "sentence_vi": "Con ___ đang ngủ.",
///   "image_url": "cdn/img/sleeping_cat.webp",
///   "audio_sentence_url": "cdn/audio/the_cat_is_sleeping.mp3",
///   "correct_answer": "cat",
///   "choices": ["cat", "dog", "bird"],
///   "blank_index": 1,
///   "show_translation_hint": true
/// }
/// ```
class FillBlankContent extends Equatable {
  /// Câu tiếng Anh với ___ làm placeholder
  final String sentence;

  /// Câu dịch tiếng Việt (cũng có ___ ở vị trí tương ứng)
  final String? sentenceVi;

  /// Ảnh minh hoạ cho câu
  final String? imageUrl;

  /// Audio đọc toàn bộ câu đúng
  final String? audioSentenceUrl;

  /// Đáp án đúng — phải nằm trong [choices]
  final String correctAnswer;

  /// 2–4 lựa chọn dạng word chip
  final List<String> choices;

  /// Vị trí từ thứ mấy trong câu bị ẩn (0-based theo word index)
  final int blankIndex;

  /// Có hiện dịch tiếng Việt khi bấm hint không
  final bool showTranslationHint;

  FillBlankContent({
    required this.sentence,
    this.sentenceVi,
    this.imageUrl,
    this.audioSentenceUrl,
    required this.correctAnswer,
    required this.choices,
    this.blankIndex = 1,
    this.showTranslationHint = false,
  }) : assert(
         choices.length >= 2 && choices.length <= 4,
         'choices phải có 2–4 phần tử',
       ),
       assert(sentence.contains('___'), 'sentence phải chứa placeholder ___');

  factory FillBlankContent.fromJson(Map<String, dynamic> json) {
    final choices = List<String>.from(json['choices'] as List);
    final content = FillBlankContent(
      sentence: json['sentence'] as String,
      sentenceVi: json['sentence_vi'] as String?,
      imageUrl: json['image_url'] as String?,
      audioSentenceUrl: json['audio_sentence_url'] as String?,
      correctAnswer: json['correct_answer'] as String,
      choices: choices,
      blankIndex: json['blank_index'] as int? ?? 1,
      showTranslationHint: json['show_translation_hint'] as bool? ?? false,
    );
    content._validate();
    return content;
  }

  void _validate() {
    assert(
      choices.contains(correctAnswer),
      'correct_answer "$correctAnswer" phải nằm trong choices $choices',
    );
  }

  static FillBlankContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'fill_blank');
    return FillBlankContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'sentence': sentence,
    if (sentenceVi != null) 'sentence_vi': sentenceVi,
    if (imageUrl != null) 'image_url': imageUrl,
    if (audioSentenceUrl != null) 'audio_sentence_url': audioSentenceUrl,
    'correct_answer': correctAnswer,
    'choices': choices,
    'blank_index': blankIndex,
    'show_translation_hint': showTranslationHint,
  };

  // ─── Helpers phân tích câu ──────────────────────────────────────

  /// Tách câu thành [trước ___] và [sau ___]
  List<String> get sentenceParts => sentence.split('___');

  String get beforeBlank => sentenceParts.isNotEmpty ? sentenceParts[0] : '';

  String get afterBlank => sentenceParts.length > 1 ? sentenceParts[1] : '';

  /// Câu hoàn chỉnh sau khi điền đáp án
  String get completeSentence => sentence.replaceAll('___', correctAnswer);

  @override
  List<Object?> get props => [
    sentence,
    sentenceVi,
    imageUrl,
    audioSentenceUrl,
    correctAnswer,
    choices,
    blankIndex,
    showTranslationHint,
  ];
}
