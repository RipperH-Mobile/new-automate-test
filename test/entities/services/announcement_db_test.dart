import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

import 'package:uchat/entities/collections/announcement_collection.dart';
import 'package:uchat/entities/services/announcement_db.dart';

void main() {
  late Isar testDb;
  late AnnouncementDb announcementDb;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    testDb = await Isar.open(
      [AnnouncementCollectionSchema],
      directory: '/tmp',
      name: 'test_announcement_db',
    );
    announcementDb = AnnouncementDb(customDbInstance: testDb);
  });

  setUp(() async {
    await testDb.writeTxn(() async {
      await testDb.announcement.clear();
    });
  });

  tearDownAll(() async {
    await testDb.close(deleteFromDisk: true);
  });

  group('putAnnouncements', () {
    test(
        'Given announcements are not exist in local db yet, When putAnnouncements is called with new announcements, Should save new announcements in local db',
        () async {
      // Given
      final announcements = [
        AnnouncementCollection(
          id: 'announcement-1',
          isBroadcasted: true,
          announceAt: DateTime(2023, 1, 1, 1),
          expireAt: DateTime(2023, 1, 2, 1),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
        AnnouncementCollection(
          id: 'announcement-2',
          isBroadcasted: false,
          announceAt: DateTime(2023, 1, 1, 2),
          expireAt: DateTime(2023, 1, 3, 2),
          isUseBroadcast: false,
          deleted: false,
          announceType: 'MAINTENANCE',
        ),
      ];

      // When
      await announcementDb.putAnnouncements(announcements: announcements);

      // Then
      final allAnnouncements = await testDb.announcement.where().findAll();
      expect(allAnnouncements.length, 2);
      expect(allAnnouncements.any((a) => a.id == 'announcement-1'), true);
      expect(allAnnouncements.any((a) => a.id == 'announcement-2'), true);
    });

    test(
        'Given announcements already exist in local db, When putAnnouncements is called with same announcements but with new data, Should save announcements with updated data in local db',
        () async {
      // Given
      final originalAnnouncement = AnnouncementCollection(
        id: 'announcement-1',
        isBroadcasted: true,
        announceAt: DateTime(2023, 1, 1, 1),
        expireAt: DateTime(2023, 1, 2, 1),
        isUseBroadcast: true,
        deleted: false,
        announceType: 'ANNOUNCE',
      );
      await announcementDb.putAnnouncements(announcements: [originalAnnouncement]);

      final updatedAnnouncements = [
        AnnouncementCollection(
          id: 'announcement-1',
          isBroadcasted: false,
          // Changed
          announceAt: DateTime(2023, 1, 1, 1),
          expireAt: DateTime(2023, 1, 2, 1),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
      ];

      // When
      await announcementDb.putAnnouncements(announcements: updatedAnnouncements);

      // Then
      final allAnnouncements = await testDb.announcement.where().findAll();
      expect(allAnnouncements.length, 1);
      expect(allAnnouncements.first.isBroadcasted, false);
    });
  });

  group('getAnnouncement', () {
    test('Given no announcements in local db, When getAnnouncement is called, Should return empty list', () async {
      // When
      final result = await announcementDb.getAnnouncement();

      // Then
      expect(result, isEmpty);
    });

    test('Given announcements exist in local db, When getAnnouncement is called, Should return filtered announcements',
        () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'announcement-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
        AnnouncementCollection(
          id: 'maintenance-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'MAINTENANCE',
        ),
        AnnouncementCollection(
          id: 'expired-announcement',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(days: 2)),
          expireAt: now.subtract(const Duration(hours: 1)),
          // Expired
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
      ];
      await announcementDb.putAnnouncements(announcements: announcements);

      // When
      final result = await announcementDb.getAnnouncement();

      // Then
      expect(result.length, 1);
      expect(result.first.id, equals('announcement-1'));
      expect(result.first.announceType, equals('ANNOUNCE'));
    });

    test('Given only deleted announcements exist, When getAnnouncement is called, Should return empty list', () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'deleted-announcement',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: true,
          // Deleted
          announceType: 'ANNOUNCE',
        ),
      ];
      await announcementDb.putAnnouncements(announcements: announcements);

      // When
      final result = await announcementDb.getAnnouncement();

      // Then
      expect(result, isEmpty);
    });
  });

  group('getMaintenance', () {
    test('Given no maintenance announcements in local db, When getMaintenance is called, Should return null', () async {
      // When
      final result = await announcementDb.getMaintenance();

      // Then
      expect(result, isNull);
    });

    test(
        'Given maintenance announcements exist in local db, When getMaintenance is called, Should return maintenance announcement',
        () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'maintenance-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'MAINTENANCE',
        ),
        AnnouncementCollection(
          id: 'maintenance-2',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 2)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'MAINTENANCE',
        ),
      ];
      await announcementDb.putAnnouncements(announcements: announcements);

      // When
      final result = await announcementDb.getMaintenance();

      // Then
      expect(result, isNotNull);
      expect(result?.id, equals('maintenance-2')); // Should return the earliest one (sorted by announceAt ascending)
      expect(result?.announceType, equals('MAINTENANCE'));
    });
  });

  group('getCoinPromotion', () {
    test('Given no coin promotions in local db, When getCoinPromotion is called, Should return empty list', () async {
      // When
      final result = await announcementDb.getCoinPromotion();

      // Then
      expect(result, isEmpty);
    });

    test('Given coin promotions exist in local db, When getCoinPromotion is called, Should return coin promotions',
        () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'coin-promo-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'COIN',
        ),
        AnnouncementCollection(
          id: 'coin-promo-2',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 2)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'COIN',
        ),
      ];
      await announcementDb.putAnnouncements(announcements: announcements);

      // When
      final result = await announcementDb.getCoinPromotion();

      // Then
      expect(result.length, 1); // Limited to 1
      expect(result.first.announceType, equals('COIN'));
    });
  });

  group('getCoinAds', () {
    test('Given no coin ads in local db, When getCoinAds is called, Should return empty list', () async {
      // When
      final result = await announcementDb.getCoinAds();

      // Then
      expect(result, isEmpty);
    });

    test('Given coin ads exist in local db, When getCoinAds is called, Should return coin ads', () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'coin-ad-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 2)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'COIN_ADS',
        ),
      ];
      await announcementDb.putAnnouncements(announcements: announcements);

      // When
      final result = await announcementDb.getCoinAds();

      // Then
      expect(result.length, 1);
      expect(result.first.announceType, equals('COIN_ADS'));
    });
  });

  group('Integration Tests', () {
    test('Given announcements with different types, When query by type, Then returns correct filtered results',
        () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'announce-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
        AnnouncementCollection(
          id: 'maintenance-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'MAINTENANCE',
        ),
        AnnouncementCollection(
          id: 'coin-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'COIN',
        ),
        AnnouncementCollection(
          id: 'coin-ad-1',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 2)),
          expireAt: now.add(const Duration(days: 1)),
          isUseBroadcast: true,
          deleted: false,
          announceType: 'COIN_ADS',
        ),
      ];

      // When - Save announcements
      await announcementDb.putAnnouncements(announcements: announcements);

      // Then - Query by type and verify
      final retrievedAnnouncements = await announcementDb.getAnnouncement();
      final maintenance = await announcementDb.getMaintenance();
      final coinPromotions = await announcementDb.getCoinPromotion();
      final coinAds = await announcementDb.getCoinAds();

      expect(retrievedAnnouncements.length, 1);
      expect(retrievedAnnouncements.first.announceType, equals('ANNOUNCE'));

      expect(maintenance, isNotNull);
      expect(maintenance?.announceType, equals('MAINTENANCE'));

      expect(coinPromotions.length, 1);
      expect(coinPromotions.first.announceType, equals('COIN'));

      expect(coinAds.length, 1);
      expect(coinAds.first.announceType, equals('COIN_ADS'));
    });

    test('Given expired announcements, When querying, Then only returns non-expired announcements', () async {
      // Given
      final now = DateTime.now();
      final announcements = [
        AnnouncementCollection(
          id: 'expired-announcement',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(days: 2)),
          expireAt: now.subtract(const Duration(hours: 1)),
          // Expired
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
        AnnouncementCollection(
          id: 'valid-announcement',
          isBroadcasted: true,
          announceAt: now.subtract(const Duration(hours: 1)),
          expireAt: now.add(const Duration(days: 1)),
          // Still valid
          isUseBroadcast: true,
          deleted: false,
          announceType: 'ANNOUNCE',
        ),
      ];

      // When - Save announcements
      await announcementDb.putAnnouncements(announcements: announcements);

      // Then - Should only return non-expired
      final result = await announcementDb.getAnnouncement();
      expect(result.length, 1);
      expect(result.first.id, equals('valid-announcement'));
    });
  });
}
