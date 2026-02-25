import 'package:uchat/entities/models.dart';

class SendFileMessageParams {
  final String chatRoomId;

  final String? messageRef;

  final List<FileInfoModel> files;

  final bool isSending;

  final String? messageText;

  final bool isLocked;

  final bool isMyNote;

  final String? bookmarkTagId;

  final bool enableUploadPro;

  final bool isResend;

  final Function? customOnSendFailed;

  final Function()? customOnPermissionDenied;

  final int loopCount;

  SendFileMessageParams({
    required this.chatRoomId,
    required this.files,
    required this.isSending,
    required this.isLocked,
    required this.isMyNote,
    required this.enableUploadPro,
    this.messageText,
    this.bookmarkTagId,
    this.isResend = false,
    this.messageRef,
    this.customOnSendFailed,
    this.customOnPermissionDenied,
    this.loopCount = 1,
  }) : assert(!(isResend == true && (messageRef == null || messageRef.isEmpty)),
            'messageRef must be provided if isResend is true');
}
