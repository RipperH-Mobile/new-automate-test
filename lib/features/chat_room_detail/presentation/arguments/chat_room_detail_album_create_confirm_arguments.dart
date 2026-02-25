import 'package:flutter/foundation.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';

@immutable
class ChatRoomDetailAlbumCreateConfirmArguments {
  final String roomId;
  final List<String> imagePathList;
  final bool enableAddImageButton;

  /// For add image to album, This will be put in the album name text field.
  /// For create album case, This must be null.
  final String? existingAlbumName;

  /// For add image to album, This will be the album id to add image to.
  final String? addToAlbumId;

  final List<MediaAsset> selectedMediaResult;

  const ChatRoomDetailAlbumCreateConfirmArguments({
    required this.roomId,
    required this.imagePathList,
    this.enableAddImageButton = false,
    this.existingAlbumName,
    this.addToAlbumId,
    this.selectedMediaResult = const [],
  });
}
