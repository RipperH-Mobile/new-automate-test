import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';

abstract class PinMessageServerRepository {
  /// Pins a message in a room
  Future<PinMessageEntity> pinMessage(PinMessageRequest request);

  /// Unpins a specific message using pin ID
  Future<void> unpinMessage(UnpinMessageRequest request);

  /// Unpins all messages in a room
  Future<void> unpinAllMessages(UnpinAllMessagesRequest request);

  /// Gets list of pinned messages with pagination
  Future<PaginationPayload<PinMessageEntity>> getPinMessages(GetPinMessagesRequest request);
}
