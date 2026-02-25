import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';

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
  late RoomMemberDb roomMemberDb;
  late MockAccountService mockAccountService;
  late MockLoggerService mockLoggerService;
  late MockUserController mockUserController;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [RoomMemberCollectionSchema],
      directory: './',
      name: 'room_member_db_test',
    );

    roomMemberDb = RoomMemberDb(customDbInstance: isar);
    mockAccountService = MockAccountService();
    GetIt.I.registerSingleton<AccountService>(mockAccountService);
    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);

    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockUserController);
    reset(mockAccountService);

    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);

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
      await isar.roomMember.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putRoomMember cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.putRoomMember(member);

      // Then
      final fetchedMember = await roomMemberDb.getOneMemberInRoom(member.roomId!, member.accountId!);
      expect(fetchedMember, member);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should save member with updated data in local db',
        () async {
      // Given
      final member = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putRoomMember(member);
      final newMember = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      final correctMember = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.putRoomMember(newMember);

      // Then
      final fetchedRoomSub = await roomMemberDb.getOneMemberInRoom(member.roomId!, member.accountId!);
      expect(fetchedRoomSub, correctMember);
    });
  });

  group('putRoomMemberWithoutTxn cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.putRoomMemberWithoutTxn(member);
      });

      // Then
      final fetchedMember = await roomMemberDb.getOneMemberInRoom(member.roomId!, member.accountId!);
      expect(fetchedMember, member);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should save member with updated data in local db',
        () async {
      // Given
      final member = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putRoomMember(member);
      final newMember = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      final correctMember = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.putRoomMemberWithoutTxn(newMember);
      });

      // Then
      final fetchedRoomSub = await roomMemberDb.getOneMemberInRoom(member.roomId!, member.accountId!);
      expect(fetchedRoomSub, correctMember);
    });
  });

  group('updateAllRoomMember cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.updateAllRoomMember([member1, member2]);

      // Then
      final fetchedMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchedMember1, member1);
      final fetchedMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchedMember2, member2);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should save member with updated data in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);
      final newMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      final correctMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final correctMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.updateAllRoomMember([newMember1, newMember2]);

      // Then
      final fetchMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchMember1, correctMember1);
      final fetchMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchMember2, correctMember2);
    });
  });

  group('putAllRoomMember cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // Then
      final fetchedMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchedMember1, member1);
      final fetchedMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchedMember2, member2);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should replace member with new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
          nickname: 'Nickname 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar('accountId3')).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);
      final newMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final newMember3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );

      final correctMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final correctMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final correctMember3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.putAllRoomMember([newMember1, newMember2, newMember3]);

      // Then
      final fetchMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchMember1, correctMember1);
      final fetchMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchMember2, correctMember2);
      final fetchMember3 = await roomMemberDb.getOneMemberInRoom(member3.roomId!, member3.accountId!);
      expect(fetchMember3, correctMember3);
    });
  });

  group('putAllRoomMemberWithoutTxn cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.putAllRoomMemberWithoutTxn([member1, member2]);
      });

      // Then
      final fetchedMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchedMember1, member1);
      final fetchedMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchedMember2, member2);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should replace member with new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
          nickname: 'Nickname 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar('accountId3')).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);
      final newMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final newMember3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );

      final correctMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final correctMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final correctMember3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'user3',
          displayName: 'User 3',
        ),
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.putAllRoomMemberWithoutTxn([newMember1, newMember2, newMember3]);
      });

      // Then
      final fetchMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchMember1, correctMember1);
      final fetchMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchMember2, correctMember2);
      final fetchMember3 = await roomMemberDb.getOneMemberInRoom(member3.roomId!, member3.accountId!);
      expect(fetchMember3, correctMember3);
    });
  });

  group('updateAllRoomMemberWithoutTxn cases', () {
    test('Given member is not exist in local db yet, When invoked with new member, Should save new member in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.updateAllRoomMemberWithoutTxn([member1, member2]);
      });

      // Then
      final fetchedMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchedMember1, member1);
      final fetchedMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchedMember2, member2);
    });

    test(
        'Given member is already exist in local db, When invoked with same member but with new data, Should save member with updated data in local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);
      final newMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final newMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      final correctMember1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1a',
          nickname: 'Nickname 1',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final correctMember2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2a',
          nickname: 'Nickname 2',
        ),
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.updateAllRoomMemberWithoutTxn([newMember1, newMember2]);
      });

      // Then
      final fetchMember1 = await roomMemberDb.getOneMemberInRoom(member1.roomId!, member1.accountId!);
      expect(fetchMember1, correctMember1);
      final fetchMember2 = await roomMemberDb.getOneMemberInRoom(member2.roomId!, member2.accountId!);
      expect(fetchMember2, correctMember2);
    });
  });

  group('getFirstOtherInRoom cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = await roomMemberDb.getFirstOtherInRoom('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test('Given only current user as member in local db, When invoked, Should return null', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putRoomMember(member1);

      // When
      final fetchedMember = await roomMemberDb.getFirstOtherInRoom('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test('Given 2 members in direct room in local db, When invoked, Should return first other member', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // When
      final fetchedMember = await roomMemberDb.getFirstOtherInRoom('roomId1');

      // Then
      expect(fetchedMember, member2);
    });

    test('Given multiple members in group room in local db, When invoked, Should return first other member', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final fetchedMember = await roomMemberDb.getFirstOtherInRoom('roomId1');

      // Then
      expect(fetchedMember, member3);
    });
  });

  group('getAllFirstOtherInRoom cases', () {
    test(
        'Given multiple members in local db, When invoked with list of room id, Should return all other member of all room id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
        ),
        rowId: 'rowId4',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      final member6 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId6',
          username: 'userId6',
          displayName: 'User 6',
        ),
        rowId: 'rowId6',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member6.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5, member6]);

      // When
      final fetchedMember = await roomMemberDb.getAllFirstOtherInRoom(['roomId1', 'roomId2', 'roomId3']);

      // Then
      expect(fetchedMember?.contains(member1), false);
      expect(fetchedMember?.contains(member2), true);
      expect(fetchedMember?.contains(member3), true);
      expect(fetchedMember?.contains(member4), true);
      expect(fetchedMember?.contains(member5), true);
      expect(fetchedMember?.contains(member6), true);
    });
  });

  group('getFirstOtherInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = roomMemberDb.getFirstOtherInRoomSync('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test('Given only current user as member in local db, When invoked, Should return null', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putRoomMember(member1);

      // When
      final fetchedMember = roomMemberDb.getFirstOtherInRoomSync('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test('Given 2 members in direct room in local db, When invoked, Should return first other member', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // When
      final fetchedMember = roomMemberDb.getFirstOtherInRoomSync('roomId1');

      // Then
      expect(fetchedMember, member2);
    });

    test('Given multiple members in group room in local db, When invoked, Should return first other member', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final fetchedMember = roomMemberDb.getFirstOtherInRoomSync('roomId1');

      // Then
      expect(fetchedMember, member3);
    });
  });

  group('getMeInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = roomMemberDb.getMeInRoomSync('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test('Given no current user member of a room in local db, When invoked with that room id, Should return null',
        () async {
      // Given
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member2]);

      // When
      final fetchedMember = roomMemberDb.getMeInRoomSync('roomId1');

      // Then
      expect(fetchedMember, null);
    });

    test(
        'Given current user member of a direct room in local db, When invoked with that room id, Should return current user',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // When
      final fetchedMember = roomMemberDb.getMeInRoomSync('roomId1');

      // Then
      expect(fetchedMember, member1);
    });

    test(
        'Given current user member of a group room in local db, When invoked with that room id, Should return current user',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final fetchedMember = roomMemberDb.getMeInRoomSync('roomId1');

      // Then
      expect(fetchedMember, member1);
    });
  });

  group('getAllMemberInRoom cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoom('roomId1');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some members in local db, When invoked with room id, Should return all member of that room id sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoom('roomId1');

      // Then
      expect(fetchedMember, [member1, member3, member4, member2]);
    });
  });

  group('getAllMemberInRoomWithPagination cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoomWithPagination(roomId: 'roomId1');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some members in local db, When invoked with room id, Should return all member of that room id sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoomWithPagination(roomId: 'roomId1');

      // Then
      expect(fetchedMember, [member1, member3, member4, member2]);
    });

    test(
        'Given some members in local db, When invoked with room id, page and pageSize, Should return all member of that room id sorted by name then by account id with pagination',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoomWithPagination(
        roomId: 'roomId1',
        page: 1,
        pageSize: 2,
      );
      final fetchedMember2 = await roomMemberDb.getAllMemberInRoomWithPagination(
        roomId: 'roomId1',
        page: 2,
        pageSize: 2,
      );

      // Then
      expect(fetchedMember, [member1, member3]);
      expect(fetchedMember2, [member4, member2]);
    });

    test(
        'Given some members in local db, When invoked with room id and keyword, Should return all member of that room id with name that contain keyword sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoomWithPagination(
        roomId: 'roomId1',
        keyword: 'A',
      );

      // Then
      expect(fetchedMember, [member3, member4]);
    });

    test(
        'Given some members in local db, When invoked with room id, keyword, page and pageSize, Should return all member of that room id with name that contain keyword sorted by name then by account id with pagination',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      final member6 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId6',
          username: 'userId6',
          displayName: 'User 6A',
        ),
        rowId: 'rowId6',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member6.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5, member6]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberInRoomWithPagination(
        roomId: 'roomId1',
        keyword: 'A',
        page: 1,
        pageSize: 2,
      );
      final fetchedMember2 = await roomMemberDb.getAllMemberInRoomWithPagination(
        roomId: 'roomId1',
        keyword: 'A',
        page: 2,
        pageSize: 2,
      );

      // Then
      expect(fetchedMember, [member3, member4]);
      expect(fetchedMember2, [member6]);
    });
  });

  group('getMemberInRoomWithPaginationCount cases', () {
    test('Given no member in local db, When invoked, Should return 0', () async {
      // When
      final count = await roomMemberDb.getMemberInRoomWithPaginationCount(roomId: 'roomId1');

      // Then
      expect(count, 0);
    });

    test('Given some members in local db, When invoked with room id, Should return count of member in that room id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final count = await roomMemberDb.getMemberInRoomWithPaginationCount(roomId: 'roomId1');

      // Then
      expect(count, 4);
    });

    test(
        'Given some members in local db, When invoked with room id and keyword, Should return count of member in that room id with name that contain keyword',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      final member6 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId6',
          username: 'userId6',
          displayName: 'User 6A',
        ),
        rowId: 'rowId6',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 6),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member6.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5, member6]);

      // When
      final count = await roomMemberDb.getMemberInRoomWithPaginationCount(
        roomId: 'roomId1',
        keyword: 'A',
      );

      // Then
      expect(count, 3);
    });
  });

  group('getAllAdminIdInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return empty list', () async {
      // When
      final result = roomMemberDb.getAllAdminIdInRoomSync('roomId1');

      // Then
      expect(result, []);
    });

    test(
        'Given some member in local db, When invoked with room id, Should return list of account id of admin in that room',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.admin,
        ),
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 2, 2, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.admin,
        ),
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final result = roomMemberDb.getAllAdminIdInRoomSync('roomId1');

      // Then
      expect(result.contains(member1.accountId!), true);
      expect(result.contains(member2.accountId!), false);
      expect(result.contains(member3.accountId!), false);
      expect(result.contains(member4.accountId!), false);
      expect(result.contains(member5.accountId!), true);
    });
  });

  group('getOwnerIdInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final result = roomMemberDb.getOwnerIdInRoomSync('roomId1');

      // Then
      expect(result, null);
    });

    test('Given some member in local db, When invoked with room id, Should return account id of owner in that room',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 2, 2, 2),
        roomType: RoomType.group,
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.owner,
        ),
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final result = roomMemberDb.getOwnerIdInRoomSync('roomId1');

      // Then
      expect(result, member2.accountId);
    });
  });

  group('searchMemberInRoom cases', () {
    test('Given no member in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedMember = await roomMemberDb.searchMemberInRoom('roomId1', '');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some members in local db, When invoked with room id, Should return all member of that room id sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.searchMemberInRoom('roomId1', '');

      // Then
      expect(fetchedMember, [member1, member3, member4, member2]);
    });

    test(
        'Given some members in local db, When invoked with room id and keyword, Should return all member of that room id with name that contain keyword sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = await roomMemberDb.searchMemberInRoom(
        'roomId1',
        'A',
      );

      // Then
      expect(fetchedMember, [member3, member4]);
    });
  });

  group('getAllMemberInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = roomMemberDb.getAllMemberInRoomSync('roomId1');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some members in local db, When invoked with room id, Should return all member of that room id sorted by name then by account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final fetchedMember = roomMemberDb.getAllMemberInRoomSync('roomId1');

      // Then
      expect(fetchedMember, [member1, member3, member4, member2]);
    });
  });

  group('getMemberCount cases', () {
    test('Given no member in local db, When invoked, Should return 0', () async {
      // When
      final count = await roomMemberDb.getMemberCount('roomId1');

      // Then
      expect(count, 0);
    });

    test('Given some members in local db, When invoked with room id, Should return member count of that room',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
          nickname: 'user 1A',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId4',
          username: 'userId4',
          displayName: 'User 4',
          nickname: 'user 1A',
        ),
        rowId: 'rowId4',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 4),
        roomType: RoomType.group,
      );
      final member5 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId5',
          username: 'userId5',
          displayName: 'User 5',
        ),
        rowId: 'rowId5',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 5),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member5.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4, member5]);

      // When
      final count = await roomMemberDb.getMemberCount('roomId1');

      // Then
      expect(count, 4);
    });
  });

  group('getOneMemberInRoom cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = await roomMemberDb.getOneMemberInRoom('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, null);
    });

    test(
        'Given some member in local db, When invoked with room id and account id, Should return member with that room id and account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // When
      final fetchedMember = await roomMemberDb.getOneMemberInRoom('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, member1);
    });
  });

  group('getOneMemberInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final fetchedMember = roomMemberDb.getOneMemberInRoomSync('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, null);
    });

    test(
        'Given some member in local db, When invoked with room id and account id, Should return member with that room id and account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1a',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2]);

      // When
      final fetchedMember = roomMemberDb.getOneMemberInRoomSync('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, member1);
    });
  });

  group('getAllMemberWithId cases', () {
    test('Given no member in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedMember = await roomMemberDb.getAllMemberWithId('accountId1');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some member in local db, When invoked with account id, Should return member with that room id and account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final fetchedMember = await roomMemberDb.getAllMemberWithId('accountId1');

      // Then
      expect(fetchedMember?.contains(member1), true);
      expect(fetchedMember?.contains(member2), false);
      expect(fetchedMember?.contains(member3), true);
    });
  });

  group('getMemberWithIdInSecretChat cases', () {
    test('Given no member in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedMember = await roomMemberDb.getMemberWithIdInSecretChat('accountId1');

      // Then
      expect(fetchedMember, []);
    });

    test(
        'Given some member in local db, When invoked with account id, Should return member with that room id and account id',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.directSecret,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.directSecret,
      );
      final member4 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member4.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3, member4]);

      // When
      final fetchedMember = await roomMemberDb.getMemberWithIdInSecretChat('accountId1');

      // Then
      expect(fetchedMember.contains(member1), false);
      expect(fetchedMember.contains(member2), false);
      expect(fetchedMember.contains(member3), true);
      expect(fetchedMember.contains(member4), false);
    });
  });

  group('deleteMemberWithoutTxn cases', () {
    test('Given some member in local db, When invoked with id, Should remove member with that account id from local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1]);

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.deleteMemberWithoutTxn(member1.localDbId!);
      });

      // Then
      final fetchedMember = await roomMemberDb.getOneMemberInRoom('roomId1', 'accountId1');
      expect(fetchedMember, isNull);
    });
  });

  group('getNextOwnerSuggestion cases', () {
    test('Given no member in local db, When invoked, Should return empty list', () async {
      // When
      final fetchedMember = await roomMemberDb.getNextOwnerSuggestion('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, []);
    });

    test('Given some member in local db, When invoked, Should return possible next owner sorted by joinedAt', () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.group,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.group,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final fetchedMember = await roomMemberDb.getNextOwnerSuggestion('roomId1', 'accountId1');

      // Then
      expect(fetchedMember, [member2, member3]);
    });
  });

  group('getDirectRoomIdByOtherIdInRoom cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final roomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom('accountId1');

      // Then
      expect(roomId, null);
    });

    test('Given some member in local db, When invoked, Should return direct room id with that account id in the room',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final roomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom('accountId2');

      // Then
      expect(roomId, member2.roomId!);
    });
  });

  group('getDirectRoomIdByOtherIdInRoomSync cases', () {
    test('Given no member in local db, When invoked, Should return null', () async {
      // When
      final roomId = roomMemberDb.getDirectRoomIdByOtherIdInRoomSync('accountId1');

      // Then
      expect(roomId, null);
    });

    test('Given some member in local db, When invoked, Should return direct room id with that account id in the room',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.group,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId3',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      final roomId = roomMemberDb.getDirectRoomIdByOtherIdInRoomSync('accountId2');

      // Then
      expect(roomId, member2.roomId!);
    });
  });

  group('deleteMemberInRoom cases', () {
    test(
        'Given some member in local db, When invoked with room id, Should remove all member with that room id from local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      await roomMemberDb.deleteMemberInRoom('roomId1');

      // Then
      final result = await roomMemberDb.getAllMemberInRoom('roomId1');
      expect(result, []);
      final fetchedMember = await roomMemberDb.getOneMemberInRoom('roomId2', 'accountId3');
      expect(fetchedMember, member3);
    });
  });

  group('deleteMemberInRoomWithoutTxn cases', () {
    test(
        'Given some member in local db, When invoked with room id, Should remove all member with that room id from local db',
        () async {
      // Given
      final member1 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId1',
          username: 'userId1',
          displayName: 'User 1',
        ),
        rowId: 'rowId1',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 1),
        roomType: RoomType.direct,
      );
      final member2 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId2',
          username: 'userId2',
          displayName: 'User 2',
        ),
        rowId: 'rowId2',
        roomId: 'roomId1',
        joinedAt: DateTime(2000, 1, 1, 2),
        roomType: RoomType.direct,
      );
      final member3 = RoomMemberCollection(
        account: ContactModel(
          id: 'accountId3',
          username: 'userId3',
          displayName: 'User 3',
        ),
        rowId: 'rowId3',
        roomId: 'roomId2',
        joinedAt: DateTime(2000, 1, 1, 3),
        roomType: RoomType.direct,
      );
      when(() => mockAccountService.getUserPublicAvatar(member1.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member2.accountId!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(member3.accountId!)).thenAnswer((_) => '');
      await roomMemberDb.putAllRoomMember([member1, member2, member3]);

      // When
      await roomMemberDb.customDbInstance?.writeTxn(() async {
        await roomMemberDb.deleteMemberInRoomWithoutTxn('roomId1');
      });

      // Then
      final result = await roomMemberDb.getAllMemberInRoom('roomId1');
      expect(result, []);
      final fetchedMember = await roomMemberDb.getOneMemberInRoom('roomId2', 'accountId3');
      expect(fetchedMember, member3);
    });
  });
}
