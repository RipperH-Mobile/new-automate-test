import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_messages_local_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_local_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/watch_pin_messages_in_room_local_request.dart';

abstract class PinMessageLocalRepository {
  /// Pin a message
  Future<void> pinMessage(PinMessageLocalRequest request, {bool useTxn = true});

  /// Pin a messages
  Future<void> pinMessages(PinMessagesLocalRequest request);

  /// Unpin a specific message by pinId
  Future<void> unpinMessage(UnpinMessageRequest request, {bool useTxn = true});

  /// Get pin message by ref
  Future<PinMessageEntity?> getPinMessageByRef(String ref);

  /// Unpin all messages in a room
  Future<void> unpinAllMessagesInRoom(UnpinAllMessagesRequest request, {bool useTxn = true});

  /// Get all pin messages in a room
  Future<PaginationPayload<PinMessageEntity>> getPinMessagesInRoom(GetPinMessagesRequest request);

  /// Watch pin messages changes in a room
  Stream<PaginationPayload<PinMessageEntity>> watchPinMessagesInRoom(WatchPinMessagesInRoomLocalRequest request);
}
