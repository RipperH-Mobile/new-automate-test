import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';

class MockAccountService extends Mock implements AccountService {}

class MockLoggerService extends Mock implements LoggerService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  late Isar isar;
  late AlbumDb albumDb;
  late MockAccountService mockAccountService;
  late MockLoggerService mockLoggerService;
  late MockUserController mockUserController;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [AlbumCollectionSchema],
      directory: './',
      name: 'album_db_test',
    );

    mockLoggerService = MockLoggerService();
    mockAccountService = MockAccountService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    GetIt.I.registerSingleton<AccountService>(mockAccountService);
    albumDb = AlbumDb(customDbInstance: isar);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockUserController);
    reset(mockAccountService);

    when(() => mockUserController.currentUser).thenReturn(
      UserEntity(
        id: 'accountId1',
        username: 'user1',
        displayName: 'User 1',
        phoneNumber: '0892345678',
      ).obs,
    );
    when(() => mockAccountService.getUserPublicAvatar(any())).thenReturn('');
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.albums.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putAlbum cases', () {
    test('Given no album in local db, When invoked, Should save new album into local db', () async {
      // Given
      final album = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.putAlbum(album);

      // Then
      final fetchedAlbum = await albumDb.getAlbum(id: 'albumId1');
      expect(fetchedAlbum?.id, album.id);
    });

    test('Given some album in local db, When invoked with same album but new data, Should save new data into local db',
        () async {
      // Given
      final album = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbum(album);
      final newAlbum = AlbumCollection(
        albumName: 'albumName1AAA',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.putAlbum(newAlbum);

      // Then
      final fetchedAlbum = await albumDb.getAlbum(id: 'albumId1');
      expect(fetchedAlbum?.id, newAlbum.id);
      expect(fetchedAlbum?.albumName, newAlbum.albumName);
    });
  });

  group('putAlbumWithoutTxn cases', () {
    test('Given no album in local db, When invoked, Should save new album into local db', () async {
      // Given
      final album = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.customDbInstance?.writeTxn(() async {
        await albumDb.putAlbumWithoutTxn(album);
      });

      // Then
      final fetchedAlbum = await albumDb.getAlbum(id: 'albumId1');
      expect(fetchedAlbum?.id, album.id);
    });

    test('Given some album in local db, When invoked with same album but new data, Should save new data into local db',
        () async {
      // Given
      final album = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbum(album);
      final newAlbum = AlbumCollection(
        albumName: 'albumName1AAA',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.customDbInstance?.writeTxn(() async {
        await albumDb.putAlbumWithoutTxn(newAlbum);
      });

      // Then
      final fetchedAlbum = await albumDb.getAlbum(id: 'albumId1');
      expect(fetchedAlbum?.id, newAlbum.id);
      expect(fetchedAlbum?.albumName, newAlbum.albumName);
    });
  });

  group('putAlbums cases', () {
    test('Given no album in local db, When invoked, Should save new album into local db', () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.putAlbums(albums: [album1, album2]);

      // Then
      final fetchedAlbum1 = await albumDb.getAlbum(id: 'albumId1');
      final fetchedAlbum2 = await albumDb.getAlbum(id: 'albumId2');
      expect(fetchedAlbum1?.id, album1.id);
      expect(fetchedAlbum1?.albumName, album1.albumName);
      expect(fetchedAlbum2?.id, album2.id);
      expect(fetchedAlbum2?.albumName, album2.albumName);
    });

    test('Given some album in local db, When invoked with same album but new data, Should save new data into local db',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2]);
      final newAlbum1 = AlbumCollection(
        albumName: 'albumName1AAA',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final newAlbum2 = AlbumCollection(
        albumName: 'albumName2AAA',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );

      // When
      await albumDb.putAlbums(albums: [newAlbum1, newAlbum2]);

      // Then
      final fetchedAlbum1 = await albumDb.getAlbum(id: 'albumId1');
      final fetchedAlbum2 = await albumDb.getAlbum(id: 'albumId2');
      expect(fetchedAlbum1?.id, newAlbum1.id);
      expect(fetchedAlbum1?.albumName, newAlbum1.albumName);
      expect(fetchedAlbum2?.id, newAlbum2.id);
      expect(fetchedAlbum2?.albumName, newAlbum2.albumName);
    });
  });

  group('getAlbum cases', () {
    test('Given no album in local db, When invoked, Should return null', () async {
      // When
      final fetchedAlbum = await albumDb.getAlbum(id: 'nonExistId');

      // Then
      expect(fetchedAlbum, null);
    });

    test('Given some album in local db, When invoked with existing id, Should return the album', () async {
      // Given
      final album = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbum(album);

      // When
      final fetchedAlbum = await albumDb.getAlbum(id: 'albumId1');

      // Then
      expect(fetchedAlbum?.id, album.id);
    });
  });

  group('getAllAlbumInRoom cases', () {
    test('Given no album in local db, When invoked, Should return empty list', () async {
      // When
      final albums = await albumDb.getAllAlbumInRoom(roomId: 'roomId1');

      // Then
      expect(albums, isEmpty);
    });

    test(
        'Given some albums in local db, When invoked with room id, Should return list of album from that room sorted by updated at',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 2, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album3 = AlbumCollection(
        albumName: 'albumName3',
        id: 'albumId3',
        accountId: 'accountId1',
        roomId: 'roomId2',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 3, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2, album3]);

      // When
      final result = await albumDb.getAllAlbumInRoom(roomId: 'roomId1');

      // Then
      expect(result.length, 2);
      expect(result[0].id, album2.id);
      expect(result[1].id, album1.id);
    });

    test(
        'Given some album in local db, When invoked with room id, page and page size, Should return list of album from that room sorted by updated at with pagination',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 2, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album3 = AlbumCollection(
        albumName: 'albumName3',
        id: 'albumId3',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 3, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album4 = AlbumCollection(
        albumName: 'albumName4',
        id: 'albumId4',
        accountId: 'accountId1',
        roomId: 'roomId2',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 4, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2, album3, album4]);

      // When
      final resultPage1 = await albumDb.getAllAlbumInRoom(roomId: 'roomId1', page: 1, pageSize: 2);
      final resultPage2 = await albumDb.getAllAlbumInRoom(roomId: 'roomId1', page: 2, pageSize: 2);

      // Then
      expect(resultPage1.length, 2);
      expect(resultPage1[0].id, album3.id);
      expect(resultPage1[1].id, album2.id);
      expect(resultPage2.length, 1);
      expect(resultPage2[0].id, album1.id);
    });
  });

  group('getAlbumCountInRoom cases', () {
    test('Given no album in local db, When invoked, Should return 0', () async {
      // When
      final count = await albumDb.getAlbumCountInRoom(roomId: 'roomId1');

      // Then
      expect(count, 0);
    });

    test('Given some album in local db, When invoked with room id, Should return count of album in that room id',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album3 = AlbumCollection(
        albumName: 'albumName3',
        id: 'albumId3',
        accountId: 'accountId1',
        roomId: 'roomId2',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2, album3]);

      // When
      final countRoom1 = await albumDb.getAlbumCountInRoom(roomId: 'roomId1');
      final countRoom2 = await albumDb.getAlbumCountInRoom(roomId: 'roomId2');

      // Then
      expect(countRoom1, 2);
      expect(countRoom2, 1);
    });
  });

  group('clearAllAlbumInRoom cases', () {
    test(
        'Given some album in local db, When invoked with room id, Should delete all album in that room id from local db',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album3 = AlbumCollection(
        albumName: 'albumName3',
        id: 'albumId3',
        accountId: 'accountId1',
        roomId: 'roomId2',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2, album3]);

      // When
      await albumDb.clearAllAlbumInRoom(roomId: 'roomId1');

      // Then
      final fetchedAlbum1 = await albumDb.getAlbum(id: 'albumId1');
      final fetchedAlbum2 = await albumDb.getAlbum(id: 'albumId2');
      final fetchedAlbum3 = await albumDb.getAlbum(id: 'albumId3');
      expect(fetchedAlbum1, isNull);
      expect(fetchedAlbum2, isNull);
      expect(fetchedAlbum3, isNotNull);
    });
  });

  group('deleteAlbum cases', () {
    test(
        'Given some album in local db, When invoked with album id, Should delete that album with that id from local db',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2]);

      // When
      await albumDb.deleteAlbum(id: 'albumId1');

      // Then
      final fetchedAlbum1 = await albumDb.getAlbum(id: 'albumId1');
      final fetchedAlbum2 = await albumDb.getAlbum(id: 'albumId2');
      expect(fetchedAlbum1, isNull);
      expect(fetchedAlbum2, isNotNull);
    });
  });

  group('deleteAlbumWithoutTxn cases', () {
    test(
        'Given some album in local db, When invoked with album id, Should delete that album with that id from local db',
        () async {
      // Given
      final album1 = AlbumCollection(
        albumName: 'albumName1',
        id: 'albumId1',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      final album2 = AlbumCollection(
        albumName: 'albumName2',
        id: 'albumId2',
        accountId: 'accountId1',
        roomId: 'roomId1',
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        createdBy: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'name1',
        ),
        isSuccess: true,
      );
      await albumDb.putAlbums(albums: [album1, album2]);

      // When
      await albumDb.customDbInstance?.writeTxn(() async {
        await albumDb.deleteAlbumWithoutTxn(id: 'albumId1');
      });

      // Then
      final fetchedAlbum1 = await albumDb.getAlbum(id: 'albumId1');
      final fetchedAlbum2 = await albumDb.getAlbum(id: 'albumId2');
      expect(fetchedAlbum1, isNull);
      expect(fetchedAlbum2, isNotNull);
    });
  });
}
