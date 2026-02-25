import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';

class PinMessageEvent {
  final PinMessageEntity pinMessage;
  PinMessageEvent({required this.pinMessage});
}