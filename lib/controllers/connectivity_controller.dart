import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/event_bus/events/connectivity_changed_event.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

final _log = useLogger();

const int acceptableLatency = 4000; // 4 seconds
const double acceptablePacketLoss = 0.05; // 5% packet loss
const double acceptableSuccessRate = 0.95; // 95% success rate
const double socketDisconnectedHttpAcceptableSuccessRate = 1.0; // 100% success rate

///
/// This enum is used to determine the connectivity status
///
enum ConnectivityStatus {
  waiting,

  // Use for
  // [SocketCaller] has [latency] < 4s
  // and [HttpCaller] has [successRate] = 1.0 (100%)
  // and [SocketCaller] has [packetLoss] = 0.0 (0%)
  // and [ConnectivityResult] does not contain [ConnectivityResult.none]
  online,

  // Use for
  // [ConnectivityResult] contains [ConnectivityResult.none]
  // or [SocketCaller] has [packetLoss] = 1.0 (100%)
  // or [HttpCaller] has [successRate] = 0.0 (0%)
  offline,

  // Use for
  // [SocketCaller] has [packetLoss] > 0.05 (5%), [latency] is not included to this condition
  // or [HttpCaller] has [successRate] < 0.95 (95%), [latency] is not included to this condition
  // and [ConnectivityResult] does not contain [ConnectivityResult.none]
  //
  // Please see const [acceptableLatency], [acceptableSuccessRate] and [acceptablePacketLoss] for current condition.
  unstable,

  // Use for
  // [SocketCaller] has [latency] > 4s, [packetLoss] = 0.0 (0%)
  // or [HttpCaller] has [latency] > 4s, [successRate] = 1.0 (100%)
  // and [ConnectivityResult] does not contain [ConnectivityResult.none]
  //
  // Please see const [acceptableLatency] for current condition.
  slow;

  String get value {
    switch (this) {
      case ConnectivityStatus.waiting:
        return 'Waiting...';
      case ConnectivityStatus.online:
        return 'Online';
      case ConnectivityStatus.offline:
        return 'Offline';
      case ConnectivityStatus.unstable:
        return 'Unstable';
      case ConnectivityStatus.slow:
        return 'Slow';
    }
  }

  @override
  toString() {
    return value;
  }

  /// Lists of connectivity statuses for internet availability checks
  ///
  /// Use [internetAvailableStatuses] to check if internet is available
  ///
  /// It contains `ConnectivityStatus.online`, `ConnectivityStatus.slow`, and `ConnectivityStatus.unstable`
  static List<ConnectivityStatus> get internetAvailableStatuses => [
        ConnectivityStatus.online,
        ConnectivityStatus.slow,
        ConnectivityStatus.unstable,
      ];

  /// Lists of connectivity statuses for internet unavailability checks
  ///
  /// Use [internetUnavailableStatuses] to check if internet is unavailable
  ///
  /// It contains `ConnectivityStatus.offline` and `ConnectivityStatus.waiting`
  static List<ConnectivityStatus> get internetUnavailableStatuses => [
        ConnectivityStatus.offline,
        ConnectivityStatus.waiting,
      ];
}

///
/// This is the controller for connectivity
///
class ConnectivityController extends GetxController {
  static ConnectivityController get instance => Get.find();

  ///
  /// Connectivity status handler
  ///

  final _connectivityStatus = ConnectivityStatus.waiting.obs;

  /// Previous connectivity status for event comparison
  ConnectivityStatus _previousConnectivityStatus = ConnectivityStatus.waiting;

  ConnectivityStatus get connectivityStatus => _connectivityStatus.value;

  ///
  /// New socket heartbeat logic
  ///
  ///
  StreamSubscription? _socketPacketLossSub;
  StreamSubscription? _socketDisconnectSub;
  StreamSubscription? _socketErrorSub;
  StreamSubscription? _socketConnectErrorSub;

  ///
  /// New http heartbeat logic
  ///
  ///
  StreamSubscription? _httpHeartbeatSub;

  ///
  /// Connectivity logic
  ///

  final _connectivityResult = <ConnectivityResult>[ConnectivityResult.none].obs;

  List<ConnectivityResult> get connectivityResult => _connectivityResult;

  @visibleForTesting
  void setConnectivityResultForTest(List<ConnectivityResult> result) {
    _connectivityResult.value = result;
  }

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  ///
  /// For check maintenance mode
  ///

  final isConnectMaintenanceWasOn = false.obs;

  StreamSubscription? _maintenanceModeUpdateSub;

  ///
  /// Getters for connectivity status
  ///

  bool get isOffline {
    return _connectivityStatus.value == ConnectivityStatus.offline;
  }

  bool get isOnline {
    return _connectivityStatus.value == ConnectivityStatus.online;
  }

  bool get isUnstable {
    return _connectivityStatus.value == ConnectivityStatus.unstable;
  }

