import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/requests/join_group_request.dart';
import 'package:uchat/features/chat_room_list/data/models/join_group_response.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/join_group_use_case.dart';

// Mock Classes
class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

// Fake Classes for Complex Types
class FakeJoinGroupRequest extends Fake implements JoinGroupRequest {}

void main() {
  late JoinGroupUseCase useCase;
  late MockChatRoomListServerRepository mockServerRepository;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeJoinGroupRequest());
  });

  setUp(() {
    mockServerRepository = MockChatRoomListServerRepository();
    useCase = JoinGroupUseCase();

    // Setup GetIt for dependency injection testing
    GetIt.I.allowReassignment = true;
    GetIt.I.registerFactory<ChatRoomListServerRepository>(() => mockServerRepository);

    // Reset mock before each test for isolation
    reset(mockServerRepository);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('JoinGroupUseCase', () {
    const testRoomId = 'test-room-id';
    late JoinGroupRequest testRequest;

    setUp(() {
      testRequest = const JoinGroupRequest(roomId: testRoomId);
    });

    test('Given public room with joined status, When useCase is called, Then returns true', () async {
      // Given
      const response = JoinGroupResponse(
        id: testRoomId,
        status: 'joined',
        roomType: RoomAccessType.public,
      );
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isTrue, reason: 'Public room with joined status should return true');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given public room with pending status, When useCase is called, Then returns false', () async {
      // Given
      const response = JoinGroupResponse(
        id: testRoomId,
        status: 'pending',
        roomType: RoomAccessType.public,
      );
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isFalse, reason: 'Public room with pending status should return false');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given public room with rejected status, When useCase is called, Then returns false', () async {
      // Given
      const response = JoinGroupResponse(
        id: testRoomId,
        status: 'rejected',
        roomType: RoomAccessType.public,
      );
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isFalse, reason: 'Public room with rejected status should return false');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given private room with joined status, When useCase is called, Then returns false', () async {
      // Given
      const response = JoinGroupResponse(
        id: testRoomId,
        status: 'joined',
        roomType: RoomAccessType.private,
      );
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isFalse, reason: 'Private room should always return false regardless of status');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given private room with pending status, When useCase is called, Then returns false', () async {
      // Given
      const response = JoinGroupResponse(
        id: testRoomId,
        status: 'pending',
        roomType: RoomAccessType.private,
      );
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isFalse, reason: 'Private room should always return false regardless of status');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given null response from server repository, When useCase is called, Then returns false', () async {
      // Given
      when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testRequest);

      // Then
      expect(result, isFalse, reason: 'Null response should return false');
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given server repository throws exception, When useCase is called, Then throws same exception', () async {
      // Given
      final exception = Exception('Network connection failed');
      when(() => mockServerRepository.joinGroup(any())).thenThrow(exception);

      // When
      Future<bool?> call() => useCase(testRequest);

      // Then
      expect(
          call,
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Network connection failed'),
          )));
      verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
      verifyNoMoreInteractions(mockServerRepository);
    });

    group('Edge cases', () {
      test('Given public room with empty status, When useCase is called, Then returns false', () async {
        // Given
        const response = JoinGroupResponse(
          id: testRoomId,
          status: '',
          roomType: RoomAccessType.public,
        );
        when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

        // When
        final result = await useCase(testRequest);

        // Then
        expect(result, isFalse, reason: 'Empty status should return false');
        verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
        verifyNoMoreInteractions(mockServerRepository);
      });

      test('Given public room with unknown status, When useCase is called, Then returns false', () async {
        // Given
        const response = JoinGroupResponse(
          id: testRoomId,
          status: 'unknown_status',
          roomType: RoomAccessType.public,
        );
        when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

        // When
        final result = await useCase(testRequest);

        // Then
        expect(result, isFalse, reason: 'Unknown status should return false');
        verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
        verifyNoMoreInteractions(mockServerRepository);
      });

      test('Given public room with case-sensitive "JOINED" status, When useCase is called, Then returns false',
          () async {
        // Given
        const response = JoinGroupResponse(
          id: testRoomId,
          status: 'JOINED', // uppercase
          roomType: RoomAccessType.public,
        );
        when(() => mockServerRepository.joinGroup(any())).thenAnswer((_) async => response);

        // When
        final result = await useCase(testRequest);

        // Then
        expect(result, isFalse, reason: 'Status comparison should be case-sensitive');
        verify(() => mockServerRepository.joinGroup(testRequest)).called(1);
        verifyNoMoreInteractions(mockServerRepository);
      });
    });
  });
}
