import 'dart:async';
import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

final _log = useLogger();

class SocketConnectFeedback {
  final Socket socket;
  final Completer<void> completer;
  Function(dynamic data)? onSocketConnecting;
  Function(dynamic data)? onSocketDisconnect;
  Function(dynamic data)? onSocketError;
  Function(dynamic data)? onSocketConnectError;
  Function(dynamic data)? onSocketConnected;
  Function(dynamic data)? onSocketReconnect;
  Function(dynamic data)? onSocketReconnectAttempt;
  Function(dynamic data)? onSocketReconnecting;

  SocketConnectFeedback({
    required this.socket,
    required this.completer,
    this.onSocketConnecting,
    this.onSocketDisconnect,
    this.onSocketError,
    this.onSocketConnectError,
    this.onSocketConnected,
    this.onSocketReconnect,
    this.onSocketReconnectAttempt,
    this.onSocketReconnecting,
  });

  _errorConverter(String callFrom, data) {
    String errorData = 'NO_DATA';
    if (data != null) {
      if (data is WebSocketException) {
        errorData = data.message;
        _log.e('Error WebSocketException : $errorData');
      } else if (data is String) {
        errorData = data;
      } else {
        errorData = data.toString();
      }
    }

    Exception error = SocketUnknownException('From SocketConnectFeedback (data: $errorData)');

    if (data == 'UnAuthorizedError' || data == 'ForbiddenError') {
      error = ApiUnauthorizedException();
    } else if (data == 'timeout') {
      error = SocketTimeoutException('From SocketConnectFeedback');
    }

    // for offline deleted account or if found invalid token force log out
    // for switch account then has been deleted account
    else if (errorData.contains('Invalid token.')) {
      _log.e('Cannot get user profile because of socket cannot connect: Invalid token from user has been deleted');
      eventBus.fire(UserExpiredEvent());
      error = ApiUnauthorizedException('Invalid token');
    } else if (errorData.contains('HandshakeException')) {
      error = SocketHandshakeException(errorData.split(':').lastOrNull?.trim() ?? errorData);
    }

    final logMsg = '$callFrom (Data: $errorData)';
    _log.e(
      UChatLogMessage(
        message: logMsg,
        additionalMessage: logMsg,
        error: error,
        additionalData: {
          'errorData': errorData,
          'callFrom': callFrom,
          'socketId': socket.id,
        },
      ),
    );

    // Broadcast event
    eventBus.fire(SocketConnectErrorEvent(error: error));

    onSocketError?.call(data);
    if (!completer.isCompleted) {
      completer.completeError(error);
    }
  }

  onError(data) {
    _errorConverter('onError', data);
  }

  onConnect(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) OnConnect\n(Data: $errorData)';
    _log.d(logMsg);

    onSocketConnected?.call(data);

    // Ack future
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  onConnectTimeout(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) onConnectTimeout\n(Data: $errorData)';
    _log.d(logMsg);

    onError(data);

    // Ack future
    if (!completer.isCompleted) {
      completer.completeError(SocketTimeoutException(errorData));
    }
  }

  onConnectError(data) {
    try {
      _errorConverter('onConnectError', data);
    } catch (e, stackTrace) {
      _log.e('OnSocketConnectError', e, stackTrace);
    }

    onSocketConnectError?.call(data);
  }

  onConnecting(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) onConnecting\n(Data: $errorData)';
    _log.d(logMsg);

    onSocketConnecting?.call(data);
  }

  onDisconnect(data) {
    // final errorData = data?.toString() ?? 'NO_DATA';
    // final logMsg = '(SID: ${socket.id}) OnDisconnect\n(Data: $errorData)';
    // _log.d('[$connectionId] $logMsg');

    onSocketDisconnect?.call(data);
  }

  onReconnect(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) OnReConnect\n(Data: $errorData)';
    _log.d(logMsg);

    onSocketReconnect?.call(data);
  }

  onReconnectAttempt(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) onReconnectAttempt\n(Data: $errorData)';
    _log.d(logMsg);

    onSocketReconnectAttempt?.call(data);
  }

  onReconnectFailed(data) {
    _errorConverter('onReconnectFailed', data);
  }

  onReconnectError(data) {
    _errorConverter('onReconnectError', data);
  }

  onReconnecting(data) {
    final errorData = data?.toString() ?? 'NO_DATA';
    final logMsg = '(SID: ${socket.id}) onReconnecting\n(Data: $errorData)';
    _log.d(logMsg);

    onSocketReconnecting?.call(data);
  }

  void onPing(data) {
    // _log.d('(SID: ${socket.id}) initSocketEvent->onPing (Data: ${data?.toString() ?? 'NO_DATA'})');
  }

  void onPong(data) {
    // _log.d('(SID: ${socket.id}) initSocketEvent->onPong (Data: ${data?.toString() ?? 'NO_DATA'})');
  }

  // Assign event
  assignEvents() {
    // _log.d('[$connectionId] Assign event.');

    // When on connect, then return success state
    socket.on('connect', onConnect);
    socket.on('connect_timeout', onConnectTimeout);
    socket.on('connect_error', onConnectError);
    socket.on('connecting', onConnecting);

    // When error catch it!
    socket.on('error', onError);

    socket.on('disconnect', onDisconnect);

    socket.on('reconnect', onReconnect);
    socket.on('reconnect_attempt', onReconnectAttempt);
    socket.on('reconnect_failed', onReconnectFailed);
    socket.on('reconnect_error', onReconnectError);
    socket.on('reconnecting', onReconnecting);

    socket.on('ping', onPing);
    socket.on('pong', onPong);
  }

  clearEvents() {
    socket.off('connect', onConnect);
    socket.off('connect_timeout', onConnectTimeout);
    socket.off('connect_error', onConnectError);
    socket.off('connecting', onConnecting);
    socket.off('error', onError);
    socket.off('disconnect', onDisconnect);
    socket.off('reconnect', onReconnect);
    socket.off('reconnect_attempt', onReconnectAttempt);
    socket.off('reconnect_failed', onReconnectFailed);
    socket.off('reconnect_error', onReconnectError);
    socket.off('reconnecting', onReconnecting);
    socket.off('ping', onPing);
    socket.off('pong', onPong);
  }
}
