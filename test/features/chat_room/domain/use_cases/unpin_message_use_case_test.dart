import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_message_use_case.dart';

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

class MockPinMessageServerRepository extends Mock implements PinMessageServerRepository {}

// Fake class for UnpinMessageRequest
class FakeUnpinMessageRequest extends Fake implements UnpinMessageRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUnpinMessageRequest());
  });
  late UnpinMessageUseCase useCase;
  late MockPinMessageLocalRepository mockPinMessageLocalRepository;
  late MockPinMessageServerRepository mockPinMessageServerRepository;

  setUp(() {
    mockPinMessageLocalRepository = MockPinMessageLocalRepository();
    mockPinMessageServerRepository = MockPinMessageServerRepository();

    useCase = UnpinMessageUseCase(
      pinMessageLocalRepository: mockPinMessageLocalRepository,
      pinMessageServerRepository: mockPinMessageServerRepository,
    );
  });

  tearDown(() {
    reset(mockPinMessageLocalRepository);
    reset(mockPinMessageServerRepository);
  });

  group('UnpinMessageUseCase', () {
    group('call', () {
      group('with pinId provided', () {
        test('Given valid params with pinId, When call is invoked, Then unpins message on server and local repository',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            pinId: 'test-pin-id',
          );

          when(() => mockPinMessageServerRepository.unpinMessage(any())).thenAnswer((_) async {});

          when(() => mockPinMessageLocalRepository.unpinMessage(any())).thenAnswer((_) async {});

          // When
          await useCase.call(params);

          // Then
          verify(() => mockPinMessageServerRepository.unpinMessage(any())).called(1);
          verify(() => mockPinMessageLocalRepository.unpinMessage(any())).called(1);

          verifyNoMoreInteractions(mockPinMessageServerRepository);
          verifyNoMoreInteractions(mockPinMessageLocalRepository);
        });

        test(
            'Given server repository throws exception, When call is invoked, Then exception is propagated and local repository is not called',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            pinId: 'test-pin-id',
          );

          final testException = Exception('Server error');

          when(() => mockPinMessageServerRepository.unpinMessage(any())).thenThrow(testException);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(call, throwsA(isA<Exception>()));

          verify(() => mockPinMessageServerRepository.unpinMessage(any())).called(1);
          verifyZeroInteractions(mockPinMessageLocalRepository);
        });

        test('Given local repository throws exception, When call is invoked, Then exception is propagated', () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            pinId: 'test-pin-id',
          );

          final testException = Exception('Local repository error');

          when(() => mockPinMessageServerRepository.unpinMessage(any())).thenAnswer((_) async {});

          when(() => mockPinMessageLocalRepository.unpinMessage(any())).thenThrow(testException);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(call, throwsA(isA<Exception>()));

          verify(() => mockPinMessageServerRepository.unpinMessage(any())).called(1);
          verify(() => mockPinMessageLocalRepository.unpinMessage(any())).called(1);
        });
      });

      group('with ref provided', () {
        test(
            'Given valid params with ref and pin message exists, When call is invoked, Then unpins message on server and local repository',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            ref: 'test-ref',
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

          when(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref'))
              .thenAnswer((_) async => mockPinMessage);

          when(() => mockPinMessageServerRepository.unpinMessage(any())).thenAnswer((_) async {});

          when(() => mockPinMessageLocalRepository.unpinMessage(any())).thenAnswer((_) async {});

          // When
          await useCase.call(params);

          // Then
          verify(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).called(1);
          verify(() => mockPinMessageServerRepository.unpinMessage(any())).called(1);
          verify(() => mockPinMessageLocalRepository.unpinMessage(any())).called(1);

          verifyNoMoreInteractions(mockPinMessageServerRepository);
          verifyNoMoreInteractions(mockPinMessageLocalRepository);
        });

        test(
            'Given params with ref but pin message not found, When call is invoked, Then throws exception with specific message',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            ref: 'test-ref',
          );

          when(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).thenAnswer((_) async => null);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(
            call,
            throwsA(predicate<Exception>(
                (e) => e.toString().contains('Either pinId or a valid ref must be provided to unpin a message'))),
          );

          verify(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).called(1);
          verifyZeroInteractions(mockPinMessageServerRepository);
          verifyNever(() => mockPinMessageLocalRepository.unpinMessage(any()));
        });

        test(
            'Given params with ref but pin message has null id, When call is invoked, Then throws exception with specific message',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            ref: 'test-ref',
          );

          const mockPinMessage = PinMessageEntity(
            id: null,
            ref: 'test-ref',
            pinnedBy: 'test-user-id',
            roomId: 'test-room-id',
            parentId: null,
            createdAt: null,
            message: null,
          );

          when(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref'))
              .thenAnswer((_) async => mockPinMessage);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(
            call,
            throwsA(predicate<Exception>(
                (e) => e.toString().contains('Either pinId or a valid ref must be provided to unpin a message'))),
          );

          verify(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).called(1);
          verifyZeroInteractions(mockPinMessageServerRepository);
          verifyNever(() => mockPinMessageLocalRepository.unpinMessage(any()));
        });

        test(
            'Given params with ref and getPinMessageByRef throws exception, When call is invoked, Then throws the original exception',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            ref: 'test-ref',
          );

          final repositoryException = Exception('Repository error');

          when(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).thenThrow(repositoryException);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(
            call,
            throwsA(repositoryException),
          );

          verify(() => mockPinMessageLocalRepository.getPinMessageByRef('test-ref')).called(1);
          verifyZeroInteractions(mockPinMessageServerRepository);
          verifyNever(() => mockPinMessageLocalRepository.unpinMessage(any()));
        });
      });

      group('error cases', () {
        test(
            'Given params with neither pinId nor ref, When call is invoked, Then throws exception with specific message',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
          );

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(
            call,
            throwsA(predicate<Exception>(
                (e) => e.toString().contains('Either pinId or a valid ref must be provided to unpin a message'))),
          );

          verifyZeroInteractions(mockPinMessageLocalRepository);
          verifyZeroInteractions(mockPinMessageServerRepository);
        });

        test(
            'Given params with both pinId and ref (pinId takes precedence), When call is invoked, Then uses pinId only',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            pinId: 'test-pin-id',
            ref: 'test-ref',
          );

          when(() => mockPinMessageServerRepository.unpinMessage(any())).thenAnswer((_) async {});

          when(() => mockPinMessageLocalRepository.unpinMessage(any())).thenAnswer((_) async {});

          // When
          await useCase.call(params);

          // Then
          verify(() => mockPinMessageServerRepository.unpinMessage(any())).called(1);
          verify(() => mockPinMessageLocalRepository.unpinMessage(any())).called(1);

          // Should not call getPinMessageByRef when pinId is provided
          verifyNever(() => mockPinMessageLocalRepository.getPinMessageByRef(any()));
          verifyNoMoreInteractions(mockPinMessageServerRepository);
          verifyNoMoreInteractions(mockPinMessageLocalRepository);
        });

        test('Given params with empty pinId (null) and empty ref, When call is invoked, Then throws exception',
            () async {
          // Given
          final params = UnpinMessageParams(
            roomId: 'test-room-id',
            pinId: null,
            ref: '',
          );

          when(() => mockPinMessageLocalRepository.getPinMessageByRef('')).thenAnswer((_) async => null);

          // When
          Future<void> call() => useCase.call(params);

          // Then
          await expectLater(
            call,
            throwsA(predicate<Exception>(
                (e) => e.toString().contains('Either pinId or a valid ref must be provided to unpin a message'))),
          );

          verify(() => mockPinMessageLocalRepository.getPinMessageByRef('')).called(1);
          verifyNoMoreInteractions(mockPinMessageLocalRepository);
          verifyZeroInteractions(mockPinMessageServerRepository);
        });
      });
    });
  });

  group('UnpinMessageParams', () {
    group('constructor', () {
      test(
          'Given valid parameters with pinId, When UnpinMessageParams is created, Then creates instance with correct properties',
          () {
        // Given
        const roomId = 'test-room-id';
        const pinId = 'test-pin-id';

        // When
        final params = UnpinMessageParams(
          roomId: roomId,
          pinId: pinId,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pinId, equals(pinId));
        expect(params.ref, isNull);
      });

      test(
          'Given valid parameters with ref, When UnpinMessageParams is created, Then creates instance with correct properties',
          () {
        // Given
        const roomId = 'test-room-id';
        const ref = 'test-ref';

        // When
        final params = UnpinMessageParams(
          roomId: roomId,
          ref: ref,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pinId, isNull);
        expect(params.ref, equals(ref));
      });

      test(
          'Given valid parameters with both pinId and ref, When UnpinMessageParams is created, Then creates instance with both properties',
          () {
        // Given
        const roomId = 'test-room-id';
        const pinId = 'test-pin-id';
        const ref = 'test-ref';

        // When
        final params = UnpinMessageParams(
          roomId: roomId,
          pinId: pinId,
          ref: ref,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pinId, equals(pinId));
        expect(params.ref, equals(ref));
      });

      test('Given only roomId, When UnpinMessageParams is created, Then creates instance with null pinId and ref', () {
        // Given
        const roomId = 'test-room-id';

        // When
        final params = UnpinMessageParams(
          roomId: roomId,
        );

        // Then
        expect(params.roomId, equals(roomId));
        expect(params.pinId, isNull);
        expect(params.ref, isNull);
      });
    });

    group('equality', () {
      test('Given two identical UnpinMessageParams, When compared for equality, Then properties match', () {
        // Given
        final params1 = UnpinMessageParams(
          roomId: 'test-room-id',
          pinId: 'test-pin-id',
          ref: 'test-ref',
        );
        final params2 = UnpinMessageParams(
          roomId: 'test-room-id',
          pinId: 'test-pin-id',
          ref: 'test-ref',
        );

        // When & Then
        expect(params1.roomId, equals(params2.roomId));
        expect(params1.pinId, equals(params2.pinId));
        expect(params1.ref, equals(params2.ref));
      });

      test('Given two different UnpinMessageParams, When compared for equality, Then properties do not match', () {
        // Given
        final params1 = UnpinMessageParams(
          roomId: 'test-room-id-1',
          pinId: 'test-pin-id-1',
        );
        final params2 = UnpinMessageParams(
          roomId: 'test-room-id-2',
          pinId: 'test-pin-id-2',
        );

        // When & Then
        expect(params1.roomId, isNot(equals(params2.roomId)));
        expect(params1.pinId, isNot(equals(params2.pinId)));
      });
    });
  });
}
