import '../entities/chat_folder_entity.dart';
import '../enums/chat_folder_type.dart';

abstract class ChatFolderLocalRepository {
  Future<ChatFolderEntity?> getById({required String id});

  Future<List<ChatFolderEntity>> getAll({
    bool sortDesc = false,
    bool isHidden = false,
    List<ChatFolderType> types = const [],
  });

  Future<void> putAll({required List<ChatFolderEntity> chatFolders, bool useTxn = true});

  Future<void> put({required ChatFolderEntity chatFolder, bool useTxn = true});

  Future<ChatFolderEntity> putOrUpdate({required ChatFolderEntity chatFolder, bool useTxn = true});

  Future<void> delete({required String id, bool useTxn = true});

  Future<void> deleteAll({required List<String> ids, bool useTxn = true});

  Future<void> clearCollection({ bool useTxn = true });
}
