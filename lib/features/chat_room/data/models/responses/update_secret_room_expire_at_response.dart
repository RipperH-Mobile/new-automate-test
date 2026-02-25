import 'package:uchat/features/chat_room/domain/entities/update_secret_room_expire_at_entity.dart';
import 'package:uchat/utils/datetime.dart';

class UpdateSecretRoomExpireAtResponse {
  String roomId;
  String roomExpirationType;
  int expireIn;
  DateTime expireAt;

  UpdateSecretRoomExpireAtResponse({
    required this.roomId,
    required this.roomExpirationType,
    required this.expireIn,
    required this.expireAt,
  });

  static UpdateSecretRoomExpireAtResponse fromMap(Map<String, dynamic> data) {
    return UpdateSecretRoomExpireAtResponse(
      roomId: data['_id'],
      roomExpirationType: data['roomExpirationType'],
      expireIn: data['expireIn'],
      expireAt: strToDateTime(data['expireAt'])!,
    );
  }

  UpdateSecretRoomExpireAtEntity toEntity() {
    return UpdateSecretRoomExpireAtEntity(
      roomId: roomId,
      roomExpirationType: roomExpirationType,
      expireIn: expireIn,
      expireAt: expireAt,
    );
  }
}
