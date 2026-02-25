import 'package:uchat/features/album/domain/entities/album_image_entity.dart';

class ShareAlbumImageEntity {
  String albumId;
  List<AlbumImageEntity> images;

  ShareAlbumImageEntity({
    required this.albumId,
    required this.images,
  });
}
