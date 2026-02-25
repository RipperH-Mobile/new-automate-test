import 'dart:async';

import 'package:get/get.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

const int heartbeatIntervalMs = 15000; // Send heartbeat every 3 seconds
const int heartbeatTimeoutMs = 30000; // Timeout for heartbeat response
const int maxHeartbeatHistorySize = 30; // Store history of last 50 heartbeats
const int highLatencyThresholdMs = 4000; // 4 seconds latency threshold
const double highPacketLossThreshold = 0.15; // 15% packet loss is considered high
const double criticalPacketLossThreshold = 0.30; // 30% packet loss is considered critical
const double reconnectPacketLossThreshold = 0.50; // 50% packet loss is considered reconnectable

class SocketHeartbeat {
  final SocketCaller socketCaller;

  SocketHeartbeat({required this.socketCaller});

  /// Using for check when heartbeat system is started
  bool _isStarted = false;

  /// Variables for tracking heartbeats and packet loss
  Timer? _heartbeatTimer;
  final _heartbeatsSent = 0.obs;
  final _heartbeatsReceived = 0.obs;
  final _lastHeartbeatId = 0.obs;
  final _heartbeatLatencies = <int>[].obs; // in milliseconds
  final _heartbeatHistory = <bool>[].obs; // true = received, false = missed
  final _lastHeartbeatTime = Rx<DateTime?>(null);
  final _lastResetMetricTime = Rx<DateTime?>(null);
  final _lastStartHeartbeatTime = Rx<DateTime?>(null);
  final _lastStopHeartbeatTime = Rx<DateTime?>(null);

  // Getters for tracking heartbeats
  int get heartbeatsReceived => _heartbeatsSent.value;

  int get heartbeatsSent => _heartbeatsSent.value;

  int get lastHeartbeatId => _lastHeartbeatId.value;

  List<int> get heartbeatLatencies => _heartbeatLatencies;

  List<bool> get heartbeatHistory => _heartbeatHistory;

  DateTime? get lastHeartbeatTime => _lastHeartbeatTime.value;

  DateTime? get lastResetMetricTime => _lastResetMetricTime.value;

  DateTime? get lastStartHeartbeatTime => _lastStartHeartbeatTime.value;

  DateTime? get lastStopHeartbeatTime => _lastStopHeartbeatTime.value;

  /// Observable metrics
  final _packetLossRate = 0.0.obs;
  final _averageLatency = 0.obs;
  SocketPacketLossSeverity _packetLossSeverity = SocketPacketLossSeverity.normal;

  final Map<String, DateTime> _pendingHeartbeats = {}; // tracks sent heartbeats waiting for response
  final Map<String, Timer> _timeoutHeartbeats = {}; // tracks sent heartbeats waiting for response

  // Getters for monitoring
  double get packetLossRate => _packetLossRate.value;

  int get averageLatency => _averageLatency.value;

  ///
  /// Subscribe to socket events
  ///
  Future<void> socketSubscribe() async {
    if (socketCaller.socket.disconnected) {
      return;
    }

    socketCaller.emitCallV3('v3.heartbeat.subscribe', {
      'clientId': socketCaller.socketId,
    });
    socketCaller.socket.on('pong', _handleHeartbeatResponse);
  }

  ///
  /// Unsubscribe from socket events
  ///
  Future<void> socketUnsubscribe() async {
    if (socketCaller.socket.disconnected) {
      return;
    }

    socketCaller.socket.off('pong');
    socketCaller.emitCallV3('v3.heartbeat.unsubscribe', {
      'clientId': socketCaller.socketId,
    });
  }

  ///
  /// Send a ping to the server
  ///
  Future<void> socketPing(String heartbeatId) async {
    if (socketCaller.socket.disconnected) {
      return;
    }

    _lastHeartbeatTime.value = DateTime.now();

    await socketCaller.emitCallV3('v3.heartbeat.ping', {
      'id': heartbeatId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'clientId': socketCaller.socketId,
    });
  }

