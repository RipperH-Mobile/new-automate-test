import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

import 'heartbeat/heartbeat_result.dart';
import 'http_caller.dart';

const int heartbeatIntervalMs = 15000; // Send heartbeat every 15 seconds
const int heartbeatTimeoutMs = 30000; // Timeout for heartbeat response
const int maxHeartbeatHistorySize = 20; // Store history of last 20 heartbeats
const int highLatencyThresholdMs = 4000; // 4 seconds latency threshold
const double highPacketLossThreshold = 0.15; // 15% packet loss is considered high
const double criticalPacketLossThreshold = 0.30; // 30% packet loss is considered critical

const Duration sendTimeout = Duration(milliseconds: heartbeatTimeoutMs);
const Duration receivedTimeout = Duration(milliseconds: heartbeatTimeoutMs);

class HttpHeartbeat {
  final HttpCaller httpCaller;

  HttpHeartbeat({required this.httpCaller});

  /// Using for check when heartbeat system is started
  bool _isStarted = false;

  /// Variables for tracking heartbeats and packet loss
  Timer? _heartbeatTimer;
  final _lastHeartbeatId = 0.obs;
  final _consecutiveFailures = 0.obs;
  final _heartbeatHistory = <HeartbeatResult>[].obs;
  final _lastHeartbeatTime = Rx<DateTime?>(null);
  final _lastResetMetricTime = Rx<DateTime?>(null);
  final _lastStartMetricTime = Rx<DateTime?>(null);
  final _lastStopMetricTime = Rx<DateTime?>(null);

  List<HeartbeatResult> get heartbeatHistory => _heartbeatHistory;

  DateTime? get lastHeartbeatTime => _lastHeartbeatTime.value;

  DateTime? get lastResetMetricTime => _lastResetMetricTime.value;

  DateTime? get lastStartMetricTime => _lastStartMetricTime.value;

  DateTime? get lastStopMetricTime => _lastStopMetricTime.value;

  /// Observable metrics
  final _successRate = 1.0.obs;
  final _averageLatency = 0.obs;
  final _lastHeartbeatLatency = 0.obs;
  final _isNetworkHealthy = true.obs;

  // Getters for metrics
  double get successRate => _successRate.value;

  int get averageLatency => _averageLatency.value;

  int get lastHeartbeatLatency => _lastHeartbeatLatency.value;

  bool get isNetworkHealthy => _isNetworkHealthy.value;

  ///
  /// Request ping
  ///
  Future<dio.Response<dynamic>> _ping(String heartbeatId) async {
    _lastHeartbeatTime.value = DateTime.now();

    return await httpCaller.dio.post(
      httpCaller.parseUrl('v3/ping'),
      data: {
        'id': heartbeatId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      options: dio.Options(
        sendTimeout: sendTimeout,
        receiveTimeout: receivedTimeout,
      ),
    );
  }

  ///
  /// Using for start heartbeat system.
  /// First time start and then periodically ping the server.
  ///
  void startHeartbeatSystem() async {
    // Check if the heartbeat system is already started
    if (_isStarted) return;
    _isStarted = true;
    _lastStartMetricTime.value = DateTime.now();

    useLogger().d('Starting heartbeat system');

    // Send first heartbeat immediately
    _sendHeartbeat();

    // Schedule periodic heartbeats
    _heartbeatTimer = Timer.periodic(const Duration(milliseconds: heartbeatIntervalMs), (_) => _sendHeartbeat());
  }

  ///
  /// Stop heartbeat tests
  ///
  void stopHeartBeating() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _isStarted = false;
    _lastStopMetricTime.value = DateTime.now();
    useLogger().d('HTTP heartbeat tests stopped');
  }

