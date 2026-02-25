import 'package:uchat/api/payloads/call/call_response.dart';
import 'package:uchat/api/payloads/call/group_call_join_response.dart';
import 'package:uchat/features/call/data/models/requests/accept_call_request.dart';
import 'package:uchat/features/call/data/models/requests/decline_call_request.dart';
import 'package:uchat/features/call/data/models/requests/join_grop_call_request.dart';
import 'package:uchat/features/call/data/models/requests/leave_group_call_request.dart';
import 'package:uchat/features/call/data/models/requests/start_call_request.dart';

abstract class CallingServerRepository {
  Future<LiveKitCallResponseV2?> startCall(StartCallRequest request);

  Future<String?> acceptCall(AcceptCallRequest request);

  Future<bool> declineCall(DeclineCallRequest request);

  Future<GroupCallJoinResponse?> joinGroupCall(JoinGroupCallRequest request);

  Future<void> leaveGroupCall(LeaveGroupCallRequest request);
}
