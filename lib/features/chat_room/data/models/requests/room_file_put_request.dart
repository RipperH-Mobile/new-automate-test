import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';

class PutAllRoomFilesRequest {
  final List<RoomFileEntity> files;
  final bool useTxn;

  const PutAllRoomFilesRequest({
    required this.files,
    this.useTxn = true,
  });
}
