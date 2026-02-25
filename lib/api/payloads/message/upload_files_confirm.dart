class UploadFilesConfirmRequest {
  String roomId;
  String ref;
  String fileType;
  int fileUploadCount;
  String? message;
  bool? isLocked;
  String? lockMessageSalt;
  String? lockMessageIv;
  String? bookmarkTagId;

  UploadFilesConfirmRequest({
    required this.roomId,
    required this.ref,
    required this.fileType,
    required this.fileUploadCount,
    this.message,
    this.isLocked = false,
    this.lockMessageSalt,
    this.lockMessageIv,
    this.bookmarkTagId,
  });

  Map<String, dynamic> toMap() {
    final jsonData = {
      'ref': ref,
      'fileType': fileType,
      'fileUploadCount': fileUploadCount,
      'isLocked': isLocked,
      'meta': {}
    };

    if (message != null && message?.isNotEmpty == true) {
      jsonData['message'] = message!;
    }

    if (bookmarkTagId != null && bookmarkTagId?.isNotEmpty == true) {
      jsonData['emojiTagId'] = bookmarkTagId!;
    }

    Map<String, dynamic> metaBody = {};
    if (lockMessageSalt != null && lockMessageSalt?.isNotEmpty == true) {
      metaBody['lockMessageSalt'] = lockMessageSalt!;
    }

    if (lockMessageIv != null && lockMessageIv?.isNotEmpty == true) {
      metaBody['lockMessageIv'] = lockMessageIv!;
    }

    if (metaBody.isNotEmpty) {
      jsonData['meta'] = metaBody;
    }

    return jsonData;
  }
}
