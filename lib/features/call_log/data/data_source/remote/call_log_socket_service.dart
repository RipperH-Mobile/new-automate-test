import 'package:uchat/api/api.dart';
import 'package:uchat/features/call_log/data/models/models/call_log_model.dart';
import 'package:uchat/features/call_log/data/models/requests/delete_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/requests/get_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/responses/delete_call_log_response.dart';

class CallLogSocketService {
  final SocketCaller socketCaller;

  CallLogSocketService({required this.socketCaller});

  Future<DeleteCallLogResponse?> deleteCallLogs(DeleteCallLogRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.deleteCallLogs.socket,
      request.toJson(),
    );
    return socketResp.mapToResponse<DeleteCallLogResponse>(
      (data) => DeleteCallLogResponse.fromJson(data),
    );
  }

  Future<PaginationPayload<CallLogModel>?> getCallLogs(GetCallLogRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getCallLogs.socket,
      request.toJson(),
    );
    return socketResp.mapToResponse((e) {
      return PaginationPayload<CallLogModel>.fromMapV3(
        e,
        listMapper: (data) {
          return (data).map((item) => CallLogModel.fromJson(item)).toList();
        },
      );
    });
  }
}
