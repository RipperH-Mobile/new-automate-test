import 'package:uchat/features/call_log/data/data_source/local/call_log_db.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/data/models/mapper/call_log_collection_mapper.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';

class CallLogLocalRepositoryImpl implements CallLogLocalRepository {
  final CallLogDb callLogDb;

  CallLogLocalRepositoryImpl({required this.callLogDb});

  @override
  Future<List<CallLogEntity>> getAllCallLogs({int? limit, CallActionType? callActionType}) {
    return callLogDb.getAllCallLogs(
      limit: limit,
      callActionType: callActionType,
    );
  }

  @override
  Future<List<CallLogEntity>> getCallLogsByRoomAndFriendIds(
    GetCallLogsByRoomAndFriendIdsRequest request,
  ) {
    return callLogDb.getCallLogsByRoomAndFriendIds(request);
  }

  @override
  Future<CallLogEntity?> getCallLog(String id) {
    return callLogDb.getCallLog(id);
  }

  @override
  Future<void> saveCallLogs(List<CallLogEntity> callLogs) async {
    final collections = CallLogCollectionMapper.fromEntities(callLogs);
    await callLogDb.putAllCallLogs(collections);
  }

  @override
  Future<bool> deleteCallLog(String id) {
    return callLogDb.deleteCallLog(id);
  }

  @override
  Future<void> deleteAllCallLogs(List<String> ids) {
    return callLogDb.deleteAllCallLogs(ids);
  }

  @override
  Future<void> clearCallLogs() {
    return callLogDb.clearCollection();
  }
}
