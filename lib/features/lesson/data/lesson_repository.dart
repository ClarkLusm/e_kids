import '../domain/models/lesson_models.dart';
import '../../quiz/_shared/question_ref.dart';
import '../domain/usecases/lesson_usecases.dart';

// ─── Mock Topic Repository ────────────────────────────────────────────────

class MockTopicRepository implements ITopicRepository {
  @override
  Future<List<Topic>> fetchAllTopics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _topics;
  }

  static const _topics = [
    Topic(
      id: 'topic_animals',
      nameEn: 'Animals',
      nameVi: 'Động vật',
      colorHex: '#E1F5EE',
      sortOrder: 1,
    ),
    Topic(
      id: 'topic_food',
      nameEn: 'Food',
      nameVi: 'Thức ăn',
      colorHex: '#FAEEDA',
      sortOrder: 2,
    ),
    Topic(
      id: 'topic_colors',
      nameEn: 'Colors',
      nameVi: 'Màu sắc',
      colorHex: '#EEEDFE',
      sortOrder: 3,
    ),
    Topic(
      id: 'topic_numbers',
      nameEn: 'Numbers',
      nameVi: 'Số đếm',
      colorHex: '#E6F1FB',
      sortOrder: 4,
    ),
    Topic(
      id: 'topic_body',
      nameEn: 'Body Parts',
      nameVi: 'Cơ thể',
      colorHex: '#FAECE7',
      sortOrder: 5,
    ),
  ];
}

// ─── Mock Lesson Repository ───────────────────────────────────────────────

class MockLessonRepository implements ILessonRepository {
  static final Map<String, List<Lesson>> _lessonsByTopic = {
    'topic_animals': [
      const Lesson(
        id: 'lesson_animals_01',
        topicId: 'topic_animals',
        titleEn: 'Cat & Dog',
        titleVi: 'Mèo và Chó',
        descriptionVi: 'Học các con vật nuôi trong nhà',
        level: 1,
        sortOrder: 1,
        minXpRequired: 0,
        vocabularyCount: 6,
        questionCount: 5,
        xpReward: 60,
      ),
      const Lesson(
        id: 'lesson_animals_02',
        topicId: 'topic_animals',
        titleEn: 'Big Animals',
        titleVi: 'Động vật to lớn',
        descriptionVi: 'Voi, sư tử, hươu cao cổ và hà mã',
        level: 2,
        sortOrder: 2,
        minXpRequired: 60,
        vocabularyCount: 8,
        questionCount: 6,
        xpReward: 80,
      ),
      const Lesson(
        id: 'lesson_animals_03',
        topicId: 'topic_animals',
        titleEn: 'Sea Animals',
        titleVi: 'Động vật biển',
        descriptionVi: 'Cá, cá heo, bạch tuộc và cua',
        level: 3,
        sortOrder: 3,
        minXpRequired: 140,
        vocabularyCount: 8,
        questionCount: 6,
        xpReward: 90,
      ),
      const Lesson(
        id: 'lesson_animals_04',
        topicId: 'topic_animals',
        titleEn: 'Birds & Insects',
        titleVi: 'Chim và Côn trùng',
        descriptionVi: 'Các loài chim và côn trùng phổ biến',
        level: 3,
        sortOrder: 4,
        minXpRequired: 140,
        vocabularyCount: 8,
        questionCount: 7,
        xpReward: 100,
      ),
    ],
    'topic_food': [
      const Lesson(
        id: 'lesson_food_01',
        topicId: 'topic_food',
        titleEn: 'Fruits',
        titleVi: 'Trái cây',
        descriptionVi: 'Táo, chuối, xoài và các loại trái cây',
        level: 1,
        sortOrder: 1,
        minXpRequired: 0,
        vocabularyCount: 7,
        questionCount: 5,
        xpReward: 60,
      ),
      const Lesson(
        id: 'lesson_food_02',
        topicId: 'topic_food',
        titleEn: 'Main Dishes',
        titleVi: 'Món chính',
        descriptionVi: 'Pizza, hamburger, cơm và các món ăn',
        level: 2,
        sortOrder: 2,
        minXpRequired: 60,
        vocabularyCount: 6,
        questionCount: 5,
        xpReward: 70,
      ),
      const Lesson(
        id: 'lesson_food_03',
        topicId: 'topic_food',
        titleEn: 'Drinks',
        titleVi: 'Đồ uống',
        descriptionVi: 'Nước, sữa, nước cam và các loại đồ uống',
        level: 2,
        sortOrder: 3,
        minXpRequired: 60,
        vocabularyCount: 6,
        questionCount: 5,
        xpReward: 70,
      ),
    ],
    'topic_colors': [
      const Lesson(
        id: 'lesson_colors_01',
        topicId: 'topic_colors',
        titleEn: 'Basic Colors',
        titleVi: 'Màu cơ bản',
        descriptionVi: 'Đỏ, xanh, vàng, trắng và đen',
        level: 1,
        sortOrder: 1,
        minXpRequired: 0,
        vocabularyCount: 6,
        questionCount: 5,
        xpReward: 60,
      ),
      const Lesson(
        id: 'lesson_colors_02',
        topicId: 'topic_colors',
        titleEn: 'More Colors',
        titleVi: 'Thêm màu sắc',
        descriptionVi: 'Cam, tím, hồng, nâu và xám',
        level: 2,
        sortOrder: 2,
        minXpRequired: 60,
        vocabularyCount: 6,
        questionCount: 6,
        xpReward: 70,
      ),
    ],
    'topic_numbers': [
      const Lesson(
        id: 'lesson_numbers_01',
        topicId: 'topic_numbers',
        titleEn: 'Numbers 1–5',
        titleVi: 'Số 1 đến 5',
        descriptionVi: 'Học đếm từ 1 đến 5',
        level: 1,
        sortOrder: 1,
        minXpRequired: 0,
        vocabularyCount: 5,
        questionCount: 5,
        xpReward: 50,
      ),
      const Lesson(
        id: 'lesson_numbers_02',
        topicId: 'topic_numbers',
        titleEn: 'Numbers 6–10',
        titleVi: 'Số 6 đến 10',
        descriptionVi: 'Học đếm từ 6 đến 10',
        level: 1,
        sortOrder: 2,
        minXpRequired: 50,
        vocabularyCount: 5,
        questionCount: 5,
        xpReward: 50,
      ),
    ],
    'topic_body': [
      const Lesson(
        id: 'lesson_body_01',
        topicId: 'topic_body',
        titleEn: 'Head & Face',
        titleVi: 'Đầu và Mặt',
        descriptionVi: 'Các bộ phận trên đầu và khuôn mặt',
        level: 2,
        sortOrder: 1,
        minXpRequired: 0,
        vocabularyCount: 7,
        questionCount: 6,
        xpReward: 75,
      ),
    ],
  };

