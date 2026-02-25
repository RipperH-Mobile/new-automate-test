import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/api/payloads/message/upload_files_confirm.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_multi_file_message_request.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_message_use_case.dart';

/// Service responsible for processing multi-file message requests
/// Separates the complex multi-file processing logic from the main use case
class MultiFileProcessingService {
  final LoggerService _logger;

  MultiFileProcessingService(this._logger);

  SyncHandleUpdateMessageUseCase get syncHandleUpdateMessageUseCase {
    return GetIt.I<SyncHandleUpdateMessageUseCase>();
  }

  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  /// Processes multi-file message requests helper
  Future<(List<MessageFileModel>, MessageCollection?)> processMultiFileHelper(
    SendMultiFileMessageRequest requestData,
    String fileType,
    Future<(SendFileMessageRequest, MessageCollection?)> Function(
            SendFileMessageRequest, String, String, String, bool, bool)
        sendFileToServerProcess,
  ) async {
    final List<MessageFileModel> messageFiles = [];
    final generateMessageFileMetric = usePerformance().newTrace('generateMessageFile');
    await generateMessageFileMetric.start();

    int length = requestData.fileInfoList?.length ?? 0;
    int totalFileSizeInBytes = 0;

    try {
      for (var i = 0; i < length; i++) {
        await SendingMsgPerformanceServiceImpl.mainTrace.start();
        await SendingMsgPerformanceServiceImpl.sendOneFileToServerTrace.start();

        final fileInfo = requestData.fileInfoList?.elementAtOrNull(i);
        if (fileInfo == null) {
          continue;
        }

        final file = await _generateFileModel(
          fileInfo,
          requestData.roomId,
          requestData.ref,
          i,
          fileInfo.messageFile?.refFile,
          fileType,
        );

        totalFileSizeInBytes += (file?.size ?? 0);

        // Add performance tracking
        SendingMsgPerformanceServiceImpl.mainTrace.putTraceAttributes(
          messageRef: requestData.ref,
          messageType: fileType,
          loopCount: requestData.loopCount,
        );
        SendingMsgPerformanceServiceImpl.sendOneFileToServerTrace.putTraceAttributes(
          messageRef: requestData.ref,
          messageType: fileType,
          fileRef: file?.refFile,
          messageSizeInBytes: (file?.size ?? 0),
        );

        final compareFile = requestData.fileInfoList?.elementAtOrNull(i);
        final newFile = file?.copyWith(
          assetId: compareFile?.assetId ?? file.assetId,
          order: compareFile?.order,
          type: compareFile?.type,
          refFile: compareFile?.messageFile?.refFile,
          thumbnailBytes: compareFile?.messageFile?.thumbnailBytes,
          url: file.url ?? compareFile?.initFile?.path,
          width: compareFile?.width,
          height: compareFile?.height,
        );

        final selectedFile = newFile ?? file;
        if (selectedFile == null) {
          await SendingMsgPerformanceServiceImpl.sendOneFileToServerTrace.stop();
          await SendingMsgPerformanceServiceImpl.mainTrace.stop();
          continue;
        }

        final req = requestData.requestList[i].copyWith(
          messageFile: selectedFile,
          files: [File(selectedFile.url!)],
        );

        final updatedReq = await sendFileToServerProcess(
          req,
          requestData.roomId,
          requestData.message.meta?.lockMessageSalt ?? '',
          requestData.message.meta?.lockMessageIv ?? '',
          requestData.enableUploadPro,
          false,
        );

        final newfile = selectedFile.copyWith(url: updatedReq.$1.messageFile.apiFileUrl);
        messageFiles.add(newfile);

        requestData.requestList[i] = updatedReq.$1;

        await SendingMsgPerformanceServiceImpl.sendOneFileToServerTrace.stop();
        await SendingMsgPerformanceServiceImpl.mainTrace.stop();

        if (i == length - 1) {
          await generateMessageFileMetric.stop();

          SendingMsgPerformanceServiceImpl.sendMessageProcessingTrace.putTraceAttributes(
            messageRef: requestData.ref,
            messageType: fileType,
            messageSizeInBytes: totalFileSizeInBytes,
          );

          // Sort the message file by order
          messageFiles.sort((a, b) => a.order.compareTo(b.order));
          return (messageFiles, updatedReq.$2);
        }
      }

      return (messageFiles, null);
    } catch (e, stackTrace) {
      _logger.e('Error generating message file model', e, stackTrace);
      rethrow;
    }
  }

