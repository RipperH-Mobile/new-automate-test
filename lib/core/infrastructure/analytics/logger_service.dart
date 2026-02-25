import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:logger/logger.dart' as fl;
import 'package:logging/logging.dart' as lg;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/features/sync/domain/sync_domain.dart';
import 'package:uchat/utils/app_env.dart';

import '../orchestrator/navigation/navigation_coordinator.dart';
import 'logger/filter.dart';
import 'logger/output.dart';
import 'performance_service.dart';

export 'package:logger/logger.dart' show LogEvent, Level;

export 'logger/message.dart';

LoggerService useLogger() {
  return GetIt.I<LoggerService>();
}

final talker = Talker(
  settings: TalkerSettings(
    enabled: true,
    maxHistoryItems: 100,

    /// You can enable/disable console logs
    useConsoleLogs: false,
  ),
  logger: TalkerLogger(),
);

class LoggerService {
  fl.Logger? logger;

  void initialize() {
    lg.Logger.root.level = kDebugMode ? lg.Level.FINE : lg.Level.OFF;
    lg.Logger.root.onRecord.listen((record) {
      final exclude = [
        'socket_io_client:engine.Socket',
        'socket_io:parser.Encoder',
        'socket_io_client:Socket',
      ];

      if (exclude.contains(record.loggerName)) {
        return;
      }

      debugPrint(
        '${record.time} - ${record.level.name} [${record.loggerName}]: >>> ${record.message}',
      );
    });

    logger = fl.Logger(
      level: LoggerService.reportLevel,
      filter: UChatLogFilter(),
      output: UChatLogOutput(),
      printer: fl.PrefixPrinter(
        fl.PrettyPrinter(
          methodCount: 10,
          // number of method calls to be displayed
          errorMethodCount: 30,
          // number of method calls if stacktrace is provided
          lineLength: 120,
          // width of the output
          colors: false,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          dateTimeFormat: fl.DateTimeFormat.onlyTime,
          // Should each log print contain a timestamp
          excludePaths: [
            'package:uchat/core/analytic/logger',
          ],
        ),
      ),
    );

    fl.Logger.removeLogListener(LoggerService.talkerLoggerListener);
    fl.Logger.addLogListener(LoggerService.talkerLoggerListener);
  }

  static Future<void> talkerLoggerListener(fl.LogEvent event) async {
    switch (event.level) {
      case fl.Level.all:
      case fl.Level.info:
        talker.info(event.message);
        break;
      case fl.Level.trace:
      case fl.Level.debug:
        talker.debug(event.message);
        break;
      case fl.Level.warning:
        talker.warning(event.message);
        break;
      case fl.Level.fatal:
      case fl.Level.error:
        talker.error(event.message);
        if (event.error != null) {
          talker.handle(event.error!, event.stackTrace);
        }
        break;

      default:
        talker.info(event.message);
        break;
    }
  }

  static fl.Level get reportLevel {
    return !AppEnv.isProd || kDebugMode ? fl.Level.debug : fl.Level.warning;
  }

  static fl.Level get sentryReportLevel {
    return !AppEnv.isProd ? fl.Level.warning : fl.Level.error;
  }

  void addLogListener(fl.LogCallback callback) {
    fl.Logger.addLogListener(callback);
  }

  void removeLogListener(fl.LogCallback callback) {
    fl.Logger.removeLogListener(callback);
  }

