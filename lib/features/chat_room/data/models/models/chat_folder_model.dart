// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_meta_entity.dart';

part 'chat_folder_model.g.dart';

@embedded
class ChatFolderModel {
  final String? folderId;
  final bool isPinned;

  ChatFolderModel({
    this.folderId,
    this.isPinned = false,
  });

  ChatFolderModel copyWith({
    String? folderId,
    bool? isPinned,
  }) {
    return ChatFolderModel(
      folderId: folderId ?? this.folderId,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  factory ChatFolderModel.fromMap(Map<String, dynamic> map) {
    return ChatFolderModel(
      folderId: map['chatFolderId'] != null ? map['chatFolderId'] as String : null,
      isPinned: map['isPinned'] != null ? map['isPinned'] as bool : false,
    );
  }

  factory ChatFolderModel.fromChatFolderMetaEntity(ChatFolderMetaEntity chatFolderMetaEntity) {
    return ChatFolderModel(
      folderId: chatFolderMetaEntity.chatFolderId,
      isPinned: chatFolderMetaEntity.isPinned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatFolderId': folderId,
      'isPinned': isPinned,
    };
  }

  @override
  String toString() => 'ChatFolderModel(chatFolderId: $folderId, isPinned: $isPinned)';

  @override
  bool operator ==(covariant ChatFolderModel other) {
    if (identical(this, other)) return true;

    return other.folderId == folderId;
  }

  @override
  int get hashCode => folderId.hashCode ^ isPinned.hashCode;
}