  ///
  /// Perform a single heartbeat test
  ///
  Future<void> _sendHeartbeat() async {
    // Not run if heartbeat system is not started
    if (!_isStarted) return;

    // Set heartbeat id for tracking
    _lastHeartbeatId.value = _lastHeartbeatId.value + 1;
    final heartbeatId = '${_lastHeartbeatId.value}';

    final startTime = DateTime.now();
    bool isSuccess = false;
    int latency = 0;
    dynamic errorDetails;

    try {
      final response = await _ping(heartbeatId);

      // Calculate latency
      latency = DateTime.now().difference(startTime).inMilliseconds;

      // Check response status
      isSuccess = response.statusCode == 200;

      if (isSuccess) {
        _consecutiveFailures.value = 0;
        // useLogger().d('HTTP heartbeat successful, latency: ${latency}ms');
      } else {
        _consecutiveFailures.value = _consecutiveFailures.value + 1;
        errorDetails = 'Status code: ${response.statusCode}';
        useLogger().w('HTTP heartbeat failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle request errors
      _consecutiveFailures.value = _consecutiveFailures.value + 1;
      errorDetails = e.toString();

      if (e is dio.DioException) {
        // Add more specific error information based on the type of DioException
        switch (e.type) {
          case dio.DioExceptionType.connectionTimeout:
            errorDetails = 'Connection timeout';
            break;
          case dio.DioExceptionType.sendTimeout:
            errorDetails = 'Send timeout';
            break;
          case dio.DioExceptionType.receiveTimeout:
            errorDetails = 'Receive timeout';
            break;
          case dio.DioExceptionType.badResponse:
            errorDetails = 'Bad response: ${e.response?.statusCode}';
            break;
          case dio.DioExceptionType.cancel:
            errorDetails = 'Request cancelled';
            break;
          default:
            errorDetails = 'Connection error: ${e.message}';
            break;
        }
      }

      useLogger().w('HTTP heartbeat failed: $errorDetails');
    }

    ///
    /// Record heartbeat result
    ///
    final result = HeartbeatResult(
      timestamp: startTime,
      isSuccess: isSuccess,
      latencyMs: latency,
      error: isSuccess ? null : errorDetails,
    );

    // Update history and metrics
    _recordHeartbeatResult(result);
  }

  ///
  /// Record heartbeat result and update metrics
  ///
  void _recordHeartbeatResult(HeartbeatResult result) {
    // Add to history
    _heartbeatHistory.add(result);

    // Update last heartbeat latency
    if (result.isSuccess) {
      _lastHeartbeatLatency.value = result.latencyMs;
    }

    // Limit history size
    while (_heartbeatHistory.length > maxHeartbeatHistorySize) {
      _heartbeatHistory.removeAt(0);
    }

    // Update metrics
    _updateMetrics();

    // Check for network health issues
    _checkNetworkHealth();
  }

  ///
  /// Update success rate and average latency metrics
  ///
  void _updateMetrics() {
    if (_heartbeatHistory.isEmpty) return;

    // Calculate success rate
    final successfulHeartbeats = _heartbeatHistory.where((result) => result.isSuccess).length;
    _successRate.value = successfulHeartbeats / _heartbeatHistory.length;

    // Calculate average latency (only for successful heartbeats)
    final successfulResults = _heartbeatHistory.where((result) => result.isSuccess).toList();
    if (successfulResults.isNotEmpty) {
      final totalLatency = successfulResults.map((result) => result.latencyMs).reduce((a, b) => a + b);
      _averageLatency.value = totalLatency ~/ successfulResults.length;
    }
  }

  ///
  /// Check for serious network health issues
  ///
  void _checkNetworkHealth() {
    // Consider network unhealthy if consecutive failures exceed threshold
    // or if success rate drops too low
    final bool wasHealthy = _isNetworkHealthy.value;
    _isNetworkHealthy.value = (_consecutiveFailures.value < 3) && (_successRate.value >= 0.5);

    // Log network health changes
    if (wasHealthy != _isNetworkHealthy.value) {
      if (_isNetworkHealthy.value) {
        useLogger().i('Network health restored');
      } else {
        useLogger().w(
          'Network health degraded. Success rate: ${(_successRate.value * 100).toStringAsFixed(1)}%, \n'
          'Consecutive failures: $_consecutiveFailures',
        );
      }
    }

    eventBus.fire(HttpHeartbeatEvent(
      successRate: _successRate.value,
      averageLatency: _averageLatency.value,
    ));
  }

  ///
  /// Clear history and reset metrics
  ///
  void resetMetrics() {
    _lastResetMetricTime.value = DateTime.now();
    _heartbeatHistory.clear();
    _consecutiveFailures.value = 0;
    _successRate.value = 1.0;
    _averageLatency.value = 0;
    _lastHeartbeatLatency.value = 0;
    _isNetworkHealthy.value = true;
  }
}