  static final Map<String, Lesson> _lessonsById = {
    for (final lessons in _lessonsByTopic.values)
      for (final lesson in lessons) lesson.id: lesson,
  };

  @override
  Future<List<Lesson>> fetchByTopic(String topicId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _lessonsByTopic[topicId] ?? [];
  }

  @override
  Future<Lesson> fetchById(String lessonId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final lesson = _lessonsById[lessonId];
    if (lesson == null) throw Exception('Lesson not found: $lessonId');
    return lesson;
  }
}

// ─── Mock Vocabulary Repository ───────────────────────────────────────────

class MockVocabularyRepository implements IVocabularyRepository {
  static final Map<String, List<Vocabulary>> _vocabByLesson = {
    'lesson_animals_01': [
      const Vocabulary(
        id: 'v1',
        lessonId: 'lesson_animals_01',
        word: 'cat',
        phonetic: 'kæt',
        translationVi: 'con mèo',
        imageUrl: 'assets/images/animals/cat.webp',
        audioUrl: 'assets/audio/cat.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v2',
        lessonId: 'lesson_animals_01',
        word: 'dog',
        phonetic: 'dɒɡ',
        translationVi: 'con chó',
        imageUrl: 'assets/images/animals/dog.webp',
        audioUrl: 'assets/audio/dog.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v3',
        lessonId: 'lesson_animals_01',
        word: 'bird',
        phonetic: 'bɜːd',
        translationVi: 'con chim',
        imageUrl: 'assets/images/animals/bird.webp',
        audioUrl: 'assets/audio/bird.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v4',
        lessonId: 'lesson_animals_01',
        word: 'fish',
        phonetic: 'fɪʃ',
        translationVi: 'con cá',
        imageUrl: 'assets/images/animals/fish.webp',
        audioUrl: 'assets/audio/fish.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v5',
        lessonId: 'lesson_animals_01',
        word: 'rabbit',
        phonetic: 'ˈræb.ɪt',
        translationVi: 'con thỏ',
        imageUrl: 'assets/images/animals/rabbit.webp',
        audioUrl: 'assets/audio/rabbit.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v6',
        lessonId: 'lesson_animals_01',
        word: 'hamster',
        phonetic: 'ˈhæm.stər',
        translationVi: 'chuột hamster',
        imageUrl: 'assets/images/animals/hamster.webp',
        audioUrl: 'assets/audio/hamster.mp3',
        partOfSpeech: 'noun',
      ),
    ],
    'lesson_animals_02': [
      const Vocabulary(
        id: 'v7',
        lessonId: 'lesson_animals_02',
        word: 'elephant',
        phonetic: 'ˈel.ɪ.fənt',
        translationVi: 'con voi',
        imageUrl: 'assets/images/animals/elephant.webp',
        audioUrl: 'assets/audio/elephant.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v8',
        lessonId: 'lesson_animals_02',
        word: 'lion',
        phonetic: 'ˈlaɪ.ən',
        translationVi: 'sư tử',
        imageUrl: 'assets/images/animals/lion.webp',
        audioUrl: 'assets/audio/lion.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v9',
        lessonId: 'lesson_animals_02',
        word: 'giraffe',
        phonetic: 'dʒɪˈrɑːf',
        translationVi: 'hươu cao cổ',
        imageUrl: 'assets/images/animals/giraffe.webp',
        audioUrl: 'assets/audio/giraffe.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'v10',
        lessonId: 'lesson_animals_02',
        word: 'hippo',
        phonetic: 'ˈhɪp.oʊ',
        translationVi: 'hà mã',
        imageUrl: 'assets/images/animals/hippo.webp',
        audioUrl: 'assets/audio/hippo.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v11',
        lessonId: 'lesson_animals_02',
        word: 'zebra',
        phonetic: 'ˈziː.brə',
        translationVi: 'ngựa vằn',
        imageUrl: 'assets/images/animals/zebra.webp',
        audioUrl: 'assets/audio/zebra.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v12',
        lessonId: 'lesson_animals_02',
        word: 'tiger',
        phonetic: 'ˈtaɪ.ɡər',
        translationVi: 'con hổ',
        imageUrl: 'assets/images/animals/tiger.webp',
        audioUrl: 'assets/audio/tiger.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v13',
        lessonId: 'lesson_animals_02',
        word: 'monkey',
        phonetic: 'ˈmʌŋ.ki',
        translationVi: 'con khỉ',
        imageUrl: 'assets/images/animals/monkey.webp',
        audioUrl: 'assets/audio/monkey.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'v14',
        lessonId: 'lesson_animals_02',
        word: 'bear',
        phonetic: 'beər',
        translationVi: 'con gấu',
        imageUrl: 'assets/images/animals/bear.webp',
        audioUrl: 'assets/audio/bear.mp3',
        partOfSpeech: 'noun',
      ),
    ],
    'lesson_food_01': [
      const Vocabulary(
        id: 'f1',
        lessonId: 'lesson_food_01',
        word: 'apple',
        phonetic: 'ˈæp.əl',
        translationVi: 'quả táo',
        imageUrl: 'assets/images/food/apple.webp',
        audioUrl: 'assets/audio/apple.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'f2',
        lessonId: 'lesson_food_01',
        word: 'banana',
        phonetic: 'bəˈnɑː.nə',
        translationVi: 'quả chuối',
        imageUrl: 'assets/images/food/banana.webp',
        audioUrl: 'assets/audio/banana.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'f3',
        lessonId: 'lesson_food_01',
        word: 'mango',
        phonetic: 'ˈmæŋ.ɡoʊ',
        translationVi: 'quả xoài',
        imageUrl: 'assets/images/food/mango.webp',
        audioUrl: 'assets/audio/mango.mp3',
        partOfSpeech: 'noun',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'f4',
        lessonId: 'lesson_food_01',
        word: 'orange',
        phonetic: 'ˈɒr.ɪndʒ',
        translationVi: 'quả cam',
        imageUrl: 'assets/images/food/orange.webp',
        audioUrl: 'assets/audio/orange.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'f5',
        lessonId: 'lesson_food_01',
        word: 'grape',
        phonetic: 'ɡreɪp',
        translationVi: 'quả nho',
        imageUrl: 'assets/images/food/grape.webp',
        audioUrl: 'assets/audio/grape.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'f6',
        lessonId: 'lesson_food_01',
        word: 'watermelon',
        phonetic: 'ˈwɔː.tər.mel.ən',
        translationVi: 'dưa hấu',
        imageUrl: 'assets/images/food/watermelon.webp',
        audioUrl: 'assets/audio/watermelon.mp3',
        partOfSpeech: 'noun',
      ),
      const Vocabulary(
        id: 'f7',
        lessonId: 'lesson_food_01',
        word: 'strawberry',
        phonetic: 'ˈstrɔː.bər.i',
        translationVi: 'dâu tây',
        imageUrl: 'assets/images/food/strawberry.webp',
        audioUrl: 'assets/audio/strawberry.mp3',
        partOfSpeech: 'noun',
      ),
    ],
    'lesson_colors_01': [
      const Vocabulary(
        id: 'c1',
        lessonId: 'lesson_colors_01',
        word: 'red',
        phonetic: 'red',
        translationVi: 'màu đỏ',
        imageUrl: 'assets/images/colors/red.webp',
        audioUrl: 'assets/audio/red.mp3',
        partOfSpeech: 'adjective',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'c2',
        lessonId: 'lesson_colors_01',
        word: 'blue',
        phonetic: 'bluː',
        translationVi: 'màu xanh dương',
        imageUrl: 'assets/images/colors/blue.webp',
        audioUrl: 'assets/audio/blue.mp3',
        partOfSpeech: 'adjective',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'c3',
        lessonId: 'lesson_colors_01',
        word: 'green',
        phonetic: 'ɡriːn',
        translationVi: 'màu xanh lá',
        imageUrl: 'assets/images/colors/green.webp',
        audioUrl: 'assets/audio/green.mp3',
        partOfSpeech: 'adjective',
        isKeyWord: true,
      ),
      const Vocabulary(
        id: 'c4',
        lessonId: 'lesson_colors_01',
        word: 'yellow',
        phonetic: 'ˈjel.oʊ',
        translationVi: 'màu vàng',
        imageUrl: 'assets/images/colors/yellow.webp',
        audioUrl: 'assets/audio/yellow.mp3',
        partOfSpeech: 'adjective',
      ),
      const Vocabulary(
        id: 'c5',
        lessonId: 'lesson_colors_01',
        word: 'white',
        phonetic: 'waɪt',
        translationVi: 'màu trắng',
        imageUrl: 'assets/images/colors/white.webp',
        audioUrl: 'assets/audio/white.mp3',
        partOfSpeech: 'adjective',
      ),
      const Vocabulary(
        id: 'c6',
        lessonId: 'lesson_colors_01',
        word: 'black',
        phonetic: 'blæk',
        translationVi: 'màu đen',
        imageUrl: 'assets/images/colors/black.webp',
        audioUrl: 'assets/audio/black.mp3',
        partOfSpeech: 'adjective',
      ),
    ],
  };

