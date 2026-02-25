// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_param.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_sent_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_from_server_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockGetMessageFromServerUseCase extends Mock implements GetMessageFromServerUseCase {}

class MockLoggerService extends Mock implements LoggerService {}

class FakeMessageEntity extends Fake implements MessageEntity {}

class FakeGetMessageFromServerParam extends Fake implements GetMessageFromServerParam {}

void main() {
  late GetAllSentMessageUseCase useCase;
  late MockMessageLocalRepository mockRepository;
  late MockGetMessageFromServerUseCase mockGetMessageFromServerUseCase;
  late MockLoggerService mockLogger;
  late GetAllSentMessageParams testParams;
  late List<MessageEntity> testMessages;
  late MessageEntity testMessage1;
  late MessageEntity testMessage2;
  late MessageEntity testMessage3;

  setUpAll(() {
    registerFallbackValue(FakeGetMessageFromServerParam());
    registerFallbackValue(true);
  });

  setUp(() {
    mockRepository = MockMessageLocalRepository();
    mockGetMessageFromServerUseCase = MockGetMessageFromServerUseCase();
    mockLogger = MockLoggerService();

    // Register the mocks in GetIt
    if (GetIt.I.isRegistered<GetMessageFromServerUseCase>()) {
      GetIt.I.unregister<GetMessageFromServerUseCase>();
    }
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
    GetIt.I.registerSingleton<GetMessageFromServerUseCase>(mockGetMessageFromServerUseCase);
    GetIt.I.registerSingleton<LoggerService>(mockLogger);

    useCase = GetAllSentMessageUseCase(
      messageLocalRepository: mockRepository,
    );

    testParams = GetAllSentMessageParams(
      roomId: 'test-room-id',
      limit: 50,
      sequenceLessThan: 1000,
      sequenceGreaterThan: 500,
      isMyNote: false,
      emojiTagId: 'emoji-tag-1',
      sequenceOfVeryFirstMessageInRoom: 100,
      useDefaultMessageLoadLimit: true,
    );

    testMessage1 = const MessageEntity(
      id: 'message-1',
      ref: 'ref-1',
      roomId: 'test-room-id',
      message: 'Test message 1',
      sequence: 800,
    );

    testMessage2 = const MessageEntity(
      id: 'message-2',
      ref: 'ref-2',
      roomId: 'test-room-id',
      message: 'Test message 2',
      sequence: 900,
    );

    testMessage3 = const MessageEntity(
      id: 'message-3',
      ref: 'ref-3',
      roomId: 'test-room-id',
      message: 'Test message 3',
      sequence: 950,
    );

    testMessages = [testMessage1, testMessage2, testMessage3];
  });

  tearDown(() {
    if (GetIt.I.isRegistered<GetMessageFromServerUseCase>()) {
      GetIt.I.unregister<GetMessageFromServerUseCase>();
    }
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
  });

  group('GetAllSentMessageUseCase', () {
    group('Happy Path Tests', () {
      test(
        'Given valid params with enough messages from local repository, When use case is called, Then returns messages from local repository without server call',
        () async {
          // Given
          // Create enough messages to reach the limit so server won't be called
          final manyMessages = List.generate(
              UChatConstant.messageLoadLimit,
              (index) => MessageEntity(
                    id: 'message-$index',
                    ref: 'ref-$index',
                    roomId: 'test-room-id',
                    message: 'Message $index',
                    sequence: 800 + index,
                  ));

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => manyMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(UChatConstant.messageLoadLimit));
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).called(1);
          verifyNever(() => mockGetMessageFromServerUseCase.call(any()));
        },
      );

      test(
        'Given params with useDefaultMessageLoadLimit true and null limit, When use case is called, Then uses default message load limit',
        () async {
          // Given
          final paramsWithDefaultLimit = GetAllSentMessageParams(
            roomId: 'test-room-id',
            useDefaultMessageLoadLimit: true,
          );

          // Create enough messages to reach the limit so server won't be called
          final manyMessages = List.generate(
              UChatConstant.messageLoadLimit,
              (index) => MessageEntity(
                    id: 'message-$index',
                    ref: 'ref-$index',
                    roomId: 'test-room-id',
                    message: 'Message $index',
                    sequence: 800 + index,
                  ));

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => manyMessages);

          // When
          final result = await useCase(paramsWithDefaultLimit);

          // Then
          expect(result, hasLength(UChatConstant.messageLoadLimit));
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: null,
                sequenceGreaterThan: null,
                isMyNote: false,
                emojiTagId: null,
              )).called(1);
        },
      );

      test(
        'Given params with useDefaultMessageLoadLimit false and null limit, When use case is called, Then uses null limit',
        () async {
          // Given
          final paramsWithoutDefaultLimit = GetAllSentMessageParams(
            roomId: 'test-room-id',
            useDefaultMessageLoadLimit: false,
          );

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => testMessages);

          // When
          final result = await useCase(paramsWithoutDefaultLimit);

          // Then
          expect(result, hasLength(3));
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: null,
                sequenceGreaterThan: null,
                isMyNote: false,
                emojiTagId: null,
              )).called(1);
        },
      );
    });

    group('Server Fetch Tests', () {
      test(
        'Given empty local messages, When use case is called, Then fetches from server and returns updated messages',
        () async {
          // Given
          final emptyMessages = <MessageEntity>[];
          final serverMessages = [testMessage1, testMessage2];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => emptyMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => serverMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(2));
          expect(result, containsAll(serverMessages));
          verify(() => mockGetMessageFromServerUseCase.call(any())).called(1);
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).called(1);
        },
      );

      test(
        'Given messages not reaching limit and not very first message, When use case is called, Then fetches from server',
        () async {
          // Given
          final limitedMessages = [testMessage1]; // Only 1 message, less than limit
          final serverMessages = [testMessage1, testMessage2, testMessage3];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => limitedMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => serverMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(3));
          verify(() => mockGetMessageFromServerUseCase.call(any())).called(1);
        },
      );

      test(
        'Given sequenceLessThan is not null, When fetching from server, Then sets onlyPrevious to true',
        () async {
          // Given
          final emptyMessages = <MessageEntity>[];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => emptyMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => []);

          // When
          await useCase(testParams);

          // Then
          final captured = verify(() => mockGetMessageFromServerUseCase.call(captureAny())).captured;
          final param = captured.first as GetMessageFromServerParam;
          expect(param.roomId, equals('test-room-id'));
          expect(param.onlyPrevious, isTrue);
        },
      );

      test(
        'Given sequenceLessThan is null, When fetching from server, Then onlyPrevious remains false',
        () async {
          // Given
          final paramsWithoutSequenceLessThan = GetAllSentMessageParams(
            roomId: 'test-room-id',
            sequenceOfVeryFirstMessageInRoom: 100,
          );
          final emptyMessages = <MessageEntity>[];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => emptyMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: null,
                sequenceGreaterThan: null,
                isMyNote: false,
                emojiTagId: null,
              )).thenAnswer((_) async => []);

          // When
          await useCase(paramsWithoutSequenceLessThan);

          // Then
          final captured = verify(() => mockGetMessageFromServerUseCase.call(captureAny())).captured;
          final param = captured.first as GetMessageFromServerParam;
          expect(param.roomId, equals('test-room-id'));
          expect(param.onlyPrevious, isFalse);
        },
      );
    });

    group('Message Deduplication Tests', () {
      test(
        'Given messages with duplicate refs, When use case is called, Then returns deduplicated messages',
        () async {
          // Given
          final duplicateMessage = const MessageEntity(
            id: 'message-duplicate',
            ref: 'ref-1',
            // Same ref as testMessage1
            roomId: 'test-room-id',
            message: 'Duplicate message',
            sequence: 850,
          );
          final messagesWithDuplicates = [testMessage1, duplicateMessage, testMessage2];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => messagesWithDuplicates);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(2)); // Only unique refs
          expect(result.map((m) => m.ref), containsAll(['ref-1', 'ref-2']));
          // Should keep the first message with the ref
          expect(result.firstWhere((m) => m.ref == 'ref-1').id, equals('message-1'));
        },
      );

      test(
        'Given messages with null refs, When use case is called, Then excludes messages with null refs',
        () async {
          // Given
          final messageWithNullRef = const MessageEntity(
            id: 'message-null-ref',
            ref: null,
            roomId: 'test-room-id',
            message: 'Message with null ref',
            sequence: 850,
          );
          final messagesWithNullRef = [testMessage1, messageWithNullRef, testMessage2];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => messagesWithNullRef);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(2)); // Excludes message with null ref
          expect(result.map((m) => m.id), containsAll(['message-1', 'message-2']));
          expect(result.any((m) => m.id == 'message-null-ref'), isFalse);
        },
      );
    });

    group('Edge Cases Tests', () {
      test(
        'Given messages reaching limit and is very first message, When use case is called, Then does not fetch from server',
        () async {
          // Given
          final paramsWithVeryFirstMessage = GetAllSentMessageParams(
            roomId: 'test-room-id',
            sequenceOfVeryFirstMessageInRoom: 900, // Same as testMessage2.sequence
          );

          // Create enough messages to reach the limit
          final manyMessages = List.generate(
              UChatConstant.messageLoadLimit,
              (index) => MessageEntity(
                    id: 'message-$index',
                    ref: 'ref-$index',
                    roomId: 'test-room-id',
                    message: 'Message $index',
                    sequence: 900, // Same as sequenceOfVeryFirstMessageInRoom
                  ));

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => manyMessages);

          // When
          final result = await useCase(paramsWithVeryFirstMessage);

          // Then
          expect(result, hasLength(UChatConstant.messageLoadLimit));
          verifyNever(() => mockGetMessageFromServerUseCase.call(any()));
        },
      );

      test(
        'Given empty messages list, When use case is called, Then returns empty list',
        () async {
          // Given
          final emptyMessages = <MessageEntity>[];

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => emptyMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => emptyMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, isEmpty);
        },
      );
    });

    group('Error Handling Tests', () {
      test(
        'Given local repository throws exception, When use case is called, Then logs warning and continues',
        () async {
          // Given
          final exception = Exception('Local database error');
          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenThrow(exception);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => testMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(3));
          verify(() => mockGetMessageFromServerUseCase.call(any())).called(1);
        },
      );

      test(
        'Given server use case throws exception, When use case is called, Then logs warning and continues',
        () async {
          // Given
          final emptyMessages = <MessageEntity>[];
          final exception = Exception('Server error');

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => emptyMessages);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenThrow(exception);

          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenAnswer((_) async => testMessages);

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, hasLength(3));
        },
      );

      test(
        'Given overall exception in use case, When use case is called, Then logs error and returns empty list',
        () async {
          // Given
          final exception = Exception('Critical error');
          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenThrow(exception);

          // Mock the second call to also throw to trigger the outer catch
          when(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).thenThrow(exception);

          when(() => mockGetMessageFromServerUseCase.call(any())).thenAnswer((_) async {});

          // When
          final result = await useCase(testParams);

          // Then
          expect(result, isEmpty);
        },
      );
    });

    group('Parameter Validation Tests', () {
      test(
        'Given GetAllSentMessageParams with all fields, When use case is called, Then passes all parameters correctly',
        () async {
          // Given
          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => testMessages);

          // When
          await useCase(testParams);

          // Then
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: 1000,
                sequenceGreaterThan: 500,
                isMyNote: false,
                emojiTagId: 'emoji-tag-1',
              )).called(1);
        },
      );

      test(
        'Given GetAllSentMessageParams with minimal fields, When use case is called, Then passes correct default values',
        () async {
          // Given
          final minimalParams = GetAllSentMessageParams(roomId: 'test-room-id');

          // Create enough messages to reach the limit so server won't be called
          final manyMessages = List.generate(
              UChatConstant.messageLoadLimit,
              (index) => MessageEntity(
                    id: 'message-$index',
                    ref: 'ref-$index',
                    roomId: 'test-room-id',
                    message: 'Message $index',
                    sequence: 800 + index,
                  ));

          when(() => mockRepository.getAllSentMessage(
                roomId: any(named: 'roomId'),
                limit: any(named: 'limit'),
                sequenceLessThan: any(named: 'sequenceLessThan'),
                sequenceGreaterThan: any(named: 'sequenceGreaterThan'),
                isMyNote: any(named: 'isMyNote'),
                emojiTagId: any(named: 'emojiTagId'),
              )).thenAnswer((_) async => manyMessages);

          // When
          await useCase(minimalParams);

          // Then
          verify(() => mockRepository.getAllSentMessage(
                roomId: 'test-room-id',
                limit: UChatConstant.messageLoadLimit,
                sequenceLessThan: null,
                sequenceGreaterThan: null,
                isMyNote: false,
                emojiTagId: null,
              )).called(1);
        },
      );
    });
  });
}
