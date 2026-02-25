import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/save_draft_message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/save_draft_message_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class FakeSaveDraftMessageEntity extends Fake implements SaveDraftMessageEntity {}

void main() {
  late SaveDraftMessageUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;
  late SaveDraftMessageEntity testParams;

  setUpAll(() {
    registerFallbackValue(FakeSaveDraftMessageEntity());
  });

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    useCase = SaveDraftMessageUseCase(
      messageLocalRepository: mockMessageLocalRepository,
    );

    testParams = const SaveDraftMessageEntity(
      roomId: 'test-room-id',
      message: 'Test draft message',
      replyMessageId: 'reply-message-id',
    );
  });

  group('SaveDraftMessageUseCase', () {
    test(
      'Given valid SaveDraftMessageEntity params, When call is invoked, Then calls saveDraftMessage on repository and completes successfully',
      () async {
        // Given
        when(() => mockMessageLocalRepository.saveDraftMessage(testParams)).thenAnswer((_) async {});

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockMessageLocalRepository.saveDraftMessage(testParams)).called(1);
      },
    );

    test(
      'Given repository throws exception, When call is invoked, Then exception propagates',
      () async {
        // Given
        final exception = Exception('Failed to save draft message');
        when(() => mockMessageLocalRepository.saveDraftMessage(testParams)).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase.call(testParams),
          throwsA(equals(exception)),
        );
        verify(() => mockMessageLocalRepository.saveDraftMessage(testParams)).called(1);
      },
    );

    test(
      'Given different SaveDraftMessageEntity params, When call is invoked, Then calls saveDraftMessage with correct params',
      () async {
        // Given
        const differentParams = SaveDraftMessageEntity(
          roomId: 'different-room-id',
          message: 'Different draft message',
          replyMessageId: null,
        );
        when(() => mockMessageLocalRepository.saveDraftMessage(differentParams)).thenAnswer((_) async {});

        // When
        await useCase.call(differentParams);

        // Then
        verify(() => mockMessageLocalRepository.saveDraftMessage(differentParams)).called(1);
        verifyNever(() => mockMessageLocalRepository.saveDraftMessage(testParams));
      },
    );

    test(
      'Given SaveDraftMessageEntity with null replyMessageId, When call is invoked, Then calls saveDraftMessage successfully',
      () async {
        // Given
        const paramsWithNullReply = SaveDraftMessageEntity(
          roomId: 'test-room-id',
          message: 'Test message',
          replyMessageId: null,
        );
        when(() => mockMessageLocalRepository.saveDraftMessage(paramsWithNullReply)).thenAnswer((_) async {});

        // When
        await useCase.call(paramsWithNullReply);

        // Then
        verify(() => mockMessageLocalRepository.saveDraftMessage(paramsWithNullReply)).called(1);
      },
    );

    test(
      'Given repository throws specific exception type, When call is invoked, Then specific exception type propagates',
      () async {
        // Given
        final argumentError = ArgumentError('Invalid draft message data');
        when(() => mockMessageLocalRepository.saveDraftMessage(testParams)).thenThrow(argumentError);

        // When/Then
        await expectLater(
          () => useCase.call(testParams),
          throwsA(isA<ArgumentError>()),
        );
        verify(() => mockMessageLocalRepository.saveDraftMessage(testParams)).called(1);
      },
    );
  });
}
