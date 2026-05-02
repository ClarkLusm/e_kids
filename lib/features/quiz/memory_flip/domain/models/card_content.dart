import 'package:equatable/equatable.dart';

enum CardType { image, word, audio, mixed }

class CardContent extends Equatable {
  final CardType type;
  final String? imageUrl;
  final String? word;
  final String? audioUrl;
  final String? translationVi;
  final String? backColor;

  const CardContent({
    required this.type,
    this.imageUrl,
    this.word,
    this.audioUrl,
    this.translationVi,
    this.backColor,
  });

  factory CardContent.fromJson(Map<String, dynamic> json) {
    final type = CardType.values.byName(json['type'] as String);
    final content = CardContent(
      type: type,
      imageUrl: json['image_url'] as String?,
      word: json['word'] as String?,
      audioUrl: json['audio_url'] as String?,
      translationVi: json['translation_vi'] as String?,
      backColor: json['back_color'] as String?,
    );
    content.validate();
    return content;
  }

  Map<String, dynamic> toJson() => {
    'type': type.name,
    if (imageUrl != null) 'image_url': imageUrl,
    if (word != null) 'word': word,
    if (audioUrl != null) 'audio_url': audioUrl,
    if (translationVi != null) 'translation_vi': translationVi,
    if (backColor != null) 'back_color': backColor,
  };

  void validate() {
    switch (type) {
      case CardType.image:
        assert(
          imageUrl != null && imageUrl!.isNotEmpty,
          'CardType.image yêu cầu image_url',
        );
      case CardType.word:
        assert(word != null && word!.isNotEmpty, 'CardType.word yêu cầu word');
      case CardType.audio:
        assert(
          audioUrl != null && audioUrl!.isNotEmpty,
          'CardType.audio yêu cầu audio_url',
        );
      case CardType.mixed:
        assert(
          word != null && imageUrl != null,
          'CardType.mixed yêu cầu cả word lẫn image_url',
        );
    }
  }

  @override
  List<Object?> get props => [
    type,
    imageUrl,
    word,
    audioUrl,
    translationVi,
    backColor,
  ];
}
