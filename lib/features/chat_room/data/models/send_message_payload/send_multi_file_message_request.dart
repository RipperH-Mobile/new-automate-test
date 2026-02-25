import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request_interface.dart';

class SendMultiFileMessageRequest implements SendMessageRequestInterface {
  @override
  final bool? isLocked;

  @override
  final Future<void> Function()? onSendFail;

  @override
  final Future<void> Function()? onPermissionDenied;

  @override
  final String ref;

  @override
  final String? replyId;

  @override
  final String roomId;

  final String? lockMessageSalt;

  final String? lockMessageIv;

  final String? bookmarkTagId;

  final List<SendFileMessageRequest> requestList;

  final bool enableUploadPro;

  final MessageCollection message;

  final List<FileInfoModel>? fileInfoList;

  final int loopCount;

  SendMultiFileMessageRequest({
    required this.roomId,
    required this.ref,
    required this.requestList,
    required this.enableUploadPro,
    required this.message,
    this.onSendFail,
    this.onPermissionDenied,
    this.isLocked,
    this.lockMessageSalt,
    this.lockMessageIv,
    this.bookmarkTagId,
    this.replyId,
    this.fileInfoList,
    this.loopCount = 1,
  });

  @override
  String toString() {
    return 'SendMultiFileMessageRequest(roomId: $roomId, ref: $ref, onSendFail: $onSendFail, requestList: $requestList, isLocked: $isLocked, lockMessageSalt: $lockMessageSalt, lockMessageIv: $lockMessageIv)';
  }
}
