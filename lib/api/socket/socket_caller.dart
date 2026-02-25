import 'dart:async';
import 'dart:math';

import 'package:async_queue/async_queue.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets.dart';

import '../http/http_caller.dart';
import 'socket_connect_feedback.dart';
import 'socket_handler.dart';
import 'socket_heartbeat.dart';
import 'socket_monitoring.dart';
import 'socket_response.dart';

final _log = useLogger();

const reconnectionAttempts = 0;
const socketConnectTimeoutMs = 10000;
const emitCallTimeout = Duration(seconds: 5);

///
/// This is for reconnect backoff delay logic.
///
const reconnectBaseDelayMs = 500; // 0.5 second
const reconnectMaxDelayMs = 30000; // 0.5 minute
const reconnectBackoffFactor = 1.5; // factor to increase delay
const reconnectBackoffInterval = 5; // Every 5 reconnect attempts, will increase the delay

const queueConnectLabel = 'connect';
const queueDisconnectLabel = 'disconnect';

///
/// SocketCaller is a singleton class that handles socket connection and communication.
/// It provides methods to connect, disconnect, and emit events to the server.
/// It also handles reconnection logic with exponential backoff.
///
class SocketCaller {
  ///
  /// Singleton Constructor
  ///
  static final SocketCaller instance = SocketCaller._internal();

  factory SocketCaller() => instance;

  SocketCaller._internal();

  ///
  /// Socket instance
  /// Included with [socket] getter for initiate socket connection
  ///
  io.Socket? _socket;

