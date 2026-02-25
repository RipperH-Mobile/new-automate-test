import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

/// Helper function to hide failed message indicator when there are no failed messages.
///
/// This function checks if there are any failed messages in the room and
/// if not, it updates the room's hasFailedMessage flag and fires an event
/// to hide the failed message indicator in the UI.
Future<void> hideFailedMessageIndicatorIfNeeded({
  required String roomId,
  required MessageDb messageDb,
  required RoomCollection? room,
}) async {
  final hasFailedMessages = await messageDb.countSendFailedMessageFromSequence(roomId: roomId) > 0;

  if (!hasFailedMessages) {
    room?.hasFailedMessage = false;
    eventBus.fire(ToggleFailedMessageEvent(roomId: roomId, show: false));
  }
}
