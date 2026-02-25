import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';

/// Request class for pinning a message locally
class PinMessageLocalRequest {
  const PinMessageLocalRequest({
    required this.pinMessage,
  });

  /// The pin message entity to store locally
  final PinMessageEntity pinMessage;
}
