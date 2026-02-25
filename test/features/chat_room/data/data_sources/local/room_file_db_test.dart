import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_file_type.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockFileService extends Mock implements FileService {}

void main() {
  late Isar isar;
  late RoomFileDb roomFileDb;
  late MockLoggerService mockLoggerService;
  late MockFileService mockFileService;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [RoomFileCollectionSchema],
      directory: './',
      name: 'room_file_db_test',
    );

    roomFileDb = RoomFileDb(customDbInstance: isar);
    mockFileService = MockFileService();
    GetIt.I.registerSingleton<FileService>(mockFileService);
    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);

    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
    when(() => mockFileService.getFileUrl(any())).thenAnswer((_) => '');
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.roomFiles.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putRoomFile cases', () {
    test(
        'Given room file is not exist in local db yet, When invoked with new room file, Should save new room file in local db',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(id: 'fileId1', messageId: 'messageId1', roomId: 'roomId1', type: MessageFileType.file),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );

      // When
      await roomFileDb.putRoomFile(roomFile);

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(fetchedRoomFile, roomFile);
    });

    test(
        'Given room file is already exist in local db, When invoked with same room file but new data, Should update room file data in local db',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final newRoomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isDownload: true,
        isHidden: true,
      );
      await roomFileDb.putRoomFile(roomFile);
      final correctRoomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isDownload: true,
        isHidden: true,
      );

      // When
      await roomFileDb.putRoomFile(newRoomFile);

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(fetchedRoomFile, correctRoomFile);
    });
  });

  group('putRoomFileWithoutTxn cases', () {
    test(
        'Given room file is not exist in local db yet, When invoked with new room file, Should save new room file in local db',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(id: 'fileId1', messageId: 'messageId1', roomId: 'roomId1', type: MessageFileType.file),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.putRoomFileWithoutTxn(roomFile);
      });

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(fetchedRoomFile, roomFile);
    });

    test(
        'Given room file is already exist in local db, When invoked with same room file but new data, Should update room file data in local db',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final newRoomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isDownload: true,
        isHidden: true,
      );
      await roomFileDb.putRoomFile(roomFile);
      final correctRoomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isDownload: true,
        isHidden: true,
      );

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.putRoomFileWithoutTxn(newRoomFile);
      });

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(fetchedRoomFile, correctRoomFile);
    });
  });

  group('putAllRoomFile cases', () {
    test('Given no room file in local db, When invoked with new room files, Should save new room files in local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );

      // When
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2]);

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      expect(fetchedRoomFile1, roomFile1);
      expect(fetchedRoomFile2, roomFile2);
    });

    test(
        'Given some room file already in local db, When invoked with same room file with new data, Should replace old room file with new room file in local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2]);
      final newRoomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isHidden: true,
        isDownload: true,
      );
      final newRoomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
          isPasswordProtected: true,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
        isHidden: true,
        isDownload: true,
      );

      // When
      await roomFileDb.putAllRoomFile([newRoomFile1, newRoomFile2]);

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      expect(fetchedRoomFile1, newRoomFile1);
      expect(fetchedRoomFile2, newRoomFile2);
    });
  });

  group('putAllRoomFileWithoutTxn cases', () {
    test('Given no room file in local db, When invoked with new room files, Should save new room files in local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.putAllRoomFileWithoutTxn([roomFile1, roomFile2]);
      });

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      expect(fetchedRoomFile1, roomFile1);
      expect(fetchedRoomFile2, roomFile2);
    });

    test(
        'Given some room file already in local db, When invoked with same room file with new data, Should replace old room file with new room file in local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2]);
      final newRoomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          isPasswordProtected: true,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
        isHidden: true,
        isDownload: true,
      );
      final newRoomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
          isPasswordProtected: true,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
        isHidden: true,
        isDownload: true,
      );

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.putAllRoomFileWithoutTxn([newRoomFile1, newRoomFile2]);
      });

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      expect(fetchedRoomFile1, newRoomFile1);
      expect(fetchedRoomFile2, newRoomFile2);
    });
  });

  group('getRoomFile cases', () {
    test('Given no room file in local db, When invoked, Should return null', () async {
      // When
      final fetchedRoomFile = await roomFileDb.getRoomFile('fileId1');

      // Then
      expect(fetchedRoomFile, isNull);
    });

    test(
        'Given some room file already in local db, When invoked with id, Should return correct room file from local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2]);

      // When
      await roomFileDb.getRoomFile(roomFile1.id!);

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile1.id!);
      expect(fetchedRoomFile, roomFile1);
    });
  });

  group('deleteAllFileInRoom cases', () {
    test(
        'Given some room file already in local db, When invoked with room id, Should remove all room file with that room id from local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3]);

      // When
      await roomFileDb.deleteAllFileInRoom('roomId1');

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      final fetchedRoomFile3 = await roomFileDb.getRoomFile(roomFile3.id!);
      expect(fetchedRoomFile1, isNull);
      expect(fetchedRoomFile2, isNull);
      expect(fetchedRoomFile3, roomFile3);
    });
  });

  group('deleteAllFileInRoomWithoutTxn cases', () {
    test(
        'Given some room file already in local db, When invoked with room id, Should remove all room file with that room id from local db',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3]);

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.deleteAllFileInRoomWithoutTxn('roomId1');
      });

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      final fetchedRoomFile3 = await roomFileDb.getRoomFile(roomFile3.id!);
      expect(fetchedRoomFile1, isNull);
      expect(fetchedRoomFile2, isNull);
      expect(fetchedRoomFile3, roomFile3);
    });
  });

  group('deleteAllFileWithMessageId cases', () {
    test(
        'Given some room file in local db, When invoked with message id, Should remove all room file with that message id from local db.',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3]);

      // When
      await roomFileDb.deleteAllFileWithMessageId('messageId1');

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      final fetchedRoomFile3 = await roomFileDb.getRoomFile(roomFile3.id!);
      expect(fetchedRoomFile1, isNull);
      expect(fetchedRoomFile2, isNull);
      expect(fetchedRoomFile3, roomFile3);
    });
  });

  group('deleteAllFileWithMessageIdWithoutTxn cases', () {
    test(
        'Given some room file in local db, When invoked with message id, Should remove all room file with that message id from local db.',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3]);

      // When
      await roomFileDb.customDbInstance?.writeTxn(() async {
        await roomFileDb.deleteAllFileWithMessageIdWithoutTxn('messageId1');
      });

      // Then
      final fetchedRoomFile1 = await roomFileDb.getRoomFile(roomFile1.id!);
      final fetchedRoomFile2 = await roomFileDb.getRoomFile(roomFile2.id!);
      final fetchedRoomFile3 = await roomFileDb.getRoomFile(roomFile3.id!);
      expect(fetchedRoomFile1, isNull);
      expect(fetchedRoomFile2, isNull);
      expect(fetchedRoomFile3, roomFile3);
    });
  });

  group('deleteRoomFile cases', () {
    test('Given no room file in local db, When invoked, Should return false', () async {
      // When
      final result = await roomFileDb.deleteRoomFile('fileId1');

      // Then
      expect(result, isFalse);
    });

    test(
        'Given some room file in local db, When invoked with id, Should remove room file with that id from local db and return true',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      await roomFileDb.putRoomFile(roomFile);

      // When
      final result = await roomFileDb.deleteRoomFile(roomFile.id!);

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(result, isTrue);
      expect(fetchedRoomFile, isNull);
    });
  });

  group('deleteRoomFileWithoutTxn cases', () {
    test('Given no room file in local db, When invoked, Should return false', () async {
      // When
      final result = await roomFileDb.customDbInstance?.writeTxn(() async {
        return await roomFileDb.deleteRoomFileWithoutTxn('fileId1');
      });

      // Then
      expect(result, isFalse);
    });

    test(
        'Given some room file in local db, When invoked with id, Should remove room file with that id from local db and return true',
        () async {
      // Given
      final roomFile = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      await roomFileDb.putRoomFile(roomFile);

      // When
      final result = await roomFileDb.customDbInstance?.writeTxn(() async {
        return await roomFileDb.deleteRoomFileWithoutTxn(roomFile.id!);
      });

      // Then
      final fetchedRoomFile = await roomFileDb.getRoomFile(roomFile.id!);
      expect(result, isTrue);
      expect(fetchedRoomFile, isNull);
    });
  });

  group('getAllFileInRoom cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getAllFileInRoom(roomId: 'roomId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with room id, Should return list of room file type file in that room sorted by message seq desc',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getAllFileInRoom(roomId: 'roomId1');

      // Then
      expect(result, [roomFile2, roomFile1]);
    });

    test(
        'Given some room file in local db, When invoked with room id, page and page size, Should return list of room file type file in that room sorted by message seq desc with pagination',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getAllFileInRoom(
        roomId: 'roomId1',
        page: 1,
        pageSize: 2,
      );
      final result2 = await roomFileDb.getAllFileInRoom(
        roomId: 'roomId1',
        page: 2,
        pageSize: 2,
      );

      // Then
      expect(result, [roomFile4, roomFile3]);
      expect(result2, [roomFile2, roomFile1]);
    });
  });

  group('getFileCountInRoom cases', () {
    test('Given no room file in local db, When invoked, Should return 0', () async {
      // When
      final result = await roomFileDb.getFileCountInRoom(roomId: 'roomId1');

      // Then
      expect(result, 0);
    });

    test(
        'Given some room file in local db, When invoked with room id, Should return count of room file type file in that room',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getFileCountInRoom(roomId: 'roomId1');

      // Then
      expect(result, 2);
    });
  });

  group('getPhotosAndVideosInRoom cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getPhotosAndVideosInRoom(roomId: 'roomId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with room id, Should return list of room file type image or video in that room sorted by message seq desc',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.video,
        ),
        type: RoomFileType.video,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getPhotosAndVideosInRoom(roomId: 'roomId1');

      // Then
      expect(result, [roomFile2, roomFile1]);
    });

    test(
        'Given some room file in local db, When invoked with room id, page and page size, Should return list of room file type image or video in that room sorted by message seq desc with pagination',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.video,
        ),
        type: RoomFileType.video,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.video,
        ),
        type: RoomFileType.video,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getPhotosAndVideosInRoom(
        roomId: 'roomId1',
        page: 1,
        pageSize: 2,
      );
      final result2 = await roomFileDb.getPhotosAndVideosInRoom(
        roomId: 'roomId1',
        page: 2,
        pageSize: 2,
      );

      // Then
      expect(result, [roomFile4, roomFile3]);
      expect(result2, [roomFile2, roomFile1]);
    });
  });

  group('getPhotoAndVideoCountInRoom cases', () {
    test('Given no room file in local db, When invoked, Should return 0', () async {
      // When
      final result = await roomFileDb.getFileCountInRoom(roomId: 'roomId1');

      // Then
      expect(result, 0);
    });

    test(
        'Given some room file in local db, When invoked with room id, Should return count of room file type file in that room',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.video,
        ),
        type: RoomFileType.video,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.video,
        ),
        type: RoomFileType.video,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getPhotoAndVideoCountInRoom(roomId: 'roomId1');

      // Then
      expect(result, 2);
    });
  });

  group('getFilesInRoom cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getFilesInRoom('roomId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with room id, Should return list of room file type file in that room sorted by message seq desc',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.file,
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.image,
        ),
        type: RoomFileType.image,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4]);

      // When
      final result = await roomFileDb.getFilesInRoom('roomId1');

      // Then
      expect(result, [roomFile2, roomFile1]);
    });
  });

  group('getFilesInAccount cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getFilesInAccount('accountId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with account id, Should return list of room file type file with that account sorted by create at excluding hidden room file',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.file,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
        type: RoomFileType.file,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.file,
          accountId: 'accountId2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
        type: RoomFileType.file,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.file,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
        type: RoomFileType.file,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.image,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
        type: RoomFileType.image,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      final roomFile5 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId5',
          messageId: 'messageId5',
          roomId: 'roomId1',
          type: MessageFileType.image,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
        type: RoomFileType.image,
        messageId: 'messageId5',
        messageSeq: 5,
        roomFileId: '_id5',
        isHidden: true,
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4, roomFile5]);

      // When
      final result = await roomFileDb.getFilesInAccount('accountId1');

      // Then
      expect(result, [roomFile3, roomFile1]);
    });
  });

  group('getPhotosAndVideosInAccount cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getPhotosAndVideosInAccount('accountId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with account id, Should return list of room file type photo or video with that account sorted by create at excluding hidden room file',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.image,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
        type: RoomFileType.image,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.video,
          accountId: 'accountId2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
        type: RoomFileType.video,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.image,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
        type: RoomFileType.image,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.file,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
        type: RoomFileType.file,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      final roomFile5 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId5',
          messageId: 'messageId5',
          roomId: 'roomId1',
          type: MessageFileType.file,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
        type: RoomFileType.file,
        messageId: 'messageId5',
        messageSeq: 5,
        roomFileId: '_id5',
        isHidden: true,
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4, roomFile5]);

      // When
      final result = await roomFileDb.getPhotosAndVideosInAccount('accountId1');

      // Then
      expect(result, [roomFile3, roomFile1]);
    });
  });

  group('getVideosInAccount cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getVideosInAccount('accountId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room file in local db, When invoked with account id, Should return list of room file type video with that account sorted by message seq',
        () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.video,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
        type: RoomFileType.video,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      final roomFile2 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId2',
          messageId: 'messageId2',
          roomId: 'roomId1',
          type: MessageFileType.video,
          accountId: 'accountId2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
        type: RoomFileType.video,
        messageId: 'messageId2',
        messageSeq: 2,
        roomFileId: '_id2',
      );
      final roomFile3 = RoomFileCollection(
        roomId: 'roomId2',
        file: MessageFileModel(
          id: 'fileId3',
          messageId: 'messageId3',
          roomId: 'roomId2',
          type: MessageFileType.video,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
        type: RoomFileType.video,
        messageId: 'messageId3',
        messageSeq: 3,
        roomFileId: '_id3',
      );
      final roomFile4 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId4',
          messageId: 'messageId4',
          roomId: 'roomId1',
          type: MessageFileType.image,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
        type: RoomFileType.image,
        messageId: 'messageId4',
        messageSeq: 4,
        roomFileId: '_id4',
      );
      final roomFile5 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId5',
          messageId: 'messageId5',
          roomId: 'roomId1',
          type: MessageFileType.file,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
        type: RoomFileType.file,
        messageId: 'messageId5',
        messageSeq: 5,
        roomFileId: '_id5',
      );
      await roomFileDb.putAllRoomFile([roomFile1, roomFile2, roomFile3, roomFile4, roomFile5]);

      // When
      final result = await roomFileDb.getVideosInAccount('accountId1');

      // Then
      expect(result, [roomFile3, roomFile1]);
    });
  });

  group('getRoomFileCollectionOne cases', () {
    test('Given no room file in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomFileDb.getRoomFileCollectionOne('roomId1', 'messageId1');

      // Then
      expect(result, isNull);
    });

    test('Given some room file in local db, When invoked, Should return the correct room file', () async {
      // Given
      final roomFile1 = RoomFileCollection(
        roomId: 'roomId1',
        file: MessageFileModel(
          id: 'fileId1',
          messageId: 'messageId1',
          roomId: 'roomId1',
          type: MessageFileType.video,
          accountId: 'accountId1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
        type: RoomFileType.video,
        messageId: 'messageId1',
        messageSeq: 1,
        roomFileId: '_id1',
      );
      await roomFileDb.putAllRoomFile([roomFile1]);

      // When
      final result = await roomFileDb.getRoomFileCollectionOne('roomId1', 'messageId1');

      // Then
      expect(result, roomFile1);
    });
  });
}
