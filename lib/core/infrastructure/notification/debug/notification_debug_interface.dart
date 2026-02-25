import 'notification_log_entity.dart';

/// Interface for notification debugging functionality
///
/// This interface defines the contract for notification logging and debugging
/// services. It provides methods for logging various notification events and
/// querying the logged data for analysis.
abstract class INotificationDebugInterface {
  /// Returns true if notification logging is enabled
  bool get isEnabled;

  // Core logging methods

  /// Logs when a notification is received from the server
  void logNotificationReceived(NotificationLogEntity log);

  /// Logs when a notification is clicked by the user
  void logNotificationClicked(NotificationLogEntity log);

  // Query methods

  /// Gets notification logs with optional filtering by room ID and timestamp
  List<NotificationLogEntity> getNotificationLogs({
    String? roomId,
    DateTime? since,
    DateTime? until,
    int? limit,
  });

  // Cleanup methods

  /// Clears all logged data
  void clearAllData();

  /// Clears only notification logs
  void clearNotificationLogs();

  // Statistics methods

  /// Returns statistics about the logged data
  Map<String, dynamic> getStatistics();
}

/// Interface for notification debug configuration
///
/// This interface defines the contract for managing debug feature toggles
/// and configuration settings.
abstract class INotificationDebugConfigInterface {
  /// Returns true if notification logging is enabled
  bool get isNotificationLoggingEnabled;

  /// Sets whether notification logging is enabled
  Future<void> setNotificationLoggingEnabled(bool enabled);

  /// Gets all debug settings as a map
  Map<String, dynamic> getAllDebugSettings();

  /// Resets all debug settings to their default values
  Future<void> resetAllDebugSettings();
}

/// Interface for notification debug filtering
///
/// This interface defines the contract for filtering notification debug data
/// based on various criteria.
abstract class INotificationDebugFilterInterface {
  /// Filters notification logs based on the provided criteria
  List<NotificationLogEntity> filterNotificationLogs(
    List<NotificationLogEntity> logs, {
    String? roomId,
    NotificationLogType? logType,
    DateTime? startTime,
    DateTime? endTime,
    int? minProcessingTime,
    int? maxProcessingTime,
    bool? hasErrors,
    String? searchText,
  });
}

/// Interface for notification debug analysis
///
/// This interface defines the contract for analyzing notification debug data
/// to identify patterns and potential issues.
abstract class INotificationDebugAnalysisInterface {
  /// Analyzes notification processing performance
  NotificationPerformanceAnalysis analyzeNotificationPerformance({
    String? roomId,
    DateTime? startTime,
    DateTime? endTime,
  });
}

/// Result of a notification performance analysis
class NotificationPerformanceAnalysis {
  /// Average processing time in milliseconds
  final int averageProcessingTime;

  /// Maximum processing time in milliseconds
  final int maxProcessingTime;

  /// Minimum processing time in milliseconds
  final int minProcessingTime;

  /// Number of notifications analyzed
  final int notificationCount;

  /// Number of errors encountered
  final int errorCount;

  /// Error rate as a percentage
  final double errorRate;

  const NotificationPerformanceAnalysis({
    required this.averageProcessingTime,
    required this.maxProcessingTime,
    required this.minProcessingTime,
    required this.notificationCount,
    required this.errorCount,
    required this.errorRate,
  });
}

/// Result of a queue behavior analysis
class QueueBehaviorAnalysis {
  /// Average queue length
  final double averageQueueLength;

  /// Maximum queue length observed
  final int maxQueueLength;

  /// Number of jobs processed
  final int jobsProcessed;

  /// Number of jobs that failed
  final int jobsFailed;

  /// Job success rate as a percentage
  final double successRate;

  /// Average job processing time in milliseconds
  final int averageJobProcessingTime;

  const QueueBehaviorAnalysis({
    required this.averageQueueLength,
    required this.maxQueueLength,
    required this.jobsProcessed,
    required this.jobsFailed,
    required this.successRate,
    required this.averageJobProcessingTime,
  });
}
