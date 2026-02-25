import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/chat_category_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

typedef IsarChatCategoryCollection = IsarCollection<ChatCategoryCollection>;

class ChatCategoryDb {
  final _log = useLogger();

  static final ChatCategoryDb instance = ChatCategoryDb._internal();

  factory ChatCategoryDb() => instance;

  ChatCategoryDb._internal();

  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarChatCategoryCollection get _chatCategoryCollection {
    return dbInstance.chatCategorys;
  }

  Future<List<ChatCategoryCollection>> getAll({
    bool sortDesc = false,
  }) async {
    try {
      return _chatCategoryCollection.where().sortById().findAll();
    } catch (e, stackTrace) {
      _log.w('Get all premium package error.', e, stackTrace);
      return [];
    }
  }

  Future<void> putAll(List<ChatCategoryCollection> chatCategorys) async {
    await dbInstance.writeTxn(() async {
      await _chatCategoryCollection.putAll(chatCategorys);
    });
  }

  Future<ChatCategoryCollection?> getById({required String id}) async {
    final chatCategory = await _chatCategoryCollection.where().idEqualTo(id).findFirst();

    return chatCategory;
  }

  Future<ChatCategoryCollection?> putOrUpdate(ChatCategoryCollection chatCategory) async {
    return await dbInstance.writeTxn(() async {
      final localChatCategory = await getById(id: chatCategory.id!);
      if (localChatCategory != null) {
        localChatCategory.update(chatCategory);
        await _chatCategoryCollection.put(localChatCategory);
        return localChatCategory;
      } else {
        await _chatCategoryCollection.put(chatCategory);
        return chatCategory;
      }
    });
  }

  Future<int> deleteAll(List<String?> ids) async {
    return await dbInstance.writeTxn(() async {
      return await _chatCategoryCollection.deleteAllById(ids);
    });
  }

  Future<void> clearCollection() async {
    await _chatCategoryCollection.clear();
  }
}
