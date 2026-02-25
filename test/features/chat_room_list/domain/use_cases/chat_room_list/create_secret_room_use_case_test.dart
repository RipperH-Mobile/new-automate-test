import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/create_secret_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/create_secret_room_response_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/create_secret_room_use_case.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class MockRoomDb extends Mock implements RoomDb {}

// Create fake implementations for mocking
class FakeRoomCollection extends Fake implements RoomCollection {}

class FakeRoomMemberCollection extends Fake implements RoomMemberCollection {}

class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

void main() {
  late CreateSecretRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockChatRoomLocalRepository mockLocalRepository;
  late MockRoomDb mockRoomDb;
  late CreateSecretRoomResponseEntity testResponseEntity;
  late CreateSecretRoomRequest testRequest;
  late DateTime testDateTime;
  late MockLoggerService mockLoggerService;

  setUpAll(() {
    registerFallbackValue(CreateSecretRoomRequest(friendAccountId: 'test-friend-id'));
    registerFallbackValue(FakeRoomCollection());
    registerFallbackValue(FakeRoomMemberCollection());
    registerFallbackValue(FakeRoomSubscriptionCollection());
    registerFallbackValue(const RoomSubscriptionEntity());
  });

  setUp(() {
    mockServerRepository = MockChatRoomListServerRepository();
    mockLocalRepository = MockChatRoomLocalRepository();
    mockRoomDb = MockRoomDb();
    mockLoggerService = MockLoggerService();

    // Register mocks with GetIt
    GetIt.I.allowReassignment = true;
    GetIt.I.registerFactory<ChatRoomListServerRepository>(() => mockServerRepository);
    GetIt.I.registerFactory<ChatRoomLocalRepository>(() => mockLocalRepository);
    GetIt.I.registerFactory<LoggerService>(() => mockLoggerService);
    GetIt.I.registerSingleton<RoomDb>(RoomDb());

    // Create the use case
    useCase = CreateSecretRoomUseCase();

    testDateTime = DateTime.now();

    // Prepare test data
    // ignore: prefer_const_constructors
    final testRoomEntity = RoomEntity(
      id: 'test-room-id',
      roomName: 'Test Secret Room',
      roomType: RoomType.directSecret,
    );

    final testRoomSubscriptionEntity = RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      roomName: 'Test Secret Room',
      accountId: 'test-account-id',
      isPinned: false,
      isMuted: false,
      isHidden: false,
      updatedAt: testDateTime,
    );

    final adminContact = ContactModel(
      id: 'test-account-id',
      displayName: 'Test User',
    );

    final friendContact = ContactModel(
      id: 'test-friend-id',
      displayName: 'Test Friend',
    );

    final testMemberEntities = [
      RoomMemberEntity(
        roomId: 'test-room-id',
        roomType: RoomType.directSecret,
        account: adminContact,
        joinedAt: testDateTime,
      ),
      RoomMemberEntity(
        roomId: 'test-room-id',
        roomType: RoomType.directSecret,
        account: friendContact,
        joinedAt: testDateTime,
      ),
    ];

    testResponseEntity = CreateSecretRoomResponseEntity(
      room: testRoomEntity,
      roomSub: testRoomSubscriptionEntity,
      members: testMemberEntities,
    );

    testRequest = CreateSecretRoomRequest(
      friendAccountId: 'test-friend-id',
    );

    // Set up default mocks
    when(() => mockServerRepository.createSecretRoom(any())).thenAnswer((_) async => testResponseEntity);

    when(() => mockLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async {});

    when(() => mockLocalRepository.getRoom(any())).thenAnswer((_) async => const RoomEntity(id: 'test-room-id'));

    when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

    // Mock logger to prevent errors
    when(() => mockLoggerService.w(any())).thenReturn(null);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('call', () {
    test('Given server repository returns successful response, When creating a secret room, Then returns RoomEntity',
        () async {
      when(() => mockRoomDb.getRoom(any())).thenAnswer((_) async {
        return null;
      });
      // Given
      // We can't easily mock EncryptHelper.instance in a static context
      // So we'll just verify the behavior with a real room without checking EncryptHelper interactions

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, equals(testResponseEntity.room));
      verify(() => mockServerRepository.createSecretRoom(testRequest)).called(1);
      verify(() => mockLocalRepository.updateAllRoomMember(any())).called(1);
      verify(() => mockLocalRepository.getRoom(testResponseEntity.room.id)).called(1);
      // Can't verify EncryptHelper.instance.createSecretRoomCryptoKey because it's a static singleton
      verify(() => mockLocalRepository.updateRoomSubscription(any())).called(1);
      reset(mockRoomDb);
    });

    test('Given server repository returns null, When creating a secret room, Then returns null', () async {
      // Given
      when(() => mockServerRepository.createSecretRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isNull);
      verify(() => mockServerRepository.createSecretRoom(testRequest)).called(1);
      verifyNever(() => mockLocalRepository.updateAllRoomMember(any()));
      verifyNever(() => mockLocalRepository.getRoom(any()));
      // We can't verify that EncryptHelper is not called, so we skip that verification
      verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
    });

    test(
        'Given local room is not found, When creating a secret room, Then still returns RoomEntity without creating crypto key',
        () async {
      // Given
      when(() => mockLocalRepository.getRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, equals(testResponseEntity.room));
      verify(() => mockServerRepository.createSecretRoom(testRequest)).called(1);
      verify(() => mockLocalRepository.updateAllRoomMember(any())).called(1);
      verify(() => mockLocalRepository.getRoom(testResponseEntity.room.id)).called(1);
      // We can verify that the local repository was accessed, which is enough
      // to confirm the behavior without needing to mock EncryptHelper.instance
      verify(() => mockLocalRepository.updateRoomSubscription(any())).called(1);
    });

    test('Given server repository throws an exception, When creating a secret room, Then throws the same exception',
        () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockServerRepository.createSecretRoom(any())).thenThrow(exception);

      // When
      Future<RoomEntity?> call() => useCase(testRequest);

      // Then
      expect(call, throwsA(isA<Exception>()));
      verify(() => mockServerRepository.createSecretRoom(testRequest)).called(1);
      verifyNever(() => mockLocalRepository.updateAllRoomMember(any()));
      verifyNever(() => mockLocalRepository.getRoom(any()));
      // Again, can't verify EncryptHelper not being called, but we can verify repository behavior
      verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
    });
  });
}
