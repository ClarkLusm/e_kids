import '../domain/models/story_builder_content.dart';
import '../domain/usecases/story_builder_usecases.dart';

class StoryBuilderMapper {
  static StoryBuilderContent fromRow(Map<String, dynamic> row) =>
      StoryBuilderContent.fromJson(row['content_json'] as Map<String, dynamic>);
}

class MockStoryBuilderRepository implements IStoryBuilderRepository {
  @override
  Future<StoryBuilderContent> fetchById(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _data[questionId] ?? _data.values.first;
  }

  static final Map<String, StoryBuilderContent> _data = {
    // ── 1 câu đơn giản (dễ) ────────────────────────────────────────
    'sb_cat_sleeps': StoryBuilderContent(
      storyTitleVi: 'Chú mèo lười biếng',
      storyImageUrl: 'assets/images/stories/cat_story.webp',
      allowAudioHint: true,
      sentences: [
        StorySentence(
          order: 1,
          correctSequence: ['The', 'cat', 'is', 'sleeping.'],
          shuffledWords: ['sleeping.', 'The', 'is', 'cat'],
          imageUrl: 'assets/images/animals/sleeping_cat.webp',
          audioUrl: 'assets/audio/the_cat_is_sleeping.mp3',
          translationVi: 'Con mèo đang ngủ.',
        ),
      ],
    ),

    // ── 2 câu (trung bình) ─────────────────────────────────────────
    'sb_dog_runs': StoryBuilderContent(
      storyTitleVi: 'Chú chó tinh nghịch',
      storyImageUrl: 'assets/images/stories/dog_story.webp',
      allowAudioHint: true,
      sentences: [
        StorySentence(
          order: 1,
          correctSequence: ['The', 'dog', 'can', 'run', 'fast.'],
          shuffledWords: ['fast.', 'can', 'The', 'run', 'dog'],
          imageUrl: 'assets/images/animals/running_dog.webp',
          audioUrl: 'assets/audio/the_dog_can_run_fast.mp3',
          translationVi: 'Con chó có thể chạy nhanh.',
        ),
        StorySentence(
          order: 2,
          correctSequence: ['It', 'is', 'very', 'happy.'],
          shuffledWords: ['happy.', 'very', 'It', 'is'],
          imageUrl: 'assets/images/animals/happy_dog.webp',
          audioUrl: 'assets/audio/it_is_very_happy.mp3',
          translationVi: 'Nó rất vui vẻ.',
        ),
      ],
    ),

    // ── 3 câu (khó hơn) ────────────────────────────────────────────
    'sb_elephant_story': StoryBuilderContent(
      storyTitleVi: 'Chú voi và bạn bè',
      storyImageUrl: 'assets/images/stories/elephant_story.webp',
      allowAudioHint: true,
      sentences: [
        StorySentence(
          order: 1,
          correctSequence: ['The', 'elephant', 'is', 'big.'],
          shuffledWords: ['big.', 'elephant', 'The', 'is'],
          imageUrl: 'assets/images/animals/elephant.webp',
          audioUrl: 'assets/audio/the_elephant_is_big.mp3',
          translationVi: 'Con voi rất to.',
        ),
        StorySentence(
          order: 2,
          correctSequence: ['It', 'lives', 'in', 'the', 'jungle.'],
          shuffledWords: ['jungle.', 'the', 'in', 'lives', 'It'],
          imageUrl: 'assets/images/animals/jungle.webp',
          audioUrl: 'assets/audio/it_lives_in_the_jungle.mp3',
          translationVi: 'Nó sống trong rừng.',
        ),
        StorySentence(
          order: 3,
          correctSequence: ['It', 'has', 'many', 'friends.'],
          shuffledWords: ['friends.', 'many', 'has', 'It'],
          imageUrl: 'assets/images/animals/animal_friends.webp',
          audioUrl: 'assets/audio/it_has_many_friends.mp3',
          translationVi: 'Nó có nhiều bạn bè.',
        ),
      ],
    ),

    // ── 2 câu về màu sắc ───────────────────────────────────────────
    'sb_sky_blue': StoryBuilderContent(
      storyTitleVi: 'Bầu trời xanh',
      allowAudioHint: true,
      sentences: [
        StorySentence(
          order: 1,
          correctSequence: ['The', 'sky', 'is', 'blue.'],
          shuffledWords: ['blue.', 'sky', 'is', 'The'],
          imageUrl: 'assets/images/colors/blue_sky.webp',
          audioUrl: 'assets/audio/the_sky_is_blue.mp3',
          translationVi: 'Bầu trời màu xanh.',
        ),
        StorySentence(
          order: 2,
          correctSequence: ['The', 'sun', 'is', 'yellow.'],
          shuffledWords: ['yellow.', 'is', 'sun', 'The'],
          imageUrl: 'assets/images/colors/yellow_sun.webp',
          audioUrl: 'assets/audio/the_sun_is_yellow.mp3',
          translationVi: 'Mặt trời màu vàng.',
        ),
      ],
    ),

    // ── 3 câu về thức ăn ───────────────────────────────────────────
    'sb_i_like_food': StoryBuilderContent(
      storyTitleVi: 'Tôi thích ăn gì?',
      allowAudioHint: true,
      sentences: [
        StorySentence(
          order: 1,
          correctSequence: ['I', 'like', 'to', 'eat', 'fruit.'],
          shuffledWords: ['fruit.', 'to', 'like', 'eat', 'I'],
          imageUrl: 'assets/images/food/fruit_bowl.webp',
          audioUrl: 'assets/audio/i_like_to_eat_fruit.mp3',
          translationVi: 'Tôi thích ăn trái cây.',
        ),
        StorySentence(
          order: 2,
          correctSequence: ['Apple', 'is', 'my', 'favorite.'],
          shuffledWords: ['favorite.', 'my', 'Apple', 'is'],
          imageUrl: 'assets/images/food/apple.webp',
          audioUrl: 'assets/audio/apple_is_my_favorite.mp3',
          translationVi: 'Táo là loại yêu thích của tôi.',
        ),
        StorySentence(
          order: 3,
          correctSequence: ['It', 'is', 'red', 'and', 'sweet.'],
          shuffledWords: ['sweet.', 'and', 'red', 'It', 'is'],
          imageUrl: 'assets/images/food/red_apple.webp',
          audioUrl: 'assets/audio/it_is_red_and_sweet.mp3',
          translationVi: 'Nó màu đỏ và ngọt.',
        ),
      ],
    ),
  };
}

class MockStoryBuilderAttemptRepository
    implements IStoryBuilderAttemptRepository {
  final List<StoryBuilderResult> saved = [];

  @override
  Future<void> saveResult(StoryBuilderResult result) async {
    await Future.delayed(const Duration(milliseconds: 150));
    saved.add(result);
    // ignore: avoid_print
    print(
      '[MockRepo] StoryBuilder: q=${result.questionId}, '
      'correct=${result.correctSentences}/${result.totalSentences}',
    );
  }
}
