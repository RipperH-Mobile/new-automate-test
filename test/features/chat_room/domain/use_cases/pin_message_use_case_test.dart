import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_local_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/pin_message_use_case.dart';

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

class MockPinMessageServerRepository extends Mock implements PinMessageServerRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

// Fake classes for request objects
class FakePinMessageRequest extends Fake implements PinMessageRequest {}

class FakePinMessageLocalRequest extends Fake implements PinMessageLocalRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePinMessageRequest());
    registerFallbackValue(FakePinMessageLocalRequest());
  });
  late PinMessageUseCase useCase;
  late MockPinMessageLocalRepository mockPinMessageLocalRepository;
  late MockPinMessageServerRepository mockPinMessageServerRepository;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUp(() {
    mockPinMessageLocalRepository = MockPinMessageLocalRepository();
    mockPinMessageServerRepository = MockPinMessageServerRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();

    useCase = PinMessageUseCase(
      pinMessageLocalRepository: mockPinMessageLocalRepository,
      pinMessageServerRepository: mockPinMessageServerRepository,
      messageLocalRepository: mockMessageLocalRepository,
    );
  });

  tearDown(() {
    reset(mockPinMessageLocalRepository);
    reset(mockPinMessageServerRepository);
    reset(mockMessageLocalRepository);
  });

  group('PinMessageUseCase', () {
    group('call', () {
      test(
          'Given valid pin message params, When call is invoked, Then pins message on server and saves to local repository',
          () async {
        // Given
        final params = PinMessageParams(
          messageId: 'test-message-id',
          roomId: 'test-room-id',
        );

        const mockMessage = MessageEntity(
          id: 'test-message-id',
          roomId: 'test-room-id',
          message: 'Test message content',
        );

        const mockPinMessageResponse = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: mockMessage,
        );

        when(() => mockPinMessageServerRepository.pinMessage(any())).thenAnswer((_) async => mockPinMessageResponse);

        when(() => mockPinMessageLocalRepository.pinMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockPinMessageServerRepository.pinMessage(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessage(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
        verifyZeroInteractions(mockMessageLocalRepository);
      });

      test(
          'Given server repository throws exception, When call is invoked, Then exception is propagated and local repository is not called',
          () async {
        // Given
        final params = PinMessageParams(
          messageId: 'test-message-id',
          roomId: 'test-room-id',
        );

        final testException = Exception('Server error');

        when(() => mockPinMessageServerRepository.pinMessage(any())).thenThrow(testException);

        // When
        Future<void> call() => useCase.call(params);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.pinMessage(any())).called(1);
        verifyZeroInteractions(mockPinMessageLocalRepository);
        verifyZeroInteractions(mockMessageLocalRepository);
      });

      test('Given local repository throws exception, When call is invoked, Then exception is propagated', () async {
        // Given
        final params = PinMessageParams(
          messageId: 'test-message-id',
          roomId: 'test-room-id',
        );

        const mockPinMessageResponse = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        final testException = Exception('Local repository error');

        when(() => mockPinMessageServerRepository.pinMessage(any())).thenAnswer((_) async => mockPinMessageResponse);

        when(() => mockPinMessageLocalRepository.pinMessage(any())).thenThrow(testException);

        // When
        Future<void> call() => useCase.call(params);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.pinMessage(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessage(any())).called(1);
        verifyZeroInteractions(mockMessageLocalRepository);
      });

      test('Given empty message ID, When call is invoked, Then processes correctly with empty message ID', () async {
        // Given
        final params = PinMessageParams(
          messageId: '',
          roomId: 'test-room-id',
        );

        const mockPinMessageResponse = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: 'test-room-id',
          parentId: null,
          createdAt: null,
          message: null,
        );

        when(() => mockPinMessageServerRepository.pinMessage(any())).thenAnswer((_) async => mockPinMessageResponse);

        when(() => mockPinMessageLocalRepository.pinMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockPinMessageServerRepository.pinMessage(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessage(any())).called(1);
        verifyZeroInteractions(mockMessageLocalRepository);
      });

      test('Given empty room ID, When call is invoked, Then processes correctly with empty room ID', () async {
        // Given
        final params = PinMessageParams(
          messageId: 'test-message-id',
          roomId: '',
        );

        const mockPinMessageResponse = PinMessageEntity(
          id: 'test-pin-id',
          ref: 'test-ref',
          pinnedBy: 'test-user-id',
          roomId: '',
          parentId: null,
          createdAt: null,
          message: null,
        );

        when(() => mockPinMessageServerRepository.pinMessage(any())).thenAnswer((_) async => mockPinMessageResponse);

        when(() => mockPinMessageLocalRepository.pinMessage(any())).thenAnswer((_) async {});

        // When
        await useCase.call(params);

        // Then
        verify(() => mockPinMessageServerRepository.pinMessage(any())).called(1);
        verify(() => mockPinMessageLocalRepository.pinMessage(any())).called(1);
        verifyZeroInteractions(mockMessageLocalRepository);
      });
    });
  });

  group('PinMessageParams', () {
    group('constructor', () {
      test('Given valid parameters, When PinMessageParams is created, Then creates instance with correct properties',
          () {
        // Given
        const messageId = 'test-message-id';
        const roomId = 'test-room-id';

        // When
        final params = PinMessageParams(
          messageId: messageId,
          roomId: roomId,
        );

        // Then
        expect(params.messageId, equals(messageId));
        expect(params.roomId, equals(roomId));
      });

      test(
          'Given empty string parameters, When PinMessageParams is created, Then creates instance with empty string properties',
          () {
        // Given
        const messageId = '';
        const roomId = '';

        // When
        final params = PinMessageParams(
          messageId: messageId,
          roomId: roomId,
        );

        // Then
        expect(params.messageId, equals(''));
        expect(params.roomId, equals(''));
      });
    });

    group('equality', () {
      test('Given two identical PinMessageParams, When compared for equality, Then properties match', () {
        // Given
        final params1 = PinMessageParams(
          messageId: 'test-message-id',
          roomId: 'test-room-id',
        );
        final params2 = PinMessageParams(
          messageId: 'test-message-id',
          roomId: 'test-room-id',
        );

        // When & Then
        expect(params1.messageId, equals(params2.messageId));
        expect(params1.roomId, equals(params2.roomId));
      });

      test('Given two different PinMessageParams, When compared for equality, Then properties do not match', () {
        // Given
        final params1 = PinMessageParams(
          messageId: 'test-message-id-1',
          roomId: 'test-room-id',
        );
        final params2 = PinMessageParams(
          messageId: 'test-message-id-2',
          roomId: 'test-room-id',
        );

        // When & Then
        expect(params1.messageId, isNot(equals(params2.messageId)));
        expect(params1.roomId, equals(params2.roomId));
      });
    });
  });
}
