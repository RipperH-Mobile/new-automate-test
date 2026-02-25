import 'package:uchat/features/call/utils/enum.dart';

class StartCallRequest {
  final CallType callType;
  final String roomId;

  StartCallRequest({
    required this.callType,
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'type': callType.value,
    };
  }
}
