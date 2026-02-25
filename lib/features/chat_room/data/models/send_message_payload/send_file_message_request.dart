import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request_interface.dart';

class SendFileMessageRequest implements SendMessageRequestInterface {
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

  final List<File> files;

  final bool isMultiple;

  final int? totalFiles;

  final void Function(double percentage)? onCompressingVideoFile;

  final ProgressCallback? onSendProgress;
  final ProgressCallback? onSendThumbnailProgress;

  final String? message;

  /// in millisecond
  final double? duration;

  final double? width;

  final double? height;

  final CancelToken? cancelToken;

  final String? refFile;

  final List<FileInfoModel>? fileInfoList;

  /// This data just store for use when preparing the request
  /// it doesn't send to the server
  final MessageFileModel messageFile;

  SendFileMessageRequest({
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
    this.onPermissionDenied,
    this.duration,
    this.width,
    this.height,
    this.cancelToken,
    this.refFile,
    this.isLocked,
    this.fileInfoList,
    this.onSendThumbnailProgress,
  });

  Future<FormData> toFormData({String? thumbnailId}) async {
    if (files.isEmpty) {
      throw 'No file added';
    }

    FormData formData;
    if (isMultiple) {
      final body = {
        'file': await MultipartFile.fromFile(messageFile.uploadFile!.path),
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

      if (messageFile.isPasswordProtected != null) {
        body['isPasswordProtected'] = messageFile.isPasswordProtected;
      }

      formData = FormData.fromMap(body);
    } else {
      final data = {
        'file': await MultipartFile.fromFile(messageFile.uploadFile!.path),
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
      if (messageFile.isPasswordProtected != null) {
        data['isPasswordProtected'] = messageFile.isPasswordProtected;
      }

      formData = FormData.fromMap(data);
    }
    return formData;
  }

  factory SendFileMessageRequest.generate({
    required String roomId,
    required String messageRef,
    required int totalFilesInMessage,
    required String fileRef,
    required int fileIndex,
    CancelToken? cancelToken,
    File? targetFile,
    bool? isLivePhoto,
    double? duration,
    String? messageText,
    String? replyId,
    required MessageFileModel messageFile,
    void Function(double percentage)? onCompressingVideoFileCallback,
    required Future<void> Function(int sent, int total) onSendProgressCallback,
    required Future<void> Function(int sent, int total) onSendThumbnailCallback,
    required Future<void> Function() onSendFailCallback,
    Future<void> Function()? onPermissionDenied,
    bool? isLocked,
    double? width,
    double? height,
    List<FileInfoModel>? fileInfoList,
  }) {
    return SendFileMessageRequest(
      roomId: roomId,
      ref: messageRef,
      message: messageText,
      files: targetFile != null ? [targetFile] : [],
      totalFiles: totalFilesInMessage,
      isMultiple: totalFilesInMessage > 1,
      refFile: fileRef,
      replyId: replyId,
      duration: duration,
      cancelToken: cancelToken ?? CancelToken(),
      messageFile: messageFile,
      onCompressingVideoFile: onCompressingVideoFileCallback,
      onSendProgress: onSendProgressCallback,
      onSendThumbnailProgress: onSendThumbnailCallback,
      onSendFail: onSendFailCallback,
      onPermissionDenied: onPermissionDenied,
      isLocked: isLocked,
      width: width,
      height: height,
      fileInfoList: fileInfoList,
    );
  }

  SendFileMessageRequest copyWith({
    bool? isLocked,
    Future<void> Function()? onSendFail,
    Future<void> Function()? onPermissionDenied,
    String? ref,
    String? replyId,
    String? roomId,
    List<File>? files,
    bool? isMultiple,
    int? totalFiles,
    void Function(double percentage)? onCompressingVideoFile,
    ProgressCallback? onSendProgress,
    String? message,
    double? duration,
    double? width,
    double? height,
    CancelToken? cancelToken,
    String? refFile,
    MessageFileModel? messageFile,
    List<FileInfoModel>? fileInfoList,
  }) {
    return SendFileMessageRequest(
      isLocked: isLocked ?? this.isLocked,
      onSendFail: onSendFail ?? this.onSendFail,
      ref: ref ?? this.ref,
      replyId: replyId ?? this.replyId,
      roomId: roomId ?? this.roomId,
      files: files ?? this.files,
      isMultiple: isMultiple ?? this.isMultiple,
      totalFiles: totalFiles ?? this.totalFiles,
      onCompressingVideoFile: onCompressingVideoFile ?? this.onCompressingVideoFile,
      onSendProgress: onSendProgress ?? this.onSendProgress,
      message: message ?? this.message,
      duration: duration ?? this.duration,
      width: width ?? this.width,
      height: height ?? this.height,
      cancelToken: cancelToken ?? this.cancelToken,
      refFile: refFile ?? this.refFile,
      messageFile: messageFile ?? this.messageFile,
      fileInfoList: fileInfoList ?? this.fileInfoList,
      onPermissionDenied: onPermissionDenied ?? this.onPermissionDenied,
    );
  }
}
