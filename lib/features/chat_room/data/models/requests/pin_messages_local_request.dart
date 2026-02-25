import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';

class PinMessagesLocalRequest {
  const PinMessagesLocalRequest({
    required this.pinMessages,
  });

  final List<PinMessageEntity> pinMessages;
}
