import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_all_room_last_seen_request.dart';
import 'package:uchat/features/chat_room/domain/entities/get_all_room_last_seen_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/get_all_room_last_seen_use_case.dart';

// Mock classes
class MockConfigDb extends Mock implements ConfigDb {}

class MockConfigInstance extends Mock implements ConfigInstance {}

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockRoomMemberCollection extends Mock implements RoomMemberCollection {}

// Fake classes for complex types
class FakeRoomUpdateEvent extends Fake implements RoomUpdateEvent {}

class FakeRoomCollection extends Fake implements RoomCollection {}

class FakeGetAllRoomLastSeenRequest extends Fake implements GetAllRoomLastSeenRequest {}

class FakeRoomMemberEntity extends Fake implements RoomMemberEntity {}

class FakeRoomMemberCollection extends Fake implements RoomMemberCollection {}

class FakeGetAllRoomLastSeenEntity extends Fake implements GetAllRoomLastSeenEntity {}

void main() {
  late GetAllRoomLastSeenUseCase useCase;
  late MockConfigDb mockConfigDb;
  late MockConfigInstance mockConfigInstance;
  late MockChatRoomLocalCompatRepository mockChatRoomLocalRepository;
  late MockChatRoomListServerRepository mockChatRoomListServerRepository;

  // Test data
  late DateTime testDateTime;
  late String testConfigKey;
  late List<GetAllRoomLastSeenEntity> testEntities;
  late RoomEntity testRoomEntity;
  late RoomMemberEntity testRoomMemberEntity;
  late ContactModel testContactModel;

  // Mock callback functions
  late Function(RoomUpdateEvent) mockOnRoomUpdateEvent;
  late Function(RoomCollection) mockOnUpdateOnlineStatus;

  setUpAll(() {
    // Register fallback values for complex types
    registerFallbackValue(FakeRoomUpdateEvent());
    registerFallbackValue(FakeRoomCollection());
    registerFallbackValue(FakeGetAllRoomLastSeenRequest());
    registerFallbackValue(FakeRoomMemberEntity());
    registerFallbackValue(FakeGetAllRoomLastSeenEntity());
  });

  setUp(() {
    // Initialize mocks
    mockConfigDb = MockConfigDb();
    mockConfigInstance = MockConfigInstance();
    mockChatRoomLocalRepository = MockChatRoomLocalCompatRepository();
    mockChatRoomListServerRepository = MockChatRoomListServerRepository();

    // Initialize test data
    testDateTime = DateTime(2024, 1, 1, 12, 0, 0);
    testConfigKey = 'ALL_ROOM_LAST_SEEN_LAST_SYNC';

    testContactModel = ContactModel(
      id: 'contact123',
      displayName: 'Test Contact',
    );

    testRoomMemberEntity = RoomMemberEntity(
      account: testContactModel,
      roomId: 'room123',
      roomType: RoomType.direct,
    );

    testRoomEntity = RoomEntity(
      id: 'room123',
      roomName: 'Test Room',
      roomType: RoomType.direct,
      createdAt: testDateTime,
      updatedAt: testDateTime,
    );

    testEntities = [
      GetAllRoomLastSeenEntity(
        roomId: 'room123',
        members: [testRoomMemberEntity],
      ),
    ];

    // Initialize mock callback functions
    mockOnRoomUpdateEvent = (RoomUpdateEvent event) {};
    mockOnUpdateOnlineStatus = (RoomCollection room) {};

    // Initialize use case
    useCase = GetAllRoomLastSeenUseCase(
      configDb: mockConfigDb,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      chatRoomListServerRepository: mockChatRoomListServerRepository,
    );

    // Reset mocks before each test
    reset(mockConfigDb);
    reset(mockConfigInstance);
    reset(mockChatRoomLocalRepository);
    reset(mockChatRoomListServerRepository);
  });

  group('GetAllRoomLastSeenUseCase', () {
    group('constructor', () {
      test('Given valid dependencies, When creating instance, Then instance is created successfully', () {
        // Given
        final configDb = MockConfigDb();
        final chatRoomLocalRepository = MockChatRoomLocalCompatRepository();
        final chatRoomListServerRepository = MockChatRoomListServerRepository();

        // When
        final useCase = GetAllRoomLastSeenUseCase(
          configDb: configDb,
          chatRoomLocalRepository: chatRoomLocalRepository,
          chatRoomListServerRepository: chatRoomListServerRepository,
        );

        // Then
        expect(useCase.configDb, equals(configDb));
        expect(useCase.chatRoomLocalRepository, equals(chatRoomLocalRepository));
        expect(useCase.chatRoomListServerRepository, equals(chatRoomListServerRepository));
      });
    });

    group('call', () {
      test(
          'Given valid params with response data, When call is executed, Then completes successfully with all operations',
          () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => testEntities);
        when(() => mockChatRoomLocalRepository.getRoom('room123')).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async => {});

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        verify(() => mockConfigInstance.saveConfig(
              key: testConfigKey,
              value: any(named: 'value', that: isA<DateTime>()),
            )).called(1);
        verify(() => mockConfigInstance.getDateTime(key: testConfigKey)).called(1);
        verify(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any(
              that: isA<GetAllRoomLastSeenRequest>(),
            ))).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom('room123')).called(1);
        verify(() => mockChatRoomLocalRepository.updateAllRoomMember(any(
              that: isA<List<RoomMemberEntity>>(),
            ))).called(1);
      });

      test('Given valid params with null response, When call is executed, Then completes without processing rooms',
          () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => null);

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        verify(() => mockConfigInstance.saveConfig(
              key: testConfigKey,
              value: any(named: 'value', that: isA<DateTime>()),
            )).called(1);
        verify(() => mockConfigInstance.getDateTime(key: testConfigKey)).called(1);
        verify(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockChatRoomLocalRepository.updateAllRoomMember(any()));
      });

      test('Given valid params with empty response, When call is executed, Then completes without processing rooms',
          () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => []);

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        verify(() => mockConfigInstance.saveConfig(
              key: testConfigKey,
              value: any(named: 'value', that: isA<DateTime>()),
            )).called(1);
        verify(() => mockConfigInstance.getDateTime(key: testConfigKey)).called(1);
        verify(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockChatRoomLocalRepository.updateAllRoomMember(any()));
      });

      test(
          'Given response with room that does not exist locally, When call is executed, Then skips processing that room',
          () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => testEntities);
        when(() => mockChatRoomLocalRepository.getRoom('room123')).thenAnswer((_) async => null); // Room not found

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        verify(() => mockConfigInstance.saveConfig(
              key: testConfigKey,
              value: any(named: 'value', that: isA<DateTime>()),
            )).called(1);
        verify(() => mockConfigInstance.getDateTime(key: testConfigKey)).called(1);
        verify(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom('room123')).called(1);
        verifyNever(() => mockChatRoomLocalRepository.updateAllRoomMember(any()));
      });

      test(
          'Given response with multiple rooms where some exist and some do not, When call is executed, Then processes only existing rooms',
          () async {
        // Given
        final multipleEntities = [
          GetAllRoomLastSeenEntity(
            roomId: 'room123',
            members: [testRoomMemberEntity],
          ),
          GetAllRoomLastSeenEntity(
            roomId: 'room456',
            members: [testRoomMemberEntity],
          ),
        ];

        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any()))
            .thenAnswer((_) async => multipleEntities);
        when(() => mockChatRoomLocalRepository.getRoom('room123')).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.getRoom('room456')).thenAnswer((_) async => null); // Room not found
        when(() => mockChatRoomLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async => {});

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        verify(() => mockChatRoomLocalRepository.getRoom('room123')).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom('room456')).called(1);
        verify(() => mockChatRoomLocalRepository.updateAllRoomMember(any())).called(1);
      });

      test('Given config save operation, When call is executed, Then saves current DateTime with correct key',
          () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => null);

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        final captured = verify(() => mockConfigInstance.saveConfig(
              key: captureAny(named: 'key'),
              value: captureAny(named: 'value'),
            )).captured;

        expect(captured[0], equals(testConfigKey));
        expect(captured[1], isA<DateTime>());
      });

      test('Given request creation, When call is executed, Then creates request with retrieved DateTime', () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => null);

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        final captured = verify(() => mockChatRoomListServerRepository.getAllRoomLastSeen(
              captureAny(),
            )).captured;

        final capturedRequest = captured.single as GetAllRoomLastSeenRequest;
        expect(capturedRequest.lastSyncAt, equals(testDateTime));
      });

      test('Given successful room processing, When call is executed, Then calls both callback functions', () async {
        // Given
        var roomUpdateEventCalled = false;
        var updateOnlineStatusCalled = false;
        RoomUpdateEvent? capturedRoomUpdateEvent;
        RoomCollection? capturedRoomCollection;

        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => testEntities);
        when(() => mockChatRoomLocalRepository.getRoom('room123')).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async => {});

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: (RoomUpdateEvent event) {
            roomUpdateEventCalled = true;
            capturedRoomUpdateEvent = event;
          },
          onUpdateOnlineStatus: (RoomCollection room) {
            updateOnlineStatusCalled = true;
            capturedRoomCollection = room;
          },
        );

        // When
        await useCase.call(params);

        // Then
        expect(roomUpdateEventCalled, isTrue);
        expect(updateOnlineStatusCalled, isTrue);
        expect(capturedRoomUpdateEvent, isNotNull);
        expect(capturedRoomCollection, isNotNull);
        expect(capturedRoomUpdateEvent!.room, isA<RoomCollection>());
        expect(capturedRoomCollection, isA<RoomCollection>());
      });

      test('Given member entity mapping, When call is executed, Then passes member entities correctly', () async {
        // Given
        when(() => mockConfigDb.authenticated).thenReturn(mockConfigInstance);
        when(() => mockConfigInstance.saveConfig(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => {});
        when(() => mockConfigInstance.getDateTime(key: any(named: 'key'))).thenAnswer((_) async => testDateTime);
        when(() => mockChatRoomListServerRepository.getAllRoomLastSeen(any())).thenAnswer((_) async => testEntities);
        when(() => mockChatRoomLocalRepository.getRoom('room123')).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.updateAllRoomMember(any())).thenAnswer((_) async => {});

        final params = GetAllRoomLastSeenParams(
          onRoomUpdateEvent: mockOnRoomUpdateEvent,
          onUpdateOnlineStatus: mockOnUpdateOnlineStatus,
        );

        // When
        await useCase.call(params);

        // Then
        final captured = verify(() => mockChatRoomLocalRepository.updateAllRoomMember(
              captureAny(),
            )).captured;

        final capturedEntities = captured.single as List<RoomMemberEntity>;
        expect(capturedEntities, hasLength(1));
        expect(capturedEntities.first, equals(testRoomMemberEntity));
      });
    });
  });

  group('GetAllRoomLastSeenParams', () {
    test('Given valid callback functions, When creating params, Then params are created successfully', () {
      // Given
      final onRoomUpdateEvent = (RoomUpdateEvent event) {};
      final onUpdateOnlineStatus = (RoomCollection room) {};

      // When
      final params = GetAllRoomLastSeenParams(
        onRoomUpdateEvent: onRoomUpdateEvent,
        onUpdateOnlineStatus: onUpdateOnlineStatus,
      );

      // Then
      expect(params.onRoomUpdateEvent, equals(onRoomUpdateEvent));
      expect(params.onUpdateOnlineStatus, equals(onUpdateOnlineStatus));
    });
  });
}
