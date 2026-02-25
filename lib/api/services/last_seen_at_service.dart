import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/api/payloads/last_seen_at/last_seen_at_payload.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class LastSeenAtService with ServiceMixin {
  // Instance
  static final LastSeenAtService instance = LastSeenAtService.internal();

  /// Factory of class.
  factory LastSeenAtService() => instance;

  /// Constructor
  LastSeenAtService.internal();

  Future<void> updateDateTimeToServer(LastSeenAtRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCallV3(BackendPath.updateLastSeenNotiAt.socket, request.toMap());
        return;
      } catch (e, stackTrace) {
        _log.w('updateDateTimeToServer with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpCaller.put(
      BackendPath.updateLastSeenNotiAt.http,
      data: request.toMap(),
    );
  }
}
