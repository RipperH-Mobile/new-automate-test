import 'package:uchat/features/album/domain/entities/album_entity.dart';

class ChatRoomDetailAlbumImageListArguments {
  String roomId;
  AlbumEntity album;

  ChatRoomDetailAlbumImageListArguments({
    required this.roomId,
    required this.album,
  });
}
