import '../domain/models/sort_bucket_content.dart';
import '../domain/models/sort_bucket_entities.dart';
import '../domain/usecases/sort_bucket_usecases.dart';

// ─── Mapper ────────────────────────────────────────────────────────────────

class SortBucketMapper {
  static SortBucketContent fromRow(Map<String, dynamic> row) =>
      SortBucketContent.fromJson(row['content_json'] as Map<String, dynamic>);
}

// ─── Mock Repository ───────────────────────────────────────────────────────

class MockSortBucketRepository implements ISortBucketRepository {
  @override
  Future<SortBucketContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockData[questionId] ?? _mockData.values.first;
  }

  static final Map<String, SortBucketContent> _mockData = {
    // ── Animals vs Food (2 buckets — dễ, 6 items) ──────────────────
    'sb_animals_food': SortBucketContent(
      buckets: [
        SortBucket(
          id: 'animals',
          label: 'Animals',
          labelVi: 'Động vật',
          colorHex: '#E1F5EE',
        ),
        SortBucket(
          id: 'food',
          label: 'Food',
          labelVi: 'Thức ăn',
          colorHex: '#FAEEDA',
        ),
      ],
      items: [
        SortItem(
          id: 'i1',
          word: 'lion',
          imageUrl: 'assets/images/animals/lion.webp',
          audioUrl: 'assets/audio/lion.mp3',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i2',
          word: 'pizza',
          imageUrl: 'assets/images/food/pizza.webp',
          audioUrl: 'assets/audio/pizza.mp3',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i3',
          word: 'elephant',
          imageUrl: 'assets/images/animals/elephant.webp',
          audioUrl: 'assets/audio/elephant.mp3',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i4',
          word: 'apple',
          imageUrl: 'assets/images/food/apple.webp',
          audioUrl: 'assets/audio/apple.mp3',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i5',
          word: 'monkey',
          imageUrl: 'assets/images/animals/monkey.webp',
          audioUrl: 'assets/audio/monkey.mp3',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i6',
          word: 'banana',
          imageUrl: 'assets/images/food/banana.webp',
          audioUrl: 'assets/audio/banana.mp3',
          correctBucketId: 'food',
        ),
      ],
      allowPartialScore: true,
    ),

    // ── Animals vs Food vs Colors (3 buckets — trung bình, 6 items) ─
    'sb_three_groups': SortBucketContent(
      buckets: [
        SortBucket(
          id: 'animals',
          label: 'Animals',
          labelVi: 'Động vật',
          colorHex: '#E1F5EE',
        ),
        SortBucket(
          id: 'food',
          label: 'Food',
          labelVi: 'Thức ăn',
          colorHex: '#FAEEDA',
        ),
        SortBucket(
          id: 'colors',
          label: 'Colors',
          labelVi: 'Màu sắc',
          colorHex: '#EEEDFE',
        ),
      ],
      items: [
        SortItem(
          id: 'i1',
          word: 'cat',
          imageUrl: 'assets/images/animals/cat.webp',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i2',
          word: 'mango',
          imageUrl: 'assets/images/food/mango.webp',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i3',
          word: 'blue',
          imageUrl: 'assets/images/colors/blue.webp',
          correctBucketId: 'colors',
        ),
        SortItem(
          id: 'i4',
          word: 'fish',
          imageUrl: 'assets/images/animals/fish.webp',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i5',
          word: 'rice',
          imageUrl: 'assets/images/food/rice.webp',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i6',
          word: 'red',
          imageUrl: 'assets/images/colors/red.webp',
          correctBucketId: 'colors',
        ),
      ],
      allowPartialScore: true,
    ),

    // ── Big vs Small animals (2 buckets — ngữ nghĩa, 6 items) ──────
    'sb_big_small': SortBucketContent(
      buckets: [
        SortBucket(
          id: 'big',
          label: 'Big',
          labelVi: 'To lớn',
          colorHex: '#FAECE7',
        ),
        SortBucket(
          id: 'small',
          label: 'Small',
          labelVi: 'Nhỏ bé',
          colorHex: '#E6F1FB',
        ),
      ],
      items: [
        SortItem(
          id: 'i1',
          word: 'elephant',
          imageUrl: 'assets/images/animals/elephant.webp',
          correctBucketId: 'big',
        ),
        SortItem(
          id: 'i2',
          word: 'cat',
          imageUrl: 'assets/images/animals/cat.webp',
          correctBucketId: 'small',
        ),
        SortItem(
          id: 'i3',
          word: 'giraffe',
          imageUrl: 'assets/images/animals/giraffe.webp',
          correctBucketId: 'big',
        ),
        SortItem(
          id: 'i4',
          word: 'bird',
          imageUrl: 'assets/images/animals/bird.webp',
          correctBucketId: 'small',
        ),
        SortItem(
          id: 'i5',
          word: 'hippo',
          imageUrl: 'assets/images/animals/hippo.webp',
          correctBucketId: 'big',
        ),
        SortItem(
          id: 'i6',
          word: 'fish',
          imageUrl: 'assets/images/animals/fish.webp',
          correctBucketId: 'small',
        ),
      ],
      allowPartialScore: true,
    ),

    // ── 4 buckets — nâng cao, 8 items ──────────────────────────────
    'sb_four_groups': SortBucketContent(
      buckets: [
        SortBucket(
          id: 'animals',
          label: 'Animals',
          labelVi: 'Động vật',
          colorHex: '#E1F5EE',
        ),
        SortBucket(
          id: 'food',
          label: 'Food',
          labelVi: 'Thức ăn',
          colorHex: '#FAEEDA',
        ),
        SortBucket(
          id: 'colors',
          label: 'Colors',
          labelVi: 'Màu sắc',
          colorHex: '#EEEDFE',
        ),
        SortBucket(
          id: 'actions',
          label: 'Actions',
          labelVi: 'Hành động',
          colorHex: '#E6F1FB',
        ),
      ],
      items: [
        SortItem(
          id: 'i1',
          word: 'dog',
          imageUrl: 'assets/images/animals/dog.webp',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i2',
          word: 'orange',
          imageUrl: 'assets/images/food/orange.webp',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i3',
          word: 'green',
          imageUrl: 'assets/images/colors/green.webp',
          correctBucketId: 'colors',
        ),
        SortItem(
          id: 'i4',
          word: 'run',
          imageUrl: 'assets/images/actions/run.webp',
          correctBucketId: 'actions',
        ),
        SortItem(
          id: 'i5',
          word: 'rabbit',
          imageUrl: 'assets/images/animals/rabbit.webp',
          correctBucketId: 'animals',
        ),
        SortItem(
          id: 'i6',
          word: 'grape',
          imageUrl: 'assets/images/food/grape.webp',
          correctBucketId: 'food',
        ),
        SortItem(
          id: 'i7',
          word: 'yellow',
          imageUrl: 'assets/images/colors/yellow.webp',
          correctBucketId: 'colors',
        ),
        SortItem(
          id: 'i8',
          word: 'jump',
          imageUrl: 'assets/images/actions/jump.webp',
          correctBucketId: 'actions',
        ),
      ],
      allowPartialScore: true,
    ),
  };
}

// ─── Mock Attempt Repository ───────────────────────────────────────────────

class MockSortBucketAttemptRepository implements ISortBucketAttemptRepository {
  final List<SortBucketResult> saved = [];

  @override
  Future<void> saveResult(SortBucketResult result) async {
    await Future.delayed(Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] SortBucket: '
      'q=${result.questionId}, '
      'correct=${result.correctCount}/${result.totalCount}, '
      'xp=${result.xpEarned}',
    );
  }
}