  /// Log a message at level [Level().verbose].
  void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.t(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (error is DioException) {
      logger?.d(
        '[Uri]\n'
        '${error.requestOptions.uri}\n\n'
        '[RequestData]\n'
        '${error.requestOptions.data}\n\n'
        '[RequestParam]\n'
        '${error.requestOptions.queryParameters}\n\n'
        '[Response]\n'
        '${error.response?.data}\n'
        '[Message]\n'
        '${message.toString()}',
        error: error,
        stackTrace: stackTrace,
      );
      return;
    }

    logger?.d(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.i(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.w(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.e(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void eNoError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.f].
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger?.f(
      error != null ? '$message (e: $error)' : message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void close() {
    if (!isClosed()) {
      logger?.close();
    }
  }

  bool isClosed() {
    return logger?.isClosed() ?? false;
  }

  /// Register an [OutputCallback] which is called for each new [OutputEvent].
  static void addOutputListener(fl.OutputCallback callback) {
    fl.Logger.addOutputListener(callback);
  }

  /// Removes a [OutputCallback] which was previously registered.
  ///
  /// Returns whether the callback was successfully removed.
  static void removeOutputListener(fl.OutputCallback callback) {
    fl.Logger.removeOutputListener(callback);
  }

  void setEnableTalker(bool enable) {
    talker.settings.enabled = enable;
  }

  Talker getTalker() {
    return talker;
  }

  ///
  /// Send troubleshoot message to server
  /// For temporary use only
  ///
  Future<void> sendTroubleshootMessage({required String topic, Map<String, dynamic>? data}) async {
    final performance = usePerformance().create('send-troubleshoot-message');
    await performance.start();
    final sendData = data ?? {};

    try {
      final response = await HttpCaller.instance.post(
        'v3/troubleshoots',
        data: {
          'topic': topic,
          'data': {
            'meta': await _getCurrentStatistics(),
            'additional': sendData,
          },
        },
      );
      useLogger().d('Successfully sent troubleshoot message', response.data);
    } catch (e, stackTrace) {
      useLogger().e('Failed to send troubleshoot message', e, stackTrace);
    }

    await performance.stop();
  }

  ///
  /// Get current statistics like a troubleshoot screen
  /// Don't send any sensitive data.
  ///
  Future<Map<String, dynamic>> _getCurrentStatistics() async {
    final currentStatistics = <String, dynamic>{};

    // App
    final appSettings = AppSettingsController.instance;
    final navigationCoordinator = GetIt.I<NavigationCoordinator>();
    currentStatistics['app'] = {
      'app_version': appSettings.version.value,
      'build_number': appSettings.buildNumber.value,
      'first_route_is_called': navigationCoordinator.firstRouteToIsCalled,
    };

    // OneSignal
    final oneSignalId = await OneSignal.User.getOnesignalId();
    final pushSubscriptionId = OneSignal.User.pushSubscription.id;

    currentStatistics['onesignal'] = {
      'onesignal_user_id': oneSignalId,
      'push_subscription_id': pushSubscriptionId,
    };

    // Calling
    currentStatistics['call'] = {
      'onesignal_user_id': UChatCallNativeMethodChanel.instance.oneSignalId,
      'voip_token': UChatCallNativeMethodChanel.instance.voipToken,
      'test_type': UChatCallNativeMethodChanel.instance.testType,
    };

    // Connectivity
    final connectivity = ConnectivityController.instance;
    currentStatistics['connectivity'] = {
      'status': connectivity.connectivityStatus.value,
    };

    // Socket Connection
    final socketCaller = SocketCaller.instance;
    currentStatistics['socket_connection'] = {
      'socket_id': socketCaller.socketId,
      'reconnect_count': socketCaller.reconnectCount,
      'reconnect_attempts': socketCaller.reconnectAttempts,
      'is_ready_for_call': socketCaller.isReadyForCall,
      'is_connecting': socketCaller.isConnecting,
      'heartbeat': {
        'history_count': socketCaller.heartbeat.heartbeatHistory.length,
        'last_heartbeat_time': socketCaller.heartbeat.lastHeartbeatTime?.toIso8601String(),
        'average_latency': socketCaller.heartbeat.averageLatency,
        'packet_loss': socketCaller.heartbeat.packetLossRate,
      },
      'monitoring': {
        'last_checked_time': socketCaller.monitoring.lastCheckedTime?.toIso8601String(),
        'last_force_reconnect_time': socketCaller.monitoring.lastForceReconnectTime?.toIso8601String(),
        'force_reconnect_count': socketCaller.monitoring.forceReconnectCount,
        'found_disconnected_count': socketCaller.monitoring.foundDisconnectedCount,
      },
    };

    // Http Connection
    final httpCaller = HttpCaller.instance;
    currentStatistics['http_connection'] = {
      'heartbeat': {
        'history_count': httpCaller.heartbeat.heartbeatHistory.length,
        'last_heartbeat_time': httpCaller.heartbeat.lastHeartbeatTime?.toIso8601String(),
        'average_latency': httpCaller.heartbeat.averageLatency,
        'success_rate': httpCaller.heartbeat.successRate,
      }
    };

    // SyncService
    final syncService = GetIt.I<SyncService>();
    currentStatistics['sync_service'] = {
      'is_syncing': syncService.isQueueProcessing.value,
      'last_sync_time': syncService.lastSyncTime?.toIso8601String(),
    };

    for (final syncProcessor in syncService.syncProcessors) {
      currentStatistics['sync_service'][syncProcessor.group.value] = {
        'current_state_version': syncProcessor.currentStateSeq,
        'first_sync_version': syncProcessor.syncingFirstStateSeq,
        'last_sync_version': syncProcessor.syncingLastStateSeq,
        'add_state_queue': syncProcessor.addStateQueue.size,
        'sync_queue_size': syncProcessor.addStateQueue.size,
        'last_process_time': syncProcessor.lastProcessTime?.toIso8601String(),
        'last_adding_time': syncProcessor.lastAddingTime?.toIso8601String(),
        'last_fetch_time': syncProcessor.lastFetchTime?.toIso8601String(),
        'missing_state_count': syncProcessor.missingStateCount,
        'exceeding_state_count': syncProcessor.exceedStateCount,
      };
    }

    return currentStatistics;
  }
}
