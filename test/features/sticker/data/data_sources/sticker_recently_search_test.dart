import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_recently_search_db.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_recently_search_collection.dart';
import 'package:uchat/utils/date.dart';

void main() {
  late Isar isar;
  late StickerRecentlySearchDb stickerRecentlySearchDb;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [StickerRecentlySearchCollectionSchema],
      directory: './',
      name: 'sticker_recently_search_test',
    );

    stickerRecentlySearchDb = StickerRecentlySearchDb(customDbInstance: isar);
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('getAllRecentlySearches cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.stickerRecentlySearches.clear();
      });
    });

    test('Given no data in local db, When invoked, Should return empty list', () async {
      final result = await stickerRecentlySearchDb.getAllRecentlySearches();

      expect(result, []);
    });

    test('Given one recently search data in local db, When invoked, Should return list of recently search data',
        () async {
      StickerRecentlySearchCollection search1 = StickerRecentlySearchCollection(id: 'search1');

      await stickerRecentlySearchDb.addRecentlySearch(
        search1,
        DateTime(2000, 1, 1, 1),
      );

      final result = await stickerRecentlySearchDb.getAllRecentlySearches();

      expect(result, [search1]);
    });

    test(
        'Given some recently search data in local db, When invoked, Should return list of recently search data sort by lastOpenedAt',
        () async {
      StickerRecentlySearchCollection search1 = StickerRecentlySearchCollection(id: 'search1');
      StickerRecentlySearchCollection search2 = StickerRecentlySearchCollection(id: 'search2');
      StickerRecentlySearchCollection search3 = StickerRecentlySearchCollection(id: 'search3');

      await stickerRecentlySearchDb.addRecentlySearch(
        search1,
        DateTime(2000, 1, 1, 1),
      );
      await stickerRecentlySearchDb.addRecentlySearch(
        search2,
        DateTime(2000, 1, 1, 2),
      );
      await stickerRecentlySearchDb.addRecentlySearch(
        search3,
        DateTime(2000, 1, 1, 3),
      );

      final result = await stickerRecentlySearchDb.getAllRecentlySearches();

      expect(result, [search3, search2, search1]);
    });

    test(
        'Given lots of recently search data in local db, When invoked, Should return list of recently search data without exceeding limit',
        () async {
      for (int i = 0; i < 35; i++) {
        StickerRecentlySearchCollection search = StickerRecentlySearchCollection(id: 'search${i + 1}');
        await stickerRecentlySearchDb.addRecentlySearch(
          search,
          DateTime(2000, 1, 1, 1).addDays(i),
        );
      }

      final result = await stickerRecentlySearchDb.getAllRecentlySearches();

      expect(result.length, 30);
    });
  });
}