  @override
  Future<List<Vocabulary>> fetchByLesson(String lessonId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _vocabByLesson[lessonId] ?? [];
  }
}

// ─── Mock QuestionRef Repository ──────────────────────────────────────────

class MockQuestionRefRepository implements IQuestionRefRepository {
  static final Map<String, List<QuestionRef>> _questionsByLesson = {
    'lesson_animals_01': [
      const QuestionRef(
        id: 'pm_cat',
        lessonId: 'lesson_animals_01',
        quizType: 'picture_match',
        xpReward: 10,
        sortOrder: 1,
      ),
      const QuestionRef(
        id: 'lt_cat',
        lessonId: 'lesson_animals_01',
        quizType: 'listen_tap',
        xpReward: 10,
        sortOrder: 2,
      ),
      const QuestionRef(
        id: 'ls_cat',
        lessonId: 'lesson_animals_01',
        quizType: 'letter_scramble',
        xpReward: 15,
        sortOrder: 3,
      ),
      const QuestionRef(
        id: 'mf_animals_easy',
        lessonId: 'lesson_animals_01',
        quizType: 'memory_flip',
        xpReward: 20,
        sortOrder: 4,
      ),
      const QuestionRef(
        id: 'sw_cat',
        lessonId: 'lesson_animals_01',
        quizType: 'speak_word',
        xpReward: 20,
        sortOrder: 5,
      ),
    ],
    'lesson_animals_02': [
      const QuestionRef(
        id: 'pm_elephant',
        lessonId: 'lesson_animals_02',
        quizType: 'picture_match',
        xpReward: 10,
        sortOrder: 1,
      ),
      const QuestionRef(
        id: 'lt_elephant',
        lessonId: 'lesson_animals_02',
        quizType: 'listen_tap',
        xpReward: 10,
        sortOrder: 2,
      ),
      const QuestionRef(
        id: 'fb_elephant_big',
        lessonId: 'lesson_animals_02',
        quizType: 'fill_blank',
        xpReward: 15,
        sortOrder: 3,
      ),
      const QuestionRef(
        id: 'mf_animals_medium',
        lessonId: 'lesson_animals_02',
        quizType: 'memory_flip',
        xpReward: 20,
        sortOrder: 4,
      ),
      const QuestionRef(
        id: 'sb_animals_food',
        lessonId: 'lesson_animals_02',
        quizType: 'sort_bucket',
        xpReward: 20,
        sortOrder: 5,
      ),
      const QuestionRef(
        id: 'wp_animals',
        lessonId: 'lesson_animals_02',
        quizType: 'word_pop',
        xpReward: 15,
        sortOrder: 6,
      ),
    ],
    'lesson_food_01': [
      const QuestionRef(
        id: 'pm_apple',
        lessonId: 'lesson_food_01',
        quizType: 'picture_match',
        xpReward: 10,
        sortOrder: 1,
      ),
      const QuestionRef(
        id: 'lt_apple',
        lessonId: 'lesson_food_01',
        quizType: 'listen_tap',
        xpReward: 10,
        sortOrder: 2,
      ),
      const QuestionRef(
        id: 'ls_apple',
        lessonId: 'lesson_food_01',
        quizType: 'letter_scramble',
        xpReward: 15,
        sortOrder: 3,
      ),
      const QuestionRef(
        id: 'sb_animals_food',
        lessonId: 'lesson_food_01',
        quizType: 'sort_bucket',
        xpReward: 20,
        sortOrder: 4,
      ),
      const QuestionRef(
        id: 'sb_i_like_food',
        lessonId: 'lesson_food_01',
        quizType: 'story_builder',
        xpReward: 20,
        sortOrder: 5,
      ),
    ],
    'lesson_colors_01': [
      const QuestionRef(
        id: 'pm_red',
        lessonId: 'lesson_colors_01',
        quizType: 'picture_match',
        xpReward: 10,
        sortOrder: 1,
      ),
      const QuestionRef(
        id: 'lt_red',
        lessonId: 'lesson_colors_01',
        quizType: 'listen_tap',
        xpReward: 10,
        sortOrder: 2,
      ),
      const QuestionRef(
        id: 'fb_sky_blue',
        lessonId: 'lesson_colors_01',
        quizType: 'fill_blank',
        xpReward: 15,
        sortOrder: 3,
      ),
      const QuestionRef(
        id: 'wp_colors',
        lessonId: 'lesson_colors_01',
        quizType: 'word_pop',
        xpReward: 15,
        sortOrder: 4,
      ),
      const QuestionRef(
        id: 'sb_sky_blue',
        lessonId: 'lesson_colors_01',
        quizType: 'story_builder',
        xpReward: 20,
        sortOrder: 5,
      ),
    ],
  };

