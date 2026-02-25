import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_sent_message_media_files_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

class MessageTypeImageV2Controller extends MessageTypeController {
  MessageTypeImageV2Controller({required super.initMessage}) {
    messageFiles.value = initMessage.files ?? [];
    messageFiles.refresh();
  }

  /// The message files
  ///
  /// This value is used to determine the message files to display the image
  ///
  /// `Default value is empty list`
  final messageFiles = <MessageFileModel>[].obs;

  /// The should show network image
  ///
  /// This value is used to determine the network image should be shown or not
  /// - If the value is true, the network image will be shown
  /// - If the value is false, the network image will not be shown
  ///
  /// `Default value is false`
  final shouldShowNetworkImage = false.obs;

  /// The file exist map
  ///
  /// This value is used to determine the file exist map
  /// - The key is the reference file
  /// - The value is the file exist state
  final fileExistMap = HashMap<String, bool>().obs;

  @override
  onInit() {
    super.onInit();

    checkFileProgress();
    // checkFileIsExist();
  }

  /// The file length
  int get fileLength => messageFiles.length;

  /// Check file length is odd or not
  ///
  /// This function will return true if the file length is odd
  /// Otherwise, this function will return false
  bool get isOddFileLength => fileLength % 2 != 0;

  /// The maximum height for the image box
  double get maxHeight {
    if (fileLength > 1) {
      // This is the maximum height for multiple images
      // Change this value to adjust the maximum height for multiple images box
      return 840.spMin;
    }

    // This is the maximum height for single image
    // Change this value to adjust the maximum height for single image box
    return 400.spMin;
  }

  /// The maximum width for the image box
  double get maxWidth => 350.spMin;

  /// The minimum width for the image box
  double get minWidth => 50.spMin;

  /// The minimum height for the image box
  double get minHeight => 50.spMin;

  /// The number of row
  ///
  /// This function will return the number of row for the image box
  /// - If the file length == 0, return 0 to show no image
  /// - If the file length == 1, return 1 to show 1 image in maximum width
  /// - If the file length == 2, return 1 to show 2 images in a row
  /// - If the file length <= 4, return 2 to show 4 images in 2 rows
  /// - If the file length <= 6, return 3 to show 6 images in 3 rows
  /// - If the file length <= 8, return 4 to show 8 images in 4 rows
  /// - If the file length <= 10, return 5 to show 10 images in 5 rows
  /// - Otherwise, this function will return 0 to show no image
  ///
  /// Note:
  /// - The maximum number of images in a row is 2
  /// - The maximum number of images in a column is 5
  int get numberOfRow {
    if (fileLength == 0) {
      return 0;
    }

    if (fileLength <= 2) {
      return 1;
    }

    if (fileLength <= 4) {
      return 2;
    }

    if (fileLength <= 6) {
      return 3;
    }

    if (fileLength <= 8) {
      return 4;
    }

    if (fileLength <= 10) {
      return 5;
    }

    return 0;
  }

