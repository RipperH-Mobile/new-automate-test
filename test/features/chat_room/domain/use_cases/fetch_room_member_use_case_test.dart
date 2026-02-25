import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';

// Mock classes
class MockLoggerService extends Mock implements LoggerService {}

class MockRoomMemberDb extends Mock implements RoomMemberDb {}

class MockRoomSubscriptionDb extends Mock implements RoomSubscriptionDb {}

class MockChatRoomApiService extends Mock implements ChatRoomApiService {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes for fallback values
class FakeGetRoomMembersRequest extends Fake implements GetRoomMembersRequest {}

class FakeRoomMemberCollection extends Fake implements RoomMemberCollection {}

class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

class FakeContactModel extends Fake implements ContactModel {}

void main() {
  late FetchRoomMemberUseCase useCase;
  late MockLoggerService mockLogger;
  late MockRoomMemberDb mockRoomMemberDb;
  late MockRoomSubscriptionDb mockRoomSubDb;
  late MockChatRoomApiService mockChatRoomApiService;
  late MockContactLocalRepository mockContactLocalRepository;
  late String testRoomId;
  late ContactModel testContactModel;
  late ContactEntity testContactEntity;
  late RoomMemberCollection testRoomMemberCollection;
  late RoomSubscriptionCollection testRoomSubscription;
  late PaginationPayload<RoomMemberCollection> testApiResponse;

  setUpAll(() {
    registerFallbackValue(FakeGetRoomMembersRequest());
    registerFallbackValue(FakeRoomMemberCollection());
    registerFallbackValue(FakeRoomSubscriptionCollection());
    registerFallbackValue(FakeContactModel());
    registerFallbackValue(true);
    registerFallbackValue(<RoomMemberCollection>[]);
  });

  setUp(() {
    mockLogger = MockLoggerService();
    mockRoomMemberDb = MockRoomMemberDb();
    mockRoomSubDb = MockRoomSubscriptionDb();
    mockChatRoomApiService = MockChatRoomApiService();
    mockContactLocalRepository = MockContactLocalRepository();

    useCase = FetchRoomMemberUseCase(
      log: mockLogger,
      roomMemberDb: mockRoomMemberDb,
      roomSubDb: mockRoomSubDb,
      chatRoomApiService: mockChatRoomApiService,
      contactLocalRepository: mockContactLocalRepository,
    );

    testRoomId = 'test-room-id';

    testContactModel = ContactModel(
      id: 'test-account-id',
      displayName: 'Test User',
      nickname: 'TestNick',
    );

    testContactEntity = ContactEntity(
      id: 'test-account-id',
      displayName: 'Test User',
      nickname: 'TestNick',
    );

    testRoomMemberCollection = RoomMemberCollection(
      roomId: testRoomId,
      roomType: RoomType.group,
      joinedAt: DateTime.now(),
      groupRole: GroupMemberRoleModel(
        role: RoomMemberRole.member,
        permissions: GroupAdminPermissionModel(
          setGroupPermissions: false,
          changeGroupInfo: false,
          pinMessages: false,
          deleteOtherMessages: false,
          groupMemberSetting: false,
          // muteOrBlockMembers: false,
          // approveJoinRequests: false,
          // enableOrDisableSlowMode: false,
        ),
      ),
      account: testContactModel,
    );

    testRoomSubscription = RoomSubscriptionCollection(
      id: 'test-subscription-id',
      roomId: testRoomId,
      hasFirstOtherInRoom: false,
    );

    testApiResponse = PaginationPayload<RoomMemberCollection>(
      data: [testRoomMemberCollection],
      page: 1,
      totalPages: 1,
      total: 1,
      pageSize: 100,
    );
  });

  group('FetchRoomMemberUseCase', () {
    test(
      'Given valid room ID, When fetching room members, Then returns members and hasFirstOtherInRoom status',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1, isA<List<RoomMemberEntity>>());
        expect(result.$1.length, equals(1));
        expect(result.$1.first.roomId, equals(testRoomId));
        expect(result.$2, equals(false)); // hasFirstOtherInRoom = false for 1 member
        verify(() => mockChatRoomApiService.getMembersInRoom(any())).called(1);
        verify(() => mockContactLocalRepository.getContact('test-account-id')).called(1);
        verify(() => mockRoomMemberDb.updateAllRoomMember(any())).called(1);
        verify(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(testRoomId)).called(1);
        verify(() => mockRoomSubDb.putRoomSubscription(any())).called(1);
      },
    );

    test(
      'Given null room ID, When fetching room members, Then returns empty list and false',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: null,
          useTransaction: true,
          saveToDb: true,
        );

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1, isEmpty);
        expect(result.$2, equals(false));
        verifyNever(() => mockChatRoomApiService.getMembersInRoom(any()));
        verifyNever(() => mockContactLocalRepository.getContact(any()));
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
        verifyNever(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any()));
      },
    );

    test(
      'Given empty room ID, When fetching room members, Then returns empty list and false',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: '',
          useTransaction: true,
          saveToDb: true,
        );

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1, isEmpty);
        expect(result.$2, equals(false));
        verifyNever(() => mockChatRoomApiService.getMembersInRoom(any()));
        verifyNever(() => mockContactLocalRepository.getContact(any()));
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
        verifyNever(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any()));
      },
    );

    test(
      'Given multiple members, When fetching room members, Then returns hasFirstOtherInRoom as true',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final secondMember = RoomMemberCollection(
          roomId: testRoomId,
          roomType: RoomType.group,
          account: ContactModel(
            id: 'test-account-id-2',
            displayName: 'Test User 2',
          ),
        );

        final multiMemberResponse = PaginationPayload<RoomMemberCollection>(
          data: [testRoomMemberCollection, secondMember],
          page: 1,
          totalPages: 1,
          total: 2,
          pageSize: 100,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => multiMemberResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(2));
        expect(result.$2, equals(true)); // hasFirstOtherInRoom = true for 2+ members
        verify(() => mockContactLocalRepository.getContact('test-account-id')).called(1);
        verify(() => mockContactLocalRepository.getContact('test-account-id-2')).called(1);
      },
    );

    test(
      'Given saveToDb false, When fetching room members, Then does not save to database',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: false,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        expect(result.$2, equals(false));
        verify(() => mockChatRoomApiService.getMembersInRoom(any())).called(1);
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
        verifyNever(() => mockRoomMemberDb.updateAllRoomMemberWithoutTxn(any()));
        verifyNever(() => mockRoomSubDb.putRoomSubscription(any()));
        verifyNever(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any()));
      },
    );

    test(
      'Given useTransaction false, When fetching room members, Then uses non-transaction methods',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: false,
          saveToDb: true,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomMemberDb.updateAllRoomMemberWithoutTxn(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        verify(() => mockRoomMemberDb.updateAllRoomMemberWithoutTxn(any())).called(1);
        verify(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).called(1);
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
        verifyNever(() => mockRoomSubDb.putRoomSubscription(any()));
      },
    );

    test(
      'Given contact with nickname, When fetching room members, Then updates member with nickname',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final contactWithNickname = ContactEntity(
          id: 'test-account-id',
          displayName: 'Test User',
          nickname: 'CustomNickname',
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => contactWithNickname);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        expect(result.$1.first.account.nickname, equals('CustomNickname'));
        verify(() => mockContactLocalRepository.getContact('test-account-id')).called(1);
      },
    );

    test(
      'Given member without account ID, When fetching room members, Then skips contact lookup',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final memberWithoutAccountId = RoomMemberCollection(
          roomId: testRoomId,
          roomType: RoomType.group,
          account: ContactModel(
            id: null,
            displayName: 'Test User',
          ),
        );

        final responseWithoutAccountId = PaginationPayload<RoomMemberCollection>(
          data: [memberWithoutAccountId],
          page: 1,
          totalPages: 1,
          total: 1,
          pageSize: 100,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => responseWithoutAccountId);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        verifyNever(() => mockContactLocalRepository.getContact(any()));
      },
    );

    test(
      'Given multiple pages of members, When fetching room members, Then fetches all pages',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final firstPageResponse = PaginationPayload<RoomMemberCollection>(
          data: [testRoomMemberCollection],
          page: 1,
          totalPages: 2,
          total: 2,
          pageSize: 100,
        );

        final secondMember = RoomMemberCollection(
          roomId: testRoomId,
          roomType: RoomType.group,
          account: ContactModel(
            id: 'test-account-id-2',
            displayName: 'Test User 2',
          ),
        );

        final secondPageResponse = PaginationPayload<RoomMemberCollection>(
          data: [secondMember],
          page: 2,
          totalPages: 2,
          total: 2,
          pageSize: 100,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((invocation) async {
          final request = invocation.positionalArguments[0] as GetRoomMembersRequest;
          if (request.page == 1) {
            return firstPageResponse;
          } else {
            return secondPageResponse;
          }
        });

        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(2));
        expect(result.$2, equals(true)); // hasFirstOtherInRoom = true for 2+ members
        verify(() => mockChatRoomApiService.getMembersInRoom(any())).called(2);
        verify(() => mockRoomMemberDb.updateAllRoomMember(any())).called(2);
      },
    );

    test(
      'Given API response with null data, When fetching room members, Then skips processing',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final responseWithNullData = PaginationPayload<RoomMemberCollection>(
          data: null,
          page: 1,
          totalPages: 1,
          total: 0,
          pageSize: 100,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => responseWithNullData);
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockRoomSubDb.putRoomSubscription(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1, isEmpty);
        expect(result.$2, equals(false));
        verifyNever(() => mockContactLocalRepository.getContact(any()));
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
      },
    );

    test(
      'Given room subscription not found, When updating hasFirstOtherInRoom, Then returns calculated value without saving',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        expect(result.$2, equals(false)); // hasFirstOtherInRoom = false for 1 member
        verify(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(testRoomId)).called(1);
        verifyNever(() => mockRoomSubDb.putRoomSubscription(any()));
        verifyNever(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any()));
      },
    );

    test(
      'Given API service throws exception, When fetching room members, Then rethrows exception and logs error',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final exception = Exception('API error');
        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(params),
          throwsA(equals(exception)),
        );
        verify(() => mockLogger.e('fetchRoomMemberAndSaveToDb error', exception, any())).called(1);
        verifyNever(() => mockContactLocalRepository.getContact(any()));
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
      },
    );

    test(
      'Given room subscription update throws exception, When updating hasFirstOtherInRoom, Then logs error and returns false',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenAnswer((_) async {});
        when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenThrow(Exception('Database error'));

        // When
        final result = await useCase(params);

        // Then
        expect(result.$1.length, equals(1));
        expect(result.$2, equals(false));
        verify(() => mockLogger.e('update first other error', any(), any())).called(1);
      },
    );

    test(
      'Given contact lookup throws exception, When fetching room members, Then rethrows exception and logs error',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final exception = Exception('Contact lookup error');
        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(params),
          throwsA(equals(exception)),
        );
        verify(() => mockContactLocalRepository.getContact('test-account-id')).called(1);
        verify(() => mockLogger.e('fetchRoomMemberAndSaveToDb error', exception, any())).called(1);
        verifyNever(() => mockRoomMemberDb.updateAllRoomMember(any()));
      },
    );

    test(
      'Given database save throws exception, When saving members, Then rethrows exception and logs error',
      () async {
        // Given
        final params = FetchRoomMemberParams(
          roomId: testRoomId,
          useTransaction: true,
          saveToDb: true,
        );

        final exception = Exception('Database save error');
        when(() => mockChatRoomApiService.getMembersInRoom(any())).thenAnswer((_) async => testApiResponse);
        when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => testContactEntity);
        when(() => mockRoomMemberDb.updateAllRoomMember(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(params),
          throwsA(equals(exception)),
        );
        verify(() => mockLogger.e('fetchRoomMemberAndSaveToDb error', exception, any())).called(1);
      },
    );
  });
}
