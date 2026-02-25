import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enums.dart';

@immutable
class JoinGroupResponse {
  final String id;
  final String status;
  final RoomAccessType roomType;

  const JoinGroupResponse({
    required this.id,
    required this.status,
    required this.roomType,
  });

  factory JoinGroupResponse.fromMap(Map<String, dynamic> map) {
    return JoinGroupResponse(
      id: map['_id'] as String,
      status: map['status'] as String,
      roomType: RoomAccessType.from(map['roomType'] as String),
    );
  }
}
