import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/api/payloads/call/call_response.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/call/utils/enum.dart';

final _log = useLogger();

class RoomCallService with ServiceMixin {
  // Instance
  static final RoomCallService instance = RoomCallService.internal();

  /// Factory of class.
  factory RoomCallService() => instance;

  /// Constructor
  RoomCallService.internal();

  // TODO: Implement this (Socket)
  // "v2.roomCalls.group.join": "roomCall.joinGroupCallRoomV2",
  // "v2.roomCalls.group.leave": "roomCall.leaveGroupCallRoomV2",
  // "v2.roomCalls.create": "roomCall.callRoomV2",

  ///
  /// Start call request
  /// - `callType` => possible value is VOICE | VIDEO
  ///
  Future<LiveKitCallResponseV2?> startCall(
    CallType callType,
    String roomId,
  ) async {
    // if (socketCaller.isConnected) {
    //   try {
    //     final socketResp = await socketCaller.emitCall(
    //       BackendPath.startCall.socket,
    //       {
    //         'roomId': roomId,
    //         'type': callType.value,
    //       },
    //     );

    //     return socketResp.mapToResponse((data) => LiveKitCallResponseV2.fromMap(data));
    //   } catch (e, stackTrace) {
    //     _log.w('startCall with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }

    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.startCall.http,
      data: {
        'roomId': roomId,
        'type': callType.value,
      },
    );

    return httpResp.mapToResponse((data) => LiveKitCallResponseV2.fromMap(data));
  }

  Future<bool> ringingCall(String roomCallId) async {
    if (roomCallId.isEmpty) return false;

    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.ringingCall.socket,
          {'roomCallId': roomCallId},
        );

        return socketResp.data == true;
      } catch (e, stackTrace) {
        _log.w('ringingCall with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post<bool>(
      BackendPath.ringingCall.http.replaceAll(':roomCallId', roomCallId),
    );

    return httpResp.data == true;
  }

  ///
  /// Return LiveKit token.
  ///
  Future<String?> acceptCall(String roomCallId) async {
    if (roomCallId.isEmpty) return null;

    // if (socketCaller.isConnected) {
    //   try {
    //     final socketResp = await socketCaller.emitCall(
    //       BackendPath.acceptCall.socket,
    //       {'roomCallId': roomCallId},
    //     );
    //
    //     return socketResp.data;
    //   } catch (e, stackTrace) {
    //     _log.w('acceptCall with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }

    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }
    final httpResp = await httpCaller.post(
      BackendPath.acceptCall.http.replaceAll(':roomCallId', roomCallId),
    );

    return httpResp.data;
  }

  Future<bool> declineCall(
    String roomCallId,
    String sid, {
    bool isCancel = false,
  }) async {
    if (roomCallId.isEmpty) return false;

    // if (socketCaller.isConnected) {
    //   Map<String, dynamic> data = {
    //     'roomCallId': roomCallId,
    //     'liveKitRoom': sid,
    //   };
    //
    //   if (isCancel == true) {
    //     data['isCancel'] = true;
    //   }
    //   try {
    //     final socketResp = await socketCaller.emitCall(
    //       BackendPath.declineCall.socket,
    //       data,
    //     );
    //
    //     return socketResp.data ?? false;
    //   } catch (e, stackTrace) {
    //     _log.w('declineCall with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }
    Map<String, dynamic> data = {
      'liveKitRoom': sid,
    };
    if (isCancel == true) {
      data['isCancel'] = true;
    }
    final httpResp = await httpCaller.post<bool>(
      BackendPath.declineCall.http.replaceAll(':roomCallId', roomCallId),
      data: data,
    );

    return httpResp.data ?? false;
  }

  Future<bool> timeoutCall(String roomCallId, String sid) async {
    if (roomCallId.isEmpty) return false;

    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.timeoutCall.socket,
          {
            'roomCallId': roomCallId,
            'liveKitRoom': sid,
          },
        );

        return socketResp.data ?? false;
      } catch (e, stackTrace) {
        _log.w('timeoutCall with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post<bool>(
      BackendPath.timeoutCall.http.replaceAll(':roomCallId', roomCallId),
      data: {
        'liveKitRoom': sid,
      },
    );

    return httpResp.data ?? false;
  }

  Future<void> resetCallStatus() async {
    await httpCaller.post(BackendPath.resetRoomCall.http);
  }

  Future<bool> isChatRoomAvailableForCall(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.availableRoomCall.socket,
          {'roomId': roomId},
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('isChatRoomAvailableForCall with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.availableRoomCall.http,
      data: {
        'roomId': roomId,
      },
    );

    return httpResp.data;
  }

  Future<GroupCallJoinResponse?> joinGroupCall(String roomId) async {
    if (roomId.isEmpty) return null;

    // if (socketCaller.isConnected) {
    //   try {
    //     final socketResp = await socketCaller.emitCall(
    //       BackendPath.joinGroupCall.socket,
    //       {'roomId': roomId},
    //     );
    //
    //     return GroupCallJoinResponse.fromMap(socketResp.data);
    //   } catch (e, stackTrace) {
    //     _log.w('joinGroupCall with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }

    final httpResp = await httpCaller.post(
      BackendPath.joinGroupCall.http.replaceAll(':roomId', roomId),
    );

    return GroupCallJoinResponse.fromMap(httpResp.data);
  }

  Future<void> leaveGroupCall(String roomId) async {
    if (roomId.isEmpty) return;

    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.leaveGroupCall.socket,
          {'roomId': roomId},
        );

        return;
      } catch (e, stackTrace) {
        _log.w('leaveGroupCall with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpCaller.post(
      BackendPath.leaveGroupCall.http.replaceAll(':roomId', roomId),
    );
  }
}
