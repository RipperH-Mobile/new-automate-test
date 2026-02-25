import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/params/remove_failed_message_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_failed_message_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

/// Service responsible for handling message failure scenarios
/// Separates error handling and failure management from the main use case
class MessageFailureService {
  final LoggerService _logger;
  final MessageDb _messageLocalRepository;

  MessageFailureService(this._logger, this._messageLocalRepository);

  /// Handles failed message scenarios
  Future<void> handleSendFailure({
    required MessageCollection message,
    required String fileRef,
    required String sendToRoomId,
  }) async {
    try {
      // Cancel video compression if the message contains video file
      if (message.file?.type == MessageFileType.video) {
        FileService.instance.cancelVideoCompression();
      }

      if (sendToRoomId != message.roomId) {
        return;
      }

      // Update state in RoomsController to show failed message
      eventBus.fire(ToggleFailedMessageEvent(roomId: sendToRoomId, show: true));

      final messageFiles = message.files;
      if (messageFiles == null || messageFiles.isEmpty) {
        return;
      }

      if (messageFiles.length == 1) {
        await _handleSingleFileFailure(message, fileRef, messageFiles);
      } else {
        await _handleMultiFileFailure(message, fileRef, messageFiles);
      }
    } catch (e, stackTrace) {
      _logger.e('handleSendFailure error', e, stackTrace);
    }
  }

  /// Handles single file failure scenarios
  Future<void> _handleSingleFileFailure(
    MessageCollection message,
    String fileRef,
    List<dynamic> messageFiles,
  ) async {
    message.isSending = false;
    message.isSendFailed = true;

    final targetMessageFile = messageFiles.firstWhereOrNull(
      (file) => file.refFile == fileRef,
    );

    if (targetMessageFile == null) {
      _logger.e('Message file is null in handleSendFailure for single file message');
      return;
    }

    if (targetMessageFile.refFile == null) {
      _logger.e('Message file refFile is null in handleSendFailure for single file message');
      return;
    }

    message.files?[0] = targetMessageFile.copyWith(
      progressState: FileProgressState.uploadFailed,
      isSendFailed: true,
    );

    await _messageLocalRepository.putMessage(message);
    eventBus.fire(AddFailedMessageToStateEvent(message: message));
    eventBus.fire(FileStateChangeEvent(
      fileRef: targetMessageFile.refFile!,
      state: FileProgressState.uploadFailed,
    ));
  }

  /// Handles multi-file failure scenarios
  Future<void> _handleMultiFileFailure(
    MessageCollection message,
    String fileRef,
    List<dynamic> messageFiles,
  ) async {
    final removeAtIndex = messageFiles.indexWhere((file) => file.refFile == fileRef);
    if (removeAtIndex == -1) {
      return;
    }

    final failedFile = messageFiles.removeAt(removeAtIndex);
    failedFile.progressState = FileProgressState.uploadFailed;
    failedFile.isSendFailed = true;

    if (failedFile.refFile == null) {
      _logger.e('Failed file refFile is null in handleSendFailure for multi-file message');
    }

    // Create new message with failed file for resend
    String newFailedMessageRef = MessageService.instance.generateMsgUid();
    MessageCollection newFailedMessage = MessageCollection()
      ..id = newFailedMessageRef
      ..ref = newFailedMessageRef
      ..roomId = message.roomId
      ..isSending = false
      ..isSendFailed = true
      ..account = message.account
      ..accountId = message.accountId
      ..type = message.type
      ..files = [failedFile]
      ..createdAt = DateTime.now()
      ..message = message.message;

    // Update original message and add failed message
    await _messageLocalRepository.putMessage(message);
    await _messageLocalRepository.putMessage(newFailedMessage);

    eventBus.fire(AddFailedMessageToStateEvent(message: newFailedMessage));
    eventBus.fire(FileStateChangeEvent(
      fileRef: failedFile.refFile!,
      state: FileProgressState.uploadFailed,
    ));
  }

  /// Handles permission denied scenarios
  Future<void> handlePermissionDenied({
    required MessageCollection message,
    required String roomId,
  }) async {
    final sentMessage = message;

    if (Get.isRegistered<MessageListController>(tag: 'chat-room-$roomId')) {
      await Get.find<MessageListController>(tag: 'chat-room-$roomId').onRemoveFailedMessage(sentMessage);
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
    } else {
      await GetIt.I<RemoveFailedMessageUseCase>().call(RemoveFailedMessageParams(message: sentMessage));
    }
  }
}
