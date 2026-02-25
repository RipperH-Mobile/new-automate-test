import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';

class CallLogWithContactEntity {
  final String id;
  final CallType callType;
  final CallActionType callActionType;
  final RoomType roomType;
  final String roomId;
  final String historyForAccountId;
  final int callCount;
  final DateTime lastStartedAt;
  final double totalDuration;
  final ContactEntity? contact;
  final RoomEntity? room;

  const CallLogWithContactEntity({
    required this.id,
    required this.callType,
    required this.callActionType,
    required this.roomType,
    required this.roomId,
    required this.historyForAccountId,
    required this.callCount,
    required this.lastStartedAt,
    required this.totalDuration,
    this.contact,
    this.room,
  });
}
