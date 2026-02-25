import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_chat_room_use_case.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late FetchChatRoomUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;
  late MockChatRoomLocalRepository mockLocalRepository;
  late RoomEntity testRoomEntity;
  late String testRoomId;

  setUpAll(() {
    registerFallbackValue('test-room-id');
    registerFallbackValue(const RoomEntity(
      id: '',
    ));
  });

  setUp(() {
    mockServerRepository = MockChatRoomListServerRepository();
    mockLocalRepository = MockChatRoomLocalRepository();

    // Replace GetIt with a direct instance injection for testing
    useCase = FetchChatRoomUseCase();
    GetIt.I.allowReassignment = true;
    GetIt.I.registerFactory<ChatRoomListServerRepository>(() => mockServerRepository);
    GetIt.I.registerFactory<ChatRoomLocalRepository>(() => mockLocalRepository);

    // ignore: prefer_const_constructors
    testRoomEntity = RoomEntity(
      id: 'test-room-id',
      roomName: 'Test Room',
      roomType: null,
    );

    testRoomId = 'test-room-id';

    // Reset mocks before each test
    reset(mockServerRepository);
    reset(mockLocalRepository);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('call', () {
    test('Given server repository returns a room, When calling the use case, Then returns the room entity', () async {
      // Given
      when(() => mockServerRepository.fetchChatRoom(any())).thenAnswer((_) async => testRoomEntity);
      when(() => mockLocalRepository.getRoom(any())).thenAnswer((_) async => testRoomEntity);
      when(() => mockLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

      // When
      final result = await useCase(testRoomId);

      // Then
      expect(result, equals(testRoomEntity));
      verify(() => mockServerRepository.fetchChatRoom(testRoomId)).called(1);
      verify(() => mockLocalRepository.getRoom(testRoomEntity.id)).called(1);
      verify(() => mockLocalRepository.putOrUpdateRoom(testRoomEntity)).called(1);
    });

    test('Given server repository returns null, When calling the use case, Then returns null', () async {
      // Given
      when(() => mockServerRepository.fetchChatRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRoomId);

      // Then
      expect(result, isNull);
      verify(() => mockServerRepository.fetchChatRoom(testRoomId)).called(1);
      verifyNever(() => mockLocalRepository.getRoom(any()));
      verifyNever(() => mockLocalRepository.putOrUpdateRoom(any()));
    });

    test(
        'Given server repository returns a room but local repository returns null, When calling the use case, Then still returns the room entity',
        () async {
      // Given
      when(() => mockServerRepository.fetchChatRoom(any())).thenAnswer((_) async => testRoomEntity);
      when(() => mockLocalRepository.getRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRoomId);

      // Then
      expect(result, equals(testRoomEntity));
      verify(() => mockServerRepository.fetchChatRoom(testRoomId)).called(1);
      verify(() => mockLocalRepository.getRoom(testRoomEntity.id)).called(1);
      verifyNever(() => mockLocalRepository.putOrUpdateRoom(any()));
    });

    test('Given server repository throws an exception, When calling the use case, Then throws the same exception',
        () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockServerRepository.fetchChatRoom(any())).thenThrow(exception);

      // When
      Future<RoomEntity?> call() => useCase(testRoomId);

      // Then
      expect(call, throwsA(isA<Exception>()));
      verify(() => mockServerRepository.fetchChatRoom(testRoomId)).called(1);
      verifyNever(() => mockLocalRepository.getRoom(any()));
      verifyNever(() => mockLocalRepository.putOrUpdateRoom(any()));
    });
  });
}
