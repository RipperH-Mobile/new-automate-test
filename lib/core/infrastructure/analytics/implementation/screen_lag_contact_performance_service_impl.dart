import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/performance_tracing_service.dart';

void registerScreenLagContactPerformanceService() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<ScreenLagContactPerformanceService>(
    ScreenLagContactPerformanceService(tracingName: ScreenLagContactTracingName.mainTrace.value),
    instanceName: ScreenLagContactTracingName.mainTrace.value,
  );
  getIt.registerSingleton<ScreenLagContactPerformanceService>(
    ScreenLagContactPerformanceService(tracingName: ScreenLagContactTracingName.initGroupListDataFromLocal.value),
    instanceName: ScreenLagContactTracingName.initGroupListDataFromLocal.value,
  );
  getIt.registerSingleton<ScreenLagContactPerformanceService>(
    ScreenLagContactPerformanceService(tracingName: ScreenLagContactTracingName.initFriendListDataFromLocal.value),
    instanceName: ScreenLagContactTracingName.initFriendListDataFromLocal.value,
  );
  getIt.registerSingleton<ScreenLagContactPerformanceService>(
    ScreenLagContactPerformanceService(tracingName: ScreenLagContactTracingName.initOAListDataFromLocal.value),
    instanceName: ScreenLagContactTracingName.initOAListDataFromLocal.value,
  );
}

enum ScreenLagContactTracingName {
  mainTrace('performance_screen_lag_contact'),
  initGroupListDataFromLocal('performance_screen_lag_contact_init_group_list_data_from_local'),
  initFriendListDataFromLocal('performance_screen_lag_contact_init_friend_list_data_from_local'),
  initOAListDataFromLocal('performance_screen_lag_contact_init_oa_list_data_from_local');

  final String value;
  const ScreenLagContactTracingName(this.value);
}

enum ScreenLagContactMetricName {
  totalFriendListCount('total_friend_list_count'),
  totalGroupListCount('total_group_list_count'),
  totalOaListCount('total_oa_list_count');

  final String value;
  const ScreenLagContactMetricName(this.value);
}

enum ScreenLagContactAttributeName {
  userId('user_id'),
  appState('app_state');

  final String value;
  const ScreenLagContactAttributeName(this.value);
}

class ScreenLagContactPerformanceService extends PerformanceTracingService {
  ScreenLagContactPerformanceService({required super.tracingName});

  static ScreenLagContactPerformanceService get mainTrace {
    return GetIt.I<ScreenLagContactPerformanceService>(
      instanceName: ScreenLagContactTracingName.mainTrace.value,
    );
  }

  static ScreenLagContactPerformanceService get initGroupListDataFromLocal {
    return GetIt.I<ScreenLagContactPerformanceService>(
      instanceName: ScreenLagContactTracingName.initGroupListDataFromLocal.value,
    );
  }

  static ScreenLagContactPerformanceService get initFriendListDataFromLocal {
    return GetIt.I<ScreenLagContactPerformanceService>(
      instanceName: ScreenLagContactTracingName.initFriendListDataFromLocal.value,
    );
  }

  static ScreenLagContactPerformanceService get initOAListDataFromLocal {
    return GetIt.I<ScreenLagContactPerformanceService>(
      instanceName: ScreenLagContactTracingName.initOAListDataFromLocal.value,
    );
  }

  void putMainTraceAttribute({required String userId, required String appState}) {
    activeTrace.putAttribute(ScreenLagContactAttributeName.userId.value, userId);
    activeTrace.putAttribute(ScreenLagContactAttributeName.appState.value, appState);
  }
}
