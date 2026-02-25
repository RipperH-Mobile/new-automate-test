import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:get/get.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_file_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';

/// Service responsible for handling progress tracking and UI updates
/// Separates UI update logic from the main use case
class ProgressTrackingService {
  final LoggerService _logger;
  final MessageDb _messageLocalRepository;

  ProgressTrackingService(this._logger, this._messageLocalRepository);

  /// Handles video compression progress callbacks
  Future<void> onCompressingVideoFileCallback({
    required double progress,
    required MessageCollection message,
    required int fileIndex,
  }) async {
    try {
      if (message.files == null || message.files!.isEmpty) return;

      // Check if the file index is out of range
      if (fileIndex >= (message.files?.length ?? -1)) return;

      final fileRef = message.files?[fileIndex].refFile;
      if (fileRef == null) return;

      // Throttle event bus fires for smoother compression progress
      EasyThrottle.throttle(
        'video_compress_progress_$fileRef',
        const Duration(milliseconds: 50),
        () {
          eventBus.fire(
            VideoFileCompressingProgressEvent(
              fileRef: fileRef,
              compressProgress: progress,
            ),
          );
        },
      );

      // Update message file progress state if needed
      final currentProgressState = message.files?[fileIndex].progressState;
      if (currentProgressState != FileProgressState.compressing) {
        EasyDebounce.debounce(
          'video_compress_state_$fileRef',
          const Duration(milliseconds: 200),
          () async {
            try {
              message.files?[fileIndex].progressState = FileProgressState.compressing;
              await _messageLocalRepository.putMessage(message);
            } catch (e, stackTrace) {
              _logger.e('Error updating compression progress state', e, stackTrace);
            }
          },
        );
      }
    } catch (e, stackTrace) {
      _logger.e('onCompressingVideoFileCallback error', e, stackTrace);
      rethrow;
    }
  }

  /// Updates file type controller for file uploads
  void updateMessageTypeFileController(
    MessageCollection message, {
    int sent = 0,
    int total = 0,
    int fileIndex = 0,
  }) {
    final msgRef = message.ref;
    if (Get.isRegistered<MessageTypeFileV2Controller>(tag: '${MessageFileType.file.value}-$msgRef') == false) {
      return;
    }

    try {
      final ctl2 = Get.find<MessageTypeFileV2Controller>(tag: '${MessageFileType.file.value}-$msgRef');

      ctl2.uploadProgressSend.value = sent.toDouble();
      ctl2.uploadProgressTotal.value = total.toDouble();
    } catch (e, stackTrace) {
      _logger.e('onUpdateFile error.', e, stackTrace);
    }
  }

  /// Updates image type controller for image uploads
  void updateMessageTypeImagesController(
    double progress,
    int fileIndex,
    String ref,
    String type,
  ) {
    if (Get.isRegistered<MessageTypeImageV2Controller>(tag: '$type-$ref') == false) {
      return;
    }

    try {
      final ctl2 = Get.find<MessageTypeImageV2Controller>(tag: '$type-$ref');
      final file = ctl2.messageFiles.elementAtOrNull(fileIndex);

      final newFile = file?.copyWith(
        progressState: FileProgressState.uploading,
        downloadProgress: progress,
      );

      if (newFile == null && file == null) {
        _logger.e('File is null in onUpdateMessageTypeImagesCtlList for fileIndex: $fileIndex');
        return;
      }

      ctl2.messageFiles[fileIndex] = newFile ?? file!;
      ctl2.messageFiles.refresh();
    } catch (e, stackTrace) {
      _logger.e('onUpdateImages error.', e, stackTrace);
    }
  }

  /// Updates compression progress for images
  void updateCompressMessageTypeImageController(
    int sent,
    int total,
    int fileIndex,
    String ref,
    String type,
  ) {
    if (Get.isRegistered<MessageTypeImageV2Controller>(tag: '$type-$ref') != true) {
      return;
    }

    try {
      final ctl2 = Get.find<MessageTypeImageV2Controller>(tag: '$type-$ref');
      final file = ctl2.messageFiles.elementAtOrNull(fileIndex);

      final progress = sent.toDouble() / total.toDouble();

      if (progress >= (file?.compressProgress ?? 0)) {
        final newFile = file?.copyWith(
          progressState: FileProgressState.uploading,
          compressProgress: progress,
        );
        final selectedFile = newFile ?? file;
        if (selectedFile != null) {
          ctl2.messageFiles[fileIndex] = selectedFile;
          ctl2.messageFiles.refresh();
        }
      }
    } catch (e, stackTrace) {
      _logger.e('onUpdateImages error.', e, stackTrace);
    }
  }

  Future<void> onThumbnailProgressCallback({
    required int sent,
    required int total,
    required MessageCollection message,
    required int fileIndex,
  }) async {
    if (message.file?.type == MessageFileType.image) {
      updateMessageTypeImagesController(
        0.35 + (sent / total * 0.25),
        fileIndex,
        message.ref!,
        message.type!.value,
      );
    }
  }

  /// Handles general send progress callbacks
  Future<void> onSendProgressCallback({
    required int sent,
    required int total,
    required MessageCollection message,
    required int fileIndex,
  }) async {
    if (message.files?.isNotEmpty != true) {
      _logger.e('Message files are null or empty in onSendProgressCallback');
      return;
    }

    // Fire upload progress event for UI components that listen to it
    final fileRef = message.files?[fileIndex].refFile;
    if (fileRef != null) {
      eventBus.fire(
        FileUploadProgressEvent(
          fileRef: fileRef,
          uploadProgress: sent.toDouble(),
          totalProgress: total.toDouble(),
        ),
      );
    }

    if (message.file?.type == MessageFileType.image) {
      updateMessageTypeImagesController(
        sent / total,
        fileIndex,
        message.ref!,
        message.type!.value,
      );
    } else if (message.file?.type == MessageFileType.file) {
      updateMessageTypeFileController(
        message,
        sent: sent,
        total: total,
        fileIndex: fileIndex,
      );
    } else if (message.file?.type == MessageFileType.video) {
      // TODO: Implement video progress update if needed
    }
  }

  /// Cleans up progress timers to prevent memory leaks
  void cleanupProgressTimers(String fileRef) {
    EasyDebounce.cancel('file_progress_state_$fileRef');
    EasyDebounce.cancel('video_compress_state_$fileRef');
    EasyThrottle.cancel('file_upload_progress_$fileRef');
    EasyThrottle.cancel('video_compress_progress_$fileRef');
  }
}
