import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';

abstract class CallLogLocalRepository {
  Future<List<CallLogEntity>> getAllCallLogs({int? limit, CallActionType? callActionType});
  Future<List<CallLogEntity>> getCallLogsByRoomAndFriendIds(GetCallLogsByRoomAndFriendIdsRequest request);
  Future<CallLogEntity?> getCallLog(String id);
  Future<void> saveCallLogs(List<CallLogEntity> callLogs);
  Future<bool> deleteCallLog(String id);
  Future<void> deleteAllCallLogs(List<String> ids);
  Future<void> clearCallLogs();
}
