import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/data/data_source/local/album_image_db.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late Isar isar;
  late AlbumImageDb albumImageDb;
  late MockLoggerService mockLoggerService;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [AlbumImageCollectionSchema],
      directory: './',
      name: 'album_image_db_test',
    );

    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    albumImageDb = AlbumImageDb(customDbInstance: isar);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.albumImages.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putAlbumImage cases', () {
    test('Given no album image in local db, When invoked, Should save new album image into local db', () async {
      // Given
      final albumImage = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );

      // When
      await albumImageDb.putAlbumImage(albumImage);

      // Then
      final result = await albumImageDb.getImagesInAlbum(albumImage.albumId!);
      expect(result, [albumImage]);
    });

    test(
        'Given album image in local db, When invoked with same album image with new data, Should save new album image into local db',
        () async {
      // Given
      final albumImage = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAlbumImage(albumImage);
      final newAlbumImage = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );

      // When
      await albumImageDb.putAlbumImage(newAlbumImage);

      // Then
      final result = await albumImageDb.getImagesInAlbum(albumImage.albumId!);
      expect(result, [newAlbumImage]);
      expect(result[0].imageName, newAlbumImage.imageName);
    });
  });

  group('putAllAlbumImage cases', () {
    test('Given no album image in local db, When invoked, Should save new album image into local db', () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );

      // When
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2]);

      // Then
      final result = await albumImageDb.getImagesInAlbum(albumImage1.albumId!);
      expect(result, [albumImage2, albumImage1]);
    });

    test(
        'Given album image in local db, When invoked with same album image with new data, Should save new album image into local db',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2]);
      final newAlbumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final newAlbumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );

      // When
      await albumImageDb.putAllAlbumImage([newAlbumImage1, newAlbumImage2]);

      // Then
      final result = await albumImageDb.getImagesInAlbum(albumImage1.albumId!);
      expect(result.length, 2);
      expect(result[0].imageId, newAlbumImage2.imageId);
      expect(result[1].imageId, newAlbumImage1.imageId);
      expect(result[0].imageName, newAlbumImage2.imageName);
      expect(result[1].imageName, newAlbumImage1.imageName);
    });
  });

  group('getImagesInAlbum cases', () {
    test('Given no album image in local db, When invoked, Should return empty list', () async {
      // When
      final result = await albumImageDb.getImagesInAlbum('albumId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some album image in local db, When invoked with album id, Should return all image in that album sorted by created at',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      final result = await albumImageDb.getImagesInAlbum('albumId1');

      // Then
      expect(result.length, 2);
      expect(result[0].imageId, albumImage2.imageId);
      expect(result[1].imageId, albumImage1.imageId);
    });

    test(
        'Given some album image in local db, When invoked with album id, page and page size, Should return all image in that album sorted by created at',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId1',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 3),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      final result1 = await albumImageDb.getImagesInAlbum('albumId1', page: 1, pageSize: 2);
      final result2 = await albumImageDb.getImagesInAlbum('albumId1', page: 2, pageSize: 2);

      // Then
      expect(result1.length, 2);
      expect(result1[0].imageId, albumImage3.imageId);
      expect(result1[1].imageId, albumImage2.imageId);
      expect(result2.length, 1);
      expect(result2[0].imageId, albumImage1.imageId);
    });

    test(
        'Given some album image in local db, When invoked with album id and before created at, Should return all image in that album sorted by created at',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId1',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 3),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      final result = await albumImageDb.getImagesInAlbum('albumId1', beforeCreatedAt: DateTime(2000, 1, 1, 2));

      // Then
      expect(result.length, 1);
      expect(result[0].imageId, albumImage1.imageId);
    });

    test(
        'Given some album image in local db, When invoked with album id and after created at, Should return all image in that album sorted by created at',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 2),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId1',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 3),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      final result = await albumImageDb.getImagesInAlbum('albumId1', afterCreatedAt: DateTime(2000, 1, 1, 2));

      // Then
      expect(result.length, 1);
      expect(result[0].imageId, albumImage3.imageId);
    });
  });

  group('getImageCountInAlbum cases', () {
    test('Given no album image in local db, When invoked, Should return 0', () async {
      // When
      final result = await albumImageDb.getImageCountInAlbum('albumId1');

      // Then
      expect(result, 0);
    });

    test('Given some album image in local db, When invoked with album id, Should return count of image in that album',
        () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      final result = await albumImageDb.getImageCountInAlbum('albumId1');

      // Then
      expect(result, 2);
    });
  });

  group('deleteImages cases', () {
    test('Given some images in local db, When invoked with one image id, Should remove that image', () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      await albumImageDb.deleteImages(['imageId2']);

      // Then
      final result = await albumImageDb.getImagesInAlbum('albumId1');
      expect(result.length, 1);
      expect(result[0].imageId, albumImage1.imageId);
      final result2 = await albumImageDb.getImagesInAlbum('albumId2');
      expect(result2.length, 1);
      expect(result2[0].imageId, albumImage3.imageId);
    });

    test('Given some images in local db, When invoked with multiple image id, Should remove those image', () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      await albumImageDb.deleteImages(['imageId1', 'imageId2']);

      // Then
      final result = await albumImageDb.getImagesInAlbum('albumId1');
      expect(result.length, 0);
      final result2 = await albumImageDb.getImagesInAlbum('albumId2');
      expect(result2.length, 1);
      expect(result2[0], albumImage3);
    });
  });

  group('deleteImagesWithoutTxn cases', () {
    test('Given some images in local db, When invoked with one image id, Should remove that image', () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      await albumImageDb.customDbInstance?.writeTxn(() async {
        await albumImageDb.deleteImagesWithoutTxn(['imageId2']);
      });

      // Then
      final result = await albumImageDb.getImagesInAlbum('albumId1');
      expect(result.length, 1);
      expect(result[0].imageId, albumImage1.imageId);
      final result2 = await albumImageDb.getImagesInAlbum('albumId2');
      expect(result2.length, 1);
      expect(result2[0].imageId, albumImage3.imageId);
    });

    test('Given some images in local db, When invoked with multiple image id, Should remove those image', () async {
      // Given
      final albumImage1 = AlbumImageCollection(
        imageId: 'imageId1',
        albumId: 'albumId1',
        imageName: 'imageName1',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage2 = AlbumImageCollection(
        imageId: 'imageId2',
        albumId: 'albumId1',
        imageName: 'imageName2',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      final albumImage3 = AlbumImageCollection(
        imageId: 'imageId3',
        albumId: 'albumId2',
        imageName: 'imageName3',
        createAt: DateTime(2000, 1, 1, 1),
        ownerId: 'accountId1',
        width: 800,
        height: 600,
      );
      await albumImageDb.putAllAlbumImage([albumImage1, albumImage2, albumImage3]);

      // When
      await albumImageDb.customDbInstance?.writeTxn(() async {
        await albumImageDb.deleteImagesWithoutTxn(['imageId1', 'imageId2']);
      });

      // Then
      final result = await albumImageDb.getImagesInAlbum('albumId1');
      expect(result.length, 0);
      final result2 = await albumImageDb.getImagesInAlbum('albumId2');
      expect(result2.length, 1);
      expect(result2[0], albumImage3);
    });
  });
}
