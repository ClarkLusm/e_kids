import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/daos/quiz_attempts_dao.dart';
import '../../../../../core/database/database_providers.dart';
import '../../../../auth/presentation/providers/auth_providers.dart';
import '../../../../home/data/local/local_child_signal_repository.dart';
import '../../../../home/data/local/local_level_progress_repository.dart';
import '../../../../home/data/local/local_skill_progress_repository.dart';
import '../../../../home/presentation/providers/learning_summary_providers.dart';
import '../../../../home/presentation/providers/skill_progress_providers.dart';
import '../../../fill_blank/domain/usecases/fill_blank_usecases.dart';
import '../../../letter_scramble/domain/usecases/letter_scramble_usecases.dart';
import '../../../listen_tap/domain/usecases/listen_tap_usecases.dart';
import '../../../memory_flip/domain/usecases/save_memory_flip_result_usecase.dart';
import '../../../picture_match/domain/usecases/picture_match_usecases.dart';
import '../../../sort_bucket/domain/usecases/sort_bucket_usecases.dart';
import '../../../speak_word/domain/usecases/speak_word_usecases.dart';
import '../../../story_builder/domain/usecases/story_builder_usecases.dart';
import '../../../word_pop/domain/usecases/word_pop_usecases.dart';

final localQuizAttemptStoreProvider = Provider<LocalQuizAttemptStore>(
  (ref) => LocalQuizAttemptStore(
    QuizAttemptsDao(ref.watch(appDatabaseProvider)),
    LocalSkillProgressRepository(ref.watch(appDatabaseProvider)),
    LocalLevelProgressRepository(ref.watch(appDatabaseProvider)),
    LocalChildSignalRepository(ref.watch(appDatabaseProvider)),
    childId: ref.watch(authStateProvider).valueOrNull?.id ?? 'mock_child_id',
    onSkillProgressChanged: () => ref.invalidate(homeSkillProgressProvider),
    onLevelProgressChanged: () => ref.invalidate(homeLearningSummaryProvider),
  ),
);

