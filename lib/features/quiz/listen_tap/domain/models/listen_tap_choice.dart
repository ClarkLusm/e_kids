import 'package:equatable/equatable.dart';

/// Một lựa chọn trong quiz listen_tap.
/// Mỗi choice có ảnh + label chữ, đúng 1 trong số đó là correct.
class ListenTapChoice extends Equatable {
  final String word;
  final String imageUrl;
  final bool isCorrect;

  const ListenTapChoice({
    required this.word,
    required this.imageUrl,
    required this.isCorrect,
  });

  factory ListenTapChoice.fromJson(Map<String, dynamic> json) =>
      ListenTapChoice(
        word: json['word'] as String,
        imageUrl: json['image_url'] as String,
        isCorrect: json['is_correct'] as bool,
      );

  Map<String, dynamic> toJson() => {
    'word': word,
    'image_url': imageUrl,
    'is_correct': isCorrect,
  };

  @override
  List<Object?> get props => [word, imageUrl, isCorrect];
}
