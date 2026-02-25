import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/file_upload/file_upload_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/file_request_builder_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/message_collection_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/message_failure_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/multi_file_processing_service.dart';
import 'package:uchat/features/chat_room/domain/file_upload/services/progress_tracking_service.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_message_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';

/// Refactored Send file message use case with clean separation of concerns
/// Delegates complex operations to specialized services
class SendFileMessageToServerUseCase implements SimpleUseCase<MessageEntity?, SendFileMessageParams> {
  SendFileMessageToServerUseCase({
    required this.userLocalRepository,
    required this.messageLocalRepository,
    required this.roomSubscriptionDb,
    required this.logger,
  })  : _fileUploadService = FileUploadService(logger),
        _messageCollectionService = MessageCollectionService(logger),
        _progressTrackingService = ProgressTrackingService(logger, messageLocalRepository),
        _messageFailureService = MessageFailureService(logger, messageLocalRepository),
        _multiFileProcessingService = MultiFileProcessingService(logger),
        _fileRequestBuilderService = FileRequestBuilderService(
          logger,
          ProgressTrackingService(logger, messageLocalRepository),
          MessageFailureService(logger, messageLocalRepository),
        );

  final UserDb userLocalRepository;
  final MessageDb messageLocalRepository;
  final RoomSubscriptionDb roomSubscriptionDb;
  final LoggerService logger;

  // Specialized services
  final FileUploadService _fileUploadService;
  final MessageCollectionService _messageCollectionService;
  final ProgressTrackingService _progressTrackingService;
  final MessageFailureService _messageFailureService;
  final MultiFileProcessingService _multiFileProcessingService;
  final FileRequestBuilderService _fileRequestBuilderService;

  SyncHandleUpdateMessageUseCase get syncHandleUpdateMessageUseCase {
    return GetIt.I<SyncHandleUpdateMessageUseCase>();
  }

  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  @override
  Future<MessageEntity?> call(SendFileMessageParams params) async {
    try {
      // Validate input
      if (params.files.length > UChatConstant.maxFilePerMessage) {
        return null;
      }

      // Start performance tracking
      await SendingMsgPerformanceServiceImpl.createMessageCollectionTypeFileTrace.start();

      // Create message collection using dedicated service
      final message = await _messageCollectionService.createMessageCollection(
        fileInfoList: params.files,
        params: params,
      );

      // Add performance tracking
      SendingMsgPerformanceServiceImpl.createMessageCollectionTypeFileTrace.putTraceAttributes(
        messageRef: message.ref!,
        messageType: message.type?.value ?? MessageType.file.value,
        fileRef: message.files?.firstOrNull?.refFile,
      );
      await SendingMsgPerformanceServiceImpl.createMessageCollectionTypeFileTrace.stop();

      // Fire event to add message to state for UI
      eventBus.fire(AddMessageToStateEvent(message: message.toCollection()));

      // put message to local db
      messageLocalRepository.putMessage(message.toCollection());

      // Process messages in background
      processMessages(
        fileInfoList: params.files,
        params: params,
        msg: message,
      );

      return message;
    } catch (e, stackTrace) {
      logger.e('Error in SendFileMessageToServerUseCase', e, stackTrace);
    }
    return null;
  }

  /// Simplified file upload processing using the new architecture
  Future<(SendFileMessageRequest, MessageCollection?)> _sendFileToServerProcess(
    SendFileMessageRequest fileReq,
    String roomId,
    String lockMessageSalt,
    String lockMessageIv,
    bool enableUploadPro,
    bool isCompressionCanceled,
  ) async {
    if (isCompressionCanceled) {
      fileReq.onSendFail?.call();
      return (fileReq, null);
    }

    final File originalFile = fileReq.files.first;
    final messageFile = fileReq.messageFile;

    try {
      // Use the file upload service for processing and uploading
      final FileUploadResult result = await _fileUploadService.processAndUploadFile(
        fileReq: fileReq,
        enableUploadPro: enableUploadPro,
        onProgress: (progress) {
          // For all file types, use the combined progress (compression + upload)
          // The FileUploadService now handles combining compression (0-50%) and upload (50-100%)
          final sent = (progress * originalFile.lengthSync()).toInt();
          final total = originalFile.lengthSync();

          if (messageFile.type == MessageFileType.video) {
            // For videos, also trigger the video compression callback for UI compatibility
            fileReq.onCompressingVideoFile?.call(progress);
          }

          // Always call the progress callback for all file types
          fileReq.onSendProgress?.call(sent, total);
          debugPrint('Upload progress for: $progress');
        },
        onCancel: () {
          logger.d('File upload cancelled for: ${originalFile.path}');
        },
        additionalData: {
          'isLocked': fileReq.isLocked,
          'message': fileReq.message,
          'lockMessageSalt': lockMessageSalt,
          'lockMessageIv': lockMessageIv,
        },
      );

      if (!result.success) {
        logger.e('File upload failed: ${originalFile.path}', result.error);
        fileReq.onSendFail?.call();
        return (fileReq, null);
      }

      // Handle file encryption if needed
      if (fileReq.isLocked == true && result.processedFile != null) {
        final encryptedFile = await _handleFileEncryption(
          fileReq: fileReq,
          uploadFile: result.processedFile!,
          roomId: roomId,
          lockMessageSalt: lockMessageSalt,
          lockMessageIv: lockMessageIv,
        );
        fileReq = fileReq.copyWith(files: [encryptedFile]);
      }

      return (fileReq, result.result);
    } on CompressionCancelledException catch (e, stackTrace) {
      logger.d('Video compression cancelled: ${originalFile.path}', e, stackTrace);
      fileReq.onSendFail?.call();
      return (fileReq, null);
    } on ApiException catch (e, stackTrace) {
      _handleApiException(e, stackTrace, fileReq);
      rethrow;
    } on DioException catch (e, stackTrace) {
      _handleDioException(e, stackTrace, fileReq);
      rethrow;
    } catch (e, stackTrace) {
      _handleGenericException(e, stackTrace, fileReq);
      rethrow;
    } finally {
      if (fileReq.refFile != null) {
        _progressTrackingService.cleanupProgressTimers(fileReq.refFile!);
      }
      MessageQueueService.mediaInstance.sendingFileRequests.remove(fileReq.refFile);
    }
  }

