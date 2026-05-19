import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../lesson/presentation/providers/lesson_providers.dart';
import '../../data/local/local_daily_mission_repository.dart';
import '../../data/local/mission_content_resolver.dart';
import '../../domain/models/home_mission.dart';
import '../../domain/models/mission_content.dart';

final localDailyMissionRepositoryProvider = Provider((ref) {
  return LocalDailyMissionRepository(ref.watch(appDatabaseProvider));
});

final missionContentResolverProvider = Provider((ref) {
  return MissionContentResolver(ref.watch(appDatabaseProvider));
});

final todayMissionsProvider = FutureProvider.autoDispose<List<HomeMission>>((
  ref,
) async {
  final childId = ref.watch(currentChildIdProvider);
  return ref
      .watch(localDailyMissionRepositoryProvider)
      .getTodayMissions(childId);
});

final preferredMissionReminderHourProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  final childId = ref.watch(currentChildIdProvider);
  return ref
      .watch(localDailyMissionRepositoryProvider)
      .getPreferredHour(childId);
});

final missionContentProvider = FutureProvider.autoDispose
    .family<MissionContent, HomeMission>((ref, mission) async {
      final childId = ref.watch(currentChildIdProvider);
      return ref
          .watch(missionContentResolverProvider)
          .resolve(childId: childId, mission: mission);
    });

final missionActionProvider =
    AsyncNotifierProvider<MissionActionController, void>(
      MissionActionController.new,
    );

class MissionActionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> completeMission(String missionId) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(localDailyMissionRepositoryProvider)
          .completeMission(missionId);
      ref.invalidate(todayMissionsProvider);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
