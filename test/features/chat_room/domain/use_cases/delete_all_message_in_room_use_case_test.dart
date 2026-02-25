import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_all_message_in_room_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

void main() {
  late DeleteAllMessageInRoomUseCase useCase;
  late MockMessageLocalRepository mockMessageRepoLocal;

  setUp(() {
    mockMessageRepoLocal = MockMessageLocalRepository();
    useCase = DeleteAllMessageInRoomUseCase(
      messageRepoLocal: mockMessageRepoLocal,
    );
  });

  group('DeleteAllMessageInRoomUseCase', () {
    test(
      'Given valid room ID, When use case is called, Then calls repository deleteAllMessageInRoom with correct parameters',
      () async {
        // Given
        const roomId = 'test-room-id';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given empty room ID, When use case is called, Then calls repository deleteAllMessageInRoom with empty string',
      () async {
        // Given
        const roomId = '';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given room ID with special characters, When use case is called, Then calls repository deleteAllMessageInRoom with correct parameters',
      () async {
        // Given
        const roomId = 'room-id-with-special-chars-@#\$%^&*()';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given very long room ID, When use case is called, Then calls repository deleteAllMessageInRoom with correct parameters',
      () async {
        // Given
        final roomId = 'a' * 1000; // Very long room ID
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given repository throws exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        const roomId = 'test-room-id';
        final exception = Exception('Database error');
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(roomId),
          throwsA(equals(exception)),
        );
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given repository throws custom exception, When use case is called, Then rethrows the custom exception',
      () async {
        // Given
        const roomId = 'test-room-id';
        final customException = ArgumentError('Invalid room ID');
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenThrow(customException);

        // When/Then
        await expectLater(
          () => useCase(roomId),
          throwsA(equals(customException)),
        );
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given repository completes successfully, When use case is called, Then completes without error',
      () async {
        // Given
        const roomId = 'test-room-id';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        final result = useCase(roomId);

        // Then
        await expectLater(result, completes);
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );

    test(
      'Given multiple calls with same room ID, When use case is called multiple times, Then calls repository multiple times',
      () async {
        // Given
        const roomId = 'test-room-id';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);
        await useCase(roomId);
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(3);
      },
    );

    test(
      'Given multiple calls with different room IDs, When use case is called multiple times, Then calls repository with correct parameters each time',
      () async {
        // Given
        const roomId1 = 'test-room-id-1';
        const roomId2 = 'test-room-id-2';
        const roomId3 = 'test-room-id-3';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId1);
        await useCase(roomId2);
        await useCase(roomId3);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId1, useTxn: true)).called(1);
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId2, useTxn: true)).called(1);
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId3, useTxn: true)).called(1);
      },
    );

    test(
      'Given constructor with repository, When use case is instantiated, Then stores repository correctly',
      () {
        // Given/When
        final testUseCase = DeleteAllMessageInRoomUseCase(
          messageRepoLocal: mockMessageRepoLocal,
        );

        // Then
        expect(testUseCase.messageRepoLocal, equals(mockMessageRepoLocal));
      },
    );

    test(
      'Given repository method completes successfully, When use case is called, Then completes without returning a value',
      () async {
        // Given
        const roomId = 'test-room-id';
        when(() =>
                mockMessageRepoLocal.deleteAllMessageInRoom(roomId: any(named: 'roomId'), useTxn: any(named: 'useTxn')))
            .thenAnswer((_) async {});

        // When
        await useCase(roomId);

        // Then
        verify(() => mockMessageRepoLocal.deleteAllMessageInRoom(roomId: roomId, useTxn: true)).called(1);
      },
    );
  });
}