  /// Handles file encryption
  Future<File> _handleFileEncryption({
    required SendFileMessageRequest fileReq,
    required File uploadFile,
    required String roomId,
    required String lockMessageSalt,
    required String lockMessageIv,
  }) async {
    if (fileReq.isLocked != true) {
      return uploadFile;
    }

    await SendingMsgPerformanceServiceImpl.encryptTrace.start();
    SendingMsgPerformanceServiceImpl.encryptTrace.putTraceAttributes(
      messageRef: fileReq.ref,
      fileRef: fileReq.refFile,
      messageType: fileReq.messageFile.type?.value ?? MessageFileType.file.value,
    );

    final roomSub = await roomSubscriptionDb.getRoomSubscriptionWithRoomId(roomId);
    if (roomSub?.password == null) {
      logger.e('No password found for room subscription: $roomId');
      return uploadFile;
    }

    final lockedKey = await EncryptHelper.instance.createCryptoKeyFromPbkdf2Key(
      password: roomSub!.password!,
      salt: lockMessageSalt,
    );

    final encryptedFile = await EncryptHelper.instance.encryptLockMessageFile(
      file: uploadFile,
      iv: lockMessageIv,
      cryptoKey: lockedKey,
    );

    if (encryptedFile == null) {
      logger.e('File encryption failed.');
      return uploadFile;
    }

    fileReq.files[0] = encryptedFile;
    await SendingMsgPerformanceServiceImpl.encryptTrace.stop();
    return encryptedFile;
  }

  /// Processes messages using specialized services
  Future<void> processMessages({
    required List<FileInfoModel> fileInfoList,
    required SendFileMessageParams params,
    required MessageEntity msg,
  }) async {
    try {
      await SendingMsgPerformanceServiceImpl.createSendMultiFileMessageRequestTrace.start();

      // Use file request builder service to create the request
      final sendMultiFileMessageRequest = _fileRequestBuilderService.createMultiFileRequest(
        message: msg,
        params: params,
        fileInfoList: fileInfoList,
      );

      SendingMsgPerformanceServiceImpl.createSendMultiFileMessageRequestTrace.putTraceAttributes(
        messageRef: sendMultiFileMessageRequest.message.ref!,
        messageType: sendMultiFileMessageRequest.message.type?.value ?? MessageType.file.value,
        fileRef: sendMultiFileMessageRequest.requestList.firstOrNull?.refFile,
      );
      await SendingMsgPerformanceServiceImpl.createSendMultiFileMessageRequestTrace.stop();

      // Add message to the queue to send to the server
      await MessageQueueService.mediaInstance.addMessageToQueue(
        messageRequest: sendMultiFileMessageRequest,
        onProcessing: (requestData) => _multiFileProcessingService.processMultiFileMessage(
          requestData,
          _sendFileToServerProcess,
        ),
      );
    } catch (e, stackTrace) {
      logger.e('Error in processMessages', e, stackTrace);

      final messageCol = msg.toCollection();
      final messageRefFiles = messageCol.files?.map((file) => file.refFile).toSet();

      if (messageRefFiles != null) {
        for (final refFile in messageRefFiles) {
          if (refFile == null) continue;
          await _messageFailureService.handleSendFailure(
            message: messageCol,
            fileRef: refFile,
            sendToRoomId: params.chatRoomId,
          );
        }
      }
    }
  }

  /// Exception handling methods
  void _handleApiException(ApiException e, StackTrace stackTrace, SendFileMessageRequest fileReq) {
    final errorType = ApiExceptionType.from(e.type);

    if (errorType == ApiExceptionType.messageRefDuplicateError) {
      // Handle duplicate error
    } else if (errorType == ApiExceptionType.permissionDenied) {
      fileReq.onPermissionDenied?.call();
    } else {
      logger.e('Cannot upload file', e, stackTrace);
      fileReq.onSendFail?.call();
    }

    if (fileReq.refFile != null) {
      _progressTrackingService.cleanupProgressTimers(fileReq.refFile!);
    }
  }

  void _handleDioException(DioException e, StackTrace stackTrace, SendFileMessageRequest fileReq) {
    logger.d('Cannot upload file', e, stackTrace);

    if (e.type != DioExceptionType.cancel) {
      fileReq.onSendFail?.call();
    }

    if (fileReq.refFile != null) {
      _progressTrackingService.cleanupProgressTimers(fileReq.refFile!);
    }
  }

  void _handleGenericException(dynamic e, StackTrace stackTrace, SendFileMessageRequest fileReq) {
    logger.e('Cannot upload file', e, stackTrace);
    fileReq.onSendFail?.call();

    if (fileReq.refFile != null) {
      _progressTrackingService.cleanupProgressTimers(fileReq.refFile!);
    }
  }
}
