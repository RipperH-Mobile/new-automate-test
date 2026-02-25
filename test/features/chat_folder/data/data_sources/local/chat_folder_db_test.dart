import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_folder/chat_folder_barrel.dart';
import 'package:uchat/features/chat_folder/data/data_sources/local/chat_folder_db.dart';
import 'package:uchat/features/chat_folder/data/models/collections/chat_folder_collection.dart';

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late Isar isar;
  late ChatFolderDb chatFolderDb;
  late MockLoggerService mockLoggerService;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [ChatFolderCollectionSchema],
      directory: './',
      name: 'chat_folder_db_test',
    );

    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    chatFolderDb = ChatFolderDb(customDbInstance: isar);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.chatFolders.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('getById cases', () {
    test('Given no chat folder in local db, When invoked, Should return null', () async {
      final result = await chatFolderDb.getById(id: 'non_existing_id');
      expect(result, isNull);
    });

    test('Given some chat folder in local db, When invoked with id, Should return that chat folder', () async {
      // Given
      final chatFolder = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      await chatFolderDb.put(chatFolder: chatFolder);

      // When
      final result = await chatFolderDb.getById(id: chatFolder.id);

      // Then
      expect(result, chatFolder);
    });
  });

  group('getAll cases', () {
    test('Given no chat folder in local db, When invoked, Should return empty list', () async {
      final result = await chatFolderDb.getAll();
      expect(result, isEmpty);
    });

    test('Given some chat folder in local db, When invoked without parameter, Should return all chat folders',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
        seq: 1,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
        seq: 2,
      );
      final chatFolder3 = ChatFolderCollection(
        id: 'folderId3',
        name: 'folder3',
        type: ChatFolderType.group,
        seq: 3,
      );
      final chatFolder4 = ChatFolderCollection(
        id: 'folderId4',
        name: 'folder4',
        type: ChatFolderType.direct,
        seq: 4,
      );
      final chatFolder5 = ChatFolderCollection(
        id: 'folderId5',
        name: 'folder5',
        type: ChatFolderType.oa,
        seq: 5,
      );
      final chatFolder6 = ChatFolderCollection(
        id: 'folderId6',
        name: 'folder6',
        type: ChatFolderType.secret,
        seq: 6,
      );
      final chatFolder7 = ChatFolderCollection(
        id: 'folderId7',
        name: 'folder7',
        type: ChatFolderType.unread,
        seq: 7,
      );
      await chatFolderDb.putAll(
          chatFolders: [chatFolder1, chatFolder2, chatFolder3, chatFolder4, chatFolder5, chatFolder6, chatFolder7]);

      // When
      final result = await chatFolderDb.getAll();

      // Then
      expect(result, [chatFolder1, chatFolder2, chatFolder3, chatFolder4, chatFolder5, chatFolder6, chatFolder7]);
    });

    test(
        'Given some chat folder in local db, When invoked with sortDesc true, Should return all chat folders with descending sort',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
        seq: 1,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
        seq: 2,
      );
      final chatFolder3 = ChatFolderCollection(
        id: 'folderId3',
        name: 'folder3',
        type: ChatFolderType.group,
        seq: 3,
      );
      final chatFolder4 = ChatFolderCollection(
        id: 'folderId4',
        name: 'folder4',
        type: ChatFolderType.direct,
        seq: 4,
      );
      final chatFolder5 = ChatFolderCollection(
        id: 'folderId5',
        name: 'folder5',
        type: ChatFolderType.oa,
        seq: 5,
      );
      final chatFolder6 = ChatFolderCollection(
        id: 'folderId6',
        name: 'folder6',
        type: ChatFolderType.secret,
        seq: 6,
      );
      final chatFolder7 = ChatFolderCollection(
        id: 'folderId7',
        name: 'folder7',
        type: ChatFolderType.unread,
        seq: 7,
      );
      await chatFolderDb.putAll(
          chatFolders: [chatFolder1, chatFolder2, chatFolder3, chatFolder4, chatFolder5, chatFolder6, chatFolder7]);

      // When
      final result = await chatFolderDb.getAll(sortDesc: true);

      // Then
      expect(result, [chatFolder7, chatFolder6, chatFolder5, chatFolder4, chatFolder3, chatFolder2, chatFolder1]);
    });

    test('Given some chat folder in local db, When invoked with isHidden true, Should return all hidden chat folders',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
        seq: 1,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
        seq: 2,
      );
      final chatFolder3 = ChatFolderCollection(
        id: 'folderId3',
        name: 'folder3',
        type: ChatFolderType.group,
        seq: 3,
      );
      final chatFolder4 = ChatFolderCollection(
        id: 'folderId4',
        name: 'folder4',
        type: ChatFolderType.direct,
        seq: 4,
      );
      final chatFolder5 = ChatFolderCollection(
        id: 'folderId5',
        name: 'folder5',
        type: ChatFolderType.oa,
        seq: 5,
      );
      final chatFolder6 = ChatFolderCollection(
        id: 'folderId6',
        name: 'folder6',
        type: ChatFolderType.secret,
        seq: 6,
      );
      final chatFolder7 = ChatFolderCollection(
        id: 'folderId7',
        name: 'folder7',
        type: ChatFolderType.unread,
        seq: 7,
      );
      final chatFolder8 = ChatFolderCollection(
        id: 'folderId8',
        name: 'folder8',
        type: ChatFolderType.normal,
        seq: 8,
        isHidden: true,
      );
      await chatFolderDb.putAll(chatFolders: [
        chatFolder1,
        chatFolder2,
        chatFolder3,
        chatFolder4,
        chatFolder5,
        chatFolder6,
        chatFolder7,
        chatFolder8,
      ]);

      // When
      final result = await chatFolderDb.getAll(isHidden: true);

      // Then
      expect(result, [chatFolder8]);
    });
  });

  group('putAll cases', () {
    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );

      // When
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), true);
      expect(result.contains(chatFolder2), true);
    });

    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);
      final updatedChatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder11',
        type: ChatFolderType.normal,
        isUnread: true,
      );
      final updatedChatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder22',
        type: ChatFolderType.all,
        isHidden: true,
      );

      // When
      await chatFolderDb.putAll(chatFolders: [updatedChatFolder1, updatedChatFolder2]);

      // Then
      final result1 = await chatFolderDb.getById(id: updatedChatFolder1.id);
      final result2 = await chatFolderDb.getById(id: updatedChatFolder2.id);
      expect(result1, isNotNull);
      expect(result2, isNotNull);
      expect(result1?.name, updatedChatFolder1.name);
      expect(result2?.name, updatedChatFolder2.name);
      expect(result1?.isUnread, updatedChatFolder1.isUnread);
      expect(result2?.isHidden, updatedChatFolder2.isHidden);
    });
  });

  group('putAllWithoutTxn cases', () {
    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );

      // When
      await chatFolderDb.customDbInstance?.writeTxn(() async {
        await chatFolderDb.putAllWithoutTxn(chatFolders: [chatFolder1, chatFolder2]);
      });

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), true);
      expect(result.contains(chatFolder2), true);
    });

    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);
      final updatedChatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder11',
        type: ChatFolderType.normal,
        isUnread: true,
      );
      final updatedChatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder22',
        type: ChatFolderType.all,
        isHidden: true,
      );

      // When
      await chatFolderDb.customDbInstance?.writeTxn(() async {
        await chatFolderDb.putAllWithoutTxn(chatFolders: [updatedChatFolder1, updatedChatFolder2]);
      });

      // Then
      final result1 = await chatFolderDb.getById(id: updatedChatFolder1.id);
      final result2 = await chatFolderDb.getById(id: updatedChatFolder2.id);
      expect(result1, isNotNull);
      expect(result2, isNotNull);
      expect(result1?.name, updatedChatFolder1.name);
      expect(result2?.name, updatedChatFolder2.name);
      expect(result1?.isUnread, updatedChatFolder1.isUnread);
      expect(result2?.isHidden, updatedChatFolder2.isHidden);
    });
  });

  group('put cases', () {
    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );

      // When
      await chatFolderDb.put(chatFolder: chatFolder1);

      // Then
      final result = await chatFolderDb.getById(id: chatFolder1.id);
      expect(result, chatFolder1);
    });

    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      await chatFolderDb.put(chatFolder: chatFolder1);
      final updatedChatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder11',
        type: ChatFolderType.normal,
        isUnread: true,
        isHidden: true,
      );

      // When
      await chatFolderDb.put(chatFolder: updatedChatFolder1);

      // Then
      final result = await chatFolderDb.getById(id: chatFolder1.id);
      expect(result, updatedChatFolder1);
      expect(result?.name, updatedChatFolder1.name);
      expect(result?.isUnread, updatedChatFolder1.isUnread);
      expect(result?.isHidden, updatedChatFolder1.isHidden);
    });
  });

  group('putWithoutTxn cases', () {
    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );

      // When
      await chatFolderDb.put(chatFolder: chatFolder1);

      // Then
      final result = await chatFolderDb.getById(id: chatFolder1.id);
      expect(result, chatFolder1);
    });

    test('Given no chat folder in local db, When invoked, Should save new chat folder into local db', () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      await chatFolderDb.put(chatFolder: chatFolder1);
      final updatedChatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder11',
        type: ChatFolderType.normal,
        isUnread: true,
        isHidden: true,
      );

      // When
      await chatFolderDb.put(chatFolder: updatedChatFolder1);

      // Then
      final result = await chatFolderDb.getById(id: chatFolder1.id);
      expect(result, updatedChatFolder1);
      expect(result?.name, updatedChatFolder1.name);
      expect(result?.isUnread, updatedChatFolder1.isUnread);
      expect(result?.isHidden, updatedChatFolder1.isHidden);
    });
  });

  group('delete cases', () {
    test('Given some chat room folder in local db, When invoked with id, Should remove that chat folder from local db',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);

      // When
      await chatFolderDb.delete(id: chatFolder1.id);

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), false);
      expect(result.contains(chatFolder2), true);
    });
  });

  group('deleteWithoutTxn cases', () {
    test('Given some chat room folder in local db, When invoked with id, Should remove that chat folder from local db',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);

      // When
      await chatFolderDb.customDbInstance?.writeTxn(() async {
        await chatFolderDb.deleteWithoutTxn(id: chatFolder1.id);
      });

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), false);
      expect(result.contains(chatFolder2), true);
    });
  });

  group('deleteAll cases', () {
    test(
        'Given some chat room folder in local db, When invoked with list of id, Should remove all specified chat folder from local db',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);

      // When
      await chatFolderDb.deleteAll(ids: [chatFolder1.id, chatFolder2.id]);

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), false);
      expect(result.contains(chatFolder2), false);
    });
  });

  group('deleteAllWithoutTxn cases', () {
    test(
        'Given some chat room folder in local db, When invoked with list of id, Should remove all specified chat folder from local db',
        () async {
      // Given
      final chatFolder1 = ChatFolderCollection(
        id: 'folderId1',
        name: 'folder1',
        type: ChatFolderType.normal,
      );
      final chatFolder2 = ChatFolderCollection(
        id: 'folderId2',
        name: 'folder2',
        type: ChatFolderType.all,
      );
      await chatFolderDb.putAll(chatFolders: [chatFolder1, chatFolder2]);

      // When
      await chatFolderDb.customDbInstance?.writeTxn(() async {
        await chatFolderDb.deleteAllWithoutTxn(ids: [chatFolder1.id, chatFolder2.id]);
      });

      // Then
      final result = await chatFolderDb.getAll();
      expect(result.contains(chatFolder1), false);
      expect(result.contains(chatFolder2), false);
    });
  });
}
