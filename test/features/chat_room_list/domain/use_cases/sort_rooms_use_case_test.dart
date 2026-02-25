import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/sort_rooms_use_case.dart';

void main() {
  group('SortRoomsUseCase', () {
    final useCase = SortRoomsUseCase();

    final room1 = RoomSubscriptionCollection(
      id: '1',
      roomName: 'Room A',
      createdAt: DateTime(2023, 1, 1),
      roomType: RoomType.group,
      unreadCount: 0,
    );
    // final room2 = RoomSubscriptionCollection(
    //   id: '2',
    //   roomName: 'Room B',
    //   createdAt: DateTime(2023, 1, 2),
    //   roomType: RoomType.group,
    //   unreadCount: 5,
    // );
    final room3 = RoomSubscriptionCollection(
      id: '3',
      roomName: 'Room C',
      createdAt: DateTime(2023, 1, 3),
      roomType: RoomType.group,
      unreadCount: 0,
    );

    test('Given an empty room list, When sorting, Then returns an empty list', () {
      // Given
      final emptyRoomList = <RoomSubscriptionCollection>[];

      // When
      final result = useCase.call(
        SortRoomParams(
          roomList: emptyRoomList,
          sortType: ChatSortingType.nameASC,
        ),
      );

      // Then
      expect(result, isEmpty);
    });

    test('Given rooms with null titles, When sorting by name ascending, Then handles null titles correctly', () {
      // Given
      final roomWithNullTitle = RoomSubscriptionCollection(
        id: '4',
        roomName: '',
        createdAt: DateTime(2023, 1, 4),
        roomType: RoomType.group,
        unreadCount: 0,
      );

      // When
      final result = useCase.call(
        SortRoomParams(
          roomList: [room3, roomWithNullTitle, room1],
          sortType: ChatSortingType.nameASC,
        ),
      );

      // Then
      expect(result.map((room) => room.roomName).toList(), ['Room A', 'Room C', '']);
    });

    test(
        'Given mixed case titles, When sorting by name ascending, Then sorts with uppercase first followed by lowercase',
        () {
      // Given
      final roomList = [
        RoomSubscriptionCollection(
            id: '1', roomName: 'aA', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '2', roomName: 'AAA', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '3', roomName: 'Aa', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '4', roomName: 'aaa', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '5', roomName: 'bB', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '6', roomName: 'BBBB', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
        RoomSubscriptionCollection(
            id: '7', roomName: 'Bb', createdAt: DateTime.now(), unreadCount: 0, roomType: RoomType.group),
      ];

      // When
      final result = useCase.call(
        SortRoomParams(
          roomList: roomList,
          sortType: ChatSortingType.nameASC,
        ),
      );

      // Then
      expect(
        result.map((room) => room.roomName).toList(),
        ['AAA', 'Aa', 'aA', 'aaa', 'BBBB', 'Bb', 'bB'],
      );
    });

    test(
        'Given mixed case titles, When sorting by name ascending, Then sorts with uppercase first followed by lowercase - 2',
        () {
      // Given
      final roomList = [
        RoomSubscriptionCollection(
          id: '3',
          roomName: 'ABb',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '1',
          roomName: 'aA',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '2',
          roomName: 'AAA',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '3',
          roomName: 'Aa',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '4',
          roomName: 'aaa',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '5',
          roomName: 'bB',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '7',
          roomName: 'ba',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '6',
          roomName: 'BBBB',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '7',
          roomName: 'Bb',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '3',
          roomName: 'Ab',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
        RoomSubscriptionCollection(
          id: '3',
          roomName: 'aab',
          createdAt: DateTime.now(),
          unreadCount: 0,
          roomType: RoomType.group,
        ),
      ];

      // When
      final resultNameASC = useCase.call(
        SortRoomParams(
          roomList: roomList,
          sortType: ChatSortingType.nameASC,
        ),
      );

      final expectedNameASC = [
        'AAA',
        'Aa',
        'ABb',
        'Ab',
        'aA',
        'aaa',
        'aab',
        'BBBB',
        'Bb',
        'ba',
        'bB',
      ];
      // Then
      expect(
        resultNameASC.map((room) => room.roomName).toList(),
        expectedNameASC,
        reason: 'Expected the result to be sorted in ascending order',
      );

      final resultNameDESC = useCase.call(
        SortRoomParams(
          roomList: roomList,
          sortType: ChatSortingType.nameDESC,
        ),
      );
      final expectedNameDESC = expectedNameASC.reversed.toList();

      expect(
        resultNameDESC.map((room) => room.roomName).toList(),
        expectedNameDESC,
        reason: 'Expected the result to be sorted in descending order',
      );
    });
  });
}
