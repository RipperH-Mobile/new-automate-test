import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'call_log_collection.g.dart';

@Collection(accessor: 'callLogs')
@Name('CallLog')
class CallLogCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id ?? '');

  @Enumerated(EnumType.name)
  CallType? callType;

  @Index()
  @Enumerated(EnumType.name)
  CallActionType? callActionType;

  @Enumerated(EnumType.name)
  RoomType? roomType;

  @Index()
  String? roomId;

  @Index()
  String? friendId;

  String? historyForAccountId;

  int? callCount;

  DateTime? lastStartedAt;

  double? totalDuration;

  CallLogCollection({
    this.id,
    this.callType,
    this.callActionType,
    this.roomType,
    this.roomId,
    this.friendId,
    this.historyForAccountId,
    this.callCount,
    this.lastStartedAt,
    this.totalDuration,
  });

  @override
  bool operator ==(Object other) {
    return other is CallLogCollection && id == other.id;
  }

  // from json
  factory CallLogCollection.fromJson(Map<String, dynamic> json) {
    return CallLogCollection(
      id: json['id'] as String?,
      callType: (json['callType'] as String?) != null ? CallType.fromString(json['callType']) : null,
      callActionType:
          (json['callActionType'] as String?) != null ? CallActionType.fromString(json['callActionType']) : null,
      roomType: (json['roomType'] as String?) != null ? RoomType.from(json['roomType']) : null,
      roomId: json['roomId'] as String?,
      friendId: json['friendId'] as String?,
      historyForAccountId: json['historyForAccountId'] as String?,
      callCount: json['callCount'] as int?,
      lastStartedAt: json['lastStartedAt'] != null ? DateTime.parse(json['lastStartedAt']) : null,
      totalDuration: (json['totalDuration'] as num?)?.toDouble(),
    );
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '[CallLogCollection] id: $id, callType: $callType, roomId: $roomId, historyForAccountId: $historyForAccountId, lastStartedAt: $lastStartedAt';
  }
}
