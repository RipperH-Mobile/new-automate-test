import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_recent_chat_sticker_gift_target_use_case.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late GetRecentChatStickerGiftTargetUseCase usecase;
  late ChatRoomLocalRepository mockChatRoomLocalRepository;
  late ContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockContactLocalRepository = MockContactLocalRepository();

    usecase = GetRecentChatStickerGiftTargetUseCase(
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  test(
    'Given 5 latest direct chat room in local db, When the use case is called without params, Then return 5 most recent room',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(id: 'account1', type: ContactType.normal.value),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(id: 'account2', type: ContactType.normal.value),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(id: 'account3', type: ContactType.normal.value),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(id: 'account4', type: ContactType.normal.value),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(id: 'account5', type: ContactType.normal.value),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.normal.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.normal.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.normal.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);

      List<String> roomIds = [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact1, contact2, contact3, contact4, contact5]);
    },
  );

  test(
    'Given 5 latest direct chat room in local db, When the use case is called 3 limit, Then return 3 most recent room',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(id: 'account1', type: ContactType.normal.value),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(id: 'account2', type: ContactType.normal.value),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(id: 'account3', type: ContactType.normal.value),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.normal.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.normal.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams(limit: 3);

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);

      List<String> roomIds = [room1.roomId!, room2.roomId!, room3.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact1, contact2, contact3]);
    },
  );

  test(
    'Given 5 latest direct chat room in local db, When the use case is called with keyword aa, Then return recent room with name that contains aa',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
        roomName: 'aaa',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
        roomName: 'abaca',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
        roomName: 'aabc',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(id: 'account1', type: ContactType.normal.value),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(id: 'account3', type: ContactType.normal.value),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(id: 'account4', type: ContactType.normal.value),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.normal.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams(keyword: 'aa');

      List<RoomSubscriptionEntity> roomSubList = [room1, room3, room4];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);

      List<String> roomIds = [room1.roomId!, room3.roomId!, room4.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember3, roomMember4]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact3, contact4]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact1, contact3, contact4]);
    },
  );

  test(
    'Given 5 latest direct chat room in local db, When the use case is called with keyword xxx and there is no room name that contain xxx, Then return empty list',
    () async {
      // Given
      final params = GetRecentChatStickerGiftTargetParams(keyword: 'xxx');

      List<RoomSubscriptionEntity> roomSubList = [];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, []);
    },
  );

  test(
    'Given 5 latest direct chat room in local db and one of the room is official account, When the use case is called, Then return 4 recent chat room and exclude official account',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(id: 'account1', type: ContactType.normal.value),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(id: 'account2', type: ContactType.normal.value),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(id: 'account3', type: ContactType.normal.value),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(id: 'account4', type: ContactType.official.value),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(id: 'account5', type: ContactType.normal.value),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.normal.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.normal.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.official.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 1,
            keyword: params.keyword,
            offset: 5,
          )).thenAnswer((_) async => []);

      List<String> roomIds = [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact1, contact2, contact3, contact5]);
    },
  );

  test(
    'Given 6 latest direct chat room in local db and one of the room is official account, When the use case is called, Then return 5 recent chat room and exclude official account',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final room6 = const RoomSubscriptionEntity(
        roomId: 'room6',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(id: 'account1', type: ContactType.normal.value),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(id: 'account2', type: ContactType.normal.value),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(id: 'account3', type: ContactType.normal.value),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(
          id: 'account4',
          type: ContactType.official.value,
        ),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(id: 'account5', type: ContactType.normal.value),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final roomMember6 = RoomMemberEntity(
        account: ContactModel(id: 'account6', type: ContactType.normal.value),
        roomId: 'room6',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.normal.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.normal.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.official.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.normal.value,
      );
      final contact6 = ContactEntity(
        id: 'account6',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 1,
            keyword: params.keyword,
            offset: 5,
          )).thenAnswer((_) async => [room6]);

      List<String> roomIds = [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: [room6.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember6]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember6.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact6]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact1, contact2, contact3, contact5, contact6]);
    },
  );

  test(
    'Given 6 latest direct chat room in local db and first 5 of the room is official account, When the use case is called, Then return 1 recent chat room and exclude official account',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final room6 = const RoomSubscriptionEntity(
        roomId: 'room6',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(
          id: 'account1',
          type: ContactType.official.value,
        ),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(
          id: 'account2',
          type: ContactType.official.value,
        ),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(
          id: 'account3',
          type: ContactType.official.value,
        ),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(
          id: 'account4',
          type: ContactType.official.value,
        ),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(
          id: 'account5',
          type: ContactType.official.value,
        ),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final roomMember6 = RoomMemberEntity(
        account: ContactModel(id: 'account6', type: ContactType.normal.value),
        roomId: 'room6',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.official.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.official.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.official.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.official.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.official.value,
      );
      final contact6 = ContactEntity(
        id: 'account6',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 5,
            keyword: params.keyword,
            offset: 5,
          )).thenAnswer((_) async => [room6]);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 4,
            keyword: params.keyword,
            offset: 6,
          )).thenAnswer((_) async => []);

      List<String> roomIds = [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!];
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: roomIds))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: [room6.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember6]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember6.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact6]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact6]);
    },
  );

  test(
    'Given 11 latest direct chat room in local db and first 10 of the room is official account, When the use case is called, Then return 1 recent chat room and exclude official account',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final room6 = const RoomSubscriptionEntity(
        roomId: 'room6',
      );
      final room7 = const RoomSubscriptionEntity(
        roomId: 'room7',
      );
      final room8 = const RoomSubscriptionEntity(
        roomId: 'room8',
      );
      final room9 = const RoomSubscriptionEntity(
        roomId: 'room9',
      );
      final room10 = const RoomSubscriptionEntity(
        roomId: 'room10',
      );
      final room11 = const RoomSubscriptionEntity(
        roomId: 'room11',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(
          id: 'account1',
          type: ContactType.official.value,
        ),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(
          id: 'account2',
          type: ContactType.official.value,
        ),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(
          id: 'account3',
          type: ContactType.official.value,
        ),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(
          id: 'account4',
          type: ContactType.official.value,
        ),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(
          id: 'account5',
          type: ContactType.official.value,
        ),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final roomMember6 = RoomMemberEntity(
        account: ContactModel(
          id: 'account6',
          type: ContactType.official.value,
        ),
        roomId: 'room6',
        roomType: RoomType.direct,
      );
      final roomMember7 = RoomMemberEntity(
        account: ContactModel(
          id: 'account7',
          type: ContactType.official.value,
        ),
        roomId: 'room7',
        roomType: RoomType.direct,
      );
      final roomMember8 = RoomMemberEntity(
        account: ContactModel(
          id: 'account8',
          type: ContactType.official.value,
        ),
        roomId: 'room8',
        roomType: RoomType.direct,
      );
      final roomMember9 = RoomMemberEntity(
        account: ContactModel(
          id: 'account9',
          type: ContactType.official.value,
        ),
        roomId: 'room9',
        roomType: RoomType.direct,
      );
      final roomMember10 = RoomMemberEntity(
        account: ContactModel(
          id: 'account10',
          type: ContactType.official.value,
        ),
        roomId: 'room10',
        roomType: RoomType.direct,
      );
      final roomMember11 = RoomMemberEntity(
        account: ContactModel(id: 'account11', type: ContactType.normal.value),
        roomId: 'room11',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.official.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.official.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.official.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.official.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.official.value,
      );
      final contact6 = ContactEntity(
        id: 'account6',
        type: ContactType.official.value,
      );
      final contact7 = ContactEntity(
        id: 'account7',
        type: ContactType.official.value,
      );
      final contact8 = ContactEntity(
        id: 'account8',
        type: ContactType.official.value,
      );
      final contact9 = ContactEntity(
        id: 'account9',
        type: ContactType.official.value,
      );
      final contact10 = ContactEntity(
        id: 'account10',
        type: ContactType.official.value,
      );
      final contact11 = ContactEntity(
        id: 'account11',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 5,
            keyword: params.keyword,
            offset: 5,
          )).thenAnswer((_) async => [room6, room7, room8, room9, room10]);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 5,
            keyword: params.keyword,
            offset: 10,
          )).thenAnswer((_) async => [room11]);

      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(
              roomIds: [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(
              roomIds: [room6.roomId!, room7.roomId!, room8.roomId!, room9.roomId!, room10.roomId!]))
          .thenAnswer(
              (_) async => <RoomMemberEntity>[roomMember6, roomMember7, roomMember8, roomMember9, roomMember10]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: [room11.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember11]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember6.account.id!,
            roomMember7.account.id!,
            roomMember8.account.id!,
            roomMember9.account.id!,
            roomMember10.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact6, contact7, contact8, contact9, contact10]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember11.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact11]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact11]);
    },
  );

  test(
    'Given 11 latest direct chat room in local db and 8 of the room is official account, When the use case is called, Then return 3 recent chat room and exclude official account',
    () async {
      // Given
      final room1 = const RoomSubscriptionEntity(
        roomId: 'room1',
      );
      final room2 = const RoomSubscriptionEntity(
        roomId: 'room2',
      );
      final room3 = const RoomSubscriptionEntity(
        roomId: 'room3',
      );
      final room4 = const RoomSubscriptionEntity(
        roomId: 'room4',
      );
      final room5 = const RoomSubscriptionEntity(
        roomId: 'room5',
      );
      final room6 = const RoomSubscriptionEntity(
        roomId: 'room6',
      );
      final room7 = const RoomSubscriptionEntity(
        roomId: 'room7',
      );
      final room8 = const RoomSubscriptionEntity(
        roomId: 'room8',
      );
      final room9 = const RoomSubscriptionEntity(
        roomId: 'room9',
      );
      final room10 = const RoomSubscriptionEntity(
        roomId: 'room10',
      );
      final room11 = const RoomSubscriptionEntity(
        roomId: 'room11',
      );
      final roomMember1 = RoomMemberEntity(
        account: ContactModel(
          id: 'account1',
          type: ContactType.official.value,
        ),
        roomId: 'room1',
        roomType: RoomType.direct,
      );
      final roomMember2 = RoomMemberEntity(
        account: ContactModel(
          id: 'account2',
          type: ContactType.official.value,
        ),
        roomId: 'room2',
        roomType: RoomType.direct,
      );
      final roomMember3 = RoomMemberEntity(
        account: ContactModel(
          id: 'account3',
          type: ContactType.normal.value,
        ),
        roomId: 'room3',
        roomType: RoomType.direct,
      );
      final roomMember4 = RoomMemberEntity(
        account: ContactModel(
          id: 'account4',
          type: ContactType.official.value,
        ),
        roomId: 'room4',
        roomType: RoomType.direct,
      );
      final roomMember5 = RoomMemberEntity(
        account: ContactModel(
          id: 'account5',
          type: ContactType.official.value,
        ),
        roomId: 'room5',
        roomType: RoomType.direct,
      );
      final roomMember6 = RoomMemberEntity(
        account: ContactModel(
          id: 'account6',
          type: ContactType.official.value,
        ),
        roomId: 'room6',
        roomType: RoomType.direct,
      );
      final roomMember7 = RoomMemberEntity(
        account: ContactModel(
          id: 'account7',
          type: ContactType.normal.value,
        ),
        roomId: 'room7',
        roomType: RoomType.direct,
      );
      final roomMember8 = RoomMemberEntity(
        account: ContactModel(
          id: 'account8',
          type: ContactType.official.value,
        ),
        roomId: 'room8',
        roomType: RoomType.direct,
      );
      final roomMember9 = RoomMemberEntity(
        account: ContactModel(
          id: 'account9',
          type: ContactType.official.value,
        ),
        roomId: 'room9',
        roomType: RoomType.direct,
      );
      final roomMember10 = RoomMemberEntity(
        account: ContactModel(
          id: 'account10',
          type: ContactType.official.value,
        ),
        roomId: 'room10',
        roomType: RoomType.direct,
      );
      final roomMember11 = RoomMemberEntity(
        account: ContactModel(id: 'account11', type: ContactType.normal.value),
        roomId: 'room11',
        roomType: RoomType.direct,
      );
      final contact1 = ContactEntity(
        id: 'account1',
        type: ContactType.official.value,
      );
      final contact2 = ContactEntity(
        id: 'account2',
        type: ContactType.official.value,
      );
      final contact3 = ContactEntity(
        id: 'account3',
        type: ContactType.normal.value,
      );
      final contact4 = ContactEntity(
        id: 'account4',
        type: ContactType.official.value,
      );
      final contact5 = ContactEntity(
        id: 'account5',
        type: ContactType.official.value,
      );
      final contact6 = ContactEntity(
        id: 'account6',
        type: ContactType.official.value,
      );
      final contact7 = ContactEntity(
        id: 'account7',
        type: ContactType.normal.value,
      );
      final contact8 = ContactEntity(
        id: 'account8',
        type: ContactType.official.value,
      );
      final contact9 = ContactEntity(
        id: 'account9',
        type: ContactType.official.value,
      );
      final contact10 = ContactEntity(
        id: 'account10',
        type: ContactType.official.value,
      );
      final contact11 = ContactEntity(
        id: 'account11',
        type: ContactType.normal.value,
      );

      final params = GetRecentChatStickerGiftTargetParams();

      List<RoomSubscriptionEntity> roomSubList = [room1, room2, room3, room4, room5];
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(limit: params.limit, keyword: params.keyword))
          .thenAnswer((_) async => roomSubList);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 4,
            keyword: params.keyword,
            offset: 5,
          )).thenAnswer((_) async => [room6, room7, room8, room9, room10]);
      when(() => mockChatRoomLocalRepository.getRecentDirectChat(
            limit: 3,
            keyword: params.keyword,
            offset: 10,
          )).thenAnswer((_) async => [room11]);

      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(
              roomIds: [room1.roomId!, room2.roomId!, room3.roomId!, room4.roomId!, room5.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember1, roomMember2, roomMember3, roomMember4, roomMember5]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(
              roomIds: [room6.roomId!, room7.roomId!, room8.roomId!, room9.roomId!, room10.roomId!]))
          .thenAnswer(
              (_) async => <RoomMemberEntity>[roomMember6, roomMember7, roomMember8, roomMember9, roomMember10]);
      when(() => mockChatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: [room11.roomId!]))
          .thenAnswer((_) async => <RoomMemberEntity>[roomMember11]);

      when(() => mockContactLocalRepository.getContactList([
            roomMember1.account.id!,
            roomMember2.account.id!,
            roomMember3.account.id!,
            roomMember4.account.id!,
            roomMember5.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact1, contact2, contact3, contact4, contact5]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember6.account.id!,
            roomMember7.account.id!,
            roomMember8.account.id!,
            roomMember9.account.id!,
            roomMember10.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact6, contact7, contact8, contact9, contact10]);
      when(() => mockContactLocalRepository.getContactList([
            roomMember11.account.id!,
          ])).thenAnswer((_) async => <ContactEntity>[contact11]);

      // When
      final result = await usecase.call(params);

      // Then
      expect(result, [contact3, contact7, contact11]);
    },
  );
}
