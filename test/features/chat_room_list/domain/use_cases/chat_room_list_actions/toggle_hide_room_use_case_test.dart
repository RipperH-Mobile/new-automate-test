import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class FakeToggleHideRoomRequest extends Fake implements ToggleHideRoomRequest {}

class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

void main() {
  late ToggleHideRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockChatRoomLocalRepository mockLocalRepository;
  late ToggleHideRoomRequest testRequest;
  late RoomSubscriptionEntity testRoomSubscription;

  setUpAll(() {
    registerFallbackValue(FakeToggleHideRoomRequest());
    registerFallbackValue(FakeRoomSubscriptionEntity());
    registerFallbackValue(FakeRoomSubscriptionCollection());
  });

  setUp(() {
    mockServerRepository = MockChatRoomListServerRepository();
    mockLocalRepository = MockChatRoomLocalRepository();

    // Clear any existing registrations
    if (GetIt.I.isRegistered<ChatRoomListServerRepository>()) {
      GetIt.I.unregister<ChatRoomListServerRepository>();
    }
    if (GetIt.I.isRegistered<ChatRoomLocalRepository>()) {
      GetIt.I.unregister<ChatRoomLocalRepository>();
    }

    // Register mocks with GetIt
    GetIt.I.registerSingleton<ChatRoomListServerRepository>(mockServerRepository);
    GetIt.I.registerSingleton<ChatRoomLocalRepository>(mockLocalRepository);

    useCase = ToggleHideRoomUseCase();

    testRequest = ToggleHideRoomRequest(
      roomId: 'test-room-id',
      isHidden: true,
    );

    testRoomSubscription = const RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      isHidden: true,
    );
  });

  tearDown(() {
    // Clean up GetIt after each test
    if (GetIt.I.isRegistered<ChatRoomListServerRepository>()) {
      GetIt.I.unregister<ChatRoomListServerRepository>();
    }
    if (GetIt.I.isRegistered<ChatRoomLocalRepository>()) {
      GetIt.I.unregister<ChatRoomLocalRepository>();
    }
  });

  group('ToggleHideRoomUseCase', () {
    test(
      'Given valid request, When server returns room subscription, Then updates local repository and completes successfully',
      () async {
        // Given
        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((entity) =>
                  entity.id == testRoomSubscription.id &&
                  entity.roomId == testRoomSubscription.roomId &&
                  entity.isHidden == testRoomSubscription.isHidden),
            ))).called(1);
      },
    );

    test(
      'Given valid request, When server returns null, Then does not update local repository',
      () async {
        // Given
        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => null);

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
      },
    );

    test(
      'Given request to hide room, When server returns room subscription with isHidden true, Then updates local repository with correct data',
      () async {
        // Given
        final hideRequest = ToggleHideRoomRequest(
          roomId: 'test-room-id',
          isHidden: true,
        );
        final hiddenRoomSubscription = const RoomSubscriptionEntity(
          id: 'test-subscription-id',
          roomId: 'test-room-id',
          isHidden: true,
        );

        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => hiddenRoomSubscription);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(hideRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(hideRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((collection) =>
                  collection.id == 'test-subscription-id' &&
                  collection.roomId == 'test-room-id' &&
                  collection.isHidden == true),
            ))).called(1);
      },
    );

    test(
      'Given request to unhide room, When server returns room subscription with isHidden false, Then updates local repository with correct data',
      () async {
        // Given
        final unhideRequest = ToggleHideRoomRequest(
          roomId: 'test-room-id',
          isHidden: false,
        );
        final unhiddenRoomSubscription = const RoomSubscriptionEntity(
          id: 'test-subscription-id',
          roomId: 'test-room-id',
          isHidden: false,
        );

        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => unhiddenRoomSubscription);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(unhideRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(unhideRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((collection) =>
                  collection.id == 'test-subscription-id' &&
                  collection.roomId == 'test-room-id' &&
                  collection.isHidden == false),
            ))).called(1);
      },
    );

    test(
      'Given server repository throws exception, When use case is called, Then rethrows exception and does not update local repository',
      () async {
        // Given
        final exception = Exception('Server error');
        when(() => mockServerRepository.toggleHideRoom(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verifyNever(() => mockLocalRepository.updateRoomSubscription(any()));
      },
    );

    test(
      'Given local repository throws exception, When updating room subscription, Then rethrows exception',
      () async {
        // Given
        final exception = Exception('Local database error');
        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => testRoomSubscription);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any())).called(1);
      },
    );

    test(
      'Given room subscription with additional properties, When server returns data, Then updates local repository with all properties preserved',
      () async {
        // Given
        final complexRoomSubscription = const RoomSubscriptionEntity(
          id: 'test-subscription-id',
          roomId: 'test-room-id',
          roomName: 'Test Room',
          accountId: 'test-account-id',
          unreadCount: 5,
          isPinned: true,
          isMuted: false,
          isHidden: true,
          isMentioned: false,
        );

        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => complexRoomSubscription);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((entity) =>
                  entity.id == 'test-subscription-id' &&
                  entity.roomId == 'test-room-id' &&
                  entity.isHidden == true &&
                  entity.roomName == 'Test Room' &&
                  entity.accountId == 'test-account-id' &&
                  entity.unreadCount == 5 &&
                  entity.isPinned == true &&
                  entity.isMuted == false &&
                  entity.isMentioned == false),
            ))).called(1);
      },
    );

    test(
      'Given room subscription with null id, When server returns data, Then updates local repository with null id',
      () async {
        // Given
        final roomSubscriptionWithNullId = const RoomSubscriptionEntity(
          id: null,
          roomId: 'test-room-id',
          isHidden: true,
        );

        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => roomSubscriptionWithNullId);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((collection) =>
                  collection.id == null && collection.roomId == 'test-room-id' && collection.isHidden == true),
            ))).called(1);
      },
    );

    test(
      'Given room subscription with null roomId, When server returns data, Then updates local repository with null roomId',
      () async {
        // Given
        final roomSubscriptionWithNullRoomId = const RoomSubscriptionEntity(
          id: 'test-subscription-id',
          roomId: null,
          isHidden: true,
        );

        when(() => mockServerRepository.toggleHideRoom(any())).thenAnswer((_) async => roomSubscriptionWithNullRoomId);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((collection) =>
                  collection.id == 'test-subscription-id' && collection.roomId == null && collection.isHidden == true),
            ))).called(1);
      },
    );

    test(
      'Given room subscription with null isHidden, When server returns data, Then updates local repository with null isHidden',
      () async {
        // Given
        final roomSubscriptionWithNullIsHidden = const RoomSubscriptionEntity(
          id: 'test-subscription-id',
          roomId: 'test-room-id',
          isHidden: null,
        );

        when(() => mockServerRepository.toggleHideRoom(any()))
            .thenAnswer((_) async => roomSubscriptionWithNullIsHidden);
        when(() => mockLocalRepository.updateRoomSubscription(any())).thenAnswer((_) async {});

        // When
        await useCase(testRequest);

        // Then
        verify(() => mockServerRepository.toggleHideRoom(testRequest)).called(1);
        verify(() => mockLocalRepository.updateRoomSubscription(any(
              that: predicate<RoomSubscriptionEntity>((collection) =>
                  collection.id == 'test-subscription-id' &&
                  collection.roomId == 'test-room-id' &&
                  collection.isHidden == null),
            ))).called(1);
      },
    );
  });
}
