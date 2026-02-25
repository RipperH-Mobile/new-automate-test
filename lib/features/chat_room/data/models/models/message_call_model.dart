import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';

part 'message_call_model.g.dart';

@embedded
class MessageCallModel {
  @Enumerated(EnumType.name)
  MessageCallType? type;
  MessageCallPayloadModel? payload;

  MessageCallModel({
    this.type,
    this.payload,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    if (type != null) {
      data['type'] = type!.value;
    }
    if (payload != null) {
      data['payload'] = payload!.toMap();
    }
    return data;
  }

  factory MessageCallModel.fromMap(Map<String, dynamic> json) {
    MessageCallType? callType;
    if (json['type'] != null) {
      callType = MessageCallType.from(json['type']);
    }

    MessageCallPayloadModel? callPayload;
    if (json['payload'] != null) {
      callPayload = MessageCallPayloadModel.fromMap(json['payload']);
    }

    return MessageCallModel(
      type: callType,
      payload: callPayload,
    );
  }

  bool get isEndCall {
    return type == MessageCallType.end;
  }

  bool get isVoice {
    return payload?.roomCallType == MessageRoomCallType.voice;
  }

  bool get isVideo {
    return payload?.roomCallType == MessageRoomCallType.video;
  }
}
