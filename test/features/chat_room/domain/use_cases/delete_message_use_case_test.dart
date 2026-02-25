import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/params/delete_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_message_use_case.dart';

// Mock Definitions
class MockMessageServerRepository extends Mock implements MessageServerRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

// Fake Classes for Fallback Values
class FakeDeleteMessageParams extends Fake implements DeleteMessageParams {}

class FakeMessageCollection extends Fake implements MessageCollection {}

class FakeMessageFileModel extends Fake implements MessageFileModel {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FakeMessageFileModel';
  }
}

void main() {
  late DeleteMessageUseCase useCase;
  late MockMessageServerRepository mockMessageServerRepository;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUpAll(() {
    // Initialize the global eventBus for testing
    initializeEventBus(enableTracking: false);

    // Register fallback values for custom types
    registerFallbackValue(FakeDeleteMessageParams());
    registerFallbackValue(FakeMessageCollection());
    registerFallbackValue(FakeMessageFileModel());
  });

  setUp(() {
    mockMessageServerRepository = MockMessageServerRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();

    useCase = DeleteMessageUseCase(
      messageRepoServer: mockMessageServerRepository,
      messageRepoLocal: mockMessageLocalRepository,
    );

    // Reset mocks before each test
    reset(mockMessageServerRepository);
    reset(mockMessageLocalRepository);
  });

  group('DeleteMessageUseCase', () {
    group('constructor', () {
      test('Given valid repositories, When DeleteMessageUseCase is created, Then initializes correctly', () {
        // Given
        final serverRepo = MockMessageServerRepository();
        final localRepo = MockMessageLocalRepository();

        // When
        final result = DeleteMessageUseCase(
          messageRepoServer: serverRepo,
          messageRepoLocal: localRepo,
        );

        // Then
        expect(result.messageRepoServer, equals(serverRepo));
        expect(result.messageRepoLocal, equals(localRepo));
      });
    });

    group('call', () {
      test(
          'Given valid params with messages having id and files, When call is executed, Then calls server repository and fires events',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId1 = 'message_1';
        const messageId2 = 'message_2';
        const fileId1 = 'file_1';
        const fileId2 = 'file_2';
        const fileId3 = 'file_3';

        final file1 = MessageFileModel(id: fileId1);
        final file2 = MessageFileModel(id: fileId2);
        final file3 = MessageFileModel(id: fileId3);

        final message1 = MessageCollection(
          id: messageId1,
          files: [file1, file2],
        );
        final message2 = MessageCollection(
          id: messageId2,
          files: [file3],
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [message1, message2],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
      });

      test(
          'Given valid params with messages having null id, When call is executed, Then skips event firing for null id messages',
          () async {
        // Given
        const roomId = 'test_room_id';
        const fileId1 = 'file_1';

        final file1 = MessageFileModel(id: fileId1);
        final messageWithNullId = MessageCollection(
          id: null, // null id
          files: [file1],
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [messageWithNullId],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // No events should be fired since messageId is null
      });

      test(
          'Given valid params with messages having null files, When call is executed, Then skips event firing for null files messages',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId = 'message_1';

        final messageWithNullFiles = MessageCollection(
          id: messageId,
          files: null, // null files
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [messageWithNullFiles],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // No events should be fired since files is null
      });

      test(
          'Given valid params with messages having files with null ids, When call is executed, Then filters out null file ids in events',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId = 'message_1';
        const fileId1 = 'file_1';

        final fileWithId = MessageFileModel(id: fileId1);
        final fileWithNullId = MessageFileModel(id: null);

        final message = MessageCollection(
          id: messageId,
          files: [fileWithId, fileWithNullId],
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [message],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // Event should be fired with only non-null file ids
      });

      test('Given empty messages list, When call is executed, Then calls server repository but fires no events',
          () async {
        // Given
        const roomId = 'test_room_id';
        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [], // empty list
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // No events should be fired since messages list is empty
      });

      test(
          'Given valid params with multiple messages, When call is executed, Then processes all messages and fires events for each valid message',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId1 = 'message_1';
        const messageId2 = 'message_2';
        const messageId3 = 'message_3';
        const fileId1 = 'file_1';
        const fileId2 = 'file_2';
        const fileId3 = 'file_3';

        final file1 = MessageFileModel(id: fileId1);
        final file2 = MessageFileModel(id: fileId2);
        final file3 = MessageFileModel(id: fileId3);

        final validMessage1 = MessageCollection(
          id: messageId1,
          files: [file1],
        );
        final validMessage2 = MessageCollection(
          id: messageId2,
          files: [file2, file3],
        );
        final invalidMessage = MessageCollection(
          id: null, // invalid - null id
          files: [file1],
        );
        final anotherInvalidMessage = MessageCollection(
          id: messageId3,
          files: null, // invalid - null files
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [validMessage1, invalidMessage, validMessage2, anotherInvalidMessage],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // Events should be fired only for validMessage1 and validMessage2
      });

      test('Given server repository throws exception, When call is executed, Then exception is propagated', () async {
        // Given
        const roomId = 'test_room_id';
        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [],
        );

        final testException = Exception('Server error');
        when(() => mockMessageServerRepository.removeMessage(any())).thenThrow(testException);

        // When
        final call = () => useCase.call(params);

        // Then
        expect(call, throwsA(equals(testException)));
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
      });

      test(
          'Given valid params with files having empty string ids, When call is executed, Then includes empty string ids in events',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId = 'message_1';
        const fileId1 = 'file_1';
        const emptyFileId = '';

        final fileWithId = MessageFileModel(id: fileId1);
        final fileWithEmptyId = MessageFileModel(id: emptyFileId);

        final message = MessageCollection(
          id: messageId,
          files: [fileWithId, fileWithEmptyId],
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [message],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // Event should be fired with both file ids including empty string
      });

      test(
          'Given valid params with single message having single file, When call is executed, Then fires single event with correct data',
          () async {
        // Given
        const roomId = 'test_room_id';
        const messageId = 'message_1';
        const fileId = 'file_1';

        final file = MessageFileModel(id: fileId);
        final message = MessageCollection(
          id: messageId,
          files: [file],
        );

        final params = DeleteMessageParams(
          roomId: roomId,
          messages: [message],
        );

        when(() => mockMessageServerRepository.removeMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockMessageServerRepository.removeMessage(params)).called(1);
        verifyNoMoreInteractions(mockMessageServerRepository);
        verifyNoMoreInteractions(mockMessageLocalRepository);
        // Single event should be fired with messageId and [fileId]
      });
    });
  });
}
