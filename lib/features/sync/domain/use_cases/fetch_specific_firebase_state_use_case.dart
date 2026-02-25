import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/domain/repositories/firebase_realtime_database_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchSpecificFirebaseStateParams {
  final int start;
  final int end;

  // The group name for the state
  final String group;

  FetchSpecificFirebaseStateParams({
    required this.start,
    required this.end,
    required this.group,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FetchSpecificFirebaseStateParams &&
        other.start == start &&
        other.end == end &&
        other.group == group;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ group.hashCode;
}

class FetchSpecificFirebaseStateUseCase
    extends SimpleUseCase<List<UpdateStateModel>, FetchSpecificFirebaseStateParams> {
  FirebaseRealtimeDatabaseRepository firebaseRealtimeDatabaseRepository;

  FetchSpecificFirebaseStateUseCase({
    required this.firebaseRealtimeDatabaseRepository,
  });

  @override
  Future<List<UpdateStateModel>> call(FetchSpecificFirebaseStateParams params) async {
    final customTrace = usePerformance().newTrace('firebase-sync-specific-${params.group.toLowerCase()}');
    await customTrace.start();
    try {
      return await firebaseRealtimeDatabaseRepository.fetchSpecificFirebaseState(
        params.start,
        params.end,
        params.group,
      );
    } finally {
      await customTrace.stop();
    }
  }
}
