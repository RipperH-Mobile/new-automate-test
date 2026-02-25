import 'package:uchat/entities/enums.dart';

class ChangeGroupAccessTypeRequest {
  final String roomId;
  final RoomAccessType accessType;

  ChangeGroupAccessTypeRequest({
    required this.roomId,
    required this.accessType,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'accessType': accessType.value,
    };
  }
}
