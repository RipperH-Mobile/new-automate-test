import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_system_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_system_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockRoomSubLocalRepository extends Mock implements RoomSubLocalRepository {}

class MockRoomMemberLocalRepository extends Mock implements RoomMemberLocalRepository {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class FakeRoomEntity extends Fake implements RoomEntity {}

void main() {
  late OpenSystemChatAndSaveToDbUseCase useCase;
  late MockChatRoomServerRepository mockChatRoomServerRepository;
  late MockChatRoomLocalRepository mockChatRoomLocalRepository;
  late MockRoomSubLocalRepository mockRoomSubLocalRepository;
  late MockRoomMemberLocalRepository mockRoomMemberLocalRepository;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    // Register fallback values
    registerFallbackValue(RoomCollection());
    registerFallbackValue(RoomSubscriptionCollection());
    registerFallbackValue(const RoomSubscriptionEntity(
      id: 'test-id',
      roomId: 'test-room-id',
      accountId: 'test-account-id',
    ));
    registerFallbackValue(GetRoomMembersRequest(roomId: '', page: 1));
    registerFallbackValue(<RoomMemberEntity>[]);
    registerFallbackValue(ContactModel(id: '', nickname: ''));
    registerFallbackValue(RoomMemberEntity(
      roomId: '',
      roomType: RoomType.system,
      account: ContactModel(id: '', nickname: ''),
    ));
    registerFallbackValue(FakeRoomEntity());
  });

  // Helper method to create a mock entity for testing
  RoomSubscriptionEntity createTestEntity() {
    return const RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'room-id',
      accountId: 'account-id',
      isPinned: false,
      isMuted: false,
      isHidden: false,
      isLocalDeleting: false,
    );
  }

  setUp(() {
    // Clear any existing registrations
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }

    // Register mock logger
    GetIt.I.registerSingleton<LoggerService>(MockLoggerService());

    mockChatRoomServerRepository = MockChatRoomServerRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockRoomSubLocalRepository = MockRoomSubLocalRepository();
    mockRoomMemberLocalRepository = MockRoomMemberLocalRepository();
    mockContactLocalRepository = MockContactLocalRepository();

    useCase = OpenSystemChatAndSaveToDbUseCase(
      chatRoomServerRepository: mockChatRoomServerRepository,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      roomSubLocalRepository: mockRoomSubLocalRepository,
      roomMemberLocalRepository: mockRoomMemberLocalRepository,
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  tearDown(() {
    // Clean up GetIt registrations after each test
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
    reset(mockChatRoomServerRepository);
    reset(mockChatRoomLocalRepository);
    reset(mockRoomSubLocalRepository);
    reset(mockRoomMemberLocalRepository);
    reset(mockContactLocalRepository);
  });

  group('OpenSystemChatAndSaveToDbUseCase', () {
    test('should return room entity when successful', () async {
      // Arrange
      final roomEntity = RoomEntity(
        id: 'room-id',
        roomName: 'Test Room',
        roomType: RoomType.system,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final roomSubEntity = RoomSubscriptionEntity(
        id: 'sub-id',
        roomId: 'room-id',
        accountId: 'account-id',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final response = OpenSystemChatResponse(room: roomEntity, roomSub: roomSubEntity);
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );

      when(() => mockChatRoomServerRepository.openSystemChat()).thenAnswer((_) async => response);
      when(() => mockChatRoomLocalRepository.putRoom(any())).thenAnswer((_) async => roomEntity);
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());
      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('room-id'))
          .thenAnswer((_) async => createTestEntity());

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      expect(result, equals(roomEntity));
      verify(() => mockChatRoomLocalRepository.putRoom(any())).called(1);
      verify(() => mockRoomSubLocalRepository.putRoomSubscription(any(that: isA<RoomSubscriptionEntity>()))).called(2);
    });

    test('should return null when server response is null', () async {
      // Arrange

      when(() => mockChatRoomServerRepository.openSystemChat()).thenAnswer((_) async => null);

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      expect(result, isNull);
      verifyNever(() => mockChatRoomLocalRepository.putRoom(any()));
      verifyNever(() => mockRoomSubLocalRepository.putRoomSubscription(any()));
    });

    test('should handle response with room but no roomSub', () async {
      // Arrange
      final roomEntity = RoomEntity(
        id: 'room-id',
        roomName: 'Test Room',
        roomType: RoomType.system,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final response = OpenSystemChatResponse(room: roomEntity, roomSub: null);
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );

      when(() => mockChatRoomServerRepository.openSystemChat()).thenAnswer((_) async => response);
      when(() => mockChatRoomLocalRepository.putRoom(any())).thenAnswer((_) async => roomEntity);
      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('room-id')).thenAnswer((_) async => null);

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      expect(result, equals(roomEntity));
      verify(() => mockChatRoomLocalRepository.putRoom(any())).called(1);
      verifyNever(() => mockRoomSubLocalRepository.putRoomSubscription(any()));
    });

    test('should fetch room members with nicknames and update hasFirstOtherInRoom', () async {
      // Arrange
      final roomId = 'room-id';
      final member1Entity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-1', nickname: 'Member 1'),
        joinedAt: DateTime.now(),
      );
      final member2Entity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-2', nickname: 'Member 2'),
        joinedAt: DateTime.now(),
      );
      final contact = ContactEntity(id: 'account-1', nickname: 'TestNickname');
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [member1Entity, member2Entity],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 2,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => contact);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      final captured = verify(() => mockRoomSubLocalRepository.putRoomSubscription(captureAny())).captured;
      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isTrue);
      verify(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).called(1);
    });

    test('should handle multiple pages of room members', () async {
      // Arrange
      final roomId = 'room-id';
      final member1Entity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-1', nickname: 'Member 1'),
        joinedAt: DateTime.now(),
      );
      final member2Entity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-2', nickname: 'Member 2'),
        joinedAt: DateTime.now(),
      );

      final page1Response = PaginationPayload<RoomMemberEntity>(
        data: [member1Entity],
        page: 1,
        pageSize: 1,
        totalPages: 2,
        total: 2,
      );
      final page2Response = PaginationPayload<RoomMemberEntity>(
        data: [member2Entity],
        page: 2,
        pageSize: 1,
        totalPages: 2,
        total: 2,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(
            any(that: isA<GetRoomMembersRequest>().having((req) => req.page, 'page', 1)),
          )).thenAnswer((_) async => page1Response);
      when(() => mockChatRoomServerRepository.getMembersInRoom(
            any(that: isA<GetRoomMembersRequest>().having((req) => req.page, 'page', 2)),
          )).thenAnswer((_) async => page2Response);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      verify(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).called(2);
    });

    test('should set hasFirstOtherInRoom to false when memberCount is 1', () async {
      // Arrange
      final roomId = 'room-id';
      final memberEntity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-1', nickname: 'Member 1'),
        joinedAt: DateTime.now(),
      );
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [memberEntity],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      final captured = verify(() => mockRoomSubLocalRepository.putRoomSubscription(captureAny())).captured;
      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isFalse);
    });

    test('should handle empty room member data', () async {
      // Arrange
      final roomId = 'room-id';
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: null,
        // Testing null data
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 0,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      final captured = verify(() => mockRoomSubLocalRepository.putRoomSubscription(captureAny())).captured;
      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isFalse);
      verifyNever(() => mockRoomMemberLocalRepository.updateAllRoomMember(any()));
    });

    test('should rethrow exception when fetching room members fails', () async {
      // Arrange
      final roomId = 'room-id';
      final exception = Exception('Network error');

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase.fetchRoomMemberAndSaveToDb(roomId),
        throwsA(same(exception)),
      );
    });

    test('should handle member without accountId', () async {
      // Arrange
      final roomId = 'room-id';
      final memberEntity = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: '', nickname: ''), // Empty account ID
        joinedAt: DateTime.now(),
      );
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [memberEntity],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      verify(() => mockContactLocalRepository.getContact(any())).called(1);
      verify(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).called(1);
    });

    test('should handle contact lookup failure', () async {
      // Arrange
      final roomId = 'room-id';
      final member = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-1', nickname: 'Test Nickname'),
        joinedAt: DateTime.now(),
      );
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [member],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact('account-1')).thenThrow(Exception('Contact not found'));

      // Act & Assert
      expect(
        () => useCase.fetchRoomMemberAndSaveToDb(roomId),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle putRoom failure', () async {
      // Arrange
      final roomEntity = RoomEntity(
        id: 'room-id',
        roomName: 'Test Room',
        roomType: RoomType.system,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final response = OpenSystemChatResponse(room: roomEntity, roomSub: null);

      when(() => mockChatRoomServerRepository.openSystemChat()).thenAnswer((_) async => response);
      when(() => mockChatRoomLocalRepository.putRoom(any())).thenThrow(Exception('Put room failed'));

      // Act & Assert
      expect(
        () => useCase.call(NoParams()),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle large memberCount correctly', () async {
      // Arrange
      final roomId = 'room-id';
      final members = List.generate(
          100,
          (index) => RoomMemberEntity(
                roomId: roomId,
                roomType: RoomType.group,
                account: ContactModel(id: 'account-$index', nickname: 'Member $index'),
                joinedAt: DateTime.now(),
              ));
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: members,
        page: 1,
        pageSize: 100,
        totalPages: 1,
        total: 100,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async {
        return null;
      });

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      final captured = verify(() => mockRoomSubLocalRepository.putRoomSubscription(captureAny())).captured;
      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isTrue); // Should be true for memberCount > 1
      verify(() => mockContactLocalRepository.getContact(any())).called(100);
    });

    test('should handle zero total pages', () async {
      // Arrange
      final roomId = 'room-id';
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [],
        page: 1,
        pageSize: 10,
        totalPages: 0,
        // Zero pages
        total: 0,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId)).thenAnswer((_) async => null);

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      verify(() => mockChatRoomServerRepository.getMembersInRoom(any())).called(1);
      verifyNever(() => mockRoomMemberLocalRepository.updateAllRoomMember(any()));
      verifyNever(() => mockRoomSubLocalRepository.putRoomSubscription(any()));
    });

    test('should handle member with account but no nickname in contact', () async {
      // Arrange
      final roomId = 'room-id';
      final member = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'account-1', nickname: 'Test Nickname'),
        joinedAt: DateTime.now(),
      );
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [member],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 1,
      );
      final contact = ContactEntity(id: 'account-1'); // No nickname

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact('account-1')).thenAnswer((_) async => contact);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId)).thenAnswer((_) async => null);

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      expect(member.account.nickname, equals('Test Nickname')); // Should remain unchanged
    });

    test('should handle different room member roles', () async {
      // Arrange
      final roomId = 'room-id';
      final adminMember = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'admin-1', nickname: 'Admin'),
        joinedAt: DateTime.now(),
      );
      final regularMember = RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.system,
        account: ContactModel(id: 'user-1', nickname: 'User'),
        joinedAt: DateTime.now(),
      );
      final membersResponse = PaginationPayload<RoomMemberEntity>(
        data: [adminMember, regularMember],
        page: 1,
        pageSize: 10,
        totalPages: 1,
        total: 2,
      );

      when(() => mockChatRoomServerRepository.getMembersInRoom(any())).thenAnswer((_) async => membersResponse);
      when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
      when(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});
      when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(roomId))
          .thenAnswer((_) async => createTestEntity());
      when(() => mockRoomSubLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => createTestEntity());

      // Act
      await useCase.fetchRoomMemberAndSaveToDb(roomId);

      // Assert
      verify(() => mockRoomMemberLocalRepository.updateAllRoomMember(any())).called(1);
      verify(() => mockRoomSubLocalRepository.putRoomSubscription(any(that: isA<RoomSubscriptionEntity>()))).called(1);
    });
  });
}
