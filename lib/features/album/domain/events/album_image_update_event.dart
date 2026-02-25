import 'package:uchat/features/album/domain/entities/album_entity.dart';

class AlbumImageUpdateEvent {
  AlbumEntity album;
  String roomId;

  AlbumImageUpdateEvent({required this.album, required this.roomId});
}
