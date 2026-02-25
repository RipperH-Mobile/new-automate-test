import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/domain/use_cases/get_recent_chat_room_for_share_use_case.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockFileService extends Mock implements FileService {}

class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

class FakeGroupPermissionEntity extends Fake implements GroupPermissionEntity {}

class FakeRoomEntity extends Fake implements RoomEntity {}

class FakePaginationPayload extends Fake implements PaginationPayload<RoomSubscriptionEntity> {}

class FakeRoomMemberEntity extends Fake implements RoomMemberEntity {}

class FakeContactModel extends Fake implements ContactModel {}

void main() {
  late MockChatRoomLocalRepository mockRepo;
  late MockFileService mockFileService;
  late GetRecentChatRoomForShareUseCase useCase;

  setUpAll(() {
    registerFallbackValue(FakeRoomSubscriptionEntity());
    registerFallbackValue(FakeGroupPermissionEntity());
    registerFallbackValue(FakeRoomEntity());
    registerFallbackValue(FakePaginationPayload());
    registerFallbackValue(FakeRoomMemberEntity());
    registerFallbackValue(FakeContactModel());
    mockFileService = MockFileService();
    GetIt.I.registerSingleton<FileService>(
      mockFileService,
    );
  });

  setUp(() {
    mockRepo = MockChatRoomLocalRepository();
    useCase = GetRecentChatRoomForShareUseCase(mockRepo, mockFileService);
    reset(mockRepo);
    reset(mockFileService);
  });

  test(
    'Given direct and group room subs with valid permissions, When call is invoked, Then returns correct ShareTargetEntity list with avatar URLs',
    () async {
      // Given
      final param = GetRecentChatRoomForShareParam(
        hasMessageType: true,
        hasMediaType: false,
        limit: 2,
      );
      final roomSubEntities = [
        const RoomSubscriptionEntity(roomId: '1', roomName: 'Direct Room', roomType: RoomType.direct),
        const RoomSubscriptionEntity(roomId: '2', roomName: 'Group Room', roomType: RoomType.group),
      ];
      final permissionEntities = [
        const GroupPermissionEntity(roomId: '2', canSendMedia: true, canSendMessages: true),
      ];
      final roomEntities = [
        const RoomEntity(id: '1', roomType: RoomType.direct, photoId: null),
        const RoomEntity(id: '2', roomType: RoomType.group, photoId: 'avatar2'),
      ];
      final contact = ContactModel(id: 'user1', avatarId: 'direct_avatar_id');
      final member = RoomMemberEntity(
        roomId: '1',
        roomType: RoomType.direct,
        account: contact,
      );

      when(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntities,
          page: 1,
          pageSize: 2,
          totalPages: 1,
          total: 2,
        ),
      );
      when(() => mockRepo.getGroupPermissionWithIds(['2'])).thenAnswer((_) async => permissionEntities);
      when(() => mockRepo.getRooms(['1', '2'])).thenAnswer((_) async => roomEntities);
      when(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).thenAnswer((_) async => [member]);
      when(() => mockFileService.getAvatarUrl('direct_avatar_id')).thenReturn('direct_avatar_url');
      when(() => mockFileService.getFileUrl('avatar2')).thenReturn('avatar2');

      // When
      final result = await useCase.call(param);

      // Then
      expect(result.length, 2, reason: 'Should return 2 share targets');
      expect(result[0].roomId, '1');
      expect(result[0].avatarUrl, 'direct_avatar_url', reason: 'Direct room avatar should come from member');
      expect(result[1].roomId, '2');
      expect(result[1].avatarUrl, 'avatar2', reason: 'Group room avatar should come from photoId');
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getGroupPermissionWithIds(['2'])).called(1);
      verify(() => mockRepo.getRooms(['1', '2'])).called(1);
      verify(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    'Given group permission denies message, When call is invoked, Then group is filtered out and only direct rooms are returned',
    () async {
      // Given
      final param = GetRecentChatRoomForShareParam(
        hasMessageType: true,
        hasMediaType: false,
        limit: 2,
      );
      final roomSubEntities = [
        const RoomSubscriptionEntity(roomId: '1', roomName: 'Direct Room', roomType: RoomType.direct),
        const RoomSubscriptionEntity(roomId: '2', roomName: 'Group Room', roomType: RoomType.group),
      ];
      final permissionEntities = [
        const GroupPermissionEntity(roomId: '2', canSendMedia: true, canSendMessages: false),
      ];
      final roomEntities = [
        const RoomEntity(id: '1', roomType: RoomType.direct, photoId: 'photoId1'),
      ];
      final roomEntities2 = [
        const RoomEntity(id: '2', roomType: RoomType.group, photoId: 'photoId2'),
      ];
      final contact = ContactModel(id: 'user1', avatarId: 'direct_avatar_id');
      final member = RoomMemberEntity(
        roomId: '1',
        roomType: RoomType.direct,
        account: contact,
      );

      when(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntities,
          page: 1,
          pageSize: 2,
          totalPages: 1,
          total: 2,
        ),
      );
      when(() => mockRepo.getGroupPermissionWithIds(['2'])).thenAnswer((_) async => permissionEntities);
      when(() => mockRepo.getRooms(['1'])).thenAnswer((_) async => roomEntities);
      when(() => mockRepo.getRooms(['2'])).thenAnswer((_) async => roomEntities2);
      when(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).thenAnswer((_) async => [member]);
      when(() => mockFileService.getAvatarUrl('direct_avatar_id')).thenReturn('direct_avatar_url');

      // When
      final result = await useCase.call(param);

      // Then
      expect(result.length, 1, reason: 'Group should be filtered out due to permission');
      expect(result[0].roomId, '1');
      expect(result[0].avatarUrl, 'direct_avatar_url');
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getGroupPermissionWithIds(['2'])).called(1);
      verify(() => mockRepo.getRooms(['1'])).called(1);
      verify(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    'Given direct room with no member found, When call is invoked, Then avatarUrl is null for that ShareTargetEntity',
    () async {
      // Given
      final param = GetRecentChatRoomForShareParam(
        hasMessageType: true,
        hasMediaType: false,
        limit: 1,
      );
      final roomSubEntities = [
        const RoomSubscriptionEntity(roomId: '1', roomName: 'Direct Room', roomType: RoomType.direct),
      ];
      final roomEntities = [
        const RoomEntity(id: '1', roomType: RoomType.direct, photoId: null),
      ];

      when(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntities,
          page: 1,
          pageSize: 1,
          totalPages: 1,
          total: 1,
        ),
      );
      when(() => mockRepo.getGroupPermissionWithIds([])).thenAnswer((_) async => []);
      when(() => mockRepo.getRooms(['1'])).thenAnswer((_) async => roomEntities);
      when(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).thenAnswer((_) async => null);

      // When
      final result = await useCase.call(param);

      // Then
      expect(result.length, 1);
      expect(result[0].roomId, '1');
      expect(result[0].avatarUrl, isNull, reason: 'Avatar should be null if no member found');
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getRooms(['1'])).called(1);
      verify(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['1'])).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    'Given group room with no photoId, When call is invoked, Then avatarUrl is null for that ShareTargetEntity',
    () async {
      // Given
      final param = GetRecentChatRoomForShareParam(
        hasMessageType: true,
        hasMediaType: false,
        limit: 1,
      );
      final roomSubEntities = [
        const RoomSubscriptionEntity(roomId: '2', roomName: 'Group Room', roomType: RoomType.group),
      ];
      final permissionEntities = [
        const GroupPermissionEntity(roomId: '2', canSendMedia: true, canSendMessages: true),
      ];
      final roomEntities = [
        const RoomEntity(id: '2', roomType: RoomType.group, photoId: null),
      ];

      when(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntities,
          page: 1,
          pageSize: 1,
          totalPages: 1,
          total: 1,
        ),
      );
      when(() => mockRepo.getGroupPermissionWithIds(['2'])).thenAnswer((_) async => permissionEntities);
      when(() => mockRepo.getRooms(['2'])).thenAnswer((_) async => roomEntities);

      // When
      final result = await useCase.call(param);

      // Then
      expect(result.length, 1);
      expect(result[0].roomId, '2');
      expect(result[0].avatarUrl, isNull, reason: 'Avatar should be null if group has no photoId');
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getGroupPermissionWithIds(['2'])).called(1);
      verify(() => mockRepo.getRooms(['2'])).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    'Given all room in first page group permission denies message, When call is invoked, Then group is filtered out and return correctly',
    () async {
      // Given
      final param = GetRecentChatRoomForShareParam(
        hasMessageType: true,
        hasMediaType: false,
        limit: 2,
      );
      final roomSubEntities = [
        const RoomSubscriptionEntity(roomId: '2', roomName: 'Room 2', roomType: RoomType.group),
        const RoomSubscriptionEntity(roomId: '3', roomName: 'Room 3', roomType: RoomType.group),
      ];
      final roomSubEntitiesPage2 = [
        const RoomSubscriptionEntity(roomId: '4', roomName: 'Room 4', roomType: RoomType.direct),
      ];
      final permissionEntities = [
        const GroupPermissionEntity(roomId: '2', canSendMedia: true, canSendMessages: false),
        const GroupPermissionEntity(roomId: '3', canSendMedia: true, canSendMessages: false),
      ];
      final roomEntities = [
        const RoomEntity(id: '4', roomType: RoomType.direct),
      ];
      final contact = ContactModel(id: 'user1', avatarId: 'direct_avatar_id');
      final member = RoomMemberEntity(
        roomId: '4',
        roomType: RoomType.direct,
        account: contact,
      );
      when(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntities,
          page: 1,
          pageSize: 2,
          totalPages: 2,
          total: 3,
        ),
      );
      when(() => mockRepo.getRoomSubCanShowInShare(page: 2, pageSize: param.limit * 2)).thenAnswer(
        (_) async => PaginationPayload<RoomSubscriptionEntity>(
          data: roomSubEntitiesPage2,
          page: 2,
          pageSize: 2,
          totalPages: 2,
          total: 3,
        ),
      );
      when(() => mockRepo.getGroupPermissionWithIds(['2', '3'])).thenAnswer((_) async => permissionEntities);
      when(() => mockRepo.getRooms(['4'])).thenAnswer((_) async => roomEntities);
      when(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['4'])).thenAnswer((_) async => [member]);
      when(() => mockFileService.getAvatarUrl('direct_avatar_id')).thenReturn('direct_avatar_url');

      // When
      final result = await useCase.call(param);

      // Then
      expect(result.length, 1, reason: 'Should return 1 share targets');
      expect(result[0].roomId, '4');
      expect(result[0].avatarUrl, 'direct_avatar_url');
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 1, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getRoomSubCanShowInShare(page: 2, pageSize: param.limit * 2)).called(1);
      verify(() => mockRepo.getGroupPermissionWithIds(['2', '3'])).called(1);
      verify(() => mockRepo.getRooms(['4'])).called(1);
      verify(() => mockRepo.getAllFirstOtherInRoom(roomIds: ['4'])).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
