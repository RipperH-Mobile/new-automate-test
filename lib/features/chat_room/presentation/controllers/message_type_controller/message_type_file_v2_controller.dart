import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/services/file_downloader_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/entities/chat_file_uploading_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

// ignore: unused_element
final _log = useLogger();

class MessageTypeFileV2Controller extends MessageTypeController {
  MessageTypeFileV2Controller({
    required super.initMessage,
  }) {
    message.value = super.initMessage;
  }

  final message = Rx<MessageCollection?>(null);
  final thumbnailFileId = ''.obs;
  final isLockedFile = false.obs;

  final uploadingFileMap = <String, ChatFileUploadingModel>{}.obs;
  final uploadProgressSend = 0.0.obs;
  final uploadProgressTotal = 0.0.obs;
  final downloadProgress = 0.0.obs;

  GlobalKey globalKey = GlobalKey();
  StreamSubscription? _messageUpdateSubscription;

  @override
  onInit() {
    if (message.value?.files?.isNotEmpty == true) {
      message.value?.files?.forEach((file) {
        bool showAsTypeFile = false;
        final mime = file.mime;

        if (mime != null) {
          showAsTypeFile = !isVideoTypeSupported(mime);
        }

        if (file.refFile == null) {
          _log.w('refFile is null');
          return;
        }

        if ((file.type == MessageFileType.file || showAsTypeFile) && file.progressState != FileProgressState.uploaded) {
          uploadingFileMap[file.refFile!] = ChatFileUploadingModel.fromMessageFileModel(
            file,
            onProgressChange: () => uploadingFileMap.refresh(),
          );
        }
      });
    }

    _messageUpdateSubscription = eventBus.on<MessageUpdateEvent>().listen(
      (event) async {
        final isSameMessage = message.value?.id == event.message.id || message.value?.ref == event.message.ref;
        if (message.value?.roomId == event.message.roomId && isSameMessage) {
          // update thumbnail when this message.value? is updated
          isLockedFile(event.message.file?.isPasswordProtected ?? false);

          if (!isLockedFile() && thumbnailFileId().isEmpty) {
            final fileId = (event.message.file?.thumbnailFileId ?? '');
            if (fileId.isEmpty) return;

            thumbnailFileId(fileId);
          }
        }
      },
    );

    thumbnailFileId(message.value?.file?.thumbnailFileId ?? '');
    isLockedFile(message.value?.file?.isPasswordProtected ?? false);

    super.onInit();
  }

  @override
  onClose() async {
    _messageUpdateSubscription?.cancel();

    super.onClose();
  }

  MessageListController get messageListCtl =>
      Get.find<MessageListController>(tag: 'chat-room-${message.value?.roomId}');

  Future<void> handleOpenFile() async {
    final file = message.value?.file;
    final isDownloading = downloadProgress.value > 0 && downloadProgress.value < 1;
    final isNotSendYet = message.value?.isSent == false;
    
    if (file == null) return;
    if (isDownloading) return;
    if (isNotSendYet) return;

    try {
      await messageListCtl.handleTapFile(file);
    } catch (e) {
      _log.e('Error open file', e);
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to open File'.tr,
        description:
            'This file type is not supported. Check the supported format or try opening it with another app'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
      );
    } finally {
      downloadProgress(1.0);
    }
  }

  String getFileName() {
    final name = message.value?.file?.name ?? '';

    if (name.isEmpty) return 'UNKNOWN'.tr;
    return p.basename(name);
  }

  String getFileExtension(String name) {
    if (name.isEmpty) return 'UNKNOWN';

    final lastDotIndex = name.lastIndexOf('.');
    if (lastDotIndex == -1 || lastDotIndex == name.length - 1) {
      return 'UNKNOWN';
    }

    return name.substring(lastDotIndex + 1);
  }

  String getFileSizeDescription(int fileSize) {
    if (fileSize == 0) return '0 KB'.tr;

    return FileService.instance.fileSizeStr(fileSize, 0);
  }

  String getFileExtensionFileSizeDescription(MessageFileModel? file) {
    final fileExtension = getFileExtension(file?.name ?? '').toUpperCase();
    final fileSize = getFileSizeDescription(file?.size ?? 0);

    return '@type File • $fileSize'.trParams({'type': fileExtension});
  }

  /// Cancel the upload file message
  ///
  /// This method will cancel the upload video message by calling the [MessageQueueService.cancelSendFile] method
  ///
  /// This method will be called when the user tap the cancel button on the video message
  void cancelUpload() {
    final refFile = initMessage.file?.refFile;
    if (refFile != null) {
      // dispose the file uploading model
      uploadingFileMap[refFile]?.dispose();
      // remove the file from the uploading file map
      uploadingFileMap.remove(refFile);

      // Cancel the upload video
      MessageQueueService.mediaInstance.cancelSendFile(
        roomId: initMessage.roomId,
        refMessage: initMessage.ref,
        refFile: initMessage.file?.refFile,
        foreCancelUpload: true,
      );
    }
  }

  /// Cancel the download file
  ///
  /// This method will cancel the download by calling [FileDownloaderService.cancelTask]
  ///
  /// This method will be called when the user tap the cancel button during download
  void cancelDownload() {
    final fileId = message.value?.file?.id;
    if (fileId != null && fileId.isNotEmpty) {
      FileDownloaderService.instance.cancelTask(fileId);
      downloadProgress(0.0);
    }
  }
}
