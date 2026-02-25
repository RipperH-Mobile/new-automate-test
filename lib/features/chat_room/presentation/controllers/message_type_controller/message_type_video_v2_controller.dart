import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/entities/chat_file_uploading_model.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_sent_message_media_files_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/chat_room/presentation/controllers/thumbnail_bytes_cache_manager.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class MessageTypeVideoV2Controller extends MessageTypeController {
  MessageTypeVideoV2Controller({required super.initMessage});

  /// Get the message file
  MessageFileModel? get messageFile => initMessage.file;

  /// The default width for thumbnail image if the message file does not have thumbnail width or have 0 value
  double get thumbnailDefaultWidth => 720;

  /// The default height for thumbnail image if the message file does not have thumbnail height or have 0 value
  double get thumbnailDefaultHeight => 1280;

  /// Get the width of the thumbnail image
  ///
  /// If the message file does not have thumbnail width or have 0 value, return [thumbnailDefaultWidth]
  double get imageWidth {
    if (messageFile?.thumbnailWidth == null || messageFile?.thumbnailWidth == 0) {
      return thumbnailDefaultWidth;
    }

    return messageFile?.thumbnailWidth ?? thumbnailDefaultWidth;
  }

  /// Get the height of the thumbnail image
  ///
  /// If the message file does not have thumbnail height or have 0 value, return [thumbnailDefaultHeight]
  double get imageHeight {
    if (messageFile?.thumbnailHeight == null || messageFile?.thumbnailHeight == 0) {
      return thumbnailDefaultHeight;
    }

    return messageFile?.thumbnailHeight ?? thumbnailDefaultHeight;
  }

  String get messageFileTag => '${messageFile?.type?.value}-${messageFile?.refFile ?? ''}';

  /// Get the sending state of the message
  ///
  /// Return true if the message is sending, otherwise return false
  bool get isSending => initMessage.isSending ?? false;

  /// Get the sent failed state of the message
  ///
  /// Return true if the message is sent failed, otherwise return false
  bool get isSentFailed => initMessage.isSendFailed ?? false;

  /// Should show network thumbnail
  ///
  /// Return true if the message file has network thumbnail, otherwise return false
  final shouldShowNetworkThumbnail = false.obs;

  /// Map of uploading file
  final uploadingFileMap = <String, ChatFileUploadingModel>{}.obs;

  /// The thumbnail bytes
  ///
  /// This value will initialize with the thumbnail bytes from the message file on the first time
  /// If the message file does not have thumbnail bytes, it will generate the thumbnail bytes from the original file
  ///
  /// This used to display the thumbnail image of the video if the file is not uploaded yet
  ///
  /// `Default value is null`
  final thumbnailBytes = Rxn<Uint8List>();

  /// The thumbnail width
  final thumbnailWidth = 0.0.obs;

  /// The thumbnail height
  final thumbnailHeight = 0.0.obs;

  /// Is file exist
  ///
  /// Return true if the file is exist, otherwise return false
  final isFileExist = true.obs;

  @override
  onInit() {
    super.onInit();

    checkFileProgress();
  }

  /// Check the file progress
  ///
  /// This method will check the file progress of the message file
  /// - If the message file is not uploaded yet, it will add the file to the [uploadingFileMap]
  /// - If the message file has thumbnail file id, it will set the [shouldShowNetworkThumbnail] to true
  /// - Otherwise, it will initialize the thumbnail bytes
  ///
  /// This method will be called on the first time the controller is initialized
  void checkFileProgress() {
    final file = initMessage.file;
    if (file != null) {
      if (file.progressState != FileProgressState.uploaded) {
        final refFile = file.refFile;
        if (refFile != null) {
          uploadingFileMap[refFile] = ChatFileUploadingModel.fromMessageFileModel(
            file,
            onProgressChange: () {
              uploadingFileMap.refresh();
            },
          );
        }
      }

      if (file.thumbnailFileId != null) {
        shouldShowNetworkThumbnail.value = true;
        final refFile = file.refFile;
        if (refFile != null) {
          GetIt.I<ThumbnailBytesCacheManager>().remove(refFile);
        }
      } else {
        shouldShowNetworkThumbnail.value = false;
        initialThumbnail();
      }
    }
  }

  /// Initialize the thumbnail bytes
  ///
  /// This method will initialize the thumbnail bytes from the message file
  /// If the message file does not have thumbnail bytes, it will generate the thumbnail bytes from the original file
  Future<void> initialThumbnail() async {
    // Set initial local thumbnail
    thumbnailWidth.value = messageFile?.thumbnailWidth?.toDouble() ?? thumbnailDefaultWidth;
    thumbnailHeight.value = messageFile?.thumbnailHeight?.toDouble() ?? thumbnailDefaultHeight;
    thumbnailBytes.value = messageFile?.thumbnailBytes;

    final originalFilePath = messageFile?.originalFilePath;
    if (thumbnailBytes.value == null && originalFilePath != null && originalFilePath.isNotEmpty) {
      thumbnailBytes.value = await FileService.instance.generateThumbnailVideo(originalFilePath);
    }

    await checkFileIsExist();
  }

  /// Check the file is exist
  ///
  /// This method will check the file is exist or not
  /// - If the message file is not sent failed, return
  /// - If the thumbnail bytes is not null, return
  /// - If the message file has asset id, check the asset is exist or not
  /// - If the message file has url, check the file is exist or not
  Future<void> checkFileIsExist() async {
    if (initMessage.isSendFailed == false) {
      return;
    }

    if (thumbnailBytes.value != null) {
      return;
    }

    if (messageFile?.assetId != null) {
      final asset = await AssetEntity.fromId(messageFile!.assetId!);
      if (asset != null) {
        final isExist = await asset.exists;
        if (isExist == false) {
          isFileExist.value = isExist;
          return;
        }
      } else {
        isFileExist.value = false;
        return;
      }
    }

    final filePath = messageFile?.url;
    if (filePath != null) {
      final isExist = await File(filePath).exists();

      if (isExist == false) {
        isFileExist.value = isExist;
        return;
      }
    }
  }

  Future<void> onOpenMediaViewer(BuildContext context) async {
    closeKeyboardWhenTapImageOrVideo();

    if (!isVideoTypeSupported(initMessage.file?.mime ?? '')) {
      UChatNewDialog.showSingleButtonDialog(
        context: context,
        title: 'Unable to open video'.tr,
        description:
            'This file type is not supported. Check the supported formats or try opening it with another app.'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: context.theme.appColors.textPrimary,
      );
      return;
    }
    // Get all sent message media files
    final messageEntityList = await GetIt.I<GetAllSentMessageMediaFilesUseCase>().call(
      GetAllSentMessageMediaFilesParams(roomId: initMessage.roomId!),
    );

    await MediaViewerService.instance.openMediaViewer<MessageCollection>(
      initialMedia: initMessage,
      medias: messageEntityList.toCollections(),
      sorting: 1,
      openFrom: MediaViewerOpenFrom.chatRoom,
    );
  }

  /// Get the upload progress of the message file
  ///
  /// Return the upload progress of the message file
  ///
  /// - If the message file is not in the [uploadingFileMap], return -1
  /// - If the message file is compressing, return the compress progress divided by 2
  /// - If the message file is uploading, return the upload progress
  ///
  /// Otherwise, return the sum of compress progress and upload progress divided by 2
  double getUploadProgress() {
    if (messageFile == null) {
      return -1;
    }

    final refFile = messageFile!.refFile;
    if (refFile == null) {
      return -1;
    }

    final fileUploadInfo = uploadingFileMap[messageFile!.refFile];

    if (fileUploadInfo == null) {
      return -1;
    }

    /// If file is not compressing or uploading, return -1
    if (![
      FileProgressState.compressing,
      FileProgressState.compressed,
      FileProgressState.uploading,
    ].contains(fileUploadInfo.fileProgressState)) {
      return -1;
    }

    /// If file is compressing return compress progress
    if (fileUploadInfo.fileProgressState == FileProgressState.compressing) {
      return fileUploadInfo.compressProgress / 2;
    }

    /// If file is uploading return upload progress
    if (fileUploadInfo.fileProgressState == FileProgressState.uploading) {
      return (fileUploadInfo.loadProgressPercent);
    }

    return (fileUploadInfo.compressProgress + fileUploadInfo.loadProgressPercent) / 2;
  }

  /// Cancel the upload video
  ///
  /// This method will cancel the upload video message by calling the [MessageQueueService.cancelSendFile] method
  ///
  /// This method will be called when the user tap the cancel button on the video message
  void cancelUploadVideo() {
    final refFile = messageFile?.refFile;
    if (refFile != null) {
      // dispose the file uploading model
      uploadingFileMap[refFile]?.dispose();
      // remove the file from the uploading file map
      uploadingFileMap.remove(refFile);

      // Cancel the upload video
      MessageQueueService.mediaInstance.cancelSendFile(
        roomId: initMessage.roomId,
        refMessage: initMessage.ref,
        refFile: messageFile?.refFile,
        foreCancelUpload: true,
      );
    }
  }
}
