// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uchat/api/payloads/message/chat_send_file.dart';
import 'package:uchat/api/payloads/message/chat_send_message_interface.dart';

class ChatSendMultipleFileRequest implements ChatSendMessageRequestInterface {
  @override
  String roomId;

  @override
  String ref;

  @override
  Future<void> Function()? onSendFail;

  bool? isLocked;
  String? lockMessageSalt;
  String? lockMessageIv;
  String? bookmarkTagId;

  List<ChatSendFileRequest> requestList;

  ChatSendMultipleFileRequest({
    required this.roomId,
    required this.ref,
    required this.requestList,
    this.onSendFail,
    this.isLocked,
    this.lockMessageSalt,
    this.lockMessageIv,
    this.bookmarkTagId,
  });

  @override
  String toString() {
    return 'ChatSendMultipleFileRequest(roomId: $roomId, ref: $ref, onSendFail: $onSendFail, requestList: $requestList, isLocked: $isLocked, lockMessageSalt: $lockMessageSalt, lockMessageIv: $lockMessageIv)';
  }
}
