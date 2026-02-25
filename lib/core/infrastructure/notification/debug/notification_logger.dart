import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import 'circular_buffer.dart';
import 'message_state_entity.dart';
import 'notification_debug_toggle_service.dart';
import 'notification_log_entity.dart';

/// Central service for logging notification-related debug information
///
/// This service maintains in-memory circular buffers for different types of
/// notification events, allowing for efficient debugging without persisting
/// data to disk. It's designed to help identify and diagnose race conditions
/// in the notification handling system.
class NotificationLogger {
  // Singleton pattern
  static final NotificationLogger _instance = NotificationLogger._internal();

  factory NotificationLogger() => _instance;

  NotificationLogger._internal();

  // In-memory storage with circular buffers
  static const int _maxNotificationLogs = 500;
  static const int _maxMessageStateLogs = 100;

  final CircularBuffer<NotificationLogEntity> _notificationLogs = CircularBuffer(_maxNotificationLogs);

  final CircularBuffer<MessageStateEntity> _messageStateLogs = CircularBuffer(_maxMessageStateLogs);

  late final NotificationDebugToggleService _debugToggle;

  /// Initialize the logger with dependencies
  void initialize() {
    useLogger().d('NotificationLogger.initialize - Initializing logger');
    _debugToggle = GetIt.instance<NotificationDebugToggleService>();
    useLogger().d('NotificationLogger.initialize - DebugToggleService initialized');
  }

  /// Returns true if notification logging is enabled
  bool get isEnabled {
    try {
      useLogger().d('NotificationLogger.isEnabled - Checking if logging is enabled');
      final enabled = _debugToggle.isNotificationLoggingEnabled;
      useLogger().d('NotificationLogger.isEnabled - Debug toggle service returned: $enabled');
      return enabled;
    } catch (e) {
      // If service is not initialized, assume logging is disabled
      useLogger().e('NotificationLogger.isEnabled - Error checking enabled state', e);
      return false;
    }
  }

  // Core logging methods

  /// Logs when a notification is received from the server
  void logNotificationReceived(NotificationLogEntity log) {
    useLogger().d('NotificationLogger.logNotificationReceived - Called with notificationId: ${log.notificationId}');
    if (!isEnabled) {
      useLogger().d('NotificationLogger.logNotificationReceived - Logging is disabled, returning');
      return;
    }

    try {
      _notificationLogs.add(log);
      useLogger().d(
          'NotificationLogger.logNotificationReceived - Successfully added log for notificationId: ${log.notificationId}');
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
      // In a real implementation, we might want to log this to a file
      useLogger().e('NotificationLogger.logNotificationReceived - Error adding log', e);
    }
  }

  /// Logs when a notification is clicked by the user
  void logNotificationClicked(NotificationLogEntity log) {
    useLogger().d('NotificationLogger.logNotificationClicked - Called with notificationId: ${log.notificationId}');
    if (!isEnabled) {
      useLogger().d('NotificationLogger.logNotificationClicked - Logging is disabled, returning');
      return;
    }

    try {
      _notificationLogs.add(log);
      useLogger().d(
          'NotificationLogger.logNotificationClicked - Successfully added log for notificationId: ${log.notificationId}');
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
      useLogger().e('NotificationLogger.logNotificationClicked - Error adding log', e);
    }
  }

  // Message state logging methods

  /// Logs message state when entering a chat room
  void logMessageState(MessageStateEntity log) {
    useLogger().d('NotificationLogger.logMessageState - Called with roomId: ${log.roomId}');
    if (!isEnabled) {
      useLogger().d('NotificationLogger.logMessageState - Logging is disabled, returning');
      return;
    }

    try {
      _messageStateLogs.add(log);
      useLogger().d('NotificationLogger.logMessageState - Successfully added log for roomId: ${log.roomId}');
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
      useLogger().e('NotificationLogger.logMessageState - Error adding log', e);
    }
  }

  // Query methods

  /// Gets notification logs with optional filtering by room ID and timestamp
  List<NotificationLogEntity> getNotificationLogs({
    String? roomId,
    DateTime? since,
    DateTime? until,
    int? limit,
  }) {
    try {
      useLogger().d(
          'NotificationLogger.getNotificationLogs - Called with roomId: $roomId, since: $since, until: $until, limit: $limit');

      Iterable<NotificationLogEntity> logs = _notificationLogs.toList();
      useLogger().d('NotificationLogger.getNotificationLogs - Total logs in buffer: ${logs.length}');

      // Apply filters
      if (roomId != null) {
        logs = logs.where((log) => log.roomId == roomId);
        useLogger().d('NotificationLogger.getNotificationLogs - After roomId filter: ${logs.length}');
      }

      if (since != null) {
        logs = logs.where((log) => log.timestamp.isAfter(since));
        useLogger().d('NotificationLogger.getNotificationLogs - After since filter: ${logs.length}');
      }

      if (until != null) {
        logs = logs.where((log) => log.timestamp.isBefore(until));
        useLogger().d('NotificationLogger.getNotificationLogs - After until filter: ${logs.length}');
      }

      // Convert to list and sort by timestamp (newest first)
      final result = logs.toList();
      result.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Apply limit if specified
      if (limit != null && limit > 0) {
        final limitedResult = result.take(limit).toList();
        useLogger().d('NotificationLogger.getNotificationLogs - Returning ${limitedResult.length} logs after limit');
        return limitedResult;
      }

      useLogger().d('NotificationLogger.getNotificationLogs - Returning ${result.length} logs');
      return result;
    } catch (e) {
      useLogger().e('NotificationLogger.getNotificationLogs - Error getting logs', e);
      return [];
    }
  }

