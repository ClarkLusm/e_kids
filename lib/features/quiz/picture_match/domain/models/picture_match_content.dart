import 'package:equatable/equatable.dart';
import 'picture_match_choice.dart';

class PictureMatchContent extends Equatable {
  final String imageUrl;
  final String correctWord;
  final List<PictureMatchChoice> choices;
  final String? imageAudioUrl;
  final String? translationVi;

  const PictureMatchContent({
    required this.imageUrl,
    required this.correctWord,
    required this.choices,
    this.imageAudioUrl,
    this.translationVi,
  }) : assert(choices.length == 4, 'Phải có đúng 4 lựa chọn');

  factory PictureMatchContent.fromJson(Map<String, dynamic> json) {
    final choices = (json['choices'] as List)
        .map((c) => PictureMatchChoice.fromJson(c as Map<String, dynamic>))
        .toList();

    final content = PictureMatchContent(
      imageUrl: json['image_url'] as String,
      correctWord: json['correct_word'] as String,
      choices: choices,
      imageAudioUrl: json['image_audio_url'] as String?,
      translationVi: json['translation_vi'] as String?,
    );
    content._validate();
    return content;
  }

  void _validate() {
    final hasCorrect = choices.any((c) => c.word == correctWord);
    assert(
      hasCorrect,
      'correct_word "$correctWord" phải nằm trong danh sách choices',
    );
  }

  static PictureMatchContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'picture_match');
    return PictureMatchContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'image_url': imageUrl,
    'correct_word': correctWord,
    'choices': choices.map((c) => c.toJson()).toList(),
    if (imageAudioUrl != null) 'image_audio_url': imageAudioUrl,
    if (translationVi != null) 'translation_vi': translationVi,
  };

  @override
  List<Object?> get props => [
    imageUrl,
    correctWord,
    choices,
    imageAudioUrl,
    translationVi,
  ];
}