  bool get isSlow {
    return _connectivityStatus.value == ConnectivityStatus.slow;
  }

  ///
  /// GetX controller for initializing.
  ///
  @override
  void onInit() async {
    _socketPacketLossSub = eventBus.on<SocketPacketLossEvent>().listen((event) => handleCheckConnectionQuality());
    _httpHeartbeatSub = eventBus.on<HttpHeartbeatEvent>().listen((event) => handleCheckConnectionQuality());
    _connectivitySub = Connectivity().onConnectivityChanged.listen(handleCheckConnectivity);

    // For check static when socket connected
    _socketErrorSub = eventBus.on<SocketErrorEvent>().listen((event) => handleCheckConnectionQuality());
    _socketConnectErrorSub = eventBus.on<SocketConnectErrorEvent>().listen((event) => handleCheckConnectionQuality());

    _maintenanceModeUpdateSub = eventBus.on<MaintenanceModeUpdateEvent>().listen(
      (event) {
        isConnectMaintenanceWasOn(event.isMaintenanceOn);
      },
    );

    ever(_connectivityStatus, (updatedStatus) {
      /// Avoid firing event when status is not changed
      if (updatedStatus == _previousConnectivityStatus) {
        return;
      }

      eventBus.fire(ConnectivityChangedEvent(previous: _previousConnectivityStatus, current: updatedStatus));
      _log.i('ConnectivityStatus: changed to: $updatedStatus | from: $_previousConnectivityStatus');
    });

    super.onInit();
  }

  ///
  /// GetX controller for disposing.
  ///
  @override
  void onClose() async {
    await _socketPacketLossSub?.cancel();
    await _httpHeartbeatSub?.cancel();
    await _connectivitySub?.cancel();
    await _socketDisconnectSub?.cancel();
    await _socketErrorSub?.cancel();
    await _socketConnectErrorSub?.cancel();
    await _maintenanceModeUpdateSub?.cancel();

    super.onClose();
  }

  SocketCaller get socketCallerInstance {
    return GetIt.I<SocketCaller>();
  }

  HttpCaller get httpCallerInstance {
    return GetIt.I<HttpCaller>();
  }

  ///
  /// This is logic for check connection quality from [HttpCaller] and [SocketCaller]
  ///
  void handleCheckConnectionQuality() {
    // Store previous status for event comparison
    _previousConnectivityStatus = _connectivityStatus.value;

    // Check condition 1 by using [ConnectivityResult]
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _connectivityStatus.value = ConnectivityStatus.offline;
      return;
    }

    final socketHeartbeat = socketCallerInstance.heartbeat;

    final httpHeartbeat = httpCallerInstance.heartbeat;

    if (httpHeartbeat.successRate == 0.0 &&
        (socketCallerInstance.isConnected && socketHeartbeat.packetLossRate == 1.0)) {
      _connectivityStatus.value = ConnectivityStatus.offline;
      return;
    }

    if (httpHeartbeat.successRate < acceptableSuccessRate ||
        (socketCallerInstance.isConnected && socketHeartbeat.packetLossRate > acceptablePacketLoss) ||
        (!socketCallerInstance.isConnected &&
            httpHeartbeat.successRate < socketDisconnectedHttpAcceptableSuccessRate)) {
      _connectivityStatus.value = ConnectivityStatus.unstable;
      return;
    }

    if (httpHeartbeat.successRate == 1.0 ||
        (socketCallerInstance.isConnected && socketHeartbeat.packetLossRate == 0.0)) {
      if (httpHeartbeat.averageLatency > acceptableLatency ||
          (socketCallerInstance.isConnected && socketHeartbeat.averageLatency > acceptableLatency)) {
        _connectivityStatus.value = ConnectivityStatus.slow;
        return;
      }
    }

    // When passing all conditions
    _connectivityStatus.value = ConnectivityStatus.online;
  }

  ///
  /// This is logic for check connectivity
  ///
  void handleCheckConnectivity(List<ConnectivityResult> result) {
    if (connectivityResult.toSet().difference(result.toSet()).isEmpty) {
      return;
    }

    _log.d(
      'ConnectivityResult: $result\n'
      'SocketConnected: ${SocketCaller.instance.isConnected}\n',
    );

    if (result.contains(ConnectivityResult.none)) {
      SocketCaller.instance.disconnect();
    } else {
      SocketCaller.instance.reconnect();
    }

    _connectivityResult.value = result;
    handleCheckConnectionQuality();
  }

  void onUserBeforeSwitch() {
    _socketDisconnectSub?.cancel();
  }

  ///
  /// Use for [Orchestrator] to check if socket is connected
  ///
  void onUserLoaded() {
    _socketDisconnectSub?.cancel();
    _socketDisconnectSub = eventBus.on<SocketDisconnectedEvent>().listen((_) => handleCheckConnectionQuality());
  }
}