final localFillBlankAttemptRepositoryProvider =
    Provider<IFillBlankAttemptRepository>(
      (ref) => _LocalFillBlankAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localLetterScrambleAttemptRepositoryProvider =
    Provider<ILetterScrambleAttemptRepository>(
      (ref) => _LocalLetterScrambleAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localListenTapAttemptRepositoryProvider =
    Provider<IListenTapAttemptRepository>(
      (ref) => _LocalListenTapAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localMemoryFlipAttemptRepositoryProvider =
    Provider<IQuizAttemptRepository>(
      (ref) => _LocalMemoryFlipAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localPictureMatchAttemptRepositoryProvider =
    Provider<IPictureMatchAttemptRepository>(
      (ref) => _LocalPictureMatchAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localSortBucketAttemptRepositoryProvider =
    Provider<ISortBucketAttemptRepository>(
      (ref) => _LocalSortBucketAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localSpeakWordAttemptRepositoryProvider =
    Provider<ISpeakWordAttemptRepository>(
      (ref) => _LocalSpeakWordAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localStoryBuilderAttemptRepositoryProvider =
    Provider<IStoryBuilderAttemptRepository>(
      (ref) => _LocalStoryBuilderAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

final localWordPopAttemptRepositoryProvider =
    Provider<IWordPopAttemptRepository>(
      (ref) => _LocalWordPopAttemptRepository(
        ref.watch(localQuizAttemptStoreProvider),
      ),
    );

class LocalQuizAttemptStore {
  LocalQuizAttemptStore(
    this._attemptsDao,
    this._skillProgressRepository,
    this._levelProgressRepository,
    this._childSignalRepository, {
    required String childId,
    void Function()? onSkillProgressChanged,
    void Function()? onLevelProgressChanged,
  }) : _childId = childId,
       _onSkillProgressChanged = onSkillProgressChanged,
       _onLevelProgressChanged = onLevelProgressChanged;

  static const _uuid = Uuid();

  final QuizAttemptsDao _attemptsDao;
  final LocalSkillProgressRepository _skillProgressRepository;
  final LocalLevelProgressRepository _levelProgressRepository;
  final LocalChildSignalRepository _childSignalRepository;
  final String _childId;
  final void Function()? _onSkillProgressChanged;
  final void Function()? _onLevelProgressChanged;

  Future<void> saveFillBlank(FillBlankResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'fill_blank',
      isCorrect: result.isCorrect,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      hintsUsed: result.hintsUsed,
      answer: result.toJson(),
    );
  }

  Future<void> saveLetterScramble(LetterScrambleResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'letter_scramble',
      isCorrect: result.isCorrect,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      hintsUsed: result.hintsUsed,
      answer: result.toJson(),
    );
  }

  Future<void> saveListenTap(ListenTapResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'listen_tap',
      isCorrect: result.isCorrect,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> saveMemoryFlip(MemoryFlipResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'memory_flip',
      isCorrect: result.isComplete,
      isCompleted: result.isComplete,
      stars: result.stars,
      xpEarned: result.xpEarned,
      timeTakenMs: result.elapsedSec * 1000,
      answer: result.toJson(),
    );
  }

  Future<void> savePictureMatch(PictureMatchResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'picture_match',
      isCorrect: result.isCorrect,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> saveSortBucket(SortBucketResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'sort_bucket',
      isCorrect: result.isCorrect,
      score: result.correctCount,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> saveSpeakWord(SpeakWordResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      sessionId: result.sessionId,
      questionId: result.questionId,
      quizType: 'speak_word',
      isCorrect: result.isCorrect,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> saveStoryBuilder(StoryBuilderResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      questionId: result.questionId,
      quizType: 'story_builder',
      isCorrect: result.isCorrect,
      score: result.correctSentences,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> saveWordPop(WordPopResult result) {
    return _save(
      childId: _childId,
      lessonId: result.lessonId,
      questionId: result.questionId,
      quizType: 'word_pop',
      isCorrect: result.isCorrect,
      score: result.score,
      xpEarned: result.xpEarned,
      timeTakenMs: result.timeTakenMs,
      answer: result.toJson(),
    );
  }

  Future<void> _save({
    required String childId,
    required String lessonId,
    required String questionId,
    required String quizType,
    required bool isCorrect,
    required int xpEarned,
    required int timeTakenMs,
    required Map<String, dynamic> answer,
    String? sessionId,
    bool isCompleted = true,
    int score = 0,
    int stars = 0,
    int hintsUsed = 0,
  }) async {
    final normalizedAnswer = Map<String, dynamic>.from(answer)
      ..['child_id'] = childId
      ..['lesson_id'] = lessonId;

    await _attemptsDao.insertAttempt(
      QuizAttemptWrite(
        id: _uuid.v4(),
        childId: childId,
        sessionId: sessionId,
        lessonId: lessonId,
        questionId: questionId,
        quizType: quizType,
        isCorrect: isCorrect,
        isCompleted: isCompleted,
        score: score,
        stars: stars,
        xpEarned: xpEarned,
        timeTakenMs: timeTakenMs,
        hintsUsed: hintsUsed,
        answerJson: jsonEncode(normalizedAnswer),
      ),
    );

    await _skillProgressRepository.recordQuizAttempt(
      childId: childId,
      quizType: quizType,
      isCorrect: isCorrect,
      xpEarned: xpEarned,
    );
    _onSkillProgressChanged?.call();

    await _levelProgressRepository.recordQuizAttempt(
      childId: childId,
      quizType: quizType,
      isCorrect: isCorrect,
      xpEarned: xpEarned,
      answer: normalizedAnswer,
    );
    _onLevelProgressChanged?.call();

    await _childSignalRepository.recomputeAfterQuizAttempt(childId);
  }
}

class _LocalFillBlankAttemptRepository implements IFillBlankAttemptRepository {
  const _LocalFillBlankAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(FillBlankResult result) =>
      _store.saveFillBlank(result);
}

class _LocalLetterScrambleAttemptRepository
    implements ILetterScrambleAttemptRepository {
  const _LocalLetterScrambleAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(LetterScrambleResult result) =>
      _store.saveLetterScramble(result);
}

class _LocalListenTapAttemptRepository implements IListenTapAttemptRepository {
  const _LocalListenTapAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(ListenTapResult result) =>
      _store.saveListenTap(result);
}

class _LocalMemoryFlipAttemptRepository implements IQuizAttemptRepository {
  const _LocalMemoryFlipAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(MemoryFlipResult result) =>
      _store.saveMemoryFlip(result);
}

class _LocalPictureMatchAttemptRepository
    implements IPictureMatchAttemptRepository {
  const _LocalPictureMatchAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(PictureMatchResult result) =>
      _store.savePictureMatch(result);
}

class _LocalSortBucketAttemptRepository
    implements ISortBucketAttemptRepository {
  const _LocalSortBucketAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(SortBucketResult result) =>
      _store.saveSortBucket(result);
}

class _LocalSpeakWordAttemptRepository implements ISpeakWordAttemptRepository {
  const _LocalSpeakWordAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(SpeakWordResult result) =>
      _store.saveSpeakWord(result);
}

class _LocalStoryBuilderAttemptRepository
    implements IStoryBuilderAttemptRepository {
  const _LocalStoryBuilderAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(StoryBuilderResult result) =>
      _store.saveStoryBuilder(result);
}

class _LocalWordPopAttemptRepository implements IWordPopAttemptRepository {
  const _LocalWordPopAttemptRepository(this._store);

  final LocalQuizAttemptStore _store;

  @override
  Future<void> saveResult(WordPopResult result) => _store.saveWordPop(result);
}
