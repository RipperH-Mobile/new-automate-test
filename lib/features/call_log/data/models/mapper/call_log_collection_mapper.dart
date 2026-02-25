import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';

class CallLogCollectionMapper {
  static CallLogCollection fromEntity(CallLogEntity entity) {
    return CallLogCollection(
      id: entity.id,
      callType: entity.callType,
      callActionType: entity.callActionType,
      roomType: entity.roomType,
      roomId: entity.roomId,
      friendId: entity.friendId,
      historyForAccountId: entity.historyForAccountId,
      callCount: entity.callCount,
      lastStartedAt: entity.lastStartedAt,
      totalDuration: entity.totalDuration,
    );
  }

  static CallLogEntity? toEntity(CallLogCollection collection) {
    if (collection.id == null ||
        collection.callType == null ||
        collection.callActionType == null ||
        collection.roomType == null ||
        collection.roomId == null ||
        collection.historyForAccountId == null ||
        collection.callCount == null ||
        collection.lastStartedAt == null ||
        collection.totalDuration == null) {
      return null;
    }

    return CallLogEntity(
      id: collection.id!,
      callType: collection.callType!,
      callActionType: collection.callActionType!,
      roomType: collection.roomType!,
      roomId: collection.roomId!,
      friendId: collection.friendId,
      historyForAccountId: collection.historyForAccountId!,
      callCount: collection.callCount!,
      lastStartedAt: collection.lastStartedAt!,
      totalDuration: collection.totalDuration!,
    );
  }

  static List<CallLogCollection> fromEntities(List<CallLogEntity> entities) {
    return entities.map(fromEntity).toList();
  }

  static List<CallLogEntity> toEntities(List<CallLogCollection> collections) {
    return collections.map(toEntity).whereType<CallLogEntity>().toList();
  }
}
