import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';

abstract class CallLogServerRepository {
  Future<int> deleteCallLogs({List<String>? callLogIds});
  Future<PaginationPayload<CallLogEntity>> getCallLogs(GetCallLogsParam param);
}
