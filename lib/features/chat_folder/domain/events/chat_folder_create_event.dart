import '../entities/chat_folder_entity.dart';

class ChatFolderCreateEvent {
  final ChatFolderEntity chatFolder;

  ChatFolderCreateEvent({required this.chatFolder});
}