  @override
  Future<List<QuestionRef>> fetchByLesson(String lessonId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _questionsByLesson[lessonId] ?? [];
  }
}

// ─── Mock Progress Repository ─────────────────────────────────────────────

class MockLessonProgressRepository implements ILessonProgressRepository {
  final Map<String, LessonProgress> _cache = {
    'lesson_animals_01': const LessonProgress(
      lessonId: 'lesson_animals_01',
      status: LessonStatus.completed,
      stars: 3,
      bestScore: 100,
      attempts: 2,
      totalXpEarned: 75,
    ),
    'lesson_animals_02': const LessonProgress(
      lessonId: 'lesson_animals_02',
      status: LessonStatus.unlocked,
      stars: 0,
      bestScore: 0,
      attempts: 0,
      totalXpEarned: 0,
    ),
  };

  @override
  Future<Map<String, LessonProgress>> fetchProgressByTopic(
    String topicId,
    String childId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Map.from(_cache);
  }

  @override
  Future<LessonProgress?> fetchProgress(String lessonId, String childId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _cache[lessonId];
  }

  @override
  Future<void> upsertProgress(String childId, LessonProgress progress) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _cache[progress.lessonId] = progress;
    // ignore: avoid_print
    print(
      '[MockRepo] Progress updated: '
      '${progress.lessonId} → ${progress.status.name}, '
      'stars=${progress.stars}',
    );
  }
}