  io.Socket get socket {
    return _socket ??= io.io(AppEnv.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'forceNew': true,
      'reconnectionAttempts': reconnectionAttempts,
      'timeout': socketConnectTimeoutMs,
      'path': '/socket.io' // optional
    });
  }

  ///
  /// Socket heartbeat handler
  ///
  SocketHeartbeat? _heartbeat;

  SocketHeartbeat get heartbeat {
    _heartbeat ??= SocketHeartbeat(socketCaller: this);

    return _heartbeat!;
  }

  bool get isReadyForCall {
    if (socket.disconnected || isConnecting || !isConnected) {
      return false;
    }

    if (heartbeat.packetLossRate > 0.1) {
      return false;
    }

    if (heartbeat.averageLatency > 4000) {
      return false;
    }

    return true;
  }

  ///
  /// Socket monitoring handler
  ///
  SocketMonitoring? _monitoring;

  SocketMonitoring get monitoring {
    _monitoring ??= SocketMonitoring(socketCaller: this);

    return _monitoring!;
  }

  ///
  /// Current access token for socket connection
  ///
  String? accessToken;

  ///
  /// Reconnect counter
  ///
  final _reconnectCount = 0.obs;
  final _reconnectAttempts = 0.obs;
  final _isWaitingForReconnectAttempts = false.obs;
  final _lastReconnectTime = Rx<DateTime?>(null);

  int get reconnectCount => _reconnectCount.value;

  int get reconnectAttempts => _reconnectAttempts.value;

  bool get isWaitingForReconnectAttempts => _isWaitingForReconnectAttempts.value;

  DateTime? get lastReconnectTime => _lastReconnectTime.value;

  ///
  /// Delay time for reconnect (ms)
  ///
  final _reconnectCurrentDelayMs = 0.obs;

  int get reconnectCurrentDelayMs => _reconnectCurrentDelayMs.value;

  ///
  /// Current socket id
  ///
  final _socketId = ''.obs;

  String get socketId => _socketId.value;

  ///
  /// Last time to connect successfully
  ///
  DateTime? lastTimeToConnect;

  ///
  /// Queue for connect.
  /// This logic is to prevent duplicate connect
  ///
  final _connectQueue = AsyncQueue.autoStart(allowDuplicate: false);

  ///
  /// Socket status
  ///
  final _isConnecting = false.obs;

  bool get isConnecting => _isConnecting.value;

  bool get isConnected => _socket?.connected ?? false;

  bool get isDisconnected => _socket?.disconnected ?? false;

  bool get isReconnecting => _socket?.io.reconnecting ?? false;

  ///
  /// Connect with current token
  ///
  void connect({Duration? timeout}) async {
    if (accessToken != null) {
      return connectWithToken(accessToken!, timeout: timeout);
    }
  }

  ///
  /// Connect socket with token wrapper.
  ///
  void connectWithToken(String token, {Duration? timeout}) async {
    _connectQueue.addJob(
      (_) async {
        try {
          _isConnecting.value = true;
          await _connectWithToken(token, timeout: timeout);
          refreshDataWhenReconnected();
        } catch (e, stackTrace) {
          _log.e('Connect with token wrapper error.', e, stackTrace);

          reconnect();
        } finally {
          _isConnecting.value = false;
        }
      },
      label: queueConnectLabel,
    );
  }

  ///
  /// For helper to reconnect socket with exponential backoff.
  ///
  void reconnect() async {
    if (accessToken == null) {
      _log.d('Reconnect aborted: no access token');
      return;
    }

    if (GetIt.I<LifeCycleService>().isPaused) {
      _log.d('Reconnect aborted: app is paused');
      return;
    }

    if (ConnectivityController.instance.connectivityResult.contains(ConnectivityResult.none)) {
      _log.d('Reconnect aborted: no connectivity');
      return;
    }

    if (isConnecting) {
      _log.d('Reconnect aborted: already connecting');
      return;
    }

    if (_isWaitingForReconnectAttempts.value) {
      _log.d('Reconnect aborted: already waiting for reconnect');
      return;
    }

    _reconnectAttempts.value++;
    _isWaitingForReconnectAttempts.value = true;
    final delayMs = calculateReconnectBackoffDelay();

    // Add jitter to prevent thundering herd
    final jitter = Random().nextInt(1000);
    final totalDelay = delayMs + jitter;

    _log.d('Reconnecting with exponential backoff: ${totalDelay}ms (attempt: ${_reconnectAttempts.value})');

    try {
      _lastReconnectTime.value = DateTime.now();
      await Future.delayed(Duration(milliseconds: totalDelay));
      connect();
    } catch (e, stackTrace) {
      _log.e('Error during reconnect', e, stackTrace);
    } finally {
      _isWaitingForReconnectAttempts.value = false;
    }
  }

  ///
  /// Connect socket with token.
  /// Please use with [connectWithToken] instead of [_connectWithToken]
  ///
  Future<void> _connectWithToken(String token, {Duration? timeout}) async {
    // Disconnect before connect
    if (isConnected) {
      if (accessToken != token) {
        SocketHandler().unSubscribe();
        _socket?.disconnect();
      } else {
        _log.d('Already connected with the same token');
        resetReconnectBackoffDelay();
        return;
      }
    }

    _log.d('Connecting with token: ${token.substring(0, 10)}...');

    // Reset [reconnectCount] when change token.
    if (accessToken != token) {
      _socket = null;
      _reconnectCount.value = -1;
      _log.d('Token changed, resetting socket and reconnect count');
    }

    // Call init socket event because
    // disconnect() clear all listener
    socket.clearListeners();

    final Completer<void> c = Completer();

    lastTimeToConnect = DateTime.now();

    accessToken = token;
    socket.io.options?['query'] = {
      'token': accessToken,
      ...GetIt.I<MetaService>().toMap(),
    };

    final feedback = SocketConnectFeedback(
      socket: socket,
      completer: c,
    );

    feedback.onSocketConnectError = (data) {
      heartbeat.stopHeartbeatSystem();

      String errorMsg = data?.toString() ?? 'Unknown error';
      _log.e('Socket connect error: $errorMsg');

      // Check for maintenance mode error
      if (errorMsg.contains('maintenance') || errorMsg.contains('service unavailable')) {
        _log.w('Service is on maintenance mode');
        if (!c.isCompleted) {
          c.completeError(ServiceOnMaintenanceModeException(
            message: 'Service is on maintenance mode',
            code: 503,
            type: 'SERVICE_UNAVAILABLE',
          ));
        }
        return;
      }

      if (errorMsg.contains('Failed host lookup')) {
        _log.e('Failed host lookup - network issue');
        eventBus.fire(SocketDisconnectedEvent(data: errorMsg));
        if (!c.isCompleted) {
          c.completeError(FailedHostLookupException(message: errorMsg));
        }
      }

      if (!isConnecting && accessToken != null) {
        _log.d('Scheduling reconnect (attempt: ${_reconnectAttempts.value})');
        reconnect();
      }
    };

    feedback.onSocketError = (data) {
      heartbeat.stopHeartbeatSystem();

      String errorMsg = data?.toString() ?? 'Unknown error';
      _log.e('Socket error: $errorMsg');

      if (errorMsg.contains('Failed host lookup')) {
        _log.e('Failed host lookup - network issue');
        eventBus.fire(SocketDisconnectedEvent(data: errorMsg));
      }

      if (!isConnecting && accessToken != null) {
        _log.d('Scheduling reconnect after error (attempt: ${_reconnectAttempts.value})');
        reconnect();
      }
    };

    feedback.onSocketConnected = (data) {
      if (socket.id case final String currentSocketId?) {
        _socketId.value = currentSocketId;
      }

      _log.d('Socket connected successfully (SID: ${socket.id})');

      try {
        SocketHandler().subscribe();
        Orchestrator.run(OrchestratorTaskType.onSocketConnected);

        _reconnectCount.value++;
        resetReconnectBackoffDelay();
        heartbeat.startHeartbeatSystem();
        HttpCaller.instance.heartbeat.resetMetrics();

        if (!c.isCompleted) {
          c.complete();
        }
      } catch (e, stackTrace) {
        _log.e('Error in onSocketConnected handler', e, stackTrace);
        if (!c.isCompleted) {
          c.completeError(e);
        }
      }
    };

    feedback.onSocketConnecting = (data) {
      _log.d('Socket connecting... (SID: $socketId)');
      eventBus.fire(SocketConnectingEvent());
    };

    feedback.onSocketReconnect = (data) {
      _log.d('Socket reconnected successfully (SID: $socketId)');

      try {
        Orchestrator.run(OrchestratorTaskType.onSocketConnected);
        SocketHandler().subscribe();

        _reconnectCount.value++;
        resetReconnectBackoffDelay();
        heartbeat.startHeartbeatSystem();
        HttpCaller.instance.heartbeat.resetMetrics();
      } catch (e, stackTrace) {
        _log.e('Error in onSocketReconnect handler', e, stackTrace);
      }
    };

    feedback.onSocketReconnecting = (data) {
      _log.d('Socket reconnecting... (attempt: ${_reconnectAttempts.value})');
      eventBus.fire(SocketConnectingEvent(isReconnect: true));
    };

    //
    // Handle when socket is disconnected.
    // This is used to handle when socket is disconnected.
    //
    feedback.onSocketDisconnect = (data) {
      String reason = data?.toString() ?? 'Unknown reason';
      _log.d('Socket disconnected (SID: $socketId) - Reason: $reason');

      eventBus.fire(SocketDisconnectedEvent(data: reason));
      heartbeat.stopHeartbeatSystem();

      // Do not try to reconnect when reason is 'io client disconnect' because it is manual disconnect
      // such as when switching accounts, adding new account.
      if (!isConnecting && accessToken != null && reason != 'io client disconnect') {
        _log.d('Scheduling reconnect after disconnect (attempt: ${_reconnectAttempts.value})');
        reconnect();
      }
    };

    //
    // Assign socket events
    feedback.assignEvents();
    socket.connect();
    eventBus.fire(SocketConnectingEvent());

    try {
      if (timeout != null) {
        // Wait for connection with timeout
        await c.future.timeout(timeout, onTimeout: () {
          _log.e('Socket connection timeout after ${timeout.inSeconds} seconds');

          // Cleanup on timeout
          feedback.clearEvents();
          socket.disconnect();

          throw SocketTimeoutException('Connection timeout after ${timeout.inSeconds} seconds');
        });
      } else {
        // Wait for connection without timeout
        await c.future;
      }
    } catch (e) {
      // Clean up on error
      if (e is! SocketTimeoutException) {
        feedback.clearEvents();
      }
      rethrow;
    }
  }

  // TODO: move to use [Orchestrator] to handle this
  void refreshDataWhenReconnected() {
    ContactsController.instance.isContactsMaintenanceWasOn(false);
    ConnectivityController.instance.isConnectMaintenanceWasOn(false);
    AppController.instance.isAlreadyShowedDialog(false);

    if (Get.currentRoute.contains('/coin/store')) {
      try {
        Get.find<CoinStoreController>().onInit();
      } catch (e) {
        _log.e('Error to find CoinsController when reconnected', e);
      }
    }
  }

  ///
  /// Helper to emit data to server
  /// [Emit message wrapper]
  ///
  /// TODO: connect socket successfully then call
  /// TODO: check why _connectingProcess always not null
  ///set token --> event --> connect --> stuck
  @Deprecated('emitCallV3')
  Future<SocketResponse> emitCall(
    String event,
    dynamic param, {
    Duration timeout = emitCallTimeout,
  }) async {
    if (socket.disconnected) {
      dismissEasyLoading();
      talker.error('EmitCall, Socket is disconnected. (event: $event)');

      throw SocketConnectionException(
        'EmitCall, Socket is disconnected. (event: $event)',
      );
    }

    try {
      final ackData = await socket.emitWithAckAsync('call', [event, param]);

      return handleAckData(ackData);
    } catch (e) {
      if (e is String) {
        if (e == 'timeout') {
          talker.error('EmitCall, Socket emit call timeout. (event: $event)');
          throw SocketTimeoutException(e);
        }

        throw SocketUnknownException(e);
      }

      rethrow;
    }
  }

  ///
  /// This function is used to handle the ack data from socket.
  /// It will check the type of the data and return the response.
  ///
  SocketResponse handleAckData(dynamic ackData) {
    // This is the Map type, may be an error.
    if (ackData is Map) {
      if (ackData['code'] case final String code) {
        throw ApiException(message: ackData['message'], code: 500, name: ackData['name'], type: code);
      } else if (ackData['code'] case final int code) {
        // Check error by code.
        if (!(code >= 200 && code < 300)) {
          // _log.w('Socket error: $data');
          talker.warning('Socket error: $ackData');

          final String? type = ackData['type'];
          final ApiException error;
          if (type == 'VALIDATION_ERROR') {
            error = ApiValidationException.fromMap(ackData);
          } else if (type == 'ERR_STATE_LIMIT_EXCEED') {
            error = ApiStateLimitExceedException.fromMap(ackData);
          } else if (type == 'ERR_DEPRECATED') {
            error = ApiDeprecatedException.fromMap(ackData);
            GetIt.I<AppVersionService>().notifyUpdate();
          } else if (type == 'ERR_FRIEND_LIMIT') {
            error = ApiFriendLimitExceedException.fromMap(ackData);
          } else if (type == 'ERR_OFFICIAL_ACCOUNT_LIMIT') {
            error = ApiOfficialAccountLimitExceedException.fromMap(ackData);
          } else {
            error = ApiException.fromMap(ackData);
          }

          talker.error(error.toString());
          throw error;
        }
      }

      // Fallback the error.
      if (ackData['message'] != null && ackData['name'] != null) {
        ackData['code'] ??= 500;
        final error = ApiException.fromMap(ackData);
        talker.error(error.toString());
        throw error;
      } else {
        ackData['code'] ??= 500;
        final error = SocketUnknownException('from ack->data is not list (data: $ackData)');
        talker.error(error.toString());
        throw error;
      }
    }

    // This is the List type, may be a success.
    if (ackData is List) {
      return SocketResponse(
        data: ackData.last,
        rawData: ackData,
      );
    }

    // This is the other type, may be an error.
    final error = SocketUnknownException('from ack->other case (data: $ackData) (type: ${ackData.runtimeType})');
    talker.error(error.toString());
    throw error;
  }

  ///
  /// Helper to emit data to server
  ///
  Future<SocketResponse> emitCallV3(String event, dynamic param, {Duration timeout = emitCallTimeout}) async {
    if (socket.disconnected) {
      dismissEasyLoading();
      talker.error('EmitCall, Socket is disconnected. (event: $event)');

      throw SocketConnectionException(
        'EmitCall, Socket is disconnected. (event: $event)',
      );
    }

    try {
      final ackData = await socket.emitWithAckAsync('callV3', [event, param]);

      return handleAckData(ackData);
    } catch (e) {
      if (e is String) {
        if (e == 'timeout') {
          talker.error('EmitCall, Socket emit call timeout. (event: $event)');
          disconnect();
          throw SocketTimeoutException(e);
        }

        throw SocketUnknownException(e);
      }

      rethrow;
    }
  }

  ///
  /// Socket disconnection
  ///
  void disconnect({Function()? afterDisconnect}) {
    _connectQueue.addJob(
      (_) {
        if (_socket == null || _socket?.disconnected == true || _socket?.connected == false || isConnecting) {
          return;
        }
        _socket?.disconnect();
        _socket?.clearListeners();
        _socket = null;

        afterDisconnect?.call();
      },
      label: queueDisconnectLabel,
    );
  }

  ///
  /// Clear credential.
  /// Using when user logout.
  ///
  void clearCredential() {
    accessToken = null;
    _socket?.io.options?['query'] = {};
  }

  void dismissEasyLoading() {
    UChatLoading.hide();
  }

  ///
  /// Helper to calculate reconnect backoff delay in ms unit.
  /// This is used to calculate the delay time for reconnect.
  ///
  int calculateReconnectBackoffDelay() {
    if (_reconnectAttempts.value <= 0) {
      _reconnectCurrentDelayMs.value = reconnectBaseDelayMs;
      return reconnectBaseDelayMs;
    }

    final backoffStep = (_reconnectAttempts.value - 1) ~/ reconnectBackoffInterval;
    final calculatedDelay = (reconnectBaseDelayMs * pow(reconnectBackoffFactor, backoffStep)).toInt();

    _reconnectCurrentDelayMs.value = min(calculatedDelay, reconnectMaxDelayMs);
    return _reconnectCurrentDelayMs.value;
  }

  ///
  /// This function is used to reset the backoff delay to the base delay.
  ///
  void resetReconnectBackoffDelay() {
    _reconnectAttempts.value = 0;
    _reconnectCurrentDelayMs.value = reconnectBaseDelayMs;
  }
}
