import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reaction_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

void main() {
  late RemoveReactionUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    useCase = RemoveReactionUseCase(
      messageLocalRepository: mockMessageLocalRepository,
    );
  });

  group('RemoveReactionUseCase', () {
    const testRoomId = 'test-room-id';
    const testMsgId = 'test-msg-id';
    const testRequest = RemoveReactionRequest(
      roomId: testRoomId,
      msgId: testMsgId,
    );

    test('Given valid request, When call is executed, Then calls repository removeReaction method', () async {
      // Given
      when(() => mockMessageLocalRepository.removeReaction(testRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(testRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReaction(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Database error';
      when(() => mockMessageLocalRepository.removeReaction(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageLocalRepository.removeReaction(testRequest)).called(1);
    });

    test('Given different room and message IDs, When call is executed, Then calls repository with correct request',
        () async {
      // Given
      const differentRoomId = 'different-room-id';
      const differentMsgId = 'different-msg-id';
      const differentRequest = RemoveReactionRequest(
        roomId: differentRoomId,
        msgId: differentMsgId,
      );
      when(() => mockMessageLocalRepository.removeReaction(differentRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(differentRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReaction(differentRequest)).called(1);
      verifyNever(() => mockMessageLocalRepository.removeReaction(testRequest));
    });

    test(
        'Given multiple calls with same request, When call is executed multiple times, Then each call invokes repository',
        () async {
      // Given
      when(() => mockMessageLocalRepository.removeReaction(testRequest)).thenAnswer((_) async => {});

      // When
      await useCase.call(testRequest);
      await useCase.call(testRequest);
      await useCase.call(testRequest);

      // Then
      verify(() => mockMessageLocalRepository.removeReaction(testRequest)).called(3);
    });

    test('Given repository completes successfully, When call is executed, Then use case completes without error',
        () async {
      // Given
      when(() => mockMessageLocalRepository.removeReaction(testRequest)).thenAnswer((_) async => {});

      // When & Then
      expect(() async => await useCase.call(testRequest), returnsNormally);
      verify(() => mockMessageLocalRepository.removeReaction(testRequest)).called(1);
    });
  });
}
