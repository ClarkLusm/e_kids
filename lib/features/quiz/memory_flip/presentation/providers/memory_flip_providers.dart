import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/memory_flip_game_state.dart';
import '../../domain/usecases/fetch_memory_flip_usecase.dart';
import '../../domain/usecases/save_memory_flip_result_usecase.dart';
import 'memory_flip_controller.dart';

final memoryFlipLessonIdProvider = Provider<String>((ref) {
  throw UnimplementedError(
    'Override memoryFlipLessonIdProvider in QuizOrchestrator.',
  );
});

final memoryFlipQuizIdProvider = Provider<String>((ref) {
  throw UnimplementedError(
    'Override memoryFlipQuizIdProvider in QuizOrchestrator.',
  );
});

final fetchMemoryFlipUseCaseProvider = Provider<FetchMemoryFlipUseCase>((ref) {
  throw UnimplementedError(
    'Provide FetchMemoryFlipUseCase from data layer composition root.',
  );
});

final saveMemoryFlipResultUseCaseProvider =
    Provider<SaveMemoryFlipResultUseCase>((ref) {
      throw UnimplementedError(
        'Provide SaveMemoryFlipResultUseCase from data layer composition root.',
      );
    });

final memoryFlipControllerProvider =
    AsyncNotifierProvider<MemoryFlipController, MemoryFlipGameState>(
      MemoryFlipController.new,
    );
