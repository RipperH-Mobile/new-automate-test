import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/message_room_call_type.dart';
import 'package:uchat/utils/datetime.dart';

part 'message_call_payload_model.g.dart';

@embedded
class MessageCallPayloadModel {
  String? callEndDuration;
  @Enumerated(EnumType.name)
  MessageRoomCallType? roomCallType;
  String? accountId;
  List<String>? joinedUsers;
  bool? isJoined;
  String? displayName;

  MessageCallPayloadModel({
    this.callEndDuration,
    this.roomCallType,
    this.accountId,
    this.joinedUsers,
    this.isJoined,
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['duration'] = callEndDuration;
    if (roomCallType != null) {
      data['roomCallType'] = roomCallType!.value;
    }
    data['accountId'] = accountId;
    data['joinedUsers'] = joinedUsers;
    data['isJoined'] = isJoined;
    data['displayName'] = displayName;
    return data;
  }

  factory MessageCallPayloadModel.fromMap(Map<String, dynamic> json) {
    final payload = MessageCallPayloadModel();
    if (json['duration'] != null) {
      if (json['duration'] is double) {
        payload.callEndDuration = (json['duration'] as double).floor().toString();
      }
      if (json['duration'] is int) {
        payload.callEndDuration = (json['duration'] as int).toString();
      }
    }
    if (json['roomCallType'] != null) {
      payload.roomCallType = MessageRoomCallType.from(json['roomCallType']);
    }

    if (json['joinedUsers'] != null) {
      payload.joinedUsers = List<String>.from(json['joinedUsers']);
    }

    payload.accountId = json['accountId'];
    payload.isJoined = json['isJoined'];
    payload.displayName = json['displayName'];
    return payload;
  }

  String get durationString {
    String time = formatTime(int.parse(callEndDuration ?? '0'));
    List<String> timeSplit = time.split(':'); // ex. the string: 00:02:00 (hour:minute:second)
    String durationTemp = time;
    if (timeSplit[0] == '00') {
      durationTemp = '${timeSplit[1]}:${timeSplit[2]}';
    }
    return durationTemp;
  }
}
