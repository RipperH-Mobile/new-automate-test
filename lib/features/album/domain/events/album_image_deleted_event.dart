import 'package:uchat/features/album/domain/entities/album_entity.dart';

class AlbumImageDeletedEvent {
  AlbumEntity album;
  String roomId;
  List<String> deletedImages;

  AlbumImageDeletedEvent({
    required this.album,
    required this.roomId,
    required this.deletedImages,
  });
}
