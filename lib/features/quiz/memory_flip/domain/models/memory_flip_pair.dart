import 'package:equatable/equatable.dart';
import 'card_content.dart';

class MemoryFlipPair extends Equatable {
  final String id;
  final CardContent cardA;
  final CardContent cardB;
  final String? audioOnMatch;
  final int difficultyWeight;

  const MemoryFlipPair({
    required this.id,
    required this.cardA,
    required this.cardB,
    this.audioOnMatch,
    this.difficultyWeight = 1,
  }) : assert(
         difficultyWeight >= 1 && difficultyWeight <= 3,
         'difficultyWeight phải từ 1–3',
       );

  factory MemoryFlipPair.fromJson(Map<String, dynamic> json) {
    return MemoryFlipPair(
      id: json['id'] as String,
      cardA: CardContent.fromJson(json['card_a'] as Map<String, dynamic>),
      cardB: CardContent.fromJson(json['card_b'] as Map<String, dynamic>),
      audioOnMatch: json['audio_on_match'] as String?,
      difficultyWeight: json['difficulty_weight'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'card_a': cardA.toJson(),
    'card_b': cardB.toJson(),
    if (audioOnMatch != null) 'audio_on_match': audioOnMatch,
    'difficulty_weight': difficultyWeight,
  };

  @override
  List<Object?> get props => [id, cardA, cardB, audioOnMatch, difficultyWeight];
}
