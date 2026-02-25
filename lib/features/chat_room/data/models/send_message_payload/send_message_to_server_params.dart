import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:webcrypto/webcrypto.dart';

class SendMessageToServerParams {
  final String chatRoomId;

  final String? messageRef;

  final bool isSecretRoom;

  final bool isShare;

  final MessageCollection message;

  final bool? isLocked;

  final AesGcmSecretKey? roomCryptoKey;

  final String? bookmarkTagId;

  final MessageModel? replyMessage;

  final String accountId;

  final bool isSending;

  final bool isResend;

  final Function? customOnSendFailed;

  final Function()? customOnPermissionDenied;

  final int loopCount;

  SendMessageToServerParams({
    required this.chatRoomId,
    required this.isSecretRoom,
    required this.message,
    required this.accountId,
    this.isLocked = false,
    this.isSending = false,
    this.isShare = false,
    this.replyMessage,
    this.roomCryptoKey,
    this.bookmarkTagId,
    this.messageRef,
    this.isResend = false,
    this.customOnSendFailed,
    this.customOnPermissionDenied,
    this.loopCount = 1,
  }) : assert(!(isResend == true && (messageRef == null || messageRef.isEmpty)),
            'messageRef must be provided if isResend is true');
}
