import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/mark_sending_messages_as_failed_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class FakeMessageEntity extends Fake implements MessageEntity {}

void main() {
  late MarkSendingMessagesAsFailedUseCase useCase;
  late MockMessageLocalRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeMessageEntity());
  });

  setUp(() {
    mockRepository = MockMessageLocalRepository();
    useCase = MarkSendingMessagesAsFailedUseCase(
      messageLocalRepository: mockRepository,
    );

    // Reset mocks before each test
    reset(mockRepository);
  });

  group('MarkSendingMessagesAsFailedUseCase', () {
    group('call', () {
      test('Given no sending messages exist, When use case is called, Then returns early without updating messages',
          () async {
        // Given
        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => <MessageEntity>[]);

        // When
        await useCase.call();

        // Then
        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);
        verifyNever(
            () => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')));
      });

      test('Given sending messages exist, When use case is called, Then marks all messages as failed and updates them',
          () async {
        // Given
        final sendingMessage1 = MessageEntity(
          id: 'msg1',
          roomId: 'room1',
          message: 'Test message 1',
          isSending: true,
          isSendFailed: false,
          createdAt: DateTime(2024, 1, 1, 10, 0, 0),
          updatedAt: DateTime(2024, 1, 1, 10, 0, 0),
        );

        final sendingMessage2 = MessageEntity(
          id: 'msg2',
          roomId: 'room2',
          message: 'Test message 2',
          isSending: true,
          isSendFailed: false,
          createdAt: DateTime(2024, 1, 1, 11, 0, 0),
          updatedAt: DateTime(2024, 1, 1, 11, 0, 0),
        );

        final sendingMessages = [sendingMessage1, sendingMessage2];

        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => sendingMessages);
        when(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase.call();

        // Then
        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);

        final captured = verify(() =>
                mockRepository.putAllMessages(messages: captureAny(named: 'messages'), useTxn: any(named: 'useTxn')))
            .captured;
        final updatedMessages = captured.single as List<MessageEntity>;

        expect(updatedMessages, hasLength(2));

        // Verify first message is updated correctly
        final updatedMessage1 = updatedMessages.firstWhere((msg) => msg.id == 'msg1');
        expect(updatedMessage1.isSending, isFalse);
        expect(updatedMessage1.isSendFailed, isTrue);
        expect(updatedMessage1.updatedAt, isNotNull);
        expect(updatedMessage1.updatedAt!.isAfter(sendingMessage1.updatedAt!), isTrue);
        expect(updatedMessage1.id, equals('msg1'));
        expect(updatedMessage1.roomId, equals('room1'));
        expect(updatedMessage1.message, equals('Test message 1'));

        // Verify second message is updated correctly
        final updatedMessage2 = updatedMessages.firstWhere((msg) => msg.id == 'msg2');
        expect(updatedMessage2.isSending, isFalse);
        expect(updatedMessage2.isSendFailed, isTrue);
        expect(updatedMessage2.updatedAt, isNotNull);
        expect(updatedMessage2.updatedAt!.isAfter(sendingMessage2.updatedAt!), isTrue);
        expect(updatedMessage2.id, equals('msg2'));
        expect(updatedMessage2.roomId, equals('room2'));
        expect(updatedMessage2.message, equals('Test message 2'));
      });

      test(
          'Given single sending message exists, When use case is called, Then marks message as failed with current timestamp',
          () async {
        // Given
        final originalUpdatedAt = DateTime(2024, 1, 1, 10, 0, 0);
        final sendingMessage = MessageEntity(
          id: 'msg1',
          roomId: 'room1',
          message: 'Test message',
          isSending: true,
          isSendFailed: false,
          createdAt: DateTime(2024, 1, 1, 9, 0, 0),
          updatedAt: originalUpdatedAt,
          sequence: 1704096000000, // 2024-01-01 10:00:00
        );

        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => [sendingMessage]);
        when(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        final beforeCall = DateTime.now();

        // When
        await useCase.call();

        final afterCall = DateTime.now();

        // Then
        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);

        final captured = verify(() =>
                mockRepository.putAllMessages(messages: captureAny(named: 'messages'), useTxn: any(named: 'useTxn')))
            .captured;
        final updatedMessages = captured.single as List<MessageEntity>;

        expect(updatedMessages, hasLength(1));

        final updatedMessage = updatedMessages.first;
        expect(updatedMessage.isSending, isFalse);
        expect(updatedMessage.isSendFailed, isTrue);
        expect(updatedMessage.updatedAt, isNotNull);
        expect(updatedMessage.updatedAt!.isAfter(originalUpdatedAt), isTrue);
        expect(updatedMessage.updatedAt!.isAfter(beforeCall) || updatedMessage.updatedAt!.isAtSameMomentAs(beforeCall),
            isTrue);
        expect(updatedMessage.updatedAt!.isBefore(afterCall) || updatedMessage.updatedAt!.isAtSameMomentAs(afterCall),
            isTrue);

        // Verify other properties remain unchanged
        expect(updatedMessage.id, equals(sendingMessage.id));
        expect(updatedMessage.roomId, equals(sendingMessage.roomId));
        expect(updatedMessage.message, equals(sendingMessage.message));
        expect(updatedMessage.createdAt, equals(sendingMessage.createdAt));
        expect(updatedMessage.sequence, equals(sendingMessage.sequence));
      });

      test(
          'Given repository throws exception when getting messages, When use case is called, Then exception is propagated',
          () async {
        // Given
        final exception = Exception('Database error');
        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(), throwsA(equals(exception)));

        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);
        verifyNever(
            () => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')));
      });

      test(
          'Given repository throws exception when putting messages, When use case is called, Then exception is propagated',
          () async {
        // Given
        final sendingMessage = MessageEntity(
          id: 'msg1',
          roomId: 'room1',
          message: 'Test message',
          isSending: true,
          isSendFailed: false,
          updatedAt: DateTime(2024, 1, 1, 10, 0, 0),
        );

        final exception = Exception('Database write error');
        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => [sendingMessage]);
        when(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(), throwsA(equals(exception)));

        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);
        verify(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .called(1);
      });

      test(
          'Given messages with mixed sending states, When use case is called, Then only processes messages returned by repository',
          () async {
        // Given
        final sendingMessage1 = MessageEntity(
          id: 'msg1',
          roomId: 'room1',
          message: 'Sending message',
          isSending: true,
          isSendFailed: false,
          updatedAt: DateTime(2024, 1, 1, 10, 0, 0),
        );

        final sendingMessage2 = MessageEntity(
          id: 'msg2',
          roomId: 'room1',
          message: 'Another sending message',
          isSending: true,
          isSendFailed: false,
          updatedAt: DateTime(2024, 1, 1, 11, 0, 0),
        );

        // Repository returns only sending messages (as expected from getAllSendingMessagesAcrossRooms)
        final sendingMessages = [sendingMessage1, sendingMessage2];

        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => sendingMessages);
        when(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase.call();

        // Then
        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);

        final captured = verify(() =>
                mockRepository.putAllMessages(messages: captureAny(named: 'messages'), useTxn: any(named: 'useTxn')))
            .captured;
        final updatedMessages = captured.single as List<MessageEntity>;

        expect(updatedMessages, hasLength(2));

        // Verify all messages are marked as failed
        for (final message in updatedMessages) {
          expect(message.isSending, isFalse);
          expect(message.isSendFailed, isTrue);
          expect(message.updatedAt, isNotNull);
        }
      });

      test(
          'Given use case is called with void parameter, When call method is invoked, Then processes messages correctly',
          () async {
        // Given
        final sendingMessage = MessageEntity(
          id: 'msg1',
          roomId: 'room1',
          message: 'Test message',
          isSending: true,
          isSendFailed: false,
          updatedAt: DateTime(2024, 1, 1, 10, 0, 0),
        );

        when(() => mockRepository.getAllSendingMessagesAcrossRooms()).thenAnswer((_) async => [sendingMessage]);
        when(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When - calling with explicit void parameter (optional parameter)
        await useCase.call(null);

        // Then
        verify(() => mockRepository.getAllSendingMessagesAcrossRooms()).called(1);
        verify(() => mockRepository.putAllMessages(messages: any(named: 'messages'), useTxn: any(named: 'useTxn')))
            .called(1);
      });
    });
  });
}
