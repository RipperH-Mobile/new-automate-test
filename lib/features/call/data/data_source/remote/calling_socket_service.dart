import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/payloads/call/call_response.dart';
import 'package:uchat/api/payloads/call/group_call_join_response.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/call/data/models/requests/start_call_request.dart';

final _log = useLogger();

class CallingSocketService {
  CallingSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<LiveKitCallResponseV2?> startCall(StartCallRequest request) async {
    try {
      final socketResp = await socketCaller.emitCallV3(
        BackendPath.startCall.socket,
        {
          'roomId': request.roomId,
          'type': request.callType.value,
        },
      );

      return socketResp.mapToResponse((data) => LiveKitCallResponseV2.fromMap(data));
    } catch (e, stackTrace) {
      _log.w('startCall with socket error. fallback to http request...', e, stackTrace);
    }

    return null;
  }

  Future<String?> acceptCall(String roomCallId) async {
    if (roomCallId.isEmpty) return null;

    try {
      final socketResp = await socketCaller.emitCallV3(
        BackendPath.acceptCall.socket,
        {'roomCallId': roomCallId},
      );

      return socketResp.data;
    } catch (e, stackTrace) {
      _log.w('acceptCall with socket error. fallback to http request...', e, stackTrace);
    }

    return null;
  }

  Future<bool> declineCall(
    String roomCallId,
    String sid, {
    bool isCancel = false,
  }) async {
    if (roomCallId.isEmpty) return false;

    Map<String, dynamic> data = {
      'roomCallId': roomCallId,
      'liveKitRoom': sid,
    };

    if (isCancel == true) {
      data['isCancel'] = true;
    }
    try {
      final socketResp = await socketCaller.emitCallV3(
        BackendPath.declineCall.socket,
        data,
      );

      return socketResp.data ?? false;
    } catch (e, stackTrace) {
      _log.w('declineCall with socket error. fallback to http request...', e, stackTrace);
    }

    return false;
  }

  Future<GroupCallJoinResponse?> joinGroupCall(String roomId) async {
    if (roomId.isEmpty) return null;

    try {
      final socketResp = await socketCaller.emitCallV3(
        BackendPath.joinGroupCall.socket,
        {'roomId': roomId},
      );

      return GroupCallJoinResponse.fromMap(socketResp.data);
    } catch (e, stackTrace) {
      _log.w('joinGroupCall with socket error. fallback to http request...', e, stackTrace);
    }

    return null;
  }

  Future<void> leaveGroupCall(String roomId) async {
    if (roomId.isEmpty) return;

    try {
      await socketCaller.emitCallV3(
        BackendPath.leaveGroupCall.socket,
        {'roomId': roomId},
      );

      return;
    } catch (e, stackTrace) {
      _log.w('leaveGroupCall with socket error. fallback to http request...', e, stackTrace);
    }
  }
}
