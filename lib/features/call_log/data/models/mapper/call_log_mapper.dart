import 'package:uchat/features/call_log/data/models/models/call_log_model.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';

class CallLogMapper {
  static CallLogEntity toEntity(CallLogModel model) {
    return CallLogEntity(
      id: model.id,
      callType: model.callType,
      callActionType: model.callActionType,
      roomType: model.roomType,
      roomId: model.roomId,
      friendId: model.friendId,
      historyForAccountId: model.historyForAccountId,
      callCount: model.callCount,
      lastStartedAt: model.lastStartedAt,
      totalDuration: model.totalDuration,
    );
  }

  static CallLogModel toModel(CallLogEntity entity) {
    return CallLogModel(
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

  static List<CallLogEntity> toEntities(List<CallLogModel> models) {
    return models.map(toEntity).toList();
  }

  static List<CallLogModel> toModels(List<CallLogEntity> entities) {
    return entities.map(toModel).toList();
  }
}
