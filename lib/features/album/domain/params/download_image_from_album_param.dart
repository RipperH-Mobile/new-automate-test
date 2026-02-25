import 'package:uchat/features/album/domain/entities/album_image_entity.dart';

class DownloadImageFromAlbumParam {
  String albumId;
  String roomId;
  List<AlbumImageEntity> images;

  DownloadImageFromAlbumParam({
    required this.albumId,
    required this.roomId,
    required this.images,
  });
}
