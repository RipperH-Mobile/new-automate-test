import 'dart:io';

import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

/// Concrete implementation of file type identifier
class FileTypeIdentifierImpl implements FileTypeIdentifier {
  @override
  MessageFileType identifyFileType(File file) {
    final extension = file.path.split('.').last.toLowerCase();

    // Image file types
    if (_imageExtensions.contains(extension)) {
      return MessageFileType.image;
    }

    // Video file types
    if (_videoExtensions.contains(extension)) {
      return MessageFileType.video;
    }

    // Default to file for all other types
    return MessageFileType.file;
  }

  @override
  Future<FileMetadata> getFileMetadata(File file) async {
    final fileName = file.path.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();
    final sizeInBytes = await file.length();

    // for non video files, we only return basic metadata
    if (!_videoExtensions.contains(extension)) {
      return FileMetadata(
        fileName: fileName,
        extension: extension,
        sizeInBytes: sizeInBytes,
      );
    }

    final videoData = await FileService.instance.getVideoInfo(file);

    return FileMetadata(
      fileName: videoData?.title ?? fileName,
      extension: extension,
      sizeInBytes: sizeInBytes,
      width: videoData?.width?.toDouble(),
      height: videoData?.height?.toDouble(),
      duration: videoData?.duration,
      mimeType: videoData?.mimetype,
    );
  }

  // Supported file extensions
  static const List<String> _imageExtensions = UChatConstant.supportImageExtensionList;

  static const List<String> _videoExtensions = UChatConstant.supportVideoExtensionList;
}
