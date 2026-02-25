import 'package:flutter/foundation.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';

@immutable
class UploadImageToAlbumParam {
  final String albumId;
  final String roomId;

  /// images is optional.
  /// If images is null, Will open gallery bottom sheet to pick images.
  /// Otherwise will use this images data to upload to server.
  final List<String>? imagePathList;

  final List<MediaAsset> mediaAssets;

  const UploadImageToAlbumParam({
    required this.albumId,
    required this.roomId,
    this.imagePathList,
    this.mediaAssets = const [],
  });
}
