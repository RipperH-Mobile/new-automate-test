import 'package:uchat/api/api.dart';
import 'package:uchat/features/call_log/data/models/models/call_log_model.dart';
import 'package:uchat/features/call_log/data/models/requests/delete_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/requests/get_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/responses/delete_call_log_response.dart';

class CallLogApiService {
  final HttpCaller httpCaller;

  CallLogApiService({
    required this.httpCaller,
  });

  Future<DeleteCallLogResponse?> deleteCallLogs(DeleteCallLogRequest request) async {
    final resp = await httpCaller.delete(
      BackendPath.deleteCallLogs.http,
      data: request.toJson(),
    );
    return resp.mapToResponse<DeleteCallLogResponse>(
      (data) => DeleteCallLogResponse.fromJson(data),
    );
  }

  Future<PaginationPayload<CallLogModel>?> getCallLogs(GetCallLogRequest request) async {
    final resp = await httpCaller.get(
      BackendPath.getCallLogs.http,
      data: request.toJson(),
    );

    return resp.mapToResponse((e) {
      return PaginationPayload<CallLogModel>.fromMapV3(
        e,
        listMapper: (data) {
          return (data).map((item) => CallLogModel.fromJson(item)).toList();
        },
      );
    });
  }
}
