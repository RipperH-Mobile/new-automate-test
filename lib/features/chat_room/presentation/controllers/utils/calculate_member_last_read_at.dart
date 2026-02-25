import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/utils/extension/extension_map.dart';

void calculateMemberLastReadAtHelper({
  required RxList<RoomMemberCollection> members,
  required RxInt myLastReadAt,
  required RxMap<String, int> memberLastReadAtMap,
  required RxInt roomLastReadAt,
  required LoggerService log,
}) {
  try {
    int lastestReadAt = 0;
    final mapLastReadAt = <String, int>{};
    for (final member in members) {
      final lastSeenMessageAt = member.lastSeenMessageAt?.millisecondsSinceEpoch;

      // Skip if the last seen message timestamp is null. (not add to the map)
      if (lastSeenMessageAt == null) {
        continue;
      }

      // Skip if the member is the current user. (not add to the map)
      if (member.isMe) {
        // Set the last read message timestamp of the current user.
        myLastReadAt.value = lastSeenMessageAt;
        continue;
      }

      // Add the last read message timestamp of the member to the map.
      mapLastReadAt[member.accountId!] = lastSeenMessageAt;

      // Update the lastest read message timestamp.
      if (lastSeenMessageAt > lastestReadAt) {
        lastestReadAt = lastSeenMessageAt;
      }
    }

    memberLastReadAtMap.value = mapLastReadAt.sortedBy((value) => value, isAsc: false);
    memberLastReadAtMap.refresh();
    roomLastReadAt.value = lastestReadAt;
    roomLastReadAt.refresh();
  } catch (e, s) {
    log.e('Error calculating member last read at', e, s);
  }
}
