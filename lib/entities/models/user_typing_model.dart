import 'package:uchat/utils/datetime.dart';

class UserTypingModel {
  String? id;
  String? roomId;
  DateTime? lastTypedAt;
  bool? isTyping;

  UserTypingModel({
    this.id,
    this.roomId,
    this.lastTypedAt,
    this.isTyping,
  });

  factory UserTypingModel.fromMap(Map<String, dynamic> json) {
    String? typingAccountId = json['_id'];
    String? roomId = json['roomId'];
    DateTime? lastTypedAt = strToDateTime(json['lastTypedAt']);
    bool? isTyping = json['isTyping'];

    return UserTypingModel(
      id: typingAccountId,
      roomId: roomId,
      lastTypedAt: lastTypedAt,
      isTyping: isTyping,
    );
  }
}
