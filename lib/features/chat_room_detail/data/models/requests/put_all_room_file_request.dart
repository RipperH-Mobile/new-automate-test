import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';

class PutAllRoomFileRequest {
  final List<RoomFileCollection> roomFiles;

  PutAllRoomFileRequest({
    required this.roomFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomFiles': roomFiles,
    };
  }
}
