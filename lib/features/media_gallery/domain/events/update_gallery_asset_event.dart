import 'package:flutter/foundation.dart';

@immutable
class UpdateGalleryAssetEvent {
  final String albumId;
  final bool refresh;

  const UpdateGalleryAssetEvent({
    required this.albumId,
    this.refresh = false,
  });
}
