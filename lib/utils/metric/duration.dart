import 'package:flutter/cupertino.dart';
import 'package:uchat/utils/date.dart';

@Deprecated('Use [DurationMetric] of core/analytics/metric instead')
class DurationMetric {
  final String debugMessage;
  final DateTime startTime = DateTime.now();

  DurationMetric({this.debugMessage = ''});

  void stop() {
    final now = DateTime.now();
    final processDuration = now.diff(startTime);

    debugPrint('[DurationMetric] $debugMessage -> Process time: ${processDuration.inMilliseconds}ms');
  }
}
