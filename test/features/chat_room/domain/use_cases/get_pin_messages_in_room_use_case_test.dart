import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_messages_local_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_pin_messages_in_room_use_case.dart';

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

class MockPinMessageServerRepository extends Mock implements PinMessageServerRepository {}

// Fake classes for request objects
class FakeGetPinMessagesRequest extends Fake implements GetPinMessagesRequest {}

class FakePinMessagesLocalRequest extends Fake implements PinMessagesLocalRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeGetPinMessagesRequest());
    registerFallbackValue(FakePinMessagesLocalRequest());
  });
  late GetPinMessagesInRoomUseCase useCase;
  late MockPinMessageLocalRepository mockPinMessageLocalRepository;
  late MockPinMessageServerRepository mockPinMessageServerRepository;

  setUp(() {
    mockPinMessageLocalRepository = MockPinMessageLocalRepository();
    mockPinMessageServerRepository = MockPinMessageServerRepository();

    useCase = GetPinMessagesInRoomUseCase(
      pinMessageLocalRepository: mockPinMessageLocalRepository,
      pinMessageServerRepository: mockPinMessageServerRepository,
    );
  });

  tearDown(() {
    reset(mockPinMessageLocalRepository);
    reset(mockPinMessageServerRepository);
  });

  group('GetPinMessagesInRoomUseCase', () {
    group('call', () {
      test(
          'Given valid request, When call is invoked, Then fetches from server, saves to local, and returns local data',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        const mockMessage = MessageEntity(
          id: 'test-message-id',
          roomId: 'test-room-id',
          message: 'Test message content',
        );

        const mockPinMessage = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: mockMessage,
        );

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final localResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.pinMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenAnswer((_) async => localResponse);

        // When
        final result = await useCase.call(request);

        // Then
        expect(result, equals(localResponse));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test('Given server returns empty data, When call is invoked, Then does not save to local and returns local data',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        final localResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenAnswer((_) async => localResponse);

        // When
        final result = await useCase.call(request);

        // Then
        expect(result, equals(localResponse));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);

        // Should not call pinMessages when data is empty
        verifyNever(() => mockPinMessageLocalRepository.pinMessages(any()));

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test('Given server returns null data, When call is invoked, Then does not save to local and returns local data',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: null,
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        final localResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenAnswer((_) async => localResponse);

        // When
        final result = await useCase.call(request);

        // Then
        expect(result, equals(localResponse));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);

        // Should not call pinMessages when data is null
        verifyNever(() => mockPinMessageLocalRepository.pinMessages(any()));

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test(
          'Given server repository throws exception, When call is invoked, Then exception is propagated and local repository is not affected',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');
        final testException = Exception('Server error');

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenThrow(testException);

        // When
        Future<PaginationPayload<PinMessageEntity>> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verifyZeroInteractions(mockPinMessageLocalRepository);
      });

      test(
          'Given server succeeds but local pinMessages throws exception, When call is invoked, Then exception is propagated',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        const mockPinMessage = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final testException = Exception('Local pinMessages error');

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.pinMessages(any())).thenThrow(testException);

        // When
        Future<PaginationPayload<PinMessageEntity>> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessages(any())).called(1);
        verifyNever(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any()));
      });

      test(
          'Given server succeeds and local pinMessages succeeds but getPinMessagesInRoom throws exception, When call is invoked, Then exception is propagated',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        const mockPinMessage = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final testException = Exception('Local getPinMessagesInRoom error');

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.pinMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenThrow(testException);

        // When
        Future<PaginationPayload<PinMessageEntity>> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);
      });

      test(
          'Given multiple pin messages from server, When call is invoked, Then saves all messages to local and returns local data',
          () async {
        // Given
        final request = GetPinMessagesRequest(roomId: 'test-room-id');

        const mockMessage1 = MessageEntity(
          id: 'test-message-id-1',
          roomId: 'test-room-id',
          message: 'Test message content 1',
        );

        const mockMessage2 = MessageEntity(
          id: 'test-message-id-2',
          roomId: 'test-room-id',
          message: 'Test message content 2',
        );

        const mockPinMessage1 = PinMessageEntity(
          id: 'test-pin-id-1',
          ref: 'test-ref-1',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: mockMessage1,
        );

        const mockPinMessage2 = PinMessageEntity(
          id: 'test-pin-id-2',
          ref: 'test-ref-2',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: mockMessage2,
        );

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage1, mockPinMessage2],
          total: 2,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final localResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage1, mockPinMessage2],
          total: 2,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.pinMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenAnswer((_) async => localResponse);

        // When
        final result = await useCase.call(request);

        // Then
        expect(result, equals(localResponse));
        expect(result.data?.length, equals(2));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test('Given empty room ID, When call is invoked, Then processes correctly with empty room ID', () async {
        // Given
        final request = GetPinMessagesRequest(roomId: '');

        final serverResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        final localResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        when(() => mockPinMessageServerRepository.getPinMessages(any())).thenAnswer((_) async => serverResponse);

        when(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).thenAnswer((_) async => localResponse);

        // When
        final result = await useCase.call(request);

        // Then
        expect(result, equals(localResponse));

        verify(() => mockPinMessageServerRepository.getPinMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.getPinMessagesInRoom(any())).called(1);
        verifyNever(() => mockPinMessageLocalRepository.pinMessages(any()));

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });
    });
  });
}
