import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/delete_room_use_case.dart';
import 'package:uchat/entities/enums.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class FakeRoomCollection extends Fake implements RoomCollection {}

void main() {
  late DeleteRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockChatRoomLocalRepository mockLocalRepository;
  late RoomCollection testRoom;
  late RoomCollection testSecretRoom;

  setUpAll(() {
    registerFallbackValue(FakeRoomCollection());
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

    useCase = DeleteRoomUseCase();

    testRoom = RoomCollection(
      id: 'test-room-id',
      roomType: RoomType.group,
    );

    testSecretRoom = RoomCollection(
      id: 'test-secret-room-id',
      roomType: RoomType.directSecret,
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

  group('DeleteRoomUseCase', () {
    test('Given valid room, When server deletion succeeds, Then completes successfully', () async {
      // Given
      when(() => mockServerRepository.deleteRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(testRoom);

      // Then
      verify(() => mockServerRepository.deleteRoom('test-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given room with null id, When use case is called, Then throws exception', () async {
      // Given
      final roomWithNullId = RoomCollection(
        id: null,
        roomType: RoomType.group,
      );

      // When/Then
      await expectLater(
        () => useCase.call(roomWithNullId),
        throwsA(isA<TypeError>()),
      );
      verifyNever(() => mockServerRepository.deleteRoom(any()));
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given secret room, When server throws ERR_ROOM_SUBSCRIPTION_NOT_FOUND, Then deletes from local repository',
        () async {
      // Given
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);
      when(() => mockLocalRepository.deleteRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(testSecretRoom);

      // Then
      verify(() => mockServerRepository.deleteRoom('test-secret-room-id')).called(1);
      verify(() => mockLocalRepository.deleteRoom('test-secret-room-id')).called(1);
    });

    test('Given non-secret room, When server throws ERR_ROOM_SUBSCRIPTION_NOT_FOUND, Then rethrows exception',
        () async {
      // Given
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(testRoom),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given secret room, When server throws different ApiException, Then rethrows exception', () async {
      // Given
      final apiException = ApiException(
        message: 'Server error',
        type: 'ERR_INTERNAL_SERVER_ERROR',
        code: 500,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(testSecretRoom),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-secret-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given room, When server throws non-ApiException, Then propagates exception', () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(exception);

      // When/Then
      await expectLater(
        () => useCase.call(testRoom),
        throwsA(equals(exception)),
      );
      verify(() => mockServerRepository.deleteRoom('test-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test(
        'Given secret room, When local repository throws exception after server error, Then propagates local exception',
        () async {
      // Given
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      final localException = Exception('Local database error');
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);
      when(() => mockLocalRepository.deleteRoom(any())).thenThrow(localException);

      // When/Then
      await expectLater(
        () => useCase.call(testSecretRoom),
        throwsA(equals(localException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-secret-room-id')).called(1);
      verify(() => mockLocalRepository.deleteRoom('test-secret-room-id')).called(1);
    });

    test('Given direct room type, When server throws ERR_ROOM_SUBSCRIPTION_NOT_FOUND, Then rethrows exception',
        () async {
      // Given
      final directRoom = RoomCollection(
        id: 'test-direct-room-id',
        roomType: RoomType.direct,
      );
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(directRoom),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-direct-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given group room type, When server throws ERR_ROOM_SUBSCRIPTION_NOT_FOUND, Then rethrows exception',
        () async {
      // Given
      final groupRoom = RoomCollection(
        id: 'test-group-room-id',
        roomType: RoomType.group,
      );
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(groupRoom),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-group-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test(
        'Given secret room with null type, When server throws ERR_ROOM_SUBSCRIPTION_NOT_FOUND, Then rethrows exception',
        () async {
      // Given
      final roomWithNullType = RoomCollection(
        id: 'test-room-id',
        roomType: null,
      );
      final apiException = ApiException(
        message: 'Room subscription not found',
        type: 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND',
        code: 404,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(roomWithNullType),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given ApiException with null type, When server throws exception, Then rethrows exception', () async {
      // Given
      final apiException = ApiException(
        message: 'Server error',
        type: null,
        code: 500,
      );
      when(() => mockServerRepository.deleteRoom(any())).thenThrow(apiException);

      // When/Then
      await expectLater(
        () => useCase.call(testSecretRoom),
        throwsA(equals(apiException)),
      );
      verify(() => mockServerRepository.deleteRoom('test-secret-room-id')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given different room IDs, When use case is called, Then calls server repository with correct ID', () async {
      // Given
      final room1 = RoomCollection(id: 'room-1', roomType: RoomType.group);
      final room2 = RoomCollection(id: 'room-2', roomType: RoomType.direct);
      when(() => mockServerRepository.deleteRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(room1);
      await useCase.call(room2);

      // Then
      verify(() => mockServerRepository.deleteRoom('room-1')).called(1);
      verify(() => mockServerRepository.deleteRoom('room-2')).called(1);
      verifyNever(() => mockLocalRepository.deleteRoom(any()));
    });

    test('Given successful server deletion, When use case completes, Then returns void', () async {
      // Given
      when(() => mockServerRepository.deleteRoom(any())).thenAnswer((_) async {});

      // When
      final result = useCase.call(testRoom);

      // Then
      expect(result, isA<Future<void>>());
      await expectLater(result, completes);
      verify(() => mockServerRepository.deleteRoom('test-room-id')).called(1);
    });
  });
}
