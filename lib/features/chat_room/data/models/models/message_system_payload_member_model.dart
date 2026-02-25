import 'package:isar_community/isar.dart';

part 'message_system_payload_member_model.g.dart';

@embedded
class MessageSystemPayloadMemberModel {
  String? id;
  String? displayName;

  MessageSystemPayloadMemberModel({
    this.id,
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
    };
  }

  factory MessageSystemPayloadMemberModel.fromMap(Map<String, dynamic> json) {
    return MessageSystemPayloadMemberModel(
      id: json['id'],
      displayName: json['displayName'],
    );
  }
}
