import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_join_group_use_case.dart';
import 'package:uchat/entities/enum/room_type.dart';

// Mock classes
class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class FakeAcceptGroupInviteRequest extends Fake implements AcceptGroupInviteRequest {}

class FakeRoomEntity extends Fake implements RoomEntity {}

void main() {
  late AcceptRoomHandleJoinGroupUseCase useCase;
  late MockChatRoomLocalCompatRepository mockChatRoomLocalRepository;
  late MockChatRoomListServerRepository mockChatRoomListServerRepository;
  late AcceptGroupInviteRequest testRequest;
  late RoomEntity testRoomEntity;

  setUpAll(() {
    registerFallbackValue(FakeAcceptGroupInviteRequest());
    registerFallbackValue(FakeRoomEntity());

    // Initialize event bus once for all tests if needed
    try {
      // Try to access eventBus to see if it's initialized
      eventBus;
    } catch (_) {
      // If not initialized, initialize it
      initializeEventBus(enableTracking: false);
    }
  });

  setUp(() {
    mockChatRoomLocalRepository = MockChatRoomLocalCompatRepository();
    mockChatRoomListServerRepository = MockChatRoomListServerRepository();

    useCase = AcceptRoomHandleJoinGroupUseCase(
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      chatRoomListServerRepository: mockChatRoomListServerRepository,
    );

    testRequest = AcceptGroupInviteRequest(roomId: 'test-room-id');
    testRoomEntity = const RoomEntity(
      id: 'test-room-id',
      roomType: RoomType.group,
      roomName: 'Test Room',
      isJoined: false,
    );

    // Reset mocks before each test
    reset(mockChatRoomLocalRepository);
    reset(mockChatRoomListServerRepository);
  });

  group('AcceptRoomHandleJoinGroupUseCase', () {
    group('constructor', () {
      test('Given required dependencies, When creating instance, Then instance is created successfully', () {
        // Given
        final localRepo = MockChatRoomLocalCompatRepository();
        final serverRepo = MockChatRoomListServerRepository();

        // When
        final instance = AcceptRoomHandleJoinGroupUseCase(
          chatRoomLocalRepository: localRepo,
          chatRoomListServerRepository: serverRepo,
        );

        // Then
        expect(instance, isNotNull);
        expect(instance.chatRoomLocalRepository, equals(localRepo));
        expect(instance.chatRoomListServerRepository, equals(serverRepo));
      });
    });

    group('call', () {
      test(
          'Given valid request and room exists, When call is executed, Then completes successfully with all operations',
          () async {
        // Given
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testRequest);

        // Then
        verify(() => mockChatRoomListServerRepository.acceptRoom(testRequest)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(testRequest.roomId)).called(1);
        verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(any(that: predicate<RoomEntity>((entity) {
              return entity.id == testRoomEntity.id &&
                  entity.isJoined == true &&
                  entity.roomType == testRoomEntity.roomType &&
                  entity.roomName == testRoomEntity.roomName;
            })))).called(1);

        // Note: Events are fired to the real event bus, not verified via mocks
      });

      test(
          'Given valid request and room exists, When call is executed, Then fires AcceptRequestEvent with correct roomId',
          () async {
        // Given
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        AcceptRequestEvent? capturedEvent;
        final subscription = eventBus.on<AcceptRequestEvent>().listen((event) {
          capturedEvent = event;
        });

        // When
        await useCase.call(testRequest);
        await Future.delayed(const Duration(milliseconds: 10)); // Allow event to propagate

        // Then
        expect(capturedEvent, isNotNull);
        expect(capturedEvent!.id, equals(testRequest.roomId));

        // Cleanup
        await subscription.cancel();
      });

      test('Given valid request and room exists, When call is executed, Then fires RequireGroupInviteUpdateEvent',
          () async {
        // Given
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        RequireGroupInviteUpdateEvent? capturedEvent;
        final subscription = eventBus.on<RequireGroupInviteUpdateEvent>().listen((event) {
          capturedEvent = event;
        });

        // When
        await useCase.call(testRequest);
        await Future.delayed(const Duration(milliseconds: 10)); // Allow event to propagate

        // Then
        expect(capturedEvent, isNotNull);

        // Cleanup
        await subscription.cancel();
      });

      test('Given valid request and room does not exist, When call is executed, Then completes without updating room',
          () async {
        // Given
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => null);

        // When
        await useCase.call(testRequest);

        // Then
        verify(() => mockChatRoomListServerRepository.acceptRoom(testRequest)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(testRequest.roomId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));

        // Note: AcceptRequestEvent should be fired but RequireGroupInviteUpdateEvent should not
      });

      test(
          'Given valid request and room does not exist, When call is executed, Then does not fire RequireGroupInviteUpdateEvent',
          () async {
        // Given
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => null);

        // When
        await useCase.call(testRequest);

        // Then
        // Verify no RequireGroupInviteUpdateEvent is fired
        RequireGroupInviteUpdateEvent? capturedEvent;
        final subscription = eventBus.on<RequireGroupInviteUpdateEvent>().listen((event) {
          capturedEvent = event;
        });

        // When
        await useCase.call(testRequest);
        await Future.delayed(const Duration(milliseconds: 10)); // Allow event to propagate

        // Then
        expect(capturedEvent, isNull);

        // Cleanup
        await subscription.cancel();
      });

      test('Given server repository throws exception, When call is executed, Then exception is propagated', () async {
        // Given
        final testException = Exception('Server error');
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenThrow(testException);

        // When & Then
        await expectLater(() => useCase.call(testRequest), throwsA(equals(testException)));

        // Verify that subsequent operations are not called
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test('Given local repository getRoom throws exception, When call is executed, Then exception is propagated',
          () async {
        // Given
        final testException = Exception('Local repository error');
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenThrow(testException);

        // When & Then
        await expectLater(() => useCase.call(testRequest), throwsA(equals(testException)));

        // Verify that server operation completed but local update failed
        verify(() => mockChatRoomListServerRepository.acceptRoom(testRequest)).called(1);
        // Note: AcceptRequestEvent should have been fired before the exception
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test(
          'Given local repository putOrUpdateRoom throws exception, When call is executed, Then exception is propagated',
          () async {
        // Given
        final testException = Exception('Put room error');
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => testRoomEntity);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenThrow(testException);

        // When & Then
        await expectLater(() => useCase.call(testRequest), throwsA(equals(testException)));

        // Verify that operations up to putOrUpdateRoom completed
        verify(() => mockChatRoomListServerRepository.acceptRoom(testRequest)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(testRequest.roomId)).called(1);
        verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).called(1);

        // Note: AcceptRequestEvent should have been fired before the exception
      });

      test('Given room with isJoined true, When call is executed, Then room is updated with isJoined true', () async {
        // Given
        final alreadyJoinedRoom = const RoomEntity(
          id: 'test-room-id',
          roomType: RoomType.group,
          roomName: 'Test Room',
          isJoined: true,
        );
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => alreadyJoinedRoom);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testRequest);

        // Then
        verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(any(that: predicate<RoomEntity>((entity) {
              return entity.id == alreadyJoinedRoom.id &&
                  entity.isJoined == true &&
                  entity.roomType == alreadyJoinedRoom.roomType &&
                  entity.roomName == alreadyJoinedRoom.roomName;
            })))).called(1);
      });

      test(
          'Given room with different roomType, When call is executed, Then room properties are preserved except isJoined',
          () async {
        // Given
        final directRoom = const RoomEntity(
          id: 'test-room-id',
          roomType: RoomType.direct,
          roomName: 'Direct Chat',
          isJoined: false,
          ownerId: 'owner-123',
          memberCount: 2,
        );
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {});
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => directRoom);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testRequest);

        // Then
        verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(any(that: predicate<RoomEntity>((entity) {
              return entity.id == directRoom.id &&
                  entity.isJoined == true &&
                  entity.roomType == directRoom.roomType &&
                  entity.roomName == directRoom.roomName &&
                  entity.ownerId == directRoom.ownerId &&
                  entity.memberCount == directRoom.memberCount;
            })))).called(1);
      });

      test('Given execution order, When call is executed, Then operations execute in correct sequence', () async {
        // Given
        final callOrder = <String>[];
        when(() => mockChatRoomListServerRepository.acceptRoom(any())).thenAnswer((_) async {
          callOrder.add('acceptRoom');
        });
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async {
          callOrder.add('getRoom');
          return testRoomEntity;
        });
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {
          callOrder.add('putOrUpdateRoom');
        });

        // When
        await useCase.call(testRequest);

        // Then
        expect(callOrder, equals(['acceptRoom', 'getRoom', 'putOrUpdateRoom']));
      });
    });
  });
}
