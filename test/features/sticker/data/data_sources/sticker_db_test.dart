import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_collection.dart';

void main() {
  late Isar isar;
  late StickerDb stickerDb;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [
        StickerCollectionSchema,
        MyStickerCollectionSchema,
      ],
      directory: './',
      name: 'sticker_db_test',
    );

    stickerDb = StickerDb(customDbInstance: isar);
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('getAllMyStickerPacks cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given empty data in local db, When getting all my sticker packs, Then return empty list', () async {
      final result = await stickerDb.getAllMyStickerPack();

      expect(result, []);
    });

    test(
        'Given 1 sticker packs in local db, When getting all my sticker packs, Then return list of that 1 sticker packs',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
      );
      await stickerDb.putMyStickerPack(pack1);

      final result = await stickerDb.getAllMyStickerPack();

      expect(result, [pack1]);
    });

    test(
        'Given all sticker packs has seq, When getting all my sticker packs, Then return list of sticker packs order by seq',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getAllMyStickerPack();

      expect(result, [pack1, pack2, pack3]);
    });

    test(
        'Given some sticker packs has seq and every packs is downloaded, When getting all my sticker packs, Then return list of sticker packs order by seq then by isDownloaded',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: null,
        isDownloaded: true,
      );
      final pack4 = MyStickerCollection(
        id: 'pack4',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3, pack4]);

      final result = await stickerDb.getAllMyStickerPack();

      expect(result, [pack1, pack2, pack4, pack3]);
    });

    test(
        'Given some sticker packs has seq and some packs is downloaded, When getting all my sticker packs, Then return list of sticker packs order by seq then by isDownloaded then by receivedAt',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: null,
        isDownloaded: true,
      );
      final pack4 = MyStickerCollection(
        id: 'pack4',
        isPublish: true,
        seq: null,
        isDownloaded: false,
        receivedAt: DateTime(2000, 1, 3),
      );
      final pack5 = MyStickerCollection(
        id: 'pack5',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );
      final pack6 = MyStickerCollection(
        id: 'pack6',
        isPublish: true,
        seq: null,
        isDownloaded: false,
        receivedAt: DateTime(2000, 1, 1),
      );
      final pack7 = MyStickerCollection(
        id: 'pack7',
        isPublish: true,
        seq: null,
        isDownloaded: false,
        receivedAt: DateTime(2000, 1, 2),
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3, pack4, pack5, pack6, pack7]);

      final result = await stickerDb.getAllMyStickerPack();

      expect(result, [pack1, pack2, pack5, pack3, pack4, pack7, pack6]);
    });
  });

  group('getMyStickerPackWithId cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test(
        'Given some my sticker collection, When calling with pack id that does not exist in local db, Should return null',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackWithId('pack99');

      expect(result, null);
    });

    test(
        'Given some my sticker collection, When calling with pack id that exist in local db, Should return that my sticker collection',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackWithId('pack2');

      expect(result, pack2);
    });
  });

  group('getMyStickerPackBetweenSeq cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test(
        'Given a param with range of 3 seq and not include both lower and upper, When invoked, Then return middle my sticker pack',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(startSeq: 1, endSeq: 3);

      expect(result, [pack2]);
    });

    test(
        'Given a param with range of 3 seq include lower but not upper, When invoked, Then return lower and middle my sticker pack',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(startSeq: 1, endSeq: 3, includeLower: true);

      expect(result.contains(pack1), true);
      expect(result.contains(pack2), true);
    });

    test(
        'Given a param with range of 3 seq include upper but not lower, When invoked, Then return upper and middle my sticker pack',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(startSeq: 1, endSeq: 3, includeUpper: true);

      expect(result.contains(pack2), true);
      expect(result.contains(pack3), true);
    });

    test(
        'Given a param with range of 3 seq and include both lower and upper, When invoked, Then return all 3 my sticker pack',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(
        startSeq: 1,
        endSeq: 3,
        includeLower: true,
        includeUpper: true,
      );

      expect(result.contains(pack1), true);
      expect(result.contains(pack2), true);
      expect(result.contains(pack3), true);
    });

    test(
        'Given a param with range of 3 seq and include both lower and upper, When invoked, Then return all 3 my sticker pack without my sticker pack that does not have seq',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );
      final pack4 = MyStickerCollection(
        id: 'pack4',
        isPublish: true,
        seq: null,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3, pack4]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(
        startSeq: 1,
        endSeq: 3,
        includeLower: true,
        includeUpper: true,
      );

      expect(result.contains(pack1), true);
      expect(result.contains(pack2), true);
      expect(result.contains(pack3), true);
    });

    test(
        'Given a param with range of 5 seq and include both lower and upper, When invoked, Then return all 5 my sticker pack',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );
      final pack4 = MyStickerCollection(
        id: 'pack4',
        isPublish: true,
        seq: 4,
        isDownloaded: true,
      );
      final pack5 = MyStickerCollection(
        id: 'pack5',
        isPublish: true,
        seq: 5,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3, pack4, pack5]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(
        startSeq: 1,
        endSeq: 5,
        includeLower: true,
        includeUpper: true,
      );

      expect(result.contains(pack1), true);
      expect(result.contains(pack2), true);
      expect(result.contains(pack3), true);
      expect(result.contains(pack4), true);
      expect(result.contains(pack5), true);
    });

    test(
        'Given a param with range of 5 seq and not include both lower and upper, When invoked, Then return 3 my sticker pack in the middle',
        () async {
      final pack1 = MyStickerCollection(
        id: 'pack1',
        isPublish: true,
        seq: 1,
        isDownloaded: true,
      );
      final pack2 = MyStickerCollection(
        id: 'pack2',
        isPublish: true,
        seq: 2,
        isDownloaded: true,
      );
      final pack3 = MyStickerCollection(
        id: 'pack3',
        isPublish: true,
        seq: 3,
        isDownloaded: true,
      );
      final pack4 = MyStickerCollection(
        id: 'pack4',
        isPublish: true,
        seq: 4,
        isDownloaded: true,
      );
      final pack5 = MyStickerCollection(
        id: 'pack5',
        isPublish: true,
        seq: 5,
        isDownloaded: true,
      );

      await stickerDb.putAllMyStickerPacks([pack1, pack2, pack3, pack4, pack5]);

      final result = await stickerDb.getMyStickerPackBetweenSeq(
        startSeq: 1,
        endSeq: 5,
        includeLower: false,
        includeUpper: false,
      );

      expect(result.contains(pack2), true);
      expect(result.contains(pack3), true);
      expect(result.contains(pack4), true);
    });
  });

  group('updateAllStickers cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given calling with 1 sticker, When updated, Then local db should update correctly', () async {
      final pack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );

      await stickerDb.putSticker(pack1);

      final newPack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );

      await stickerDb.updateAllStickers([newPack1]);

      final result = await stickerDb.getStickerById('pack1', 'fileId1');

      expect(result, newPack1);
    });

    test('Given calling with multiple stickers, When updated, Then local db should update correctly', () async {
      final pack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final pack2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
      );
      final pack3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(pack1);
      await stickerDb.putSticker(pack2);
      await stickerDb.putSticker(pack3);

      final newPack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );
      final newPack2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );
      final newPack3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );

      await stickerDb.updateAllStickers([newPack1, newPack2, newPack3]);

      final result1 = await stickerDb.getStickerById('pack1', 'fileId1');
      final result2 = await stickerDb.getStickerById('pack1', 'fileId2');
      final result3 = await stickerDb.getStickerById('pack1', 'fileId3');

      expect(result1, newPack1);
      expect(result2, newPack2);
      expect(result3, newPack3);
    });

    test(
        'Given calling with 1 sticker, When old data have lastUsedAt but new data does not, Then local db should update without affecting lastUsedAt',
        () async {
      final pack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );

      await stickerDb.putSticker(pack1);

      final newPack1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '❤️',
      );

      await stickerDb.updateAllStickers([newPack1]);

      final result = await stickerDb.getStickerById('pack1', 'fileId1');

      expect(
          result,
          StickerCollection(
            id: 'sticker1',
            packId: 'pack1',
            fileId: 'fileId1',
            emoji: '❤️',
            lastUsedAt: DateTime(2000, 1, 1, 1),
          ));
    });
  });

  group('getStickerById cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given some sticker collection, When calling with id that does not exist in local db, Should return null',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getStickerById('pack99', 'fileId1');

      expect(result, null);
    });

    test(
        'Given some sticker collection, When calling with id that exist in local db, Should return that sticker collection',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getStickerById('pack1', 'fileId2');

      expect(result, sticker2);
    });
  });

  group('updateStickerLastUsedAt cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test(
        'Given packId and fileId that exist in local db, When invoked, Then update lastUsedAt correctly and return true',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);

      final result = await stickerDb.updateStickerLastUsedAt('pack1', 'fileId1', DateTime(2000, 1, 1, 1));
      final newData = await stickerDb.getStickerById('pack1', 'fileId1');

      expect(result, true);
      expect(
        newData,
        StickerCollection(
          id: 'sticker1',
          packId: 'pack1',
          fileId: 'fileId1',
          emoji: '',
          lastUsedAt: DateTime(2000, 1, 1, 1),
        ),
      );
    });

    test('Given packId and fileId that does not exist in local db, When invoked, Then return false', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);

      final result = await stickerDb.updateStickerLastUsedAt('pack99', 'fileId1', DateTime(2000, 1, 1, 1));
      final newData = await stickerDb.getStickerById('pack1', 'fileId1');

      expect(result, false);
      expect(newData, sticker1);
    });
  });

  group('getRecentlyUsedStickers cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given all stickers is not used, When invoked, Should return empty list', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getRecentlyUsedStickers();

      expect(result, []);
    });

    test('Given 1 sticker is used, When invoked, Should return list with that sticker', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getRecentlyUsedStickers();

      expect(result, [sticker2]);
    });

    test('Given multiple stickers is used, When invoked, Should return list with used stickers order by lastUsedAt',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 3),
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 2),
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getRecentlyUsedStickers();

      expect(result, [sticker1, sticker2, sticker3]);
    });

    test(
        'Given multiple stickers is used, When invoked with limit, Should return list with used stickers order by lastUsedAt without exceeding that limit',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 3),
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack1',
        fileId: 'fileId2',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 2),
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
        lastUsedAt: DateTime(2000, 1, 1, 1),
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getRecentlyUsedStickers(limit: 2);

      expect(result, [sticker1, sticker2]);
    });
  });

  group('getStickersWithEmoji cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given no sticker in local db with ❤️ emoji, When invoked, Should return empty list', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);

      final result = await stickerDb.getStickersWithEmoji('❤️');

      expect(result, []);
    });

    test('Given 1 sticker in local db with ❤️ emoji, When invoked, Should return list of that sticker', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '❤️',
      );

      await stickerDb.putSticker(sticker1);

      final result = await stickerDb.getStickersWithEmoji('❤️');

      expect(result, [sticker1]);
    });

    test(
        'Given multiple stickers in local db with ❤️ emoji, When invoked, Should return list of stickers with ❤️ emoji',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '❤️',
      );

      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack2',
        fileId: 'fileId2',
        emoji: '❤️',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);

      final result = await stickerDb.getStickersWithEmoji('❤️');

      expect(result.contains(sticker1), true);
      expect(result.contains(sticker2), true);
    });
  });

  group('getAllStickersWithPackId cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.myStickers.clear();
        await isar.stickers.clear();
      });
    });

    test('Given there is no sticker with params pack id, When invoked, Should return empty list', () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack2',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getAllStickersWithPackId('packId99');

      expect(result, []);
    });

    test('Given there is a sticker with params pack id, When invoked, Should return list of sticker with that pack id',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack2',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getAllStickersWithPackId('pack2');

      expect(result.contains(sticker2), true);
    });

    test('Given there are stickers with params pack id, When invoked, Should return list of sticker with that pack id',
        () async {
      final sticker1 = StickerCollection(
        id: 'sticker1',
        packId: 'pack1',
        fileId: 'fileId1',
        emoji: '',
      );
      final sticker2 = StickerCollection(
        id: 'sticker2',
        packId: 'pack2',
        fileId: 'fileId2',
        emoji: '',
      );
      final sticker3 = StickerCollection(
        id: 'sticker3',
        packId: 'pack1',
        fileId: 'fileId3',
        emoji: '',
      );

      await stickerDb.putSticker(sticker1);
      await stickerDb.putSticker(sticker2);
      await stickerDb.putSticker(sticker3);

      final result = await stickerDb.getAllStickersWithPackId('pack1');

      expect(result.contains(sticker1), true);
      expect(result.contains(sticker3), true);
    });
  });
}
