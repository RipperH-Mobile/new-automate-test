import 'duration.dart';

@Deprecated('Use `GetIt.I<>(PerformanceService)` instead')
class Metric {
  @Deprecated('Use `GetIt.I<>(PerformanceService).startDuration()` instead')
  static DurationMetric startDuration(String debugMessage) {
    return DurationMetric(debugMessage: debugMessage);
  }
}
