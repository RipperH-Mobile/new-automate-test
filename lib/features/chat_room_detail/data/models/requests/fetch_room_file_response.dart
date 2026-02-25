import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';

class FetchRoomFileResponse {
  final List<MessageFileModel> files;
  final int page;
  final int totalPages;

  FetchRoomFileResponse({
    required this.files,
    required this.page,
    required this.totalPages,
  });
}
