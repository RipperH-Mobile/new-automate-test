import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/domain/entities/draft_message_entity.dart'; // Add this import
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_draft_message_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/nullable_utils.dart';

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class MockMessageEntity extends Mock implements MessageEntity {}

class MockDraftMessageEntity extends Mock implements DraftMessageEntity {}

class FakeRoomEntity extends Fake implements RoomEntity {}

class FakeDraftMessageEntity extends Fake implements DraftMessageEntity {}

void main() {
  late UpdateDraftMessageUseCase useCase;
  late MockChatRoomLocalCompatRepository mockChatRoomRepository;
  late MockMessageLocalRepository mockMessageRepository;
  late MockLoggerService mockLogger;
  late String testRoomId;
  late RoomEntity testRoom;
  late MessageEntity testReplyMessageEntity;

  setUpAll(() {
    registerFallbackValue(FakeRoomEntity());
    registerFallbackValue(FakeDraftMessageEntity());
    registerFallbackValue(true);
  });

  setUp(() {
    mockChatRoomRepository = MockChatRoomLocalCompatRepository();
    mockMessageRepository = MockMessageLocalRepository();
    mockLogger = MockLoggerService();
    useCase = UpdateDraftMessageUseCase(
      log: mockLogger,
      chatRoomLocalRepository: mockChatRoomRepository,
      messageLocalRepository: mockMessageRepository,
    );

    testRoomId = 'test-room-id';
    testRoom = const RoomEntity(
      id: 'test-room-id',
      roomType: RoomType.direct,
      roomName: 'Test Room',
    );

    testReplyMessageEntity = const MessageEntity(
      id: 'test-message-id',
      message: 'Test reply message',
    );
  });

  group('UpdateDraftMessageUseCase', () {
    test(
      'Given draft message exists and room exists, When useCase is called, Then returns updated room with draft and clears draft message',
      () async {
        // Given
        final mockDraftMessage = MockDraftMessageEntity();
        when(() => mockDraftMessage.roomId).thenReturn(testRoomId);
        when(() => mockDraftMessage.message).thenReturn('Draft message content');
        when(() => mockDraftMessage.replyMessage).thenReturn(testReplyMessageEntity);

        when(() => mockMessageRepository.getDraftMessage()).thenAnswer((_) async => mockDraftMessage);

        when(() => mockChatRoomRepository.getRoom(testRoomId)).thenAnswer((_) async => testRoom);

        final expectedUpdatedRoom = testRoom.copyWith(
          draftMessage: 'Draft message content',
          draftReplyMessage: Nullable.value(testReplyMessageEntity),
        );

        when(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData')))
            .thenAnswer((_) async => expectedUpdatedRoom);

        when(() => mockMessageRepository.clearDraftMessage()).thenAnswer((_) async {});

        // When
        final result = await useCase(NoParams());

        // Then
        expect(result, equals(expectedUpdatedRoom));
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verify(() => mockChatRoomRepository.getRoom(testRoomId)).called(1);
        verify(() => mockChatRoomRepository.putRoom(any(), replaceData: true)).called(1);
        verify(() => mockMessageRepository.clearDraftMessage()).called(1);
        verifyNever(() => mockLogger.w(any()));
      },
    );

    test(
      'Given draft message exists with null message and reply, When useCase is called, Then returns updated room with null values',
      () async {
        // Given
        final mockDraftMessage = MockDraftMessageEntity();
        when(() => mockDraftMessage.roomId).thenReturn(testRoomId);
        when(() => mockDraftMessage.message).thenReturn(null);
        when(() => mockDraftMessage.replyMessage).thenReturn(null);

        when(() => mockMessageRepository.getDraftMessage()).thenAnswer((_) async => mockDraftMessage);

        when(() => mockChatRoomRepository.getRoom(testRoomId)).thenAnswer((_) async => testRoom);

        final expectedUpdatedRoom = testRoom.copyWith(
          draftMessage: null,
          draftReplyMessage: const Nullable.value(null),
        );

        when(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData')))
            .thenAnswer((_) async => expectedUpdatedRoom);

        when(() => mockMessageRepository.clearDraftMessage()).thenAnswer((_) async {});

        // When
        final result = await useCase(NoParams());

        // Then
        expect(result, equals(expectedUpdatedRoom));
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verify(() => mockChatRoomRepository.getRoom(testRoomId)).called(1);
        verify(() => mockChatRoomRepository.putRoom(any(), replaceData: true)).called(1);
        verify(() => mockMessageRepository.clearDraftMessage()).called(1);
        verifyNever(() => mockLogger.w(any()));
      },
    );

    test(
      'Given no draft message exists, When useCase is called, Then returns null and logs warning',
      () async {
        // Given
        when(() => mockMessageRepository.getDraftMessage()).thenAnswer((_) async => null);

        // When
        final result = await useCase(NoParams());

        // Then
        expect(result, isNull);
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verifyNever(() => mockChatRoomRepository.getRoom(any()));
        verifyNever(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData')));
        verifyNever(() => mockMessageRepository.clearDraftMessage());
      },
    );

    test(
      'Given draft message exists but room does not exist, When useCase is called, Then returns null and logs warning',
      () async {
        // Given
        final mockDraftMessage = MockDraftMessageEntity();
        when(() => mockDraftMessage.roomId).thenReturn(testRoomId);
        when(() => mockDraftMessage.message).thenReturn('Draft message content');
        when(() => mockDraftMessage.replyMessage).thenReturn(testReplyMessageEntity);

        when(() => mockMessageRepository.getDraftMessage()).thenAnswer((_) async => mockDraftMessage);

        when(() => mockChatRoomRepository.getRoom(testRoomId)).thenAnswer((_) async => null);

        // When
        final result = await useCase(NoParams());

        // Then
        expect(result, isNull);
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verify(() => mockChatRoomRepository.getRoom(testRoomId)).called(1);
        verify(() => mockLogger.w('Room not found for ID: $testRoomId')).called(1);
        verifyNever(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData')));
        verifyNever(() => mockMessageRepository.clearDraftMessage());
      },
    );

    test(
      'Given draft message repository throws exception, When useCase is called, Then exception propagates',
      () async {
        // Given
        final exception = Exception('Database error');
        when(() => mockMessageRepository.getDraftMessage()).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(NoParams()),
          throwsA(equals(exception)),
        );
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verifyNever(() => mockChatRoomRepository.getRoom(any()));
        verifyNever(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData')));
        verifyNever(() => mockMessageRepository.clearDraftMessage());
      },
    );

    test(
      'Given room repository throws exception during putRoom, When useCase is called, Then exception propagates',
      () async {
        // Given
        final mockDraftMessage = MockDraftMessageEntity();
        when(() => mockDraftMessage.roomId).thenReturn(testRoomId);
        when(() => mockDraftMessage.message).thenReturn('Draft message content');
        when(() => mockDraftMessage.replyMessage).thenReturn(testReplyMessageEntity);

        when(() => mockMessageRepository.getDraftMessage()).thenAnswer((_) async => mockDraftMessage);

        when(() => mockChatRoomRepository.getRoom(testRoomId)).thenAnswer((_) async => testRoom);

        final exception = Exception('Failed to save room');
        when(() => mockChatRoomRepository.putRoom(any(), replaceData: any(named: 'replaceData'))).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(NoParams()),
          throwsA(equals(exception)),
        );
        verify(() => mockMessageRepository.getDraftMessage()).called(1);
        verify(() => mockChatRoomRepository.getRoom(testRoomId)).called(1);
        verify(() => mockChatRoomRepository.putRoom(any(), replaceData: true)).called(1);
        verifyNever(() => mockMessageRepository.clearDraftMessage());
      },
    );
  });
}
