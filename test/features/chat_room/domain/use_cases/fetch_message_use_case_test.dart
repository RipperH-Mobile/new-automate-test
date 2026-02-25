import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_from_server_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_message_use_case.dart';

class MockMessageServerRepository extends Mock implements MessageServerRepository {}

void main() {
  late FetchMessageUseCase useCase;
  late MockMessageServerRepository mockMessageServerRepository;
  late ChatMessagesRequest testRequest;
  late GetMessageFromServerEntity testEntity;

  setUpAll(() {
    registerFallbackValue(GetMessageFromServerParams(
      roomId: 'room123',
      pageSize: 20,
      isMyNote: false,
    ));
  });

  setUp(() {
    mockMessageServerRepository = MockMessageServerRepository();
    useCase = FetchMessageUseCase(messageRepository: mockMessageServerRepository);
    testRequest = ChatMessagesRequest(
      roomId: 'room123',
      pageSize: 20,
    );
    testEntity = GetMessageFromServerEntity(
      messages: [],
      hasMore: false,
    );

    // Reset mocks before each test
    reset(mockMessageServerRepository);
  });

  group('FetchMessageUseCase', () {
    test('Given valid chat messages request, When call is executed, Then returns GetMessageFromServerEntity', () async {
      // Given
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => testEntity);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testEntity));
      verify(() => mockMessageServerRepository.getMessageInRoom(any(
            that: predicate<GetMessageFromServerParams>(
              (params) => params.roomId == 'room123' && params.pageSize == 20 && params.isMyNote == false,
            ),
          ))).called(1);
    });

    test(
        'Given request with empty roomId, When call is executed, Then uses empty roomId parameter in GetMessageFromServerParams',
        () async {
      // Given
      final requestWithEmptyRoomId = ChatMessagesRequest(
        roomId: '',
        pageSize: 15,
      );
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => testEntity);

      // When
      await useCase.call(requestWithEmptyRoomId);

      // Then
      verify(() => mockMessageServerRepository.getMessageInRoom(any(
            that: predicate<GetMessageFromServerParams>(
              (params) => params.roomId == '' && params.pageSize == 15 && params.isMyNote == false,
            ),
          ))).called(1);
    });

    test('Given repository returns null, When call is executed, Then returns null', () async {
      // Given
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, isNull);
      verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      final exception = Exception('Fetch message failed');
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenThrow(exception);

      // When & Then
      expect(
        () => useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
    });

    test(
        'Given different request parameters, When call is executed, Then repository is called with correct converted params',
        () async {
      // Given
      final differentRequest = ChatMessagesRequest(
        roomId: 'room789',
        pageSize: 50,
      );
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => testEntity);

      // When
      await useCase.call(differentRequest);

      // Then
      verify(() => mockMessageServerRepository.getMessageInRoom(any(
            that: predicate<GetMessageFromServerParams>(
              (params) => params.roomId == 'room789' && params.pageSize == 50 && params.isMyNote == false,
            ),
          ))).called(1);
    });

    test('Given repository call succeeds, When call is executed, Then completes without error', () async {
      // Given
      when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => testEntity);

      // When & Then
      expect(() => useCase.call(testRequest), returnsNormally);
      verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
    });
  });
}
