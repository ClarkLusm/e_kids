import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../lesson/presentation/providers/lesson_providers.dart';
import '../../data/local/local_level_progress_repository.dart';
import '../../domain/models/home_learning_summary.dart';

final localLevelProgressRepositoryProvider =
    Provider<LocalLevelProgressRepository>(
      (ref) => LocalLevelProgressRepository(ref.watch(appDatabaseProvider)),
    );

final homeLearningSummaryProvider =
    FutureProvider.autoDispose<HomeLearningSummary>((ref) async {
      final childId = ref.watch(currentChildIdProvider);
      return ref
          .watch(localLevelProgressRepositoryProvider)
          .getSummary(childId);
    });