  BoxConstraints get boxConstraints => BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        minHeight: minHeight,
        minWidth: minWidth,
      );

  /// The number of column
  ///
  /// [rowIndex] is the row index to determine the number of column
  ///
  /// This function will return the number of column for the image box
  /// - If the [rowIndex] is the last row and the file length is odd, return 1
  /// - Otherwise, return 2
  int numberOfColumn(int rowIndex) {
    final isLastRow = rowIndex == numberOfRow - 1;

    if (isLastRow && isOddFileLength) {
      return 1;
    }

    return 2;
  }

  /// The aspect ratio
  ///
  /// [rowIndex] is the row index to determine the aspect ratio
  ///
  /// This function will return the aspect ratio for the image box
  /// - If the [rowIndex] is the last row and the file length is odd, return 297/148
  /// - Otherwise, return 1
  double aspectRatio(int rowIndex) {
    final isLastRow = rowIndex == numberOfRow - 1;

    if (isLastRow && isOddFileLength) {
      return 297.spMin / 148.spMin;
    }

    return 1;
  }

  /// Get the file index
  ///
  /// [rowIndex] is the row index
  /// [columnIndex] is the column index
  ///
  /// This function will return the file index by the row index and column index
  int getFile(int rowIndex, int columnIndex) {
    return rowIndex * 2 + columnIndex;
  }

  /// The message file tag
  ///
  /// [file] is the message file model
  ///
  /// This function will return the message file tag by the message file model
  String messageFileTag(MessageFileModel file) => '${super.initMessage.ref}-file-${file.refFile}';

  /// Compute the image dimension
  ///
  /// [originWidth] is the origin width of the image
  /// [originHeight] is the origin height of the image
  ///
  /// This function will compute the image dimension by the origin width and origin height
  (double, double) computeImageDimension({required double originWidth, required double originHeight}) {
    double imageWidth = originWidth;
    double imageHeight = originHeight;

    /// Handle Landscape Image
    if (imageHeight < imageWidth) {
      if (imageWidth > maxWidth) {
        imageWidth = maxWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      if (imageWidth < maxWidth) {
        imageWidth = maxWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      if (imageHeight < minHeight) {
        imageHeight = minHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      return (imageWidth, imageHeight);
    }

    /// Handle Portrait Image
    if (imageHeight > imageWidth) {
      if (imageHeight > maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageWidth < minWidth) {
        imageWidth = minWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      return (imageWidth, imageHeight);
    }

    /// Handle Square Image
    if (imageHeight == imageWidth && imageWidth != 0 && imageHeight != 0) {
      if (imageHeight > maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < minHeight) {
        imageHeight = minHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      return (imageWidth, imageHeight);
    }

    return (imageWidth, imageHeight);
  }

  /// On open media viewer
  ///
  /// [targetMessage] is the target message collection
  /// [index] is the index of the image
  ///
  /// This function will open the media viewer with the target message collection
  Future<void> onOpenMediaViewer({required MessageCollection targetMessage, int index = 0}) async {
    closeKeyboardWhenTapImageOrVideo();

    /// Get all sent message media files
    final messageEntityList = await GetIt.I<GetAllSentMessageMediaFilesUseCase>().call(
      GetAllSentMessageMediaFilesParams(roomId: targetMessage.roomId!),
    );

    await MediaViewerService.instance.openMediaViewer<MessageCollection>(
      initialMedia: targetMessage,
      medias: messageEntityList.toCollections(),
      imageIndexOfGroup: index,
      sorting: 1,
      openFrom: MediaViewerOpenFrom.chatRoom,
    );
  }

  /// Check the file progress
  ///
  /// This function will check the file progress on init
  /// - If the file progress is not uploaded, this function will add the file to the [uploadingFileMap]
  /// - If the file progress is uploaded, this function will set the [shouldShowNetworkImage] to true
  void checkFileProgress() {
    for (final file in messageFiles) {
      if (file.apiFileUrl != null && shouldShowNetworkImage.value == false) {
        shouldShowNetworkImage.value = true;
        // for (var file in messageFiles) {
        //   final refFile = file.refFile;
        //   if (refFile != null) {
        //     GetIt.I<ThumbnailBytesCacheManager>().remove(refFile);
        //   }
        // }
      }
    }
  }

  /// Check file is exist
  ///
  /// This function will check the file is exist on init
  /// - If the file is not exist, this function will set the [fileExistMap] to false
  /// - Otherwise, this function will set the [fileExistMap] to true
  Future<void> checkFileIsExist() async {
    // If the message is not send failed, return
    if (initMessage.isSendFailed == false) {
      return;
    }

    for (final file in messageFiles) {
      bool isExist = true;
      final fileAssetId = file.assetId;

      // First, check the file is exist in the asset entity (gallery)
      if (fileAssetId != null) {
        final asset = await AssetEntity.fromId(fileAssetId);

        if (asset != null) {
          isExist = await asset.exists;
          if (isExist == false) {
            fileExistMap.value[file.refFile!] = isExist;
            continue;
          }
        } else {
          fileExistMap.value[file.refFile!] = false;
          continue;
        }
      }

      // Second, check the file is exist in the file path
      final filePath = file.url;
      if (filePath != null) {
        isExist = await File(filePath).exists();

        if (isExist == false) {
          fileExistMap.value[file.refFile!] = isExist;
          continue;
        }
      }
    }

    fileExistMap.refresh();
  }

  /// Is file exist
  ///
  /// [refFile] is the reference file to check the file is exist
  bool isFileExist(String? refFile) {
    if (refFile == null) {
      return false;
    }

    final isExist = fileExistMap.value[refFile];
    if (isExist == null) {
      return true;
    }

    return isExist;
  }

  /// Cancel the upload video
  ///
  /// This method will cancel the upload video message by calling the [MessageQueueService.cancelSendFile] method
  ///
  /// This method will be called when the user tap the cancel button on the video message
  void onCancelUpload(String? cancelRefFile) {
    final refFile = messageFiles
        .firstWhereOrNull(
          (file) => file.refFile == cancelRefFile,
        )
        ?.refFile;
    if (refFile != null) {
      // Cancel the upload video
      MessageQueueService.mediaInstance.cancelSendFile(
        roomId: initMessage.roomId,
        refMessage: initMessage.ref,
        refFile: cancelRefFile,
        foreCancelUpload: true,
      );
    }
  }
}
