import 'package:uchat/features/album/domain/entities/album_entity.dart';

class AlbumCreateEvent {
  AlbumEntity album;
  String roomId;

  AlbumCreateEvent({required this.album, required this.roomId});
}
