import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/chat_folder_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  late Isar isar;
  late RoomSubscriptionDb roomSubscriptionDb;
  late MockLoggerService mockLoggerService;
  late MockUserController mockUserController;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [RoomSubscriptionCollectionSchema],
      directory: './',
      name: 'room_subscription_db',
    );

    roomSubscriptionDb = RoomSubscriptionDb(customDbInstance: isar);
    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);

    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockUserController);

    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);

    // Set up for currentUser call in message mixin to work.
    when(() => mockUserController.currentUser).thenReturn(
      UserEntity(
        id: 'userId1',
        username: 'user1',
        displayName: 'User 1',
        phoneNumber: '0892345678',
      ).obs,
    );
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.roomSubscription.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('getRoomSubscriptionWithId cases', () {
    test('Given empty local db, When invoke with not exist room sub id, Should return null', () async {
      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');

      // Then
      expect(result, null);
    });

    test('Given some room sub in local db, When invoke existing room sub id, Should return that room sub', () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);

      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');

      // Then
      expect(result, roomSub);
    });
  });

  group('getRoomSubscriptionWithRoomId cases', () {
    test('Given empty local db, When invoke with not exist room id, Should return null', () async {
      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionWithRoomId('roomId1');

      // Then
      expect(result, null);
    });

    test('Given some room sub in local db, When invoke existing room id, Should return that room sub', () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);

      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionWithRoomId('roomId1');

      // Then
      expect(result, roomSub);
    });
  });

  group('getRoomSubscriptionWithRoomIdSync cases', () {
    test('Given empty local db, When invoke with not exist room id, Should return null', () async {
      // When
      final result = roomSubscriptionDb.getRoomSubscriptionWithRoomIdSync('roomId1');

      // Then
      expect(result, null);
    });

    test('Given some room sub in local db, When invoke existing room id, Should return that room sub', () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);

      // When
      final result = roomSubscriptionDb.getRoomSubscriptionWithRoomIdSync('roomId1');

      // Then
      expect(result, roomSub);
    });
  });

  group('putRoomSubscription cases', () {
    test(
        'Given room sub is not exist in local db yet, When invoked with new room sub, Should save new room sub in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      final result = await roomSubscriptionDb.putRoomSubscription(roomSub);

      // Then
      expect(result, roomSub);
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, roomSub);
    });

    test(
        'Given room sub is already exist in local db, When invoked with same room sub but with new data, Should save room sub with updated data in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);
      final newRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      final result = await roomSubscriptionDb.putRoomSubscription(newRoomSub);

      // Then
      expect(result, correctRoomSub);
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, correctRoomSub);
    });

    test(
        'Given room sub is already exist in local db, When invoked with same room sub but with new data and replaceData is true, Should save new room sub in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(message: 'hello', id: 'message1'),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);
      final newRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      final result = await roomSubscriptionDb.putRoomSubscription(newRoomSub, replaceData: true);

      // Then
      expect(result, newRoomSub);
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, newRoomSub);
    });
  });

  group('putRoomSubscriptionWithoutTxn cases', () {
    test(
        'Given room sub is not exist in local db yet, When invoked with new room sub, Should save new room sub in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        final result = await roomSubscriptionDb.putRoomSubscriptionWithoutTxn(roomSub);

        expect(result, roomSub);
      });

      // Then
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, roomSub);
    });

    test(
        'Given room sub is already exist in local db, When invoked with same room sub but with new data, Should save room sub with updated data in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);
      final newRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        final result = await roomSubscriptionDb.putRoomSubscriptionWithoutTxn(newRoomSub);
        expect(result, correctRoomSub);
      });

      // Then
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, correctRoomSub);
    });

    test(
        'Given room sub is already exist in local db, When invoked with same room sub but with new data and replaceData is true, Should save new room sub in local db and return that new room sub',
        () async {
      // Given
      final roomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(message: 'hello', id: 'message1'),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub);
      final newRoomSub = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        final result = await roomSubscriptionDb.putRoomSubscriptionWithoutTxn(newRoomSub, replaceData: true);

        expect(result, newRoomSub);
      });

      // Then
      final fetchedRoomSub = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub, newRoomSub);
    });
  });

  group('updateAllRoomSubscription cases', () {
    test(
        'Given some room sub already exist in local db, When invoked with already exist and new room sub, Should update existing room sub and add new room sub to local db',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);

      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newRoomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.updateAllRoomSubscription([newRoomSub1, roomSub2]);

      // Then
      final roomSub1Result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(roomSub1Result, newRoomSub1);
      final roomSub2Result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId2');
      expect(roomSub2Result, roomSub2);
    });
  });

  group('updateAllRoomSubscriptionWithoutTxn cases', () {
    test(
        'Given some room sub already exist in local db, When invoked with already exist and new room sub, Should update existing room sub and add new room sub to local db',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);

      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newRoomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        await roomSubscriptionDb.updateAllRoomSubscriptionWithoutTxn([newRoomSub1, roomSub2]);
      });

      // Then
      final roomSub1Result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(roomSub1Result, newRoomSub1);
      final roomSub2Result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId2');
      expect(roomSub2Result, roomSub2);
    });
  });

  group('putAllRoomSub cases', () {
    test(
        'Given some roomSub already exist in local db, When invoked with already exist room sub with new data and new room sub, Should replace existing room sub with new room sub and add new room sub to local db',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(message: 'hello', id: 'message1'),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);
      final newRoomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      final count = await roomSubscriptionDb.putAllRoomSub([newRoomSub1, roomSub2]);
      expect(count, 2);

      // Then
      final fetchedRoomSub1 = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub1, newRoomSub1);
      final fetchedRoomSub2 = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId2');
      expect(fetchedRoomSub2, roomSub2);
    });
  });

  group('putAllRoomSubWithoutTxn cases', () {
    test(
        'Given some roomSub already exist in local db, When invoked with already exist room sub with new data and new room sub, Should replace existing room sub with new room sub and add new room sub to local db',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(message: 'hello', id: 'message1'),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);
      final newRoomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room A',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        final count = await roomSubscriptionDb.putAllRoomSubWithoutTxn([newRoomSub1, roomSub2]);
        expect(count, 2);
      });

      // Then
      final fetchedRoomSub1 = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(fetchedRoomSub1, newRoomSub1);
      final fetchedRoomSub2 = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId2');
      expect(fetchedRoomSub2, roomSub2);
    });
  });

  group('getRoomSubscriptionWithIdsSync cases', () {
    test('Given empty local db, When invoked with not exist room sub ids, Should return empty list', () async {
      // When
      final result = roomSubscriptionDb.getRoomSubscriptionWithIdsSync(['roomSubId1', 'roomSubId2']);

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked with existing room sub ids, Should return those room subs sort by roomLocalDateTime',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(
          message: 'hello2',
          id: 'message2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = roomSubscriptionDb.getRoomSubscriptionWithIdsSync(['roomId1', 'roomId2']);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with existing room sub ids and desc is true, Should return those room subs sort by roomLocalDateTime desc',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        lastMessage: MessageModel(
          message: 'hello2',
          id: 'message2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = roomSubscriptionDb.getRoomSubscriptionWithIdsSync(['roomId1', 'roomId2'], desc: true);

      // Then
      expect(result, [roomSub2, roomSub1]);
    });
  });

  group('getAllUnreadCount cases', () {
    test('Given no room sub in local db, When invoked, Should return 0', () async {
      // When
      final result = await roomSubscriptionDb.getAllUnreadCount();

      // Then
      expect(result, 0);
    });

    test('Given some room sub in local db, When invoked, Should return sum of unread count', () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isRoomDeleted: false,
        isHidden: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 3,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isHidden: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getAllUnreadCount();

      // Then
      expect(result, 8);
    });

    test('Given some room sub in local db, When invoked, Should return sum of unread count excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isRoomDeleted: false,
        isHidden: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 3,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isHidden: false,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 8,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isHidden: false,
        isRoomDeleted: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getAllUnreadCount();

      // Then
      expect(result, 8);
    });

    test('Given some room sub in local db, When invoked, Should return sum of unread count excluding hidden room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isRoomDeleted: false,
        isHidden: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 3,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isHidden: false,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 8,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        isHidden: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getAllUnreadCount();

      // Then
      expect(result, 8);
    });
  });

  group('getRoomCanShowInShare cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare();

      // Then
      expect(result, isEmpty);
    });

    test('Given some room sub in local db, When invoked, Should return list of room sub that can be shared to',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare();

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db and some room is direct room of deleted user, When invoked, Should return list of room sub that can be shared to',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare();

      // Then
      expect(result, [roomSub2]);
    });

    test(
        'Given some room sub in local db and some room is direct room of blocked user, When invoked, Should return list of room sub that can be shared to',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: true,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare();

      // Then
      expect(result, [roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with pageSize, Should return list of room sub that can be shared to without exceeding the pageSize',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare(pageSize: 1);

      // Then
      expect(result, [roomSub1]);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that can be shared to sort by roomLocalDateTime',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello2',
          id: 'message2',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare();

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with pageSize, Should return list of room sub that can be shared to sort by roomLocalDateTime without exceeding pageSize',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello2',
          id: 'message2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello3',
          id: 'message3',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare(page: 1, pageSize: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with page 2 and pageSize, Should return list of room sub that can be shared to sort by roomLocalDateTime without exceeding pageSize',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello2',
          id: 'message2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello3',
          id: 'message3',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getRoomCanShowInShare(page: 2, pageSize: 2);

      // Then
      expect(result, [roomSub3]);
    });
  });

  group('getRecentDirectChat cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getRecentDirectChat();

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of direct room sub that can be shared to sorted by roomLocalDateTime',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat();

      // Then
      expect(result, [roomSub1, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with limit, Should return list of direct room sub that can be shared to sorted by roomLocalDateTime without exceeding limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(limit: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with offset, Should return list of direct room sub that can be shared to sorted by roomLocalDateTime offset by the given offset',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(offset: 2);

      // Then
      expect(result, [roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with limit and offset, Should return list of direct room sub that can be shared to sorted by roomLocalDateTime offset by the given offset without exceeding limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(limit: 2, offset: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with keyword, Should return list of direct room sub that can be shared to and room name contain keyword sorted by roomLocalDateTime',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(keyword: 'aaa');

      // Then
      expect(result, [roomSub4, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with keyword and limit, Should return list of direct room sub that can be shared to and room name contain keyword sorted by roomLocalDateTime without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(keyword: 'aaa', limit: 2);

      // Then
      expect(result, [roomSub5, roomSub4]);
    });

    test(
        'Given some room sub in local db, When invoked with keyword and offset, Should return list of direct room sub that can be shared to and room name contain keyword sorted by roomLocalDateTime offset by the given offset',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(keyword: 'aaa', offset: 2);

      // Then
      expect(result, [roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with keyword, limit and offset, Should return list of direct room sub that can be shared to and room name contain keyword sorted by roomLocalDateTime offset by the given offset without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5aaa',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isDirectChatFriend: true,
        lastMessage: MessageModel(
          message: 'hello',
          id: 'message1',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getRecentDirectChat(keyword: 'aaa', limit: 2, offset: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });
  });

  group('searchRoomCanShowInShareSync cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = roomSubscriptionDb.searchRoomCanShowInShareSync('keyword');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that can be shared to and room name contain keyword',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'number 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = roomSubscriptionDb.searchRoomCanShowInShareSync('room');

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some empty direct or blocked room sub in local db, When invoked, Should return list of room sub that can be shared to and room name contain keyword',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
        isDirectChatBlocked: false,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When
      final result = roomSubscriptionDb.searchRoomCanShowInShareSync('room');

      // Then
      expect(result, [roomSub1, roomSub2]);
    });

    test(
        'Given some room sub in local db, When invoked with limit, Should return list of room sub that can be shared to and room name contain keyword without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = roomSubscriptionDb.searchRoomCanShowInShareSync('room', limit: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });
  });

  group('getRoomForSharePreview cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getRoomForSharePreview();

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that can be show in share preview sorted by latest share',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomForSharePreview();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3, roomSub4]);
    });

    test(
        'Given some room sub isDeleted is true in local db, When invoked, Should return list of room sub that can be show in share preview sorted by latest share excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isRoomDeleted: true,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomForSharePreview();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub4]);
    });

    test(
        'Given some room sub in local db, When invoked with limit, Should return list of room sub that can be show in share preview sorted by latest share without exceeding limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomForSharePreview(limit: 2);

      // Then
      expect(result, [roomSub1, roomSub2]);
    });
  });

  group('getRoomLatestShareSync cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = roomSubscriptionDb.getRoomLatestShareSync();

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.getRoomLatestShareSync();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some deleted room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isRoomDeleted: true,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.getRoomLatestShareSync();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with limit Should return list of room sub that has latestShare value sorted by latest share without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.getRoomLatestShareSync(limit: 2);

      // Then
      expect(result, [roomSub4, roomSub1]);
    });
  });

  group('getRoomLatestShare cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getRoomLatestShare();

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomLatestShare();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some deleted room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isRoomDeleted: true,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomLatestShare();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with limit Should return list of room sub that has latestShare value sorted by latest share without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomLatestShare(limit: 2);

      // Then
      expect(result, [roomSub4, roomSub1]);
    });
  });

  group('searchRoomLatestShareSync cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = roomSubscriptionDb.searchRoomLatestShareSync('keyword');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.searchRoomLatestShareSync('room');

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some deleted room sub in local db, When invoked, Should return list of room sub that has latestShare value sorted by latest share excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isRoomDeleted: true,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.searchRoomLatestShareSync('room');

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked with limit Should return list of room sub that has latestShare value sorted by latest share without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = roomSubscriptionDb.searchRoomLatestShareSync('room', limit: 2);

      // Then
      expect(result, [roomSub4, roomSub1]);
    });

    test(
        'Given some room sub do not have room name in local db, When invoked with limit Should return list of room sub that has latestShare value sorted by latest share including those without room name',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 3),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        latestShare: DateTime(2000, 1, 1, 2),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 1),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 4),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        latestShare: DateTime(2000, 1, 1, 5),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When

      final result = roomSubscriptionDb.searchRoomLatestShareSync('a');

      // Then
      expect(result, [roomSub5, roomSub4, roomSub3]);
    });
  });

  group('getAllHiddenRoomSub cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getAllHiddenRoomSub();

      // Then
      expect(result, isEmpty);
    });

    test('Given some room sub in local db, When invoked, Should return list of hidden room sub sorted by hiddenAt',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 3),
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 2),
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When

      final result = await roomSubscriptionDb.getAllHiddenRoomSub();

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });

    test(
        'Given some deleted room sub in local db, When invoked, Should return list of hidden room sub sorted by hiddenAt excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        isRoomDeleted: true,
        hiddenAt: DateTime(2000, 1, 1, 3),
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 2),
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 4),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When

      final result = await roomSubscriptionDb.getAllHiddenRoomSub();

      // Then
      expect(result, [roomSub2, roomSub3]);
    });
  });

  group('getRoomSubTypeGroup cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getRoomSubTypeGroup();

      // Then
      expect(result, isEmpty);
    });

    test('Given some room sub in local db, When invoked, Should return list of group room sub excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When

      final result = await roomSubscriptionDb.getRoomSubTypeGroup();

      // Then
      expect(result.contains(roomSub1), false);
      expect(result.contains(roomSub2), true);
      expect(result.contains(roomSub3), true);
      expect(result.contains(roomSub4), false);
    });
  });

  group('searchRoomTypeGroup cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.searchRoomTypeGroup(keyword: 'room');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of group room sub excluding deleted or hidden room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 5),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When

      final result = await roomSubscriptionDb.searchRoomTypeGroup(keyword: 'a');

      // Then
      expect(result, [roomSub2, roomSub3]);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of group room sub sorted by name lowercase then name then id',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room b',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room c',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When

      final result = await roomSubscriptionDb.searchRoomTypeGroup(keyword: 'room');

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);
    });

    test(
        'Given some room sub in local db, When invoked with limit, Should return list of group room sub sorted by name lowercase then name then id without exceeding the limit',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'room a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room b',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room c',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When

      final result = await roomSubscriptionDb.searchRoomTypeGroup(keyword: 'room', limit: 3);

      // Then
      expect(result, [roomSub1, roomSub2, roomSub3]);
    });
  });

  group('searchRoomTypeDirects cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.searchRoomTypeDirects('room');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of direct room sub excluding deleted, hidden or room without message sorted by roomLocalDateTime',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isDirectChatBlocked: false,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId5',
          message: 'message 5',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 5),
        lastMessage: MessageModel(
          id: 'messageId6',
          message: 'message 6',
          createdAt: DateTime(2000, 1, 1, 6),
        ),
      );
      final roomSub7 = RoomSubscriptionCollection(
        id: 'roomSubId7',
        roomId: 'roomId7',
        roomName: 'Room 7a',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isHidden: true,
        hiddenAt: DateTime(2000, 1, 1, 5),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6, roomSub7]);

      // When

      final result = await roomSubscriptionDb.searchRoomTypeDirects('a');

      // Then
      expect(result, [roomSub3, roomSub2]);
    });
  });

  group('getAllRoomSubByChatFolderId cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getAllRoomSubByChatFolderId(chatFolderId: 'folderId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When Invoked with chatFolderId, Should return list of room sub with matching chatFolderId excluding deleted room',
        () async {
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [],
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When

      final result = await roomSubscriptionDb.getAllRoomSubByChatFolderId(chatFolderId: 'folderId1');

      // Then
      expect(result.contains(roomSub1), true);
      expect(result.contains(roomSub2), false);
      expect(result.contains(roomSub3), false);
      expect(result.contains(roomSub4), false);
      expect(result.contains(roomSub5), true);
      expect(result.contains(roomSub6), false);
    });

    test(
        'Given some room sub in local db, When Invoked with chatFolderId and isPinned is false, Should return list of room sub with matching chatFolderId excluding deleted room',
        () async {
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [],
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When

      final result = await roomSubscriptionDb.getAllRoomSubByChatFolderId(
        chatFolderId: 'folderId1',
        isPinned: false,
      );

      // Then
      expect(result.contains(roomSub1), true);
      expect(result.contains(roomSub2), false);
      expect(result.contains(roomSub3), false);
      expect(result.contains(roomSub4), false);
      expect(result.contains(roomSub5), false);
      expect(result.contains(roomSub6), false);
    });

    test(
        'Given some room sub in local db, When Invoked with chatFolderId and isPinned is true, Should return list of room sub with matching chatFolderId excluding deleted room',
        () async {
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [],
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When

      final result = await roomSubscriptionDb.getAllRoomSubByChatFolderId(
        chatFolderId: 'folderId1',
        isPinned: true,
      );

      // Then
      expect(result.contains(roomSub1), false);
      expect(result.contains(roomSub2), false);
      expect(result.contains(roomSub3), false);
      expect(result.contains(roomSub4), false);
      expect(result.contains(roomSub5), true);
      expect(result.contains(roomSub6), false);
    });
  });

  group('searchRoomCanEdit cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.searchRoomCanEdit('room');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of room sub that has message and room name contain keyword excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3]);

      // When
      final result = await roomSubscriptionDb.searchRoomCanEdit('room');

      // Then
      expect(result, [roomSub1]);
    });
  });

  group('getAllRoom cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getAllRoom();

      // Then
      expect(result, isEmpty);
    });

    test('Given some room sub in local db, When invoked, Should return list of room sub that can show in chat list',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isLocalDeleting: true,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.bookmark,
        hasFirstOtherInRoom: true,
        isLocalDeleting: true,
        lastMessage: MessageModel(
          id: 'messageId5',
          message: 'message 5',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getAllRoom();

      // Then
      expect(result.contains(roomSub1), true);
      expect(result.contains(roomSub2), true);
      expect(result.contains(roomSub3), false);
      expect(result.contains(roomSub4), false);
      expect(result.contains(roomSub5), false);
    });

    test(
        'Given some room sub in local db, When invoked with enableBookmark true, Should return list of room sub that can show in chat list',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isLocalDeleting: true,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.bookmark,
        hasFirstOtherInRoom: true,
        isLocalDeleting: true,
        lastMessage: MessageModel(
          id: 'messageId5',
          message: 'message 5',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getAllRoom();

      // Then
      expect(result.contains(roomSub1), true);
      expect(result.contains(roomSub2), true);
      expect(result.contains(roomSub3), false);
      expect(result.contains(roomSub4), false);
      expect(result.contains(roomSub5), false);
    });
  });

  group('getLatestDirectChatRooms cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getLatestDirectChatRooms();

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return list of direct chat sorted by roomLocalDateTime excluding deleted room without exceeding the limit',
        () async {
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4]);

      // When
      final result = await roomSubscriptionDb.getLatestDirectChatRooms();

      // Then
      expect(result, [roomSub2, roomSub1]);
    });

    test(
        'Given some room sub in local db, When invoked with limit, Should return list of direct chat sorted by roomLocalDateTime excluding deleted room without exceeding the limit',
        () async {
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 1),
        ),
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId2',
          message: 'message 2',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId3',
          message: 'message 3',
          createdAt: DateTime(2000, 1, 1, 3),
        ),
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
        lastMessage: MessageModel(
          id: 'messageId4',
          message: 'message 4',
          createdAt: DateTime(2000, 1, 1, 4),
        ),
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId5',
          message: 'message 5',
          createdAt: DateTime(2000, 1, 1, 5),
        ),
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5]);

      // When
      final result = await roomSubscriptionDb.getLatestDirectChatRooms(limit: 2);

      // Then
      expect(result, [roomSub5, roomSub2]);
    });
  });

  group('deleteRoomSubWithRoomId cases', () {
    test(
        'Given some room sub in local db, When invoked with roomId, Should set isLocalDeleting and lastMessage of that room to false and null respectively',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);

      // When
      await roomSubscriptionDb.deleteRoomSubWithRoomId('roomId1');

      // Then
      final result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(result, isNull);
    });
  });

  group('deleteRoomSubWithRoomIdWithoutTxn cases', () {
    test(
        'Given some room sub in local db, When invoked with roomId, Should set isLocalDeleting and lastMessage of that room to false and null respectively',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        lastMessage: MessageModel(
          id: 'messageId1',
          message: 'message 1',
          createdAt: DateTime(2000, 1, 1, 2),
        ),
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);

      // When
      await roomSubscriptionDb.customDbInstance?.writeTxn(() async {
        await roomSubscriptionDb.deleteRoomSubWithRoomIdWithoutTxn('roomId1');
      });

      // Then
      final result = await roomSubscriptionDb.getRoomSubscriptionWithId('roomSubId1');
      expect(result, isNull);
    });
  });

  group('countPinedRoomAllChat cases', () {
    test('Given no room sub in local db, When invoked, Should return 0', () async {
      // When
      final result = await roomSubscriptionDb.countPinedRoomAllChat();

      // Then
      expect(result, 0);
    });

    test(
        'Given some room sub in local db, When invoked with roomId, Should return count of pinned room excluding deleted room and secret room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isPinned: false,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        isRoomDeleted: true,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When
      final result = await roomSubscriptionDb.countPinedRoomAllChat();

      // Then
      expect(result, 2);
    });
  });

  group('countPinedRoomInFolder cases', () {
    test('Given no room sub in local db, When invoked, Should return 0', () async {
      // When
      final result = await roomSubscriptionDb.countPinedRoomInFolder();

      // Then
      expect(result, 0);
    });

    test(
        'Given some room sub in local db, When invoked with roomId, Should return count of pinned room in chat folder excluding deleted room and secret room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isPinned: false,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: true,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub7 = RoomSubscriptionCollection(
        id: 'roomSubId7',
        roomId: 'roomId7',
        roomName: 'Room 7',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 7),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub8 = RoomSubscriptionCollection(
        id: 'roomSubId8',
        roomId: 'roomId8',
        roomName: 'Room 8',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 8),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [],
      );
      await roomSubscriptionDb
          .putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6, roomSub7, roomSub8]);

      // When
      final result = await roomSubscriptionDb.countPinedRoomInFolder();

      // Then
      expect(result, 3);
    });
  });

  group('getAllUnreadRoom cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getAllUnreadRoom();

      // Then
      expect(result, isEmpty);
    });

    test('Given some room sub in local db, When invoked with roomId, Should return all unread room', () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 1,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 2,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isRoomDeleted: true,
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 3,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 5,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 6,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
      );
      await roomSubscriptionDb.putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6]);

      // When
      final result = await roomSubscriptionDb.getAllUnreadRoom();

      // Then
      expect(result?.contains(roomSub1), true);
      expect(result?.contains(roomSub2), true);
      expect(result?.contains(roomSub3), true);
      expect(result?.contains(roomSub4), false);
      expect(result?.contains(roomSub5), true);
      expect(result?.contains(roomSub6), true);
    });
  });

  group('getRoomSubscriptionByRoomAndAccount cases', () {
    test('Given no room sub in local db, When invoked, Should return null', () async {
      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionByRoomAndAccount('roomId1', 'accountId1');

      // Then
      expect(result, isNull);
    });

    test('Given some room sub in local db, When invoked, Should return null', () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
      );
      await roomSubscriptionDb.putRoomSubscription(roomSub1);

      // When
      final result = await roomSubscriptionDb.getRoomSubscriptionByRoomAndAccount('roomId1', 'accountId1');

      // Then
      expect(result, roomSub1);
    });
  });

  group('getAllRoomSubscriptionByChatFolder cases', () {
    test('Given no room sub in local db, When invoked, Should return empty list', () async {
      // When
      final result = await roomSubscriptionDb.getAllRoomSubscriptionByChatFolder(chatFolderId: 'folderId1');

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given some room sub in local db, When invoked, Should return all room sub with matching folderId excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: true,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub7 = RoomSubscriptionCollection(
        id: 'roomSubId7',
        roomId: 'roomId7',
        roomName: 'Room 7',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 7),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub8 = RoomSubscriptionCollection(
        id: 'roomSubId8',
        roomId: 'roomId8',
        roomName: 'Room 8',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 8),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [],
      );

      await roomSubscriptionDb
          .putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6, roomSub7, roomSub8]);

      // When
      final result = await roomSubscriptionDb.getAllRoomSubscriptionByChatFolder(chatFolderId: 'folderId1');

      // Then
      expect(result?.contains(roomSub1), true);
      expect(result?.contains(roomSub2), true);
      expect(result?.contains(roomSub3), true);
      expect(result?.contains(roomSub4), false);
      expect(result?.contains(roomSub5), false);
      expect(result?.contains(roomSub6), false);
      expect(result?.contains(roomSub7), false);
      expect(result?.contains(roomSub8), false);
    });

    test(
        'Given some room sub in local db, When invoked with isPinned true, Should return all room sub with matching folderId and pinned excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: true,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub7 = RoomSubscriptionCollection(
        id: 'roomSubId7',
        roomId: 'roomId7',
        roomName: 'Room 7',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 7),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub8 = RoomSubscriptionCollection(
        id: 'roomSubId8',
        roomId: 'roomId8',
        roomName: 'Room 8',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 8),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [],
      );

      await roomSubscriptionDb
          .putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6, roomSub7, roomSub8]);

      // When
      final result = await roomSubscriptionDb.getAllRoomSubscriptionByChatFolder(
        chatFolderId: 'folderId1',
        isPinned: true,
      );

      // Then
      expect(result?.contains(roomSub1), true);
      expect(result?.contains(roomSub2), false);
      expect(result?.contains(roomSub3), false);
      expect(result?.contains(roomSub4), false);
      expect(result?.contains(roomSub5), false);
      expect(result?.contains(roomSub6), false);
      expect(result?.contains(roomSub7), false);
      expect(result?.contains(roomSub8), false);
    });

    test(
        'Given some room sub in local db, When invoked with isPinned false, Should return all room sub with matching folderId and not pinned excluding deleted room',
        () async {
      // Given
      final roomSub1 = RoomSubscriptionCollection(
        id: 'roomSubId1',
        roomId: 'roomId1',
        roomName: 'Room 1',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub2 = RoomSubscriptionCollection(
        id: 'roomSubId2',
        roomId: 'roomId2',
        roomName: 'Room 2',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: false,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: false,
          )
        ],
      );
      final roomSub3 = RoomSubscriptionCollection(
        id: 'roomSubId3',
        roomId: 'roomId3',
        roomName: 'Room 3',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
          )
        ],
      );
      final roomSub4 = RoomSubscriptionCollection(
        id: 'roomSubId4',
        roomId: 'roomId4',
        roomName: 'Room 4',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
        hasFirstOtherInRoom: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: true,
          )
        ],
      );
      final roomSub5 = RoomSubscriptionCollection(
        id: 'roomSubId5',
        roomId: 'roomId5',
        roomName: 'Room 5',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.directSecret,
        hasFirstOtherInRoom: true,
        isPinned: true,
      );
      final roomSub6 = RoomSubscriptionCollection(
        id: 'roomSubId6',
        roomId: 'roomId6',
        roomName: 'Room 6',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        isRoomDeleted: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId1',
            isPinned: true,
          )
        ],
      );
      final roomSub7 = RoomSubscriptionCollection(
        id: 'roomSubId7',
        roomId: 'roomId7',
        roomName: 'Room 7',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 7),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [
          ChatFolderModel(
            folderId: 'folderId2',
            isPinned: false,
          )
        ],
      );
      final roomSub8 = RoomSubscriptionCollection(
        id: 'roomSubId8',
        roomId: 'roomId8',
        roomName: 'Room 8',
        accountId: 'accountId1',
        unreadCount: 0,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 8),
        roomType: RoomType.direct,
        hasFirstOtherInRoom: true,
        isPinned: true,
        chatFolders: [],
      );

      await roomSubscriptionDb
          .putAllRoomSub([roomSub1, roomSub2, roomSub3, roomSub4, roomSub5, roomSub6, roomSub7, roomSub8]);

      // When
      final result = await roomSubscriptionDb.getAllRoomSubscriptionByChatFolder(
        chatFolderId: 'folderId1',
        isPinned: false,
      );

      // Then
      expect(result?.contains(roomSub1), false);
      expect(result?.contains(roomSub2), true);
      expect(result?.contains(roomSub3), true);
      expect(result?.contains(roomSub4), false);
      expect(result?.contains(roomSub5), false);
      expect(result?.contains(roomSub6), false);
      expect(result?.contains(roomSub7), false);
      expect(result?.contains(roomSub8), false);
    });
  });
}
