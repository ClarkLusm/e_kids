import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../lesson/presentation/providers/lesson_providers.dart';
import '../../data/local/local_daily_mission_repository.dart';
import '../../domain/models/home_mission.dart';

final localDailyMissionRepositoryProvider = Provider((ref) {
  return LocalDailyMissionRepository(ref.watch(appDatabaseProvider));
});

final todayMissionsProvider = FutureProvider.autoDispose<List<HomeMission>>((
  ref,
) async {
  final childId = ref.watch(currentChildIdProvider);
  return ref
      .watch(localDailyMissionRepositoryProvider)
      .getTodayMissions(childId);
});
