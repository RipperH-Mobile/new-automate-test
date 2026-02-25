import 'package:flutter/foundation.dart';
import 'package:uchat/controllers/connectivity_controller.dart';

@immutable
class ConnectivityChangedEvent {
  final ConnectivityStatus previous;
  final ConnectivityStatus current;

  const ConnectivityChangedEvent({
    required this.previous,
    required this.current,
  });
}
