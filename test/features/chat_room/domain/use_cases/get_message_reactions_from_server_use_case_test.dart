import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_local_message_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_reactions_from_server_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockMessageServerRepository extends Mock implements MessageServerRepository {}

class FakeUpdateLocalMessageReactionRequest extends Fake implements UpdateLocalMessageReactionRequest {}

void main() {
  late GetMessageReactionsFromServerUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;
  late MockMessageServerRepository mockMessageServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeUpdateLocalMessageReactionRequest());
  });

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    mockMessageServerRepository = MockMessageServerRepository();
    useCase = GetMessageReactionsFromServerUseCase(
      messageLocalRepository: mockMessageLocalRepository,
      messageServerRepository: mockMessageServerRepository,
    );
  });

  group('GetMessageReactionsFromServerUseCase', () {
    const testMsgId = 'test-msg-id';
    const testRoomId = 'test-room-id';
    const testPage = 1;
    const testPageSize = 10;

    final testRequest = GetMessageReactRequest(
      msgId: testMsgId,
      roomId: testRoomId,
      page: testPage,
      pageSize: testPageSize,
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

    final testResponse = PaginationPayload<MessageReactionEntity>(
      data: testReactions,
      page: testPage,
      pageSize: testPageSize,
      total: 2,
      totalPages: 1,
    );

    test('Given valid request, When call is executed, Then fetches reactions from server and updates local repository',
        () async {
      // Given
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenAnswer((_) async => testResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).thenAnswer((_) async => {});

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testResponse));
      expect(result.data, hasLength(2));
      expect(result.data!.first.emojiId, equals('emoji1'));
      expect(result.data!.last.emojiId, equals('emoji2'));
      expect(result.page, equals(testPage));
      expect(result.pageSize, equals(testPageSize));
      expect(result.total, equals(2));
      expect(result.totalPages, equals(1));

      verify(() => mockMessageServerRepository.getMessageReact(testRequest)).called(1);
      verify(() => mockMessageLocalRepository.updateLocalMessageReaction(
            any<UpdateLocalMessageReactionRequest>(),
          )).called(1);
    });

    test('Given server repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Server error';
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageServerRepository.getMessageReact(testRequest)).called(1);
      verifyNever(() => mockMessageLocalRepository.updateLocalMessageReaction(any()));
    });

    test(
        'Given successful server response, When call is executed, Then processes correctly regardless of local update success',
        () async {
      // Given
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenAnswer((_) async => testResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any()))
          .thenAnswer((_) async => {}); // Local update succeeds

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testResponse));
      verify(() => mockMessageServerRepository.getMessageReact(testRequest)).called(1);
      verify(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).called(1);
    });

    test('Given empty reactions response, When call is executed, Then updates local repository with empty reactions',
        () async {
      // Given
      final emptyResponse = PaginationPayload<MessageReactionEntity>(
        data: [],
        page: testPage,
        pageSize: testPageSize,
        total: 0,
        totalPages: 0,
      );
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenAnswer((_) async => emptyResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).thenAnswer((_) async => {});

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(emptyResponse));
      expect(result.data, isEmpty);
      expect(result.total, equals(0));

      verify(() => mockMessageServerRepository.getMessageReact(testRequest)).called(1);
      verify(() => mockMessageLocalRepository.updateLocalMessageReaction(
            any<UpdateLocalMessageReactionRequest>(),
          )).called(1);
    });

    test('Given different request parameters, When call is executed, Then calls repositories with correct parameters',
        () async {
      // Given
      const differentMsgId = 'different-msg-id';
      const differentRoomId = 'different-room-id';
      const differentPage = 2;
      const differentPageSize = 20;

      final differentRequest = GetMessageReactRequest(
        msgId: differentMsgId,
        roomId: differentRoomId,
        page: differentPage,
        pageSize: differentPageSize,
      );

      final differentResponse = PaginationPayload<MessageReactionEntity>(
        data: [],
        page: differentPage,
        pageSize: differentPageSize,
        total: 0,
        totalPages: 0,
      );

      when(() => mockMessageServerRepository.getMessageReact(differentRequest))
          .thenAnswer((_) async => differentResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).thenAnswer((_) async => {});

      // When
      final result = await useCase.call(differentRequest);

      // Then
      expect(result, equals(differentResponse));
      expect(result.page, equals(differentPage));
      expect(result.pageSize, equals(differentPageSize));

      verify(() => mockMessageServerRepository.getMessageReact(differentRequest)).called(1);
      verifyNever(() => mockMessageServerRepository.getMessageReact(testRequest));

      // Verify the local repository is called with correct UpdateLocalMessageReactionRequest
      final captured = verify(() => mockMessageLocalRepository.updateLocalMessageReaction(
            captureAny<UpdateLocalMessageReactionRequest>(),
          )).captured;

      final updateRequest = captured.first as UpdateLocalMessageReactionRequest;
      expect(updateRequest.msgId, equals(differentMsgId));
      expect(updateRequest.roomId, equals(differentRoomId));
      expect(updateRequest.reactions, equals([]));
    });

    test(
        'Given successful execution, When call is executed, Then verifies correct UpdateLocalMessageReactionRequest parameters',
        () async {
      // Given
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenAnswer((_) async => testResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).thenAnswer((_) async => {});

      // When
      await useCase.call(testRequest);

      // Then
      final captured = verify(() => mockMessageLocalRepository.updateLocalMessageReaction(
            captureAny<UpdateLocalMessageReactionRequest>(),
          )).captured;

      final updateRequest = captured.first as UpdateLocalMessageReactionRequest;
      expect(updateRequest.msgId, equals(testMsgId));
      expect(updateRequest.roomId, equals(testRoomId));
      expect(updateRequest.reactions, equals(testReactions));
      expect(updateRequest.reactions, hasLength(2));
    });

    test('Given server response with null data, When call is executed, Then throws Exception', () async {
      // Given
      final responseWithNullData = PaginationPayload<MessageReactionEntity>(
        data: null,
        page: testPage,
        pageSize: testPageSize,
        total: 0,
        totalPages: 0,
      );
      when(() => mockMessageServerRepository.getMessageReact(testRequest))
          .thenAnswer((_) async => responseWithNullData);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('No data received from server'),
        )),
      );
      verify(() => mockMessageServerRepository.getMessageReact(testRequest)).called(1);
      verifyNever(() => mockMessageLocalRepository.updateLocalMessageReaction(any()));
    });

    test('Given local repository update fails, When call is executed, Then throws local repository exception',
        () async {
      // Given
      when(() => mockMessageServerRepository.getMessageReact(testRequest)).thenAnswer((_) async => testResponse);
      when(() => mockMessageLocalRepository.updateLocalMessageReaction(any())).thenThrow(Exception('Local error'));

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Local error'),
        )),
      );
    });
  });
}
