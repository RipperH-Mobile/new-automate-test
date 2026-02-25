import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/payloads/call/call_response.dart';
import 'package:uchat/api/payloads/call/group_call_join_response.dart';
import 'package:uchat/features/call/data/models/requests/accept_call_request.dart';
import 'package:uchat/features/call/data/models/requests/decline_call_request.dart';
import 'package:uchat/features/call/data/models/requests/join_grop_call_request.dart';
import 'package:uchat/features/call/data/models/requests/leave_group_call_request.dart';
import 'package:uchat/features/call/data/models/requests/start_call_request.dart';

class CallingApiService {
  CallingApiService({
    required this.httpCaller,
  });

  final HttpCaller httpCaller;

  Future<LiveKitCallResponseV2?> startCall(StartCallRequest request) async {
    if (request.roomId.isEmpty) return null;
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
        'roomId': request.roomId,
        'type': request.callType.value,
      },
    );

    return httpResp.mapToResponse((data) => LiveKitCallResponseV2.fromMap(data));
  }

  Future<String?> acceptCall(AcceptCallRequest request) async {
    if (request.roomCallId.isEmpty) return null;
    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }
    final httpResp = await httpCaller.post(
      BackendPath.acceptCall.http.replaceAll(':roomCallId', request.roomCallId),
    );

    return httpResp.data;
  }

  Future<bool> declineCall(DeclineCallRequest request) async {
    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }

    if (request.roomCallId.isEmpty) return false;
    Map<String, dynamic> data = {
      'liveKitRoom': request.liveKitRoomSID,
    };
    if (request.isCancel == true) {
      data['isCancel'] = true;
    }
    final httpResp = await httpCaller.post<bool>(
      BackendPath.declineCall.http.replaceAll(':roomCallId', request.roomCallId),
      data: data,
    );

    return httpResp.data ?? false;
  }

  Future<GroupCallJoinResponse?> joinGroupCall(JoinGroupCallRequest request) async {
    if (request.roomId.isEmpty) return null;

    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.joinGroupCall.http.replaceAll(':roomId', request.roomId),
    );

    return GroupCallJoinResponse.fromMap(httpResp.data);
  }

  Future<void> leaveGroupCall(LeaveGroupCallRequest request) async {
    if (request.roomId.isEmpty) return;

    if (httpCaller.accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        httpCaller.updateAccessToken(token);
      }
    }

    await httpCaller.post(
      BackendPath.leaveGroupCall.http.replaceAll(':roomId', request.roomId),
    );
  }
}
