import 'package:equatable/equatable.dart';
import 'sort_bucket_entities.dart';

/// Model cho quiz sort_bucket — kéo thẻ từ vào đúng nhóm.
///
/// JSON mẫu:
/// ```json
/// {
///   "buckets": [
///     { "id": "animals", "label": "Animals", "label_vi": "Động vật",
///       "color_hex": "#E1F5EE" },
///     { "id": "food",    "label": "Food",    "label_vi": "Thức ăn",
///       "color_hex": "#FAEEDA" }
///   ],
///   "items": [
///     { "id": "i1", "word": "lion",  "image_url": "cdn/img/lion.webp",
///       "correct_bucket_id": "animals" },
///     { "id": "i2", "word": "pizza", "image_url": "cdn/img/pizza.webp",
///       "correct_bucket_id": "food" }
///   ],
///   "allow_partial_score": true
/// }
/// ```
class SortBucketContent extends Equatable {
  final List<SortBucket> buckets;
  final List<SortItem> items;

  /// true = tính điểm theo từng item đúng, false = all-or-nothing
  final bool allowPartialScore;

  const SortBucketContent({
    required this.buckets,
    required this.items,
    this.allowPartialScore = true,
  }) : assert(
         buckets.length >= 2 && buckets.length <= 4,
         'Số bucket phải từ 2–4',
       ),
       assert(items.length >= 4 && items.length <= 9, 'Số items phải từ 4–9');

  factory SortBucketContent.fromJson(Map<String, dynamic> json) {
    final buckets = (json['buckets'] as List)
        .map((b) => SortBucket.fromJson(b as Map<String, dynamic>))
        .toList();
    final items = (json['items'] as List)
        .map((i) => SortItem.fromJson(i as Map<String, dynamic>))
        .toList();

    final content = SortBucketContent(
      buckets: buckets,
      items: items,
      allowPartialScore: json['allow_partial_score'] as bool? ?? true,
    );
    content._validate();
    return content;
  }

  void _validate() {
    final bucketIds = buckets.map((b) => b.id).toSet();
    for (final item in items) {
      assert(
        bucketIds.contains(item.correctBucketId),
        'Item "${item.word}" có correctBucketId "${item.correctBucketId}" '
        'không tồn tại trong buckets',
      );
    }
  }

  static SortBucketContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'sort_bucket');
    return SortBucketContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'buckets': buckets.map((b) => b.toJson()).toList(),
    'items': items.map((i) => i.toJson()).toList(),
    'allow_partial_score': allowPartialScore,
  };

  SortBucket bucketById(String id) => buckets.firstWhere((b) => b.id == id);

  @override
  List<Object?> get props => [buckets, items, allowPartialScore];
}
