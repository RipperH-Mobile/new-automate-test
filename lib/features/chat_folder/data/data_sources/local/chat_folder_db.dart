import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/manager.dart';

import '../../models/collections/chat_folder_collection.dart';

typedef IsarChatFolderCollection = IsarCollection<ChatFolderCollection>;

class ChatFolderDb {
  final _log = useLogger();
  Isar? customDbInstance;

  ChatFolderDb({this.customDbInstance});

  Isar? get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance;
  }

  IsarChatFolderCollection? get _chatFolderCollection {
    return dbInstance?.chatFolders;
  }

  /// Get ChatFolderCollection by id
  ///
  /// If not found return null
  ///
  /// [id] is required, this is the id of ChatFolderCollection
  Future<ChatFolderCollection?> getById({required String id}) async {
    return await _chatFolderCollection?.where().idEqualTo(id).findFirst();
  }

  /// Get all ChatFolderCollection
  ///
  /// If not found return empty list
  ///
  /// [includeChatRoom] is optional, if true then it will find all RoomSubscriptionCollection by chatFolderId and put it into chatRooms
  /// Default is true
  ///
  /// [sortDesc] is optional, if true then it will sort by seq desc. Default is false (sort by seq asc)
  ///
  /// [isHidden] is optional, if true then it will find all hidden chat folder. Default is false
  Future<List<ChatFolderCollection>> getAll({
    bool sortDesc = false,
    bool isHidden = false,
  }) async {
    try {
      List<ChatFolderCollection> chatFolders = [];

      final queryBuilder = _chatFolderCollection?.filter().isHiddenEqualTo(isHidden);
      if (queryBuilder == null) {
        return [];
      }

      if (sortDesc) {
        chatFolders = await queryBuilder.sortBySeqDesc().findAll();
      } else {
        chatFolders = await queryBuilder.sortBySeq().findAll();
      }

      return chatFolders;
    } catch (e, stackTrace) {
      _log.d('Get all chat folder error.', e, stackTrace);
      return [];
    }
  }

  /// Put all ChatFolderCollection at once
  ///
  /// [chatFolders] is required, this is the list of ChatFolderCollection that you want to put
  Future<void> putAll({required List<ChatFolderCollection> chatFolders}) async {
    await dbInstance?.writeTxn(() async {
      await _chatFolderCollection?.putAll(chatFolders);
    });
  }

  /// Put all ChatFolderCollection at once without transaction
  ///
  /// [chatFolders] is required, this is the list of ChatFolderCollection that you want to put
  Future<void> putAllWithoutTxn({required List<ChatFolderCollection> chatFolders}) async {
    await _chatFolderCollection?.putAll(chatFolders);
  }

  /// For updating all variable in ChatFolderCollection or creating new one
  ///
  /// If you want to update only `few variable` in ChatFolderCollection then use `putOrUpdate` method
  ///
  /// [chatFolder] is required, this is the ChatFolderCollection that you want to put
  Future<void> put({required ChatFolderCollection chatFolder}) async {
    await dbInstance?.writeTxn(() async {
      await _chatFolderCollection?.put(chatFolder);
    });
  }

  /// For updating a ChatFolderCollection or creating new one if not exist
  ///
  /// [chatFolder] is required, this is the ChatFolderCollection that you want to put
  Future<ChatFolderCollection?> putWithoutTxn({required ChatFolderCollection chatFolder}) async {
    await _chatFolderCollection?.put(chatFolder);
    return chatFolder;
  }

  /// For deleting a ChatFolderCollection with id and transaction
  ///
  /// [id] is required, this is the id of ChatFolderCollection that you want to delete
  ///
  /// If success return true, if not return false
  Future<bool> delete({required String id}) async {
    return await dbInstance?.writeTxn(() async {
      return await _chatFolderCollection?.deleteById(id) ?? false;
    }) ??
        false;
  }

  /// For deleting a ChatFolderCollection with id without transaction
  ///
  /// [id] is required, this is the id of ChatFolderCollection that you want to delete
  ///
  /// If success return true, if not return false
  Future<bool> deleteWithoutTxn({required String id}) async {
    return await _chatFolderCollection?.deleteById(id) ?? false;
  }

  /// For deleting all ChatFolderCollection with ids and transaction at once
  ///
  /// [ids] is required, this is the list of id of ChatFolderCollection that you want to delete
  ///
  /// If success return number of deleted ChatFolderCollection
  Future<int> deleteAll({required List<String> ids}) async {
    return await dbInstance?.writeTxn(() async {
      return await _chatFolderCollection?.deleteAllById(ids) ?? 0;
    }) ??
        0;
  }

  Future<void> deleteAllWithoutTxn({required List<String> ids}) async {
    await _chatFolderCollection?.deleteAllById(ids);
  }

  /// For clear all data in ChatFolderCollection and reset auto increment id
  ///
  /// `be careful when using this method`
  Future<void> clearCollection() async {
    await _chatFolderCollection?.clear();
  }
}
