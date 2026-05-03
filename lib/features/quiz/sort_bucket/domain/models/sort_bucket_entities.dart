import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Một nhóm/bucket mà items sẽ được kéo vào.
class SortBucket extends Equatable {
  final String id;
  final String label;
  final String? labelVi;
  final String? colorHex;
  final String? imageUrl;

  const SortBucket({
    required this.id,
    required this.label,
    this.labelVi,
    this.colorHex,
    this.imageUrl,
  });

  factory SortBucket.fromJson(Map<String, dynamic> json) => SortBucket(
    id: json['id'] as String,
    label: json['label'] as String,
    labelVi: json['label_vi'] as String?,
    colorHex: json['color_hex'] as String?,
    imageUrl: json['image_url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    if (labelVi != null) 'label_vi': labelVi,
    if (colorHex != null) 'color_hex': colorHex,
    if (imageUrl != null) 'image_url': imageUrl,
  };

  /// Parse colorHex thành Flutter Color
  Color get color {
    if (colorHex == null) return const Color(0xFFEEEDFE);
    final hex = colorHex!.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  List<Object?> get props => [id, label, labelVi, colorHex, imageUrl];
}

/// Một thẻ từ vựng cần phân loại vào đúng bucket.
class SortItem extends Equatable {
  final String id;
  final String word;
  final String? imageUrl;
  final String? audioUrl;
  final String correctBucketId;

  const SortItem({
    required this.id,
    required this.word,
    this.imageUrl,
    this.audioUrl,
    required this.correctBucketId,
  });

  factory SortItem.fromJson(Map<String, dynamic> json) => SortItem(
    id: json['id'] as String,
    word: json['word'] as String,
    imageUrl: json['image_url'] as String?,
    audioUrl: json['audio_url'] as String?,
    correctBucketId: json['correct_bucket_id'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'word': word,
    if (imageUrl != null) 'image_url': imageUrl,
    if (audioUrl != null) 'audio_url': audioUrl,
    'correct_bucket_id': correctBucketId,
  };

  @override
  List<Object?> get props => [id, word, imageUrl, audioUrl, correctBucketId];
}
