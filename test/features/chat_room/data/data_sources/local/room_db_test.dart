import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  late Isar isar;
  late RoomDb roomDb;
  late MockLoggerService mockLoggerService;
  late MockUserController mockUserController;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [RoomCollectionSchema],
      directory: './',
      name: 'room_db_test',
    );

    roomDb = RoomDb(customDbInstance: isar);
    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockUserController);

    // Set up for currentUser call in message mixin to work.
    when(() => mockUserController.currentUser).thenReturn(
      UserEntity(
        id: 'accountId1',
        username: 'user1',
        displayName: 'User 1',
        phoneNumber: '0892345678',
      ).obs,
    );
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.rooms.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putRoom cases', () {
    test('Given room is not exist in local db yet, When invoked with new room  Should save new room in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.putRoom(room);

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, room);
    });

    test(
        'Given room is already exist in local db, When invoked with same room but with new data, Should save room  with updated data in local db',
        () async {
      // Given
      final room = RoomCollection(
          id: 'roomId1',
          roomType: RoomType.direct,
          createdAt: DateTime(2000, 1, 1, 1),
          updatedAt: DateTime(2000, 1, 1, 1),
          originalRoomName: 'Room 1',
          ownerId: 'accountId1',
          isJoined: true);
      await roomDb.putRoom(room);
      final newRoom = RoomCollection(
        id: 'roomId1',
        originalRoomName: 'Room 1A',
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctRoom = RoomCollection(
          id: 'roomId1',
          roomType: RoomType.direct,
          createdAt: DateTime(2000, 1, 1, 1),
          updatedAt: DateTime(2000, 1, 1, 2),
          originalRoomName: 'Room 1A',
          ownerId: 'accountId1',
          isJoined: true);
      // When
      await roomDb.putRoom(newRoom);

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, correctRoom);
    });

    test(
        'Given room is already exist in local db, When invoked with same room but with new data and replaceData is true, Should save new room in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room);
      final newRoom = RoomCollection(
          id: 'roomId1',
          roomType: RoomType.direct,
          createdAt: DateTime(2000, 1, 1, 1),
          updatedAt: DateTime(2000, 1, 1, 2),
          originalRoomName: 'Room 1A',
          ownerId: 'accountId2',
          isJoined: true);

      // When
      await roomDb.putRoom(newRoom, replaceData: true);

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, newRoom);
    });
  });

  group('updateAllRoom cases', () {
    test(
        'Given some room already exist in local db, When invoked with already exist and new room, Should update existing room and add new room to local db',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room1);

      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final newRoom1 = RoomCollection(
        id: 'roomId1',
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
      );
      final correctRoom1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );

      // When
      await roomDb.updateAllRoom([newRoom1, room2]);

      // Then
      final room1Result = await roomDb.getRoom('roomId1');
      expect(room1Result, correctRoom1);
      final room2Result = await roomDb.getRoom('roomId2');
      expect(room2Result, room2);
    });
  });

  group('putAllRoom cases', () {
    test(
        'Given some room already exist in local db, When invoked with already exist and new room, Should replace existing room and add new room to local db',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room1);

      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final newRoom1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.putAllRoom([newRoom1, room2]);

      // Then
      final room1Result = await roomDb.getRoom('roomId1');
      expect(room1Result, newRoom1);
      final room2Result = await roomDb.getRoom('roomId2');
      expect(room2Result, room2);
    });
  });

  group('putAllRoomWithoutTxn cases', () {
    test(
        'Given some room already exist in local db, When invoked with already exist and new room, Should replace existing room and add new room to local db',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room1);

      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final newRoom1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.putAllRoomWithoutTxn([newRoom1, room2]);
      });

      // Then
      final room1Result = await roomDb.getRoom('roomId1');
      expect(room1Result, newRoom1);
      final room2Result = await roomDb.getRoom('roomId2');
      expect(room2Result, room2);
    });
  });

  group('updateAllRoomWithoutTxn cases', () {
    test(
        'Given some room already exist in local db, When invoked with already exist and new room, Should update existing room and add new room to local db',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room1);

      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final newRoom1 = RoomCollection(
        id: 'roomId1',
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
      );
      final correctRoom1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.updateAllRoomWithoutTxn([newRoom1, room2]);
      });

      // Then
      final room1Result = await roomDb.getRoom('roomId1');
      expect(room1Result, correctRoom1);
      final room2Result = await roomDb.getRoom('roomId2');
      expect(room2Result, room2);
    });
  });

  group('putRoomWithoutTxn cases', () {
    test('Given room is not exist in local db yet, When invoked with new room  Should save new room in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.putRoomWithoutTxn(room);
      });

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, room);
    });

    test(
        'Given room is already exist in local db, When invoked with same room but with new data, Should save room  with updated data in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putRoom(room);
      final newRoom = RoomCollection(
        id: 'roomId1',
        originalRoomName: 'Room 1A',
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctRoom = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.putRoomWithoutTxn(newRoom);
      });

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, correctRoom);
    });

    test(
        'Given room is already exist in local db, When invoked with same room but with new data and replaceData is true, Should save new room in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
        draftMessage: 'draft message 1',
      );
      await roomDb.putRoom(room);
      final newRoom = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2000, 1, 1, 2),
        originalRoomName: 'Room 1A',
        ownerId: 'accountId2',
        isJoined: true,
      );

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.putRoomWithoutTxn(newRoom, replaceData: true);
      });

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, newRoom);
    });
  });

  group('putOrUpdateRoom cases', () {
    test('Given room is not exist in local db yet, When invoked with new room  Should save new room in local db',
        () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );

      // When
      await roomDb.putOrUpdateRoom(room);

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, room);
    });

    test(
        'Given room is already exist in local db, When invoked with same room but with new data, Should save room  with updated data in local db',
        () async {
      // Given
      final room = RoomCollection(
          id: 'roomId1',
          roomType: RoomType.direct,
          createdAt: DateTime(2000, 1, 1, 1),
          updatedAt: DateTime(2000, 1, 1, 1),
          originalRoomName: 'Room 1',
          ownerId: 'accountId1',
          isJoined: true);
      await roomDb.putRoom(room);
      final newRoom = RoomCollection(
        id: 'roomId1',
        originalRoomName: 'Room 1A',
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctRoom = RoomCollection(
          id: 'roomId1',
          roomType: RoomType.direct,
          createdAt: DateTime(2000, 1, 1, 1),
          updatedAt: DateTime(2000, 1, 1, 2),
          originalRoomName: 'Room 1A',
          ownerId: 'accountId1',
          isJoined: true);
      // When
      await roomDb.putOrUpdateRoom(newRoom);

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, correctRoom);
    });
  });

  group('getRoom cases', () {
    test('Given room is not exist in local db, When invoked with roomId, Should return null', () async {
      // When
      final fetchedRoom = await roomDb.getRoom('roomId1');

      // Then
      expect(fetchedRoom, null);
    });

    test('Given room is exist in local db, When invoked with roomId, Should return the correct room', () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putRoom(room);

      // When
      final fetchedRoom = await roomDb.getRoom('roomId1');

      // Then
      expect(fetchedRoom, room);
    });
  });

  group('getRoomSync cases', () {
    test('Given room is not exist in local db, When invoked with roomId, Should return null', () async {
      // When
      final fetchedRoom = roomDb.getRoomSync('roomId1');

      // Then
      expect(fetchedRoom, null);
    });

    test('Given room is exist in local db, When invoked with roomId, Should return the correct room', () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putRoom(room);

      // When
      final fetchedRoom = roomDb.getRoomSync('roomId1');

      // Then
      expect(fetchedRoom, room);
    });
  });

  group('getRooms cases', () {
    test('Given no room is exist in local db, When invoked with roomIds, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.getRooms(['roomId1', 'roomId2']);

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test('Given some room is exist in local db, When invoked with roomIds, Should return the correct rooms', () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2]);

      // When
      final fetchedRooms = await roomDb.getRooms(['roomId1', 'roomId2', 'roomId4']);

      // Then
      expect(fetchedRooms?.contains(room1), true);
      expect(fetchedRooms?.contains(room2), true);
      expect(fetchedRooms?.contains(room3), false);
      expect(fetchedRooms?.length, 2);
    });
  });

  group('getRoomsNotSecretAndNotBookmark cases', () {
    test('Given no room in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.getRoomsNotSecretAndNotBookmark(['roomId1', 'roomId2']);

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test(
        'Given some room in local db, When invoked with list of room id, Should return list of that room id excluding secret and bookmark room',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.directSecret,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.bookmark,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room4 = RoomCollection(
        id: 'roomId4',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 4',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3, room4]);

      // When
      final fetchedRooms = await roomDb.getRoomsNotSecretAndNotBookmark(['roomId1', 'roomId2', 'roomId3', 'roomId4']);

      // Then
      expect(fetchedRooms?.contains(room1), true);
      expect(fetchedRooms?.contains(room2), false);
      expect(fetchedRooms?.contains(room3), false);
      expect(fetchedRooms?.contains(room4), true);
    });
  });

  group('getBookmarkRoom cases', () {
    test('Given no room in local db, When invoked, Should return null', () async {
      // When
      final fetchedRooms = await roomDb.getBookmarkRoom();

      // Then
      expect(fetchedRooms, isNull);
    });

    test('Given some room in local db, When invoked, Should return the oldest bookmark room', () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.bookmark,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.bookmark,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2]);

      // When
      final fetchedRooms = await roomDb.getBookmarkRoom();

      // Then
      expect(fetchedRooms, room1);
    });
  });

  group('getRoomLatestSearch cases', () {
    test('Given no room in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.getRoomLatestSearch();

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test(
        'Given some room in local db, When invoked, Should return list of room that have latestSearch data sorted by latestSearch',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 1);
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 2);
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3]);

      // When
      final fetchedRooms = await roomDb.getRoomLatestSearch();

      // Then
      expect(fetchedRooms, [room2, room1]);
    });

    test(
        'Given some room in local db, When invoked with limit, Should return list of room that have latestSearch data sorted by latestSearch without exceeding limit',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 1);
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 2);
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room4 = RoomCollection(
        id: 'roomId4',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 4',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 3);
      await roomDb.putAllRoom([room1, room2, room3, room4]);

      // When
      final fetchedRooms = await roomDb.getRoomLatestSearch(limit: 2);

      // Then
      expect(fetchedRooms, [room4, room2]);
    });
  });

  group('clearAllLatestSearch cases', () {
    test(
        'Given some room have latestSearch data in local db, When invoked, Should remove latestSearch data from all room in local db',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 1);
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      )..latestSearch = DateTime(2023, 1, 1, 2);
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3]);

      // When
      await roomDb.clearAllLatestSearch();

      // Then
      final fetchedRooms = await roomDb.getRoomLatestSearch();
      expect(fetchedRooms, isEmpty);
    });
  });

  group('deleteRoom cases', () {
    test('Given some room in local db, When invoked with id, Should remove that room from local db', () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putRoom(room);

      // When
      await roomDb.deleteRoom('roomId1');

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, null);
    });
  });

  group('deleteRoomWithoutTxn cases', () {
    test('Given some room in local db, When invoked with id, Should remove that room from local db', () async {
      // Given
      final room = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putRoom(room);

      // When
      await roomDb.customDbInstance?.writeTxn(() async {
        await roomDb.deleteRoomWithoutTxn('roomId1');
      });

      // Then
      final fetchedRoom = await roomDb.getRoom('roomId1');
      expect(fetchedRoom, null);
    });
  });

  group('getRoomTypeGroup cases', () {
    test('Given no group room in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.getRoomTypeGroup();

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test('Given some group room in local db, When invoked, Should return list of group room sorted by name', () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 3),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room4 = RoomCollection(
        id: 'roomId4',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room5 = RoomCollection(
        id: 'roomId5',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3, room4, room5]);

      // When
      final fetchedRooms = await roomDb.getRoomTypeGroup();

      // Then
      expect(fetchedRooms, [room1, room2, room4, room5]);
    });
  });

  group('getGroupsWithMeAsAnOwner cases', () {
    test('Given no group room in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.getGroupsWithMeAsAnOwner();

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test(
        'Given some group room in local db, When invoked, Should return list of group room that I am the owner sorted by name',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 3),
        originalRoomName: 'Room 3',
        isJoined: true,
      );
      final room4 = RoomCollection(
        id: 'roomId4',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room5 = RoomCollection(
        id: 'roomId5',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room6 = RoomCollection(
        id: 'roomId6',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'Room 6',
        ownerId: 'accountId2',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3, room4, room5, room6]);

      // When
      final fetchedRooms = await roomDb.getGroupsWithMeAsAnOwner();

      // Then
      expect(fetchedRooms, [room1, room2, room4, room5]);
    });
  });

  group('searchRoomTypeGroup cases', () {
    test('Given no group room in local db, When invoked with keyword, Should return empty list', () async {
      // When
      final fetchedRooms = await roomDb.searchRoomTypeGroup('room');

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test(
        'Given some group room in local db, When invoked with keyword, Should return list of group room that have keyword in name sorted by name',
        () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 3),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room4 = RoomCollection(
        id: 'roomId4',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room5 = RoomCollection(
        id: 'roomId5',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3, room4, room5]);

      // When
      final fetchedRooms = await roomDb.searchRoomTypeGroup('room');

      // Then
      expect(fetchedRooms, [room1, room2, room4, room5]);
    });
  });

  group('getRoomTypeDirectSync cases', () {
    test('Given no group room in local db, When invoked with keyword, Should return empty list', () async {
      // When
      final fetchedRooms = roomDb.getRoomTypeDirectSync();

      // Then
      expect(fetchedRooms, isEmpty);
    });

    test('Given some direct room in local db, When invoked with keyword, Should return list of direct room', () async {
      // Given
      final room1 = RoomCollection(
        id: 'roomId1',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 1),
        originalRoomName: 'Room 1',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room2 = RoomCollection(
        id: 'roomId2',
        roomType: RoomType.direct,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 2),
        originalRoomName: 'Room 2',
        ownerId: 'accountId1',
        isJoined: true,
      );
      final room3 = RoomCollection(
        id: 'roomId3',
        roomType: RoomType.group,
        createdAt: DateTime(2000, 1, 1, 1),
        updatedAt: DateTime(2023, 1, 1, 3),
        originalRoomName: 'Room 3',
        ownerId: 'accountId1',
        isJoined: true,
      );
      await roomDb.putAllRoom([room1, room2, room3]);

      // When
      final fetchedRooms = roomDb.getRoomTypeDirectSync();

      // Then
      expect(fetchedRooms?.contains(room1), true);
      expect(fetchedRooms?.contains(room2), true);
      expect(fetchedRooms?.contains(room3), false);
    });
  });
}
