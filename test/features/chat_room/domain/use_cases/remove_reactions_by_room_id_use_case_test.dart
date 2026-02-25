import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

void main() {
  late RemoveReactionsByRoomIdUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    useCase = RemoveReactionsByRoomIdUseCase(
      messageLocalRepository: mockMessageLocalRepository,
    );
  });

  group('RemoveReactionsByRoomIdUseCase', () {
    const testRoomId = 'test-room-id';
    const testRequest = RemoveReactionsByRoomIdRequest(
      roomId: testRoomId,
    );

    test('Given valid request, When call is executed, Then calls repository removeReactionsByRoomId method', () async {
      // Given
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(testRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Database error';
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).called(1);
    });

    test('Given different room ID, When call is executed, Then calls repository with correct request', () async {
      // Given
      const differentRoomId = 'different-room-id';
      const differentRequest = RemoveReactionsByRoomIdRequest(
        roomId: differentRoomId,
      );
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(differentRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(differentRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(differentRequest)).called(1);
      verifyNever(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest));
    });

    test(
        'Given multiple calls with same request, When call is executed multiple times, Then each call invokes repository',
        () async {
      // Given
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(testRequest);
      await useCase.call(testRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).called(2);
    });

    test('Given repository completes successfully, When call is executed, Then use case completes without error',
        () async {
      // Given
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).thenAnswer((_) async => {});

      // When & Then
      expect(() async => await useCase.call(testRequest), returnsNormally);
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(testRequest)).called(1);
    });

    test('Given empty room ID, When call is executed, Then calls repository with empty room ID request', () async {
      // Given
      const emptyRoomRequest = RemoveReactionsByRoomIdRequest(
        roomId: '',
      );
      when(() => mockMessageLocalRepository.removeReactionsByRoomId(emptyRoomRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(emptyRoomRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReactionsByRoomId(emptyRoomRequest)).called(1);
    });
  });
}
