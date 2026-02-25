import 'dart:async';
import 'dart:io';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

/// Image file preview model
///
/// This model is used to preview the image file
///
/// The image file can be from the gallery or from the desktop picker file
///
/// If the image file is from the gallery, the asset ID will be used to get the image file from the gallery
///
/// If the image file is from the desktop picker file, the origin file will be used to compress the image file
class ImageFilePreviewModel {
  final _log = useLogger();

  /// Origin image file
  /// [Required]
  /// The origin image file, this file will be used to compress the image file
  ///
  /// The origin image file will be stored in this variable
  ///
  /// `For desktop`
  final File? originFile;

  /// Asset ID of the image file from gallery
  ///
  /// The asset ID of the image file from gallery will be stored in this variable
  /// Use for get the image file from gallery
  ///
  /// `For mobile`
  final String? assetId;

  /// Selected image file from the chat message
  final File? fileFromMessage;

  /// Asset entity of the image file from gallery
  ///
  /// The asset entity of the image file from gallery will be stored in this variable
  ///
  /// It will initialize the asset entity from the asset ID
  ///
  /// `For mobile`
  AssetEntity? asset;

  /// Should compress image file or not
  /// [Default is true]
  ///
  /// If the image file size is greater than [oversize](3 MB) value, it will compress the image file to reduce the file size
  /// If the image file size is less than [oversize](3 MB) value, it will not compress the image file
  final bool shouldCompress;

  /// Is image file compressed or not
  /// [Default is false]
  ///
  /// Check if the image file is compressed or not after compressing the image file
  bool compressed;

  /// Compressed image file
  /// [Default is null]
  ///
  /// The compressed image file will be stored in this variable after compressing the image file
  /// Initial value is the origin image file, after compressing the image file, the value will be changed to the compressed image file
  ///
  /// `For desktop`
  late File compressedFile;

  /// Callback function after compressing the image file is completed
  /// [Default is null]
  ///
  /// This callback function will be called after compressing the image file is completed
  final Function()? onCompressComplete;

  int originWidth = 0;
  int originHeight = 0;

  double originalFileSize = 0;
  double compressedFileSize = 0;

  bool isFailed = false;

  ImageFilePreviewModel({
    this.assetId,
    this.originFile,
    this.fileFromMessage,
    this.compressed = false,
    this.shouldCompress = true,
    this.onCompressComplete,
  }) {
    if (GetPlatform.isMobile) {
      assert(assetId != null || fileFromMessage != null, 'Asset ID Or fileFromMessage is required');

      if (assetId != null) {
        _fetchAssetEntity();
      }
    }

    if (GetPlatform.isDesktop) {
      assert(originFile != null, 'Origin file is required');

      /// Set the origin image file to the compressed image file
      compressedFile = originFile!;

      // Get the origin image file size
      final fileSize = FileService.instance.fileSize(originFile!);
      originalFileSize = fileSize;

      /// Compress the image if shouldCompress is true and the image file is not compressed yet
      if (shouldCompress && !compressed && originFile != null) {
        _compressFile();
      }
    }
  }

  /// Get oversize value for image file in MB
  int get _oversize => 3;

  /// Compress the image file to reduce the file size
  /// [Private function]
  /// [Return Future<File>]
  ///
  /// This function will compress the image file to reduce the file size
  /// The compressed image file will be stored in the compressedFile variable
  ///
  /// If the image file size is greater than the oversize value (3 MB), it will compress the image file
  Future<File?> _compressFile() async {
    final Completer<File?> completer = Completer<File?>();

    () async {
      try {
        if (originalFileSize > _oversize) {
          final file = await FileService.instance.compressImageToFile(file: originFile!);

          if (file != null) {
            compressedFile = file;
            compressedFileSize = FileService.instance.fileSize(file);
          } else {
            isFailed = true;
          }
        }

        compressed = true;
      } catch (e) {
        isFailed = true;
      } finally {
        completer.complete(compressedFile);
        onCompressComplete?.call();
      }
    }();

    return completer.future;
  }

  Future<AssetEntity?> _fetchAssetEntity() async {
    final Completer<AssetEntity?> completer = Completer<AssetEntity?>();

    () async {
      try {
        if (assetId != null) {
          asset = await AssetEntity.fromId(assetId!);

          if (asset != null) {
            originWidth = asset!.width;
            originHeight = asset!.height;
          }
        }
      } catch (e) {
        isFailed = true;
      } finally {
        completer.complete(asset);
        onCompressComplete?.call();
      }
    }();

    return completer.future;
  }

  Future<void> deleteCompressedFile() async {
    try {
      if (compressedFile.existsSync()) {
        await compressedFile.delete();
      }
    } on PathNotFoundException catch (e, stacktrace) {
      _log.d('There is no file to delete', e, stacktrace);
    } catch (e, stacktrace) {
      _log.e('Error on deleteCompressedFile', e, stacktrace);
    }
  }
}
