import 'package:uchat/features/chat_folder/data/models/collections/chat_folder_collection.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_entity.dart';
import 'package:uchat/features/chat_folder/domain/enums/chat_folder_type.dart';

import '../../domain/repositories/chat_folder_local_repository.dart';
import '../data_sources/local/chat_folder_db.dart';

class ChatFolderLocalRepositoryImpl implements ChatFolderLocalRepository {
  final ChatFolderDb chatFolderDb;

  ChatFolderLocalRepositoryImpl({
    required this.chatFolderDb,
  });

  @override
  Future<void> clearCollection({bool useTxn = false}) async {
    await chatFolderDb.clearCollection();
  }

  @override
  Future<void> delete({required String id, bool useTxn = true}) async {
    if (useTxn) {
      await chatFolderDb.delete(id: id);
      return;
    }

    await chatFolderDb.deleteWithoutTxn(id: id);
  }

  @override
  Future<void> deleteAll({required List<String> ids, bool useTxn = true}) async {
    if (useTxn) {
      await chatFolderDb.deleteAll(ids: ids);
      return;
    }

    await chatFolderDb.deleteAllWithoutTxn(ids: ids);
  }

  @override
  Future<List<ChatFolderEntity>> getAll({
    bool sortDesc = false,
    bool isHidden = false,
    List<ChatFolderType> types = const [],
  }) async {
    final chatFolders = await chatFolderDb.getAll(
      sortDesc: sortDesc,
      isHidden: isHidden,
    );

    return chatFolders.map((item) => item.toEntity()).toList();
  }

  @override
  Future<ChatFolderEntity?> getById({required String id}) async {
    final chatFolder = await chatFolderDb.getById(id: id);

    return chatFolder?.toEntity();
  }

  @override
  Future<void> put({required ChatFolderEntity chatFolder, bool useTxn = true}) async {
    final chatFolderCollection = ChatFolderCollection.fromEntity(chatFolder);

    if (useTxn) {
      await chatFolderDb.put(chatFolder: chatFolderCollection);
      return;
    }

    await chatFolderDb.putWithoutTxn(chatFolder: chatFolderCollection);
  }

  @override
  Future<void> putAll({required List<ChatFolderEntity> chatFolders, bool useTxn = true}) async {
    final chatFolderCollections = chatFolders.map((item) => ChatFolderCollection.fromEntity(item)).toList();

    if (useTxn) {
      await chatFolderDb.putAll(chatFolders: chatFolderCollections);
      return;
    }

    await chatFolderDb.putAllWithoutTxn(chatFolders: chatFolderCollections);
  }

  @override
  Future<ChatFolderEntity> putOrUpdate({required ChatFolderEntity chatFolder, bool useTxn = true}) async {
    final existingChatFolder = await chatFolderDb.getById(id: chatFolder.id);

    if (existingChatFolder != null) {
      existingChatFolder.update(ChatFolderCollection.fromEntity(chatFolder));

      if (useTxn) {
        await chatFolderDb.put(chatFolder: existingChatFolder);
      } else {
        await chatFolderDb.putWithoutTxn(chatFolder: existingChatFolder);
      }

      return existingChatFolder.toEntity();
    } else {
      await put(chatFolder: chatFolder, useTxn: useTxn);
      return chatFolder;
    }
  }
}
