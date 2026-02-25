import '../entities/chat_folder_entity.dart';

/// Event for updating chat folders, Could be type of event UPDATE, DELETE, REORDER
class ChatFolderUpdateEvent {
  final List<ChatFolderEntity> chatFolders;

  ChatFolderUpdateEvent({required this.chatFolders});

  @override
  String toString() {
    return 'ChatFolderUpdateEvent{chatFolders: $chatFolders}';
  }
}
