import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';

/// Constants for ChatRoom performance tracing
class ChatRoomTraceNames {
  static const String onInit = 'performance_screen_lag_open_chat_room_on_init';
  static const String initData = 'performance_screen_lag_open_chat_room_init_data';
  static const String messageLoad = 'performance_screen_lag_open_chat_room_load';
  static const String olderMessageLoad = 'performance_screen_lag_open_chat_room_older_load';
}

/// Constants for ChatRoom performance metrics
class ChatRoomMetricNames {
  static const String firstRenderTimeMs = 'firstRenderTimeMs';
  static const String fullLoadTimeMs = 'fullLoadTimeMs';
  static const String olderMessageLoadTimeMs = 'olderMessageLoadTimeMs';
  static const String messageCount = 'messageCount';
  static const String fileSizeMb = 'fileSizeMb';
  static const String totalLocalMessage = 'totalLocalMessage';
  static const String totalUnreadMessage = 'totalUnreadMessage';
}

/// Constants for ChatRoom performance attributes
class ChatRoomAttributeNames {
  static const String userId = 'userId';
  static const String roomId = 'roomId';
  static const String chatType = 'chatType';
  static const String dataType = 'dataType';
  static const String loadSize = 'loadSize';
}

/// Helper class for Firebase Performance tracing in MessageListController.
class ChatRoomTracer {
  /// Wraps a performance trace around an async operation.
  static Future<void> trace({
    required String name,
    required Future<void> Function(PerformanceTrace trace) body,
    bool isAutoTraceStart = true,
    bool isAutoTraceStop = true,
    Map<String, String>? initialAttributes,
  }) async {
    final traceInstance = PerformanceTrace.create(name);

    if (isAutoTraceStart) {
      await traceInstance.start();
    }

    try {
      initialAttributes?.forEach((key, value) {
        traceInstance.putAttribute(key, value);
      });

      await body(traceInstance);
    } catch (_) {
      rethrow;
    } finally {
      traceInstance.putAttribute(
        ChatRoomAttributeNames.userId,
        UserController.instance.currentUser.value?.id ?? '',
      );

      if (isAutoTraceStop) {
        await traceInstance.stop();
      }
    }
  }
}
