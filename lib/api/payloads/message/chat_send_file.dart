import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import 'chat_send_message_interface.dart';

final _log = useLogger();

class ChatSendFileRequest implements ChatSendMessageRequestInterface {
  @override
  String roomId;

  @override
  String ref;

  @override
  Future<void> Function()? onSendFail;

  List<File> files;
  String? replyId;
  bool isMultiple;
  int? totalFiles;
  void Function(double percentage)? onCompressingVideoFile;
  ProgressCallback? onSendProgress;
  String? message;
  // in millisecond
  double? duration;
  double? width;
  double? height;
  CancelToken? cancelToken;
  String? refFile;

  /// This data just store for use when preparing the request
  /// it doesn't send to the server
  MessageFileModel messageFile;

  bool? isLocked;

  ChatSendFileRequest({
    required this.roomId,
    required this.ref,
    required this.files,
    required this.messageFile,
    this.replyId,
    this.isMultiple = false,
    this.totalFiles,
    this.onCompressingVideoFile,
    this.onSendProgress,
    this.message,
    this.onSendFail,
    this.duration,
    this.width,
    this.height,
    this.cancelToken,
    this.refFile,
    this.isLocked,
  });

  Future<FormData> toFormData({String? thumbnailId}) async {
    if (files.isEmpty) {
      throw 'No file added';
    }
    FormData formData;
    if (isMultiple) {
      final body = {
        'ref': ref,
        'replyId': replyId,
        'isMultiple': isMultiple,
        'totalFiles': totalFiles,
        'duration': duration,
        'width': width,
        'height': height,
        'blurhash': messageFile.blurhash,
        'type': messageFile.type?.value,
        'mimeType': messageFile.mime,
        'isLocked': isLocked,
        'fileSize': messageFile.size,
      };

      if (thumbnailId != null) {
        body['thumbnailId'] = thumbnailId;
      }

      if (message != null && message!.isNotEmpty) {
        body['message'] = message;
      }
      if (refFile != null) {
        body['refFile'] = refFile;
      }
      _log.d('logging map body $body');
      formData = FormData.fromMap(body);
      for (var file in files) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(file.path),
          ),
        );
      }
    } else {
      final data = {
        'file': await MultipartFile.fromFile(files.first.path),
        'ref': ref,
        'replyId': replyId,
        'duration': duration,
        'width': width,
        'height': height,
        'blurhash': messageFile.blurhash,
        'type': messageFile.type?.value,
        'mimeType': messageFile.mime,
        'isLocked': isLocked,
        'fileSize': messageFile.size,
      };

      if (thumbnailId != null) {
        data['thumbnailId'] = thumbnailId;
      }

      if (message != null && message!.isNotEmpty) {
        data['message'] = message;
      }
      if (refFile != null) {
        data['refFile'] = refFile;
      }
      formData = FormData.fromMap(data);
    }
    return formData;
  }

  factory ChatSendFileRequest.generate({
    required String roomId,
    required String messageRef,
    required int totalFilesInMessage,
    required File targetFile,
    required String fileRef,
    required int fileIndex,
    CancelToken? cancelToken,
    bool? isLivePhoto,
    double? duration,
    String? messageText,
    String? replyId,
    required MessageFileModel messageFile,
    void Function(double percentage)? onCompressingVideoFileCallback,
    required Future<void> Function(int sent, int total) onSendProgressCallback,
    required Future<void> Function() onSendFailCallback,
    bool? isLocked,
  }) {
    return ChatSendFileRequest(
      roomId: roomId,
      ref: messageRef,
      message: messageText,
      files: [targetFile],
      totalFiles: totalFilesInMessage,
      isMultiple: totalFilesInMessage > 1,
      refFile: fileRef,
      replyId: replyId,
      duration: duration,
      cancelToken: cancelToken ?? CancelToken(),
      messageFile: messageFile,
      onCompressingVideoFile: onCompressingVideoFileCallback,
      onSendProgress: onSendProgressCallback,
      onSendFail: onSendFailCallback,
      isLocked: isLocked,
    );
  }
}

class ChatSendFileResponse {
  MessageCollection? message;

  ChatSendFileResponse({
    this.message,
  });

  factory ChatSendFileResponse.fromJson(Map<String, dynamic> json) {
    return ChatSendFileResponse(message: MessageCollection.fromMap(json));
  }
}
