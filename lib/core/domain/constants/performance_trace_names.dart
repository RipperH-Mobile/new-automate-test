class PerformanceTraceNames {
  const PerformanceTraceNames._();

  /// Performance flutter calling trace names:
  /// 1. performance_calling_incoming_call
  /// 2. performance_calling_accept
  /// 3. performance_calling_missed
  static const String performanceCallingIncomingCall = 'performance_calling_incoming_call';
  static const String performanceCallingAccept = 'performance_calling_accept';
  static const String performanceCallingMissed = 'performance_calling_missed';

  /// Performance screen lag notification trace names:
  /// 1. performance_screen_lag_notification_center
  static const String performanceScreenLagNotificationCenter = 'performance_screen_lag_notification_center';
}
