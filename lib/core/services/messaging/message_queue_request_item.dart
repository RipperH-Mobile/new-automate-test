import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request_interface.dart';

class MessageQueueRequestItem<T extends SendMessageRequestInterface> {
  final String roomId;
  final String messageRef;
  final T messageRequest;
  final OnPrecessMessageRequestFunction<T> onProcessing;

  MessageQueueRequestItem({
    required this.roomId,
    required this.messageRef,
    required this.messageRequest,
    required this.onProcessing,
  });
}
