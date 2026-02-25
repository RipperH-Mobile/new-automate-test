import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_pin_room_use_case.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

// Create a fake implementation for mocking
class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

void main() {
  late TogglePinRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockChatRoomLocalRepository mockLocalRepository;
  late RoomSubscriptionEntity testSubscriptionEntity;
  late TogglePinRoomRequest testRequest;

  setUpAll(() {
    registerFallbackValue(TogglePinRoomRequest(roomId: 'test-room-id', isPinned: true));
    registerFallbackValue(RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      isPinned: true,
      isMuted: false,
      isHidden: false,
      updatedAt: DateTime.now(),
      accountId: 'test-account-id',
    ));
    // Register fallback value for RoomSubscriptionCollection
    registerFallbackValue(FakeRoomSubscriptionCollection());
  });

  setUp(() {
    mockServerRepository = MockChatRoomListServerRepository();
    mockLocalRepository = MockChatRoomLocalRepository();

    // Replace GetIt with a direct instance injection for testing
    useCase = TogglePinRoomUseCase();
    GetIt.I.allowReassignment = true;
    GetIt.I.registerFactory<ChatRoomListServerRepository>(() => mockServerRepository);
    GetIt.I.registerFactory<ChatRoomLocalRepository>(() => mockLocalRepository);

    testSubscriptionEntity = RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      isPinned: true,
      isMuted: false,
      isHidden: false,
      updatedAt: DateTime.now(),
      accountId: 'test-account-id',
    );

    testRequest = TogglePinRoomRequest(
      roomId: 'test-room-id',
      isPinned: true,
    );

    // Reset mocks before each test
    reset(mockServerRepository);
    reset(mockLocalRepository);

    // Mock the updateRoomSubscription method to return Future<void>
    when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('call', () {
    test('Given server repository returns successfully, When calling the use case, Then returns Right with entity',
        () async {
      // Given
      when(() => mockServerRepository.togglePinRoom(any())).thenAnswer((_) async => testSubscriptionEntity);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, equals(testSubscriptionEntity));
      verify(() => mockServerRepository.togglePinRoom(testRequest)).called(1);
      verify(() => mockLocalRepository.updateRoomSubscription(any())).called(1);
    });

    test('Given server repository returns null, When calling the use case, Then returns null', () async {
      // Given
      when(() => mockServerRepository.togglePinRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isNull);
      verify(() => mockServerRepository.togglePinRoom(testRequest)).called(1);
      verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
    });

    test('Given server repository throws an exception, When calling the use case, Then throws the same exception',
        () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockServerRepository.togglePinRoom(any())).thenThrow(exception);

      // When
      Future<RoomSubscriptionEntity?> call() => useCase(testRequest);

      // Then
      expect(call, throwsA(isA<Exception>()));
      verify(() => mockServerRepository.togglePinRoom(testRequest)).called(1);
      verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
    });
  });
}
