import 'package:uchat/features/call/data/models/models/room_call_model.dart';

class SocketCallProcessEvent {
  final RoomCallModel roomCall;

  const SocketCallProcessEvent({required this.roomCall});
}
