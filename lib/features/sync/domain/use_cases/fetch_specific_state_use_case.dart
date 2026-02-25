import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_state_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/state_group.dart';
import '../../data/models/payloads/get_state.dart';
import '../repositories/sync_server_repository.dart';

class FetchSpecificStateParams {
  final int start;
  final int end;

  // The group name for the state
  final String group;

  FetchSpecificStateParams({
    required this.start,
    required this.end,
    required this.group,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FetchSpecificStateParams && other.start == start && other.end == end && other.group == group;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ group.hashCode;
}

@Deprecated('Use FetchSpecificFirebaseStateUseCase instead')
class FetchSpecificStateUseCase extends SimpleUseCase<List<UpdateStateModel>?, FetchSpecificStateParams> {
  SyncServerRepository get syncServerRepository => GetIt.I<SyncServerRepository>();

  @override
  Future<List<UpdateStateModel>?> call(FetchSpecificStateParams params) async {
    final start = params.start;
    final end = params.end;
    final group = params.group;

    if (end < start) {
      return null;
    }

    final customTrace = usePerformance().newTrace('sync-specific-${group.toLowerCase()}');
    await customTrace.start();

    useLogger().d('[$group] Sync specific from [$start] to [$end]');

    // When have current seq, update from state list
    final GetStateRequest req = GetStateRequest()
      ..group = StateGroup.from(group)
      ..startSeq = start
      ..endSeq = end;

    GetStateResponse? res;
    try {
      res = await syncServerRepository.fetchStates(req);
    } on ApiStateLimitExceedException catch (e, stackTrace) {
      useLogger().d('[$group] Sync specific error, because STATE_LIMIT_EXCEED.', e, stackTrace);

      await customTrace.stop();
      rethrow;
    } catch (e, stackTrace) {
      useLogger().e('[$group] Call fetchStates from syncSpecific error.', e, stackTrace);

      await customTrace.stop();
      rethrow;
    }

    // Fallback response
    if (res?.states == null) {
      useLogger().w('[$group] State result is nothing.');

      await customTrace.stop();
      return null;
    }

    await customTrace.stop();
    return res?.states;
  }
}
