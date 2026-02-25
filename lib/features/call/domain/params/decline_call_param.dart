import 'package:uchat/features/call/data/models/models/room_call_model.dart';

class DeclineCallParam {
  final RoomCallModel roomCallModel;
  final bool isCancel;

  DeclineCallParam({
    required this.roomCallModel,
    required this.isCancel,
  });
}
