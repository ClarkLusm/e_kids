import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/local/placement_path_assignment_service.dart';
import '../../domain/models/placement_result.dart';

final placementPathAssignmentServiceProvider = Provider((ref) {
  return PlacementPathAssignmentService(ref.watch(appDatabaseProvider));
});

final currentPlacementChildIdProvider = Provider<String>((ref) {
  return ref.watch(authStateProvider).valueOrNull?.id ?? 'local_child';
});

final hasActiveLearningPathProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final childId = ref.watch(currentPlacementChildIdProvider);
  final row =
      await (db.select(db.childLearningPaths)
            ..where((tbl) => tbl.childId.equals(childId))
            ..where((tbl) => tbl.status.equals('active'))
            ..where((tbl) => tbl.deletedAt.isNull())
            ..limit(1))
          .getSingleOrNull();

  return row != null;
});

final placementActionControllerProvider =
    AsyncNotifierProvider<PlacementActionController, void>(
      PlacementActionController.new,
    );

class PlacementActionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> skipPlacement() async {
    state = const AsyncLoading();
    try {
      await ref
          .read(placementPathAssignmentServiceProvider)
          .skipPlacement(childId: ref.read(currentPlacementChildIdProvider));
      ref.invalidate(hasActiveLearningPathProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<PlacementResult> completePlacement({
    required int score,
    required int maxScore,
    required List<Map<String, Object?>> answers,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(placementPathAssignmentServiceProvider)
          .completePlacement(
            childId: ref.read(currentPlacementChildIdProvider),
            score: score,
            maxScore: maxScore,
            answers: answers,
          );
      ref.invalidate(hasActiveLearningPathProvider);
      state = const AsyncData(null);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