  /// Main processing method for multi-file messages
  Future<void> processMultiFileMessage(
    SendMultiFileMessageRequest requestData,
    Future<(SendFileMessageRequest, MessageCollection?)> Function(
            SendFileMessageRequest, String, String, String, bool, bool)
        sendFileToServerProcess,
  ) async {
    try {
      await SendingMsgPerformanceServiceImpl.sendMessageProcessingTrace.start();

      final messageDescription = requestData.requestList.first.message;
      final fileType = requestData.requestList.firstOrNull?.messageFile.type?.value ?? MessageFileType.file.value;

      await processMultiFileHelper(requestData, fileType, sendFileToServerProcess);

      // Call uploadFilesConfirm to tell server that app finished upload (or fail) all files
      if (requestData.requestList.isNotEmpty) {
        final msgResp = await MessageService.instance.uploadFilesConfirm(
          UploadFilesConfirmRequest(
            roomId: requestData.roomId,
            ref: requestData.ref,
            fileType: fileType,
            fileUploadCount: requestData.requestList.length,
            message: messageDescription,
            isLocked: requestData.isLocked,
            lockMessageSalt: requestData.lockMessageSalt,
            lockMessageIv: requestData.lockMessageIv,
            bookmarkTagId: requestData.bookmarkTagId,
          ),
        );

        final tempMsg = msgResp.copyWith(
          isSending: false,
          isSendFailed: false,
        );

        await dbInstance.writeTxn(() async {
          final eventCb = await syncHandleUpdateMessageUseCase.call(
            SyncHandleUpdateMessageParams(receiveMessage: tempMsg),
          );
          for (final event in eventCb) {
            event.call();
          }
        });
      }

      // Send analytics event
      await _sendAnalyticsEvent(requestData);
    } catch (e, stackTrace) {
      _logger.e('Error in processMultiFileMessage', e, stackTrace);
      rethrow;
    } finally {
      await SendingMsgPerformanceServiceImpl.sendMessageProcessingTrace.stop();
    }
  }

  /// Sends analytics event for message processing
  Future<void> _sendAnalyticsEvent(SendMultiFileMessageRequest requestData) async {
    if (requestData.message.type == null) {
      _logger.e('Message type is null in processMultiFileMessage');
    }

    final RoomDb roomDb = GetIt.I<RoomDb>();
    final room = await roomDb.getRoom(requestData.roomId);

    String mediaType = EventProperty.getMessageTypeForEventParams(
      requestData.message.type ?? MessageType.file,
    );

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.messageReceived,
      eventProperties: EventProperty.messageReceived(
        EventProperty.getChatTypeForEventParams(room),
        mediaType,
      ),
    );
  }

  /// Generates file model for processing
  Future<MessageFileModel?> _generateFileModel(
    FileInfoModel fileInfo,
    String roomId,
    String refMsg,
    int index,
    String? refFile,
    String type,
  ) async {
    try {
      return await MessageFileModel.generateMessageFile(
        refFile: refFile ?? MessageService.instance.generateRefFile(roomId),
        refMsg: refMsg,
        index: index,
        fileInfo: fileInfo,
        compressImageQuality: 40,
        compressImageFormat: CompressFormat.webp,
        compressCallback: (int sent, int total, int fileIndex, String ref, String type) {
          // Compression callback - could be extracted to progress service
          _logger.d('Compression progress: $sent/$total for file $fileIndex');
        },
        type: type,
      );
    } catch (e, stackTrace) {
      _logger.e('Error generating file model', e, stackTrace);
      return null;
    }
  }
}
