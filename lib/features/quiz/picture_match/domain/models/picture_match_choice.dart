import 'package:equatable/equatable.dart';

class PictureMatchChoice extends Equatable {
  final String word;
  final String? audioUrl;

  const PictureMatchChoice({required this.word, this.audioUrl});

  factory PictureMatchChoice.fromJson(Map<String, dynamic> json) =>
      PictureMatchChoice(
        word: json['word'] as String,
        audioUrl: json['audio_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'word': word,
    if (audioUrl != null) 'audio_url': audioUrl,
  };

  @override
  List<Object?> get props => [word, audioUrl];
}
