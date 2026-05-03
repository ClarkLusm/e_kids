// Domain models
export 'domain/models/card_content.dart';
export 'domain/models/card_state.dart';
export 'domain/models/memory_flip_content.dart';
export 'domain/models/memory_flip_game_state.dart';
export 'domain/models/memory_flip_pair.dart';
export 'domain/models/score_config.dart';

// Use cases
export 'domain/usecases/fetch_memory_flip_usecase.dart';
export 'domain/usecases/save_memory_flip_result_usecase.dart';

// Data
export 'data/memory_flip_mapper.dart';

// Presentation
export 'presentation/providers/memory_flip_providers.dart';
export 'presentation/screens/memory_flip_screen.dart';
export 'presentation/widgets/flip_card_widget.dart';
export 'presentation/widgets/game_header_widget.dart';
export 'presentation/widgets/result_sheet_widget.dart';

/**
 * memory_flip/domain/models/ — 6 file thuần Dart, không import Flutter:
  card_content.dart (CardType enum + validate), card_state.dart (CardFaceState runtime), memory_flip_pair.dart, score_config.dart + accessibility_config.dart, memory_flip_content.dart (GridSize enum + root model + fromJson), memory_flip_game_state.dart (shuffle board, tính XP, tính sao).
  memory_flip/domain/usecases/ — 2 file: FetchMemoryFlipUseCase (interface IMemoryFlipRepository) và SaveMemoryFlipResultUseCase (interface IQuizAttemptRepository + DTO MemoryFlipResult).
  memory_flip/data/ — memory_flip_mapper.dart chứa MemoryFlipMapper.fromRow(), MockMemoryFlipRepository với 2 bộ mock data đầy đủ (mf_animals_easy grid 3×2, mf_animals_medium grid 4×3), và MockQuizAttemptRepository.
  memory_flip/presentation/ — Controller Riverpod FamilyAsyncNotifier xử lý toàn bộ game flow (preview → tap → match/mismatch → finish → replay). 3 widget: FlipCardWidget (3D animation rotateY + 4 loại mặt trước), GameHeaderWidget (progress bar + live timer + flip counter), ResultSheetWidget (sao + XP + từ đã học + action buttons). MemoryFlipScreen kết nối tất cả lại.
 */