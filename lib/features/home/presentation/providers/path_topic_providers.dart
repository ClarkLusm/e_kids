import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../lesson/presentation/providers/lesson_providers.dart';
import '../../data/local/local_path_topic_repository.dart';
import '../../domain/models/path_topic_summary.dart';

final localPathTopicRepositoryProvider = Provider<LocalPathTopicRepository>(
  (ref) => LocalPathTopicRepository(ref.watch(appDatabaseProvider)),
);

final homePathTopicSummariesProvider =
    FutureProvider.autoDispose<List<PathTopicSummary>>((ref) {
      final childId = ref.watch(currentChildIdProvider);
      return ref
          .watch(localPathTopicRepositoryProvider)
          .getPathTopicSummaries(childId);
    });
