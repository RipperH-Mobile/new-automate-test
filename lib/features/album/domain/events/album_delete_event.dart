import 'package:uchat/features/album/domain/entities/album_entity.dart';

class AlbumDeleteEvent {
  AlbumEntity album;
  String roomId;

  AlbumDeleteEvent({required this.album, required this.roomId});
}
