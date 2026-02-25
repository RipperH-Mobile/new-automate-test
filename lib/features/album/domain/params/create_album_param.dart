import 'package:flutter/foundation.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';

@immutable
class CreateAlbumParam {
  final String albumName;
  final String roomId;
  final List<String> selectedImagePathList;
  final List<MediaAsset> selectedMediaAssets;

  const CreateAlbumParam({
    required this.albumName,
    required this.roomId,
    required this.selectedImagePathList,
    this.selectedMediaAssets = const [],
  });
}