  /// Gets message state logs with optional filtering by room ID and timestamp
  List<MessageStateEntity> getMessageStateLogs({
    String? roomId,
    DateTime? since,
    DateTime? until,
    int? limit,
  }) {
    try {
      useLogger().d(
          'NotificationLogger.getMessageStateLogs - Called with roomId: $roomId, since: $since, until: $until, limit: $limit');

      Iterable<MessageStateEntity> logs = _messageStateLogs.toList();
      useLogger().d('NotificationLogger.getMessageStateLogs - Total logs in buffer: ${logs.length}');

      // Apply filters
      if (roomId != null) {
        logs = logs.where((log) => log.roomId == roomId);
        useLogger().d('NotificationLogger.getMessageStateLogs - After roomId filter: ${logs.length}');
      }

      if (since != null) {
        logs = logs.where((log) => log.timestamp.isAfter(since));
        useLogger().d('NotificationLogger.getMessageStateLogs - After since filter: ${logs.length}');
      }

      if (until != null) {
        logs = logs.where((log) => log.timestamp.isBefore(until));
        useLogger().d('NotificationLogger.getMessageStateLogs - After until filter: ${logs.length}');
      }

      // Convert to list and sort by timestamp (newest first)
      final result = logs.toList();
      result.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Apply limit if specified
      if (limit != null && limit > 0) {
        final limitedResult = result.take(limit).toList();
        useLogger().d('NotificationLogger.getMessageStateLogs - Returning ${limitedResult.length} logs after limit');
        return limitedResult;
      }

      useLogger().d('NotificationLogger.getMessageStateLogs - Returning ${result.length} logs');
      return result;
    } catch (e) {
      useLogger().e('NotificationLogger.getMessageStateLogs - Error getting logs', e);
      return [];
    }
  }

  // Cleanup methods

  /// Clears all logged data
  void clearAllData() {
    try {
      _notificationLogs.clear();
      _messageStateLogs.clear();
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
    }
  }

  /// Clears only notification logs
  void clearNotificationLogs() {
    try {
      _notificationLogs.clear();
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
    }
  }

  /// Clears only message state logs
  void clearMessageStateLogs() {
    try {
      _messageStateLogs.clear();
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
    }
  }

  // Statistics methods

  /// Returns statistics about the logged data
  Map<String, dynamic> getStatistics() {
    try {
      final logs = _notificationLogs.toList();

      // Calculate statistics for notification logs
      final receivedCount = logs.where((log) => log.logType == NotificationLogType.received).length;
      final clickedCount = logs.where((log) => log.logType == NotificationLogType.clicked).length;
      final handledCount = logs.where((log) => log.logType == NotificationLogType.handled).length;
      final errorCount = logs.where((log) => log.logType == NotificationLogType.error).length;

      // Calculate average processing time
      final processingTimes =
          logs.where((log) => log.processingTimeMs != null).map((log) => log.processingTimeMs!).toList();

      final averageProcessingTime =
          processingTimes.isEmpty ? 0 : processingTimes.reduce((a, b) => a + b) ~/ processingTimes.length;

      // Calculate statistics for message state logs
      final messageStateLogs = _messageStateLogs.toList();
      final messageStateCount = messageStateLogs.length;

      // Calculate average fetch time
      final fetchTimes =
          messageStateLogs.where((log) => log.fetchTimeMs != null).map((log) => log.fetchTimeMs!).toList();

      final averageFetchTime = fetchTimes.isEmpty ? 0 : fetchTimes.reduce((a, b) => a + b) ~/ fetchTimes.length;

      return {
        'notificationLogs': {
          'total': logs.length,
          'received': receivedCount,
          'clicked': clickedCount,
          'handled': handledCount,
          'errors': errorCount,
          'averageProcessingTime': averageProcessingTime,
        },
        'messageStateLogs': {
          'total': messageStateCount,
          'averageFetchTime': averageFetchTime,
        },
        'bufferStatus': {
          'notificationLogs': '${_notificationLogs.size}/$_maxNotificationLogs',
          'messageStateLogs': '${_messageStateLogs.size}/$_maxMessageStateLogs',
        },
      };
    } catch (e) {
      return {
        'error': 'Failed to calculate statistics: $e',
      };
    }
  }
}
