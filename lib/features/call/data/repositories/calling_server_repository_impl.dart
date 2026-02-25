import 'package:uchat/api/payloads/call/call_response.dart';
import 'package:uchat/api/payloads/call/group_call_join_response.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/call/data/data_source/remote/calling_api_service.dart';
import 'package:uchat/features/call/data/data_source/remote/calling_socket_service.dart';
import 'package:uchat/features/call/data/models/requests/accept_call_request.dart';
import 'package:uchat/features/call/data/models/requests/decline_call_request.dart';
import 'package:uchat/features/call/data/models/requests/join_grop_call_request.dart';
import 'package:uchat/features/call/data/models/requests/leave_group_call_request.dart';
import 'package:uchat/features/call/data/models/requests/start_call_request.dart';
import 'package:uchat/features/call/domain/repositories/calling_server_repository.dart';

class CallingServerRepositoryImpl implements CallingServerRepository {
  CallingServerRepositoryImpl({
    required this.callingApiService,
    required this.callingSocketService,
    required this.socketCaller,
  });

  final CallingApiService callingApiService;
  final CallingSocketService callingSocketService;
  final SocketCaller socketCaller;

  @override
  Future<String?> acceptCall(AcceptCallRequest request) async {
    return await callingApiService.acceptCall(request);
  }

  @override
  Future<bool> declineCall(DeclineCallRequest request) async {
    return await callingApiService.declineCall(request);
  }

  @override
  Future<GroupCallJoinResponse?> joinGroupCall(JoinGroupCallRequest request) async {
    return await callingApiService.joinGroupCall(request);
  }

  @override
  Future<void> leaveGroupCall(LeaveGroupCallRequest request) async {
    return await callingApiService.leaveGroupCall(request);
  }

  @override
  Future<LiveKitCallResponseV2?> startCall(StartCallRequest request) async {
    return await callingApiService.startCall(request);
  }
}
