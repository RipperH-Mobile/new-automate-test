import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_local_message_reactions_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_local_message_reactions_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

void main() {
  late GetLocalMessageReactionsUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    useCase = GetLocalMessageReactionsUseCase(
      messageLocalRepository: mockMessageLocalRepository,
    );
  });

  group('GetLocalMessageReactionsUseCase', () {
    const testRoomId = 'test-room-id';
    const testMsgId = 'test-msg-id';
    const testRequest = GetLocalMessageReactionsRequest(
      roomId: testRoomId,
      msgId: testMsgId,
    );

    final testReaction1 = MessageReactionEntity(
      emojiId: 'emoji1',
      fileId: 'file1',
      accountId: 'account1',
      displayName: 'User 1',
      avatarPath: 'avatar1.jpg',
      createdAt: DateTime(2023, 1, 1),
    );

    final testReaction2 = MessageReactionEntity(
      emojiId: 'emoji2',
      fileId: 'file2',
      accountId: 'account2',
      displayName: 'User 2',
      avatarPath: 'avatar2.jpg',
      createdAt: DateTime(2023, 1, 2),
    );

    final testReactions = [testReaction1, testReaction2];

    test('Given valid request with existing reactions, When call is executed, Then returns list of reactions',
        () async {
      // Given
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest))
          .thenAnswer((_) async => testReactions);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testReactions));
      expect(result, hasLength(2));
      expect(result.first.emojiId, equals('emoji1'));
      expect(result.first.accountId, equals('account1'));
      expect(result.first.displayName, equals('User 1'));
      expect(result.last.emojiId, equals('emoji2'));
      expect(result.last.accountId, equals('account2'));
      expect(result.last.displayName, equals('User 2'));
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).called(1);
    });

    test('Given repository returns null, When call is executed, Then returns empty list', () async {
      // Given
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest))
          .thenAnswer((_) async => null);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals([]));
      expect(result, isEmpty);
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).called(1);
    });

    test('Given repository returns empty list, When call is executed, Then returns empty list', () async {
      // Given
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest))
          .thenAnswer((_) async => []);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals([]));
      expect(result, isEmpty);
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Database error';
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).called(1);
    });

    test('Given different room and message IDs, When call is executed, Then calls repository with correct request',
        () async {
      // Given
      const differentRoomId = 'different-room-id';
      const differentMsgId = 'different-msg-id';
      const differentRequest = GetLocalMessageReactionsRequest(
        roomId: differentRoomId,
        msgId: differentMsgId,
      );
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(differentRequest))
          .thenAnswer((_) async => []);

      // When
      final result = await useCase.call(differentRequest);

      // Then
      expect(result, equals([]));
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(differentRequest)).called(1);
      verifyNever(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest));
    });

    test('Given single reaction, When call is executed, Then returns list with single reaction', () async {
      // Given
      final singleReaction = [testReaction1];
      when(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest))
          .thenAnswer((_) async => singleReaction);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(singleReaction));
      expect(result, hasLength(1));
      expect(result.first.emojiId, equals('emoji1'));
      verify(() => mockMessageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(testRequest)).called(1);
    });
  });
}
