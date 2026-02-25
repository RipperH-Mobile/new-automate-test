import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_multi_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/message_failure_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/progress_tracking_service.dart';

/// Service responsible for building file upload requests
/// Separates request creation logic from the main use case
class FileRequestBuilderService {
  final LoggerService _logger;
  final ProgressTrackingService _progressTrackingService;
  final MessageFailureService _messageFailureService;

  FileRequestBuilderService(
    this._logger,
    this._progressTrackingService,
    this._messageFailureService,
  );

  /// Creates a multi-file message request
  SendMultiFileMessageRequest createMultiFileRequest({
    required MessageEntity message,
    required SendFileMessageParams params,
    required List<FileInfoModel> fileInfoList,
  }) {
    try {
      final List<SendFileMessageRequest> sendFileRequests = [];

      for (var messageFileIndex = 0; messageFileIndex < fileInfoList.length; messageFileIndex++) {
        final fileInfo = fileInfoList[messageFileIndex];
        final msgFileModel = message.files?.elementAtOrNull(messageFileIndex);

        final sendFileRequest = SendFileMessageRequest.generate(
          fileInfoList: fileInfoList,
          roomId: params.chatRoomId,
          messageRef: message.ref!,
          totalFilesInMessage: fileInfoList.length,
          targetFile: null,
          fileRef: fileInfo.messageFile?.refFile ?? msgFileModel!.refFile!,
          fileIndex: messageFileIndex,
          isLivePhoto: fileInfo.isLivePhoto,
          duration: fileInfo.duration,
          messageText: message.message,
          replyId: message.replyMessage?.id,
          messageFile: msgFileModel!,
          isLocked: message.isLocked,
          width: fileInfo.width,
          height: fileInfo.height,
          onSendThumbnailCallback: (sent, total) async {
            await _progressTrackingService.onThumbnailProgressCallback(
              sent: sent,
              total: total,
              message: message.toCollection(),
              fileIndex: messageFileIndex,
            );
          },
          onCompressingVideoFileCallback: (double progress) async {
            await _progressTrackingService.onCompressingVideoFileCallback(
              progress: progress,
              message: message.toCollection(),
              fileIndex: messageFileIndex,
            );
          },
          onSendProgressCallback: (sent, total) async {
            await _progressTrackingService.onSendProgressCallback(
              sent: sent,
              total: total,
              message: message.toCollection(),
              fileIndex: messageFileIndex,
            );
          },
          onPermissionDenied: () async {
            final callback = _buildPermissionDeniedCallback(
              params,
              message,
            );
            await callback();
          },
          onSendFailCallback: () async {
            final callback = _buildSendFailCallback(
              params,
              message,
              msgFileModel,
            );
            await callback();
          },
        );
        sendFileRequests.add(sendFileRequest);
      }

      return SendMultiFileMessageRequest(
        message: message.toCollection(),
        roomId: params.chatRoomId,
        ref: message.ref!,
        requestList: sendFileRequests,
        isLocked: message.isLocked,
        lockMessageSalt: message.meta?.lockMessageSalt,
        lockMessageIv: message.meta?.lockMessageIv,
        bookmarkTagId: params.bookmarkTagId,
        enableUploadPro: params.enableUploadPro,
        fileInfoList: fileInfoList,
        loopCount: params.loopCount,
        onPermissionDenied: () async => _buildPermissionDeniedCallback(params, message),
        onSendFail: () async => _buildMultiFileSendFailCallback(params, message, sendFileRequests),
      );
    } catch (e, stackTrace) {
      _logger.e('createMultiFileRequest error', e, stackTrace);
      rethrow;
    }
  }

  /// Builds permission denied callback
  Function() _buildPermissionDeniedCallback(
    SendFileMessageParams params,
    MessageEntity message,
  ) {
    return () async {
      if (params.customOnPermissionDenied != null) {
        await params.customOnPermissionDenied!();
      }
      await _messageFailureService.handlePermissionDenied(
        message: message.toCollection().copy(),
        roomId: params.chatRoomId,
      );
    };
  }

  /// Builds send fail callback for individual files
  Function() _buildSendFailCallback(
    SendFileMessageParams params,
    MessageEntity message,
    MessageFileModel msgFileModel,
  ) {
    return () async {
      if (params.customOnSendFailed != null) {
        await params.customOnSendFailed!();
      }

      final fileRef = msgFileModel.refFile;
      if (fileRef == null) {
        _logger.e('msgFileModel or refFile is null in onSendFailCallback');
        return;
      }

      await _messageFailureService.handleSendFailure(
        message: message.toCollection(),
        fileRef: fileRef,
        sendToRoomId: params.chatRoomId,
      );
    };
  }

  /// Builds send fail callback for multi-file messages
  Function() _buildMultiFileSendFailCallback(
    SendFileMessageParams params,
    MessageEntity message,
    List<SendFileMessageRequest> sendFileRequests,
  ) {
    return () async {
      if (params.customOnSendFailed != null) {
        await params.customOnSendFailed!();
      }

      for (var i = 0; i < sendFileRequests.length; i++) {
        final fileRef = sendFileRequests[i].messageFile.refFile;
        if (fileRef == null) continue;

        await _messageFailureService.handleSendFailure(
          message: message.toCollection(),
          fileRef: fileRef,
          sendToRoomId: params.chatRoomId,
        );
      }
    };
  }
}
