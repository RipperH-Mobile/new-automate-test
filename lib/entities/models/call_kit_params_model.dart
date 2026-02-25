import 'dart:convert';

import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';

class CallKitParamsModel {
  CallKitParamsModel({
    this.avatar,
    this.liveKitToken,
    this.liveKitRoomSid,
    this.name,
    this.background,
    this.roomCallId,
    this.roomId,
    this.roomType,
    this.callType,
    this.type,
  });

  final String? avatar;
  final String? liveKitToken;
  final String? liveKitRoomSid;
  final String? name;
  final String? background;
  final String? roomCallId;
  final String? roomId;
  final RoomType? roomType; //DIRECT, GROUP
  final CallType? callType; //VOICE, VIDEO
  final double? type; //0=audio, 1=video, incoming lib standard.

  factory CallKitParamsModel.fromJson(String str) => CallKitParamsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CallKitParamsModel.fromMap(Map<String, dynamic> json) => CallKitParamsModel(
        avatar: json['imageUrl'],
        liveKitToken: json['liveKitToken'],
        liveKitRoomSid: json['liveKitRoomSID'],
        name: json['title'],
        roomCallId: json['roomCallId'],
        roomId: json['roomId'],
        background: json['background'],
        roomType: json['roomType'] != null ? RoomType.from(json['roomType']) : null,
        callType: json['callType'] != null ? CallType.fromString(json['callType']) : null,
        type: double.tryParse(json['type']),
      );

  Map<String, dynamic> toMap() => {
        'avatar': avatar,
        'roomCallId': roomCallId,
        'roomId': roomId,
        'liveKitToken': liveKitToken,
        'liveKitRoomSID': liveKitRoomSid,
        'name': name,
        'background': background,
        'roomType': roomType,
        'callType': callType,
        'type': type,
      };
}
