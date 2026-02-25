import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import "package:uchat/core/event_bus/event_bus.dart";
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/toggle_pin_room_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_pin_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockRoomSubLocalRepository extends Mock implements RoomSubLocalRepository {}

// Create a mock RoomSubscriptionCollection to allow mocking toEntity method
class MockRoomSubscriptionEntity extends Mock implements RoomSubscriptionEntity {}

void main() {
  late TogglePinRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockRoomSubLocalRepository mockLocalRepository;
  late RoomSubscriptionEntity testSubscriptionEntity;
  late TogglePinRoomParams testParams;
  late MockRoomSubscriptionEntity testEntity;
  late DateTime testDateTime;

  setUpAll(() {
    registerFallbackValue(TogglePinRoomRequest(roomId: 'test-room-id', isPinned: true));
    registerFallbackValue(
      const RoomSubscriptionEntity(
        id: 'test-subscription-id',
        roomId: 'test-room-id',
        isPinned: true,
      ),
    );

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
    mockServerRepository = MockChatRoomListServerRepository();
    mockLocalRepository = MockRoomSubLocalRepository();

    useCase = TogglePinRoomUseCase(
      chatRoomListServerRepository: mockServerRepository,
      roomSubLocalRepository: mockLocalRepository,
    );

    testDateTime = DateTime.now();

    testSubscriptionEntity = RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      isPinned: true,
      isMuted: false,
      isHidden: false,
      updatedAt: testDateTime,
      accountId: 'test-account-id',
      isLocalDeleting: false,
    );

    // Create a mock collection instead of a real one to allow stubbing toEntity
    testEntity = MockRoomSubscriptionEntity();

    testParams = TogglePinRoomParams(
      roomId: 'test-room-id',
      isPinned: true,
      isSecretRoom: false,
    );

    // Set up default mocks
    when(() => mockServerRepository.togglePinRoom(any())).thenAnswer((_) async => testSubscriptionEntity);

    when(() => mockLocalRepository.putRoomSubscription(any())).thenAnswer((_) async => testEntity);

    // Set basic properties on the mock collection
    when(() => testEntity.id).thenReturn('test-subscription-id');
    when(() => testEntity.roomId).thenReturn('test-room-id');
    when(() => testEntity.isPinned).thenReturn(true);
    when(() => testEntity.isLocalDeleting).thenReturn(false);
  });

  group('call', () {
    test('Given server repository returns successfully, When toggling pin, Then returns RoomSubscriptionEntity',
        () async {
      // Given
      // Setup is done in setUp

      // When
      final result = await useCase(testParams);

      // Then
      expect(result, equals(testSubscriptionEntity));
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verify(() => mockLocalRepository.putRoomSubscription(any())).called(1);
    });

    test('Given server repository returns null, When toggling pin, Then returns null', () async {
      // Given
      when(() => mockServerRepository.togglePinRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testParams);

      // Then
      expect(result, isNull);
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verifyNever(() => mockLocalRepository.putRoomSubscription(any()));
    });

    test(
        'Given server returns ERR_ROOM_SUBSCRIPTION_NOT_FOUND for secret room, When toggling pin, Then uses local data',
        () async {
      // Given
      final apiException = ApiException(
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        message: 'Room subscription not found',
      );
      // when testSubscriptionEntity copywith
      when(() => testEntity.copyWith(isPinned: any(named: 'isPinned')))
          .thenReturn(testSubscriptionEntity.copyWith(isPinned: true));
      when(() => mockServerRepository.togglePinRoom(any())).thenThrow(apiException);

      when(() => mockLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => testEntity);

      final testSecretRoomParams = TogglePinRoomParams(
        roomId: 'test-room-id',
        isPinned: true,
        isSecretRoom: true,
      );

      // When
      final result = await useCase(testSecretRoomParams);

      // Then
      expect(result, equals(testEntity));
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verify(() => mockLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
      verify(() => mockLocalRepository.putRoomSubscription(any())).called(1);
    });

    test(
        'Given server returns ERR_ROOM_SUBSCRIPTION_NOT_FOUND but local data is null, When toggling pin, Then returns null',
        () async {
      // Given
      final apiException = ApiException(
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        message: 'Room subscription not found',
      );

      when(() => mockServerRepository.togglePinRoom(any())).thenThrow(apiException);

      when(() => mockLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);

      final testSecretRoomParams = TogglePinRoomParams(
        roomId: 'test-room-id',
        isPinned: true,
        isSecretRoom: true,
      );

      // When
      final result = await useCase(testSecretRoomParams);

      // Then
      expect(result, isNull);
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verify(() => mockLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
      verifyNever(() => mockLocalRepository.putRoomSubscription(any()));
    });

    test(
        'Given server returns ERR_ROOM_SUBSCRIPTION_NOT_FOUND for non-secret room, When toggling pin, Then rethrows exception',
        () async {
      // Given
      final apiException = ApiException(
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        message: 'Room subscription not found',
      );

      when(() => mockServerRepository.togglePinRoom(any())).thenThrow(apiException);

      // When
      Future<RoomSubscriptionEntity?> call() => useCase(testParams);

      // Then
      expect(call, throwsA(isA<ApiException>()));
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verifyNever(() => mockLocalRepository.getRoomSubscriptionWithRoomId(any()));
      verifyNever(() => mockLocalRepository.putRoomSubscription(any()));
    });

    test('Given server returns different error, When toggling pin, Then rethrows exception', () async {
      // Given
      final apiException = ApiException(
        type: 'SOME_OTHER_ERROR',
        message: 'Some other error',
      );

      when(() => mockServerRepository.togglePinRoom(any())).thenThrow(apiException);

      final testSecretRoomParams = TogglePinRoomParams(
        roomId: 'test-room-id',
        isPinned: true,
        isSecretRoom: true,
      );

      // When
      Future<RoomSubscriptionEntity?> call() => useCase(testSecretRoomParams);

      // Then
      expect(call, throwsA(isA<ApiException>()));
      verify(() => mockServerRepository.togglePinRoom(any())).called(1);
      verifyNever(() => mockLocalRepository.getRoomSubscriptionWithRoomId(any()));
      verifyNever(() => mockLocalRepository.putRoomSubscription(any()));
    });
  });
}
