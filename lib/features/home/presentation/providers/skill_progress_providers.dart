import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../lesson/presentation/providers/lesson_providers.dart';
import '../../data/local/local_skill_progress_repository.dart';
import '../../domain/models/skill_progress_summary.dart';

final localSkillProgressRepositoryProvider = Provider((ref) {
  return LocalSkillProgressRepository(ref.watch(appDatabaseProvider));
});

final homeSkillProgressProvider =
    FutureProvider.autoDispose<List<SkillProgressSummary>>((ref) {
      final childId = ref.watch(currentChildIdProvider);
      return ref
          .watch(localSkillProgressRepositoryProvider)
          .getSkillProgress(childId);
    });

final parentSkillGoalProgressProvider =
    FutureProvider.autoDispose<List<SkillProgressSummary>>((ref) {
      final childId = ref.watch(currentChildIdProvider);
      return ref
          .watch(localSkillProgressRepositoryProvider)
          .getOrCreateSkillProgress(childId);
    });

final skillGoalActionProvider =
    AsyncNotifierProvider<SkillGoalActionController, void>(
      SkillGoalActionController.new,
    );

class SkillGoalActionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateTarget({
    required SkillProgressSummary skill,
    required int requiredUnits,
  }) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(localSkillProgressRepositoryProvider)
          .updateTarget(
            childId: skill.childId,
            pathId: skill.pathId,
            level: skill.level,
            skillKey: skill.skillKey,
            requiredUnits: requiredUnits,
          );
      ref.invalidate(homeSkillProgressProvider);
      ref.invalidate(parentSkillGoalProgressProvider);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
