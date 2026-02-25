import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';

part 'message_system_model.g.dart';

@embedded
class MessageSystemModel {
  @Enumerated(EnumType.name)
  MessageSystemType? type;

  MessageSystemPayloadModel? payload;

  MessageSystemModel({
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

  factory MessageSystemModel.fromMap(Map<String, dynamic> json) {
    MessageSystemType? systemType;
    if (json['type'] != null) {
      systemType = MessageSystemType.from(json['type']);
    }

    MessageSystemPayloadModel? systemPayload;
    if (json['payload'] != null) {
      systemPayload = MessageSystemPayloadModel.fromMap(json['payload']);
    }

    return MessageSystemModel(
      type: systemType,
      payload: systemPayload,
    );
  }

  bool get isCallEnd {
    return type == MessageSystemType.callEnd;
  }
}