  ///
  /// Add this method to start the heartbeat system
  ///
  void startHeartbeatSystem() async {
    useLogger().d('Starting heartbeat system');

    // Clear any existing timer
    if (_isStarted) {
      stopHeartbeatSystem();
    }
    _isStarted = true;
    _lastStartHeartbeatTime.value = DateTime.now();

    // Initialize tracking variables
    _resetHeartbeatStats();

    // Register heartbeat response handler
    socketSubscribe();

    // First call for heartbeat
    _sendHeartbeat();

    // Start periodic heartbeat
    _heartbeatTimer = Timer.periodic(const Duration(milliseconds: heartbeatIntervalMs), (_) => _sendHeartbeat());
  }

  ///
  /// Stop the heartbeat system
  ///
  void stopHeartbeatSystem() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _lastStopHeartbeatTime.value = DateTime.now();

    // Remove heartbeat event handler
    socketUnsubscribe();

    useLogger().d('Heartbeat system stopped');
    _isStarted = false;
  }

  ///
  /// Reset heartbeat statistics
  ///
  void _resetHeartbeatStats() {
    _heartbeatsSent.value = 0;
    _heartbeatsReceived.value = 0;
    _heartbeatHistory.clear();
    _heartbeatLatencies.clear();
    _pendingHeartbeats.clear();
    _lastHeartbeatId.value = 0;
    _packetLossRate.value = 0.0;
    _averageLatency.value = 0;
    _packetLossSeverity = SocketPacketLossSeverity.normal;
    _lastResetMetricTime.value = DateTime.now();
  }

  ///
  /// Send a heartbeat packet to the server
  ///
  void _sendHeartbeat() async {
    // Don't send heartbeats if not connected
    if (!socketCaller.isConnected) {
      return;
    }

    // Set heartbeat id for tracking
    final heartbeatId = '${socketCaller.socketId}-${_lastHeartbeatId.value++}';

    // Record the time this heartbeat was sent
    _pendingHeartbeats[heartbeatId] = DateTime.now();

    // Increment sent counter
    _heartbeatsSent.value++;

    // Send heartbeat packet to server
    socketPing(heartbeatId);
    // useLogger().d('Heartbeat sent: $heartbeatId');

    // Set timeout for this heartbeat
    _setHeartbeatTimeout(heartbeatId);
  }

  // Set a timeout for heartbeat response
  void _setHeartbeatTimeout(String heartbeatId) {
    _timeoutHeartbeats[heartbeatId] = Timer(const Duration(milliseconds: heartbeatTimeoutMs), () {
      // Check if this heartbeat is still pending
      if (_pendingHeartbeats.containsKey(heartbeatId)) {
        // Remove from pending heartbeats
        _pendingHeartbeats.remove(heartbeatId);

        // Record as missed heartbeat
        _recordMissedHeartbeat();

        useLogger().w('Heartbeat timed out: $heartbeatId');
      }
    });
  }

  // Handle heartbeat response from server
  void _handleHeartbeatResponse(dynamic data) {
    try {
      if (data is! Map) {
        useLogger().e('Invalid heartbeat response format: $data');
        return;
      }

      final String? heartbeatId = data['id'];
      if (heartbeatId == null) {
        useLogger().e('Heartbeat response missing ID: $data');
        return;
      }

      // useLogger().d('Heartbeat received: $heartbeatId');

      // Check if this heartbeat is pending
      if (_pendingHeartbeats.containsKey(heartbeatId)) {
        final sentTime = _pendingHeartbeats[heartbeatId]!;
        final latency = DateTime.now().difference(sentTime).inMilliseconds;

        // Remove from pending heartbeats
        _pendingHeartbeats.remove(heartbeatId);

        _timeoutHeartbeats[heartbeatId]?.cancel();
        _timeoutHeartbeats.remove(heartbeatId);

        // Record successful heartbeat
        _recordSuccessfulHeartbeat(latency);

        // useLogger().d('Heartbeat response received: $heartbeatId, latency: ${latency}ms');
      } else {
        useLogger().w('Received response for unknown heartbeat: $heartbeatId');
      }
    } catch (e, stackTrace) {
      useLogger().e('Error handling heartbeat response', e, stackTrace);
    }
  }

  // Record a successful heartbeat
  void _recordSuccessfulHeartbeat(int latency) {
    _heartbeatsReceived.value++;

    // Add to history (true = received)
    _heartbeatHistory.add(true);

    // Add latency measurement
    _heartbeatLatencies.add(latency);

    // Limit history size
    _trimHistoryIfNeeded();

    // Update packet loss rate and average latency
    _updateMetrics();
  }

  // Record a missed heartbeat
  void _recordMissedHeartbeat() {
    // Add to history (false = missed)
    _heartbeatHistory.add(false);

    // Limit history size
    _trimHistoryIfNeeded();

    // Update packet loss rate
    _updateMetrics();
  }

  // Trim history arrays if they exceed the maximum size
  void _trimHistoryIfNeeded() {
    while (_heartbeatHistory.length > maxHeartbeatHistorySize) {
      _heartbeatHistory.removeAt(0);
    }

    while (_heartbeatLatencies.length > maxHeartbeatHistorySize) {
      _heartbeatLatencies.removeAt(0);
    }
  }

  // Update packet loss rate and latency metrics
  void _updateMetrics() {
    // Calculate packet loss rate based on history
    if (_heartbeatHistory.isNotEmpty) {
      final missedCount = _heartbeatHistory.where((received) => !received).length;
      _packetLossRate.value = missedCount / _heartbeatHistory.length;
    } else {
      _packetLossRate.value = 0.0;
    }

    // Calculate average latency
    if (_heartbeatLatencies.isNotEmpty) {
      final sum = _heartbeatLatencies.reduce((a, b) => a + b);
      _averageLatency.value = sum ~/ _heartbeatLatencies.length;
    } else {
      _averageLatency.value = 0;
    }

    // Fire events based on packet loss thresholds
    _checkPacketLossThresholds();

    // Log current metrics
    // useLogger().d(
    //   'Packet Loss Rate: ${(_packetLossRate.value * 100).toStringAsFixed(2)}%, \n'
    //   'Average Latency: ${_averageLatency.value}ms',
    // );
  }

  // Check if packet loss exceeds thresholds and trigger events
  void _checkPacketLossThresholds() {
    if (_packetLossRate.value >= criticalPacketLossThreshold) {
      // Critical packet loss - may need to force reconnect
      useLogger().e('Critical packet loss detected: ${(_packetLossRate.value * 100).toStringAsFixed(2)}%');

      _packetLossSeverity = SocketPacketLossSeverity.critical;

      // Fire event for critical packet loss
      eventBus.fire(SocketPacketLossEvent(
        rate: _packetLossRate.value,
        severity: _packetLossSeverity,
        latency: _averageLatency.value,
      ));

      // Consider forced reconnection
      _handleCriticalPacketLoss();
      return;
    } else if (_packetLossRate.value >= highPacketLossThreshold) {
      // High packet loss - notify but don't reconnect yet
      useLogger().w('High packet loss detected: ${(_packetLossRate.value * 100).toStringAsFixed(2)}%');

      _packetLossSeverity = SocketPacketLossSeverity.high;

      // Fire event for high packet loss
      eventBus.fire(SocketPacketLossEvent(
        rate: _packetLossRate.value,
        severity: _packetLossSeverity,
        latency: _averageLatency.value,
      ));
      return;
    } else if (_averageLatency.value >= highLatencyThresholdMs) {
      // High latency - notify but don't reconnect yet
      useLogger().w('High latency detected: ${_averageLatency.value}ms');

      _packetLossSeverity = SocketPacketLossSeverity.highLatency;

      // Fire event for high latency
      eventBus.fire(SocketPacketLossEvent(
        rate: _packetLossRate.value,
        severity: _packetLossSeverity,
        latency: _averageLatency.value,
      ));
      return;
    }

    if (_packetLossSeverity != SocketPacketLossSeverity.normal) {
      // Reset packet loss severity if it was previously high, highLatency, or critical
      _packetLossSeverity = SocketPacketLossSeverity.normal;

      // Fire event for normal packet loss
      eventBus.fire(SocketPacketLossEvent(
        rate: _packetLossRate.value,
        severity: _packetLossSeverity,
        latency: _averageLatency.value,
      ));
    }
  }

  // Handle critical packet loss
  void _handleCriticalPacketLoss() {
    // Only force reconnect if we have enough data points and are still connected
    if (_packetLossRate.value >= reconnectPacketLossThreshold && socketCaller.isConnected) {
      useLogger().w('Forcing reconnection due to critical packet loss');

      // Disconnect and reconnect with backoff
      socketCaller.reconnect();
    }
  }
}
