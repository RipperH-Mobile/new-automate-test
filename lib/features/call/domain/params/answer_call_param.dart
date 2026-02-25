import 'package:uchat/features/call/data/models/models/room_call_model.dart';

class AnswerCallParam {
  final RoomCallModel callData;
  final bool isGroupIncoming;

  AnswerCallParam({
    required this.callData,
    required this.isGroupIncoming,
  });
}
