import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class CallLogWithContactMapper {
  static List<CallLogWithContactEntity> fromCallLogs({
    required List<CallLogEntity> callLogs,
    required List<ContactEntity> contacts,
    required List<RoomEntity> rooms,
  }) {
    final contactsById = <String, ContactEntity>{
      for (final contact in contacts)
        if ((contact.id ?? '').isNotEmpty) contact.id!: contact,
    };

    final roomsById = <String, RoomEntity>{
      for (final room in rooms)
        if (room.id.isNotEmpty) room.id: room,
    };

    return callLogs
        .map(
          (callLog) => fromCallLog(
            callLog: callLog,
            contactsById: contactsById,
            roomsById: roomsById,
          ),
        )
        .toList();
  }

  static CallLogWithContactEntity fromCallLog({
    required CallLogEntity callLog,
    required Map<String, ContactEntity> contactsById,
    required Map<String, RoomEntity> roomsById,
  }) {
    final contact = contactsById[callLog.friendId];

    final room = roomsById[callLog.roomId];

    return CallLogWithContactEntity(
      id: callLog.id,
      callType: callLog.callType,
      callActionType: callLog.callActionType,
      roomType: callLog.roomType,
      roomId: callLog.roomId,
      historyForAccountId: callLog.historyForAccountId,
      callCount: callLog.callCount,
      lastStartedAt: callLog.lastStartedAt,
      totalDuration: callLog.totalDuration,
      contact: contact,
      room: room,
    );
  }
}
