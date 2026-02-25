import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/watch_pin_messages_in_room_local_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_pin_messages_in_room_use_case.dart';

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

// Fake class for WatchPinMessagesInRoomLocalRequest
class FakeWatchPinMessagesInRoomLocalRequest extends Fake implements WatchPinMessagesInRoomLocalRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeWatchPinMessagesInRoomLocalRequest());
  });
  late WatchPinMessagesInRoomUseCase useCase;
  late MockPinMessageLocalRepository mockPinMessageRepository;

  setUp(() {
    mockPinMessageRepository = MockPinMessageLocalRepository();

    useCase = WatchPinMessagesInRoomUseCase(
      pinMessageRepository: mockPinMessageRepository,
    );
  });

  tearDown(() {
    reset(mockPinMessageRepository);
  });

  group('WatchPinMessagesInRoomUseCase', () {
    group('call', () {
      test('Given valid params, When call is invoked, Then returns stream from repository', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );

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

        final mockResponse = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add data to the stream
        streamController.add(mockResponse);

        // Then
        await expectLater(
          resultStream.take(1),
          emits(mockResponse),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given params without pageSize, When call is invoked, Then passes null pageSize to repository', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
        );

        final mockResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 20,
          totalPages: 0,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add data to the stream
        streamController.add(mockResponse);

        // Then
        await expectLater(
          resultStream.take(1),
          emits(mockResponse),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given empty room ID, When call is invoked, Then processes correctly with empty room ID', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: '',
          pageSize: 10,
        );

        final mockResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 10,
          totalPages: 0,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add data to the stream
        streamController.add(mockResponse);

        // Then
        await expectLater(
          resultStream.take(1),
          emits(mockResponse),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given zero pageSize, When call is invoked, Then processes correctly with zero pageSize', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 0,
        );

        final mockResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 0,
          totalPages: 0,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add data to the stream
        streamController.add(mockResponse);

        // Then
        await expectLater(
          resultStream.take(1),
          emits(mockResponse),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given large pageSize, When call is invoked, Then processes correctly with large pageSize', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 1000,
        );

        final mockResponse = PaginationPayload<PinMessageEntity>(
          data: [],
          total: 0,
          page: 1,
          pageSize: 1000,
          totalPages: 0,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add data to the stream
        streamController.add(mockResponse);

        // Then
        await expectLater(
          resultStream.take(1),
          emits(mockResponse),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given stream with multiple emissions, When call is invoked, Then all emissions are received', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );

        const mockPinMessage1 = PinMessageEntity(
          id: 'test-pin-id-1',
          ref: 'test-ref-1',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        const mockPinMessage2 = PinMessageEntity(
          id: 'test-pin-id-2',
          ref: 'test-ref-2',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        final mockResponse1 = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage1],
          total: 1,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final mockResponse2 = PaginationPayload<PinMessageEntity>(
          data: [mockPinMessage1, mockPinMessage2],
          total: 2,
          page: 1,
          pageSize: 20,
          totalPages: 1,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add multiple emissions to the stream
        streamController.add(mockResponse1);
        streamController.add(mockResponse2);

        // Then
        await expectLater(
          resultStream.take(2),
          emitsInOrder([mockResponse1, mockResponse2]),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });

      test('Given stream with error, When call is invoked, Then error is propagated', () async {
        // Given
        final params = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );

        final streamController = StreamController<PaginationPayload<PinMessageEntity>>();
        final testException = Exception('Stream error');

        when(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).thenAnswer((_) => streamController.stream);

        // When
        final resultStream = useCase.call(params);

        // Add error to the stream
        streamController.addError(testException);

        // Then
        await expectLater(
          resultStream,
          emitsError(isA<Exception>()),
        );

        verify(() => mockPinMessageRepository.watchPinMessagesInRoom(any())).called(1);
        verifyNoMoreInteractions(mockPinMessageRepository);

        await streamController.close();
      });
    });
  });

  group('WatchPinMessagesInRoomParams', () {
    group('constructor', () {
      test(
          'Given valid parameters with pageSize, When WatchPinMessagesInRoomParams is created, Then creates instance with correct properties',
          () {
        // Given
        const roomId = 'test-room-id';
        const pageSize = 20;

        // When
        final params = WatchPinMessagesInRoomParams(
          roomId: roomId,
          pageSize: pageSize,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pageSize, equals(pageSize));
      });

      test(
          'Given valid parameters without pageSize, When WatchPinMessagesInRoomParams is created, Then creates instance with null pageSize',
          () {
        // Given
        const roomId = 'test-room-id';

        // When
        final params = WatchPinMessagesInRoomParams(
          roomId: roomId,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pageSize, isNull);
      });

      test(
          'Given empty room ID, When WatchPinMessagesInRoomParams is created, Then creates instance with empty room ID',
          () {
        // Given
        const roomId = '';
        const pageSize = 10;

        // When
        final params = WatchPinMessagesInRoomParams(
          roomId: roomId,
          pageSize: pageSize,
        );

        // Then
        expect(params.roomId, equals(''));
        expect(params.pageSize, equals(pageSize));
      });

      test(
          'Given zero pageSize, When WatchPinMessagesInRoomParams is created, Then creates instance with zero pageSize',
          () {
        // Given
        const roomId = 'test-room-id';
        const pageSize = 0;

        // When
        final params = WatchPinMessagesInRoomParams(
          roomId: roomId,
          pageSize: pageSize,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pageSize, equals(0));
      });
    });

    group('equality', () {
      test('Given two identical WatchPinMessagesInRoomParams, When compared for equality, Then properties match', () {
        // Given
        final params1 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );
        final params2 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );

        // When & Then
        expect(params1.roomId, equals(params2.roomId));
        expect(params1.pageSize, equals(params2.pageSize));
      });

      test('Given two different WatchPinMessagesInRoomParams, When compared for equality, Then properties do not match',
          () {
        // Given
        final params1 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id-1',
          pageSize: 20,
        );
        final params2 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id-2',
          pageSize: 10,
        );

        // When & Then
        expect(params1.roomId, isNot(equals(params2.roomId)));
        expect(params1.pageSize, isNot(equals(params2.pageSize)));
      });

      test(
          'Given params with different pageSize values including null, When compared for equality, Then pageSize properties differ correctly',
          () {
        // Given
        final params1 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
          pageSize: 20,
        );
        final params2 = WatchPinMessagesInRoomParams(
          roomId: 'test-room-id',
        ); // pageSize is null

        // When & Then
        expect(params1.roomId, equals(params2.roomId));
        expect(params1.pageSize, isNot(equals(params2.pageSize)));
        expect(params1.pageSize, equals(20));
        expect(params2.pageSize, isNull);
      });
    });
  });
}
