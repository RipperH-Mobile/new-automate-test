import 'package:flutter/cupertino.dart';
import 'package:uchat/utils/date.dart';

class DurationMetric {
  final String name;
  DateTime _startTime = DateTime.now();

  DurationMetric(this.name);

  void start() {
    _startTime = DateTime.now();
    debugPrint(
      '[DurationMetric] $name -> Start time: +0ms (${_startTime.isToday ? _startTime.format('HH:mm:ss.S') : _startTime.toIso8601String()})',
    );
  }

  Duration get capturedDuration {
    final now = DateTime.now();
    return now.diff(_startTime);
  }

  void stop() {
    final now = DateTime.now();
    final processDuration = now.diff(_startTime);

    debugPrint(
      '[DurationMetric] $name -> Process time: +${processDuration.inMilliseconds}ms (${now.format('HH:mm:ss.S')})',
    );
  }
}
