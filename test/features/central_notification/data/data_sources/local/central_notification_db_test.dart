import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/central_notification/data/data_source/local/central_notification_db.dart';
import 'package:uchat/features/central_notification/data/model/central_notification_data_model.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late Isar isar;
  late CentralNotificationDb centralNotiDb;
  late MockLoggerService mockLoggerService;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [CentralNotificationCollectionSchema],
      directory: './',
      name: 'central_notification_db_test',
    );

    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    centralNotiDb = CentralNotificationDb(customDbInstance: isar);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.centralNotification.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('deleteCentralNotiOnDb cases', () {
    test('Given some central noti in local db, When invoked with id, Should remove that central noti', () async {
      // Given
      final centralNoti1 = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );
      final centralNoti2 = CentralNotificationCollection(
        id: 'centralNotiId2',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 2),
      );
      await centralNotiDb.putAllCentralNoti([centralNoti1, centralNoti2]);

      // When
      await centralNotiDb.deleteCentralNotiOnDb('centralNotiId1');

      // Then
      final fetchedCentralNoti1 = await centralNotiDb.getCentralNoti(centralNoti1.id!);
      final fetchedCentralNoti2 = await centralNotiDb.getCentralNoti(centralNoti2.id!);
      expect(fetchedCentralNoti1, isNull);
      expect(fetchedCentralNoti2, centralNoti2);
    });
  });

  group('getAllCentralNoti cases', () {
    test('Given no central noti in local db, When invoked, Should return empty list', () async {
      // When
      final centralNotiList = await centralNotiDb.getAllCentralNoti();

      // Then
      expect(centralNotiList, isEmpty);
    });

    test('Given some central noti in local db, when invoked, Should return all central noti sorted by createdAt',
        () async {
      // Given
      final centralNoti1 = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );
      final centralNoti2 = CentralNotificationCollection(
        id: 'centralNotiId2',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 2),
      );
      final centralNoti3 = CentralNotificationCollection(
        id: 'centralNotiId3',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 3),
      );
      await centralNotiDb.putAllCentralNoti([centralNoti1, centralNoti2, centralNoti3]);

      // When
      final centralNotiList = await centralNotiDb.getAllCentralNoti();

      // Then
      expect(centralNotiList, [centralNoti3, centralNoti2, centralNoti1]);
    });
  });

  group('getCentralNoti cases', () {
    test('Given no central noti in local db, When invoked, Should return null', () async {
      // When
      final centralNoti = await centralNotiDb.getCentralNoti('someId');

      // Then
      expect(centralNoti, isNull);
    });

    test('Given some central noti in local db, When invoked with id, Should return central noti with that id',
        () async {
      // Given
      final centralNoti1 = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );
      final centralNoti2 = CentralNotificationCollection(
        id: 'centralNotiId2',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 2),
      );
      await centralNotiDb.putAllCentralNoti([centralNoti1, centralNoti2]);

      // When
      final fetchedCentralNoti = await centralNotiDb.getCentralNoti('centralNotiId2');

      // Then
      expect(fetchedCentralNoti, centralNoti2);
    });
  });

  group('putAllCentralNoti cases', () {
    test('Given some central noti, When invoked, Should store all central noti in local db', () async {
      // Given
      final centralNoti1 = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );
      final centralNoti2 = CentralNotificationCollection(
        id: 'centralNotiId2',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 2),
      );

      // When
      await centralNotiDb.putAllCentralNoti([centralNoti1, centralNoti2]);

      // Then
      final fetchedCentralNoti1 = await centralNotiDb.getCentralNoti(centralNoti1.id!);
      final fetchedCentralNoti2 = await centralNotiDb.getCentralNoti(centralNoti2.id!);
      expect(fetchedCentralNoti1, centralNoti1);
      expect(fetchedCentralNoti2, centralNoti2);
    });
  });

  group('putAllCentralNotiWithoutTxn cases', () {
    test('Given some central noti, When invoked, Should store all central noti in local db', () async {
      // Given
      final centralNoti1 = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );
      final centralNoti2 = CentralNotificationCollection(
        id: 'centralNotiId2',
        notiType: CentralNotiType.acceptFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 2),
      );

      // When
      await centralNotiDb.customDbInstance?.writeTxn(() async {
        await centralNotiDb.putAllCentralNotiWithoutTxn([centralNoti1, centralNoti2]);
      });

      // Then
      final fetchedCentralNoti1 = await centralNotiDb.getCentralNoti(centralNoti1.id!);
      final fetchedCentralNoti2 = await centralNotiDb.getCentralNoti(centralNoti2.id!);
      expect(fetchedCentralNoti1, centralNoti1);
      expect(fetchedCentralNoti2, centralNoti2);
    });
  });

  group('putCentralNoti cases', () {
    test('Given no central noti in local db, When invoked with new data, Should save new data into local db', () async {
      // Given
      final centralNoti = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        createdAt: DateTime(2000, 1, 1, 1),
      );

      // When
      await centralNotiDb.putCentralNoti(centralNoti);

      // Then
      final fetchedCentralNoti = await centralNotiDb.getCentralNoti(centralNoti.id!);
      expect(fetchedCentralNoti, centralNoti);
    });

    test(
        'Given central noti already in local db, When invoked with that central noti with updated data, Should save new data into local db',
        () async {
      // Given
      final centralNoti = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        data: CentralNotificationDataModel(
          displayName: 'displayName1',
        ),
        createdAt: DateTime(2000, 1, 1, 1),
      );
      await centralNotiDb.putCentralNoti(centralNoti);

      final updatedCentralNoti = CentralNotificationCollection(
        id: 'centralNotiId1',
        notiType: CentralNotiType.newFriend,
        historyForAccountId: 'accountId1',
        data: CentralNotificationDataModel(
          displayName: 'displayNameA',
        ),
        createdAt: DateTime(2000, 1, 1, 1),
      );

      // When
      await centralNotiDb.putCentralNoti(updatedCentralNoti);

      // Then
      final fetchedCentralNoti = await centralNotiDb.getCentralNoti(centralNoti.id!);
      expect(fetchedCentralNoti, updatedCentralNoti);
      expect(fetchedCentralNoti?.data?.displayName, 'displayNameA');
    });
  });
}
