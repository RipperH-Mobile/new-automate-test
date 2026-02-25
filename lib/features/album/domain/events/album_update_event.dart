import 'package:uchat/features/album/domain/entities/album_entity.dart';

class AlbumUpdateEvent {
  AlbumEntity album;
  String roomId;

  AlbumUpdateEvent({required this.album, required this.roomId});
}
