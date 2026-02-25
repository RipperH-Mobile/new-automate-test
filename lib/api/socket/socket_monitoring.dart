import 'dart:async';

import 'package:get/get.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

const int monitoringIntervalMs = 5000; // Check every 15 seconds
const int forceReconnectWhenFoundDisconnectedTimes = 5;

class SocketMonitoring {
  final SocketCaller socketCaller;

  SocketMonitoring({required this.socketCaller});

  /// Using for check when heartbeat system is started
  bool _isStarted = false;

  bool get isStarted => _isStarted;

  /// Variables for tracking heartbeats and packet loss
  Timer? _monitoringTimer;
  final _lastCheckedTime = Rx<DateTime?>(null);
  final _lastForceReconnectTime = Rx<DateTime?>(null);
  final _forceReconnectCount = 0.obs;
  final _foundDisconnectedCount = 0.obs;

  // Getters for tracking monitoring
  DateTime? get lastCheckedTime => _lastCheckedTime.value;

  DateTime? get lastForceReconnectTime => _lastForceReconnectTime.value;

  int get forceReconnectCount => _forceReconnectCount.value;

  int get foundDisconnectedCount => _foundDisconnectedCount.value;

  ///
  /// Add this method to start the heartbeat system
  ///
  void startMonitoringSystem() async {
    useLogger().d('Starting socket monitoring system');

    // Clear any existing timer
    if (_isStarted) {
      return;
    }
    _isStarted = true;

    // Start periodic heartbeat
    _monitoringTimer = Timer.periodic(const Duration(milliseconds: monitoringIntervalMs), (_) => _monitoring());
  }

  ///
  /// Stop the monitoring system
  ///
  void stopMonitoringSystem() {
    _monitoringTimer?.cancel();
    _monitoringTimer = null;

    useLogger().d('Socket monitoring system stopped');
    _isStarted = false;
  }

  ///
  /// Check socket status
  ///
  void _monitoring() async {
    _lastCheckedTime.value = DateTime.now();

    // Don't send heartbeats if not connected
    if (socketCaller.isReadyForCall || socketCaller.isConnecting || socketCaller.isWaitingForReconnectAttempts) {
      _foundDisconnectedCount.value = 0;
      return;
    }

    if (UserController.instance.currentUser.value == null) {
      _foundDisconnectedCount.value = 0;
      return;
    }

    if (!socketCaller.isConnected) {
      if (_foundDisconnectedCount.value < forceReconnectWhenFoundDisconnectedTimes) {
        _foundDisconnectedCount.value++;
      } else {
        socketCaller.reconnect();
        _foundDisconnectedCount.value = 0;
        _forceReconnectCount.value++;
        _lastForceReconnectTime.value = DateTime.now();
      }
    }
  }
}
