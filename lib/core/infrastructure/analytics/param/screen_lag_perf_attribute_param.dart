import 'package:uchat/core/infrastructure/analytics/enum/source_performance_state.dart';

class ScreenLagPerfAttributeParams {
  final String? userId;
  final SourcePerformanceState? sourcePerformanceState;

  ScreenLagPerfAttributeParams({
    this.userId,
    this.sourcePerformanceState,
  });

  Map<String, String> toNameValuePairs() {
    final Map<String, String> attributes = {};

    if (userId != null) attributes['userId'] = userId!;
    if (sourcePerformanceState != null) attributes['app_state'] = sourcePerformanceState!.value;

    return attributes;
  }
}
