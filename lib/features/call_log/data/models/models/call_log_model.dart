import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';

class CallLogModel {
  final String id;
  final CallType callType;
  final CallActionType callActionType;
  final RoomType roomType;
  final String roomId;
  final String historyForAccountId;
  final int callCount;
  final DateTime lastStartedAt;
  final double totalDuration;
  final String? friendId;

  CallLogModel({
    required this.id,
    required this.callType,
    required this.callActionType,
    required this.roomType,
    required this.roomId,
    required this.historyForAccountId,
    required this.callCount,
    required this.lastStartedAt,
    required this.totalDuration,
    this.friendId,
  });

  factory CallLogModel.fromJson(Map<String, dynamic> json) {
    return CallLogModel(
      id: json['_id'],
      callType: CallType.fromString(json['callType']),
      callActionType: CallActionType.fromString(json['callActionType']) ?? CallActionType.incoming,
      roomType: RoomType.from(json['roomType']) ?? RoomType.direct,
      roomId: json['roomId'],
      historyForAccountId: json['historyForAccountId'],
      callCount: json['callCount'],
      lastStartedAt: DateTime.parse(json['lastStartedAt']),
      totalDuration: (json['totalDuration'] as num).toDouble(),
      friendId: json['friendId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'callType': callType.toString(),
      'callActionType': callActionType.value,
      'roomType': roomType.toString(),
      'roomId': roomId,
      'historyForAccountId': historyForAccountId,
      'callCount': callCount,
      'lastStartedAt': lastStartedAt.toIso8601String(),
      'totalDuration': totalDuration,
      'friendId': friendId,
    };
  }
}
