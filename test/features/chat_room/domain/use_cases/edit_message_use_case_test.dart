import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/params/edit_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/edit_message_use_case.dart';

class MockMessageServerRepository extends Mock implements MessageServerRepository {}

void main() {
  late EditMessageUseCase useCase;
  late MockMessageServerRepository mockMessageServerRepository;
  late EditMessageParams testParams;

  setUpAll(() {
    registerFallbackValue(EditMessageParams(
      roomId: 'room123',
      messageId: 'message123',
      newContent: 'New content',
    ));
  });

  setUp(() {
    mockMessageServerRepository = MockMessageServerRepository();
    useCase = EditMessageUseCase(messageServerRepository: mockMessageServerRepository);
    testParams = EditMessageParams(
      roomId: 'room123',
      messageId: 'message123',
      newContent: 'Updated message content',
    );

    // Reset mocks before each test
    reset(mockMessageServerRepository);
  });

  group('EditMessageUseCase', () {
    test('Given valid edit message params, When call is executed, Then editMessage is called on repository', () async {
      // Given
      when(() => mockMessageServerRepository.editMessage(any())).thenAnswer((_) async {});

      // When
      await useCase.call(testParams);

      // Then
      verify(() => mockMessageServerRepository.editMessage(testParams)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      final exception = Exception('Edit message failed');
      when(() => mockMessageServerRepository.editMessage(any())).thenThrow(exception);

      // When & Then
      expect(
        () => useCase.call(testParams),
        throwsA(equals(exception)),
      );
      verify(() => mockMessageServerRepository.editMessage(testParams)).called(1);
    });

    test('Given different message params, When call is executed, Then repository is called with correct params',
        () async {
      // Given
      final differentParams = EditMessageParams(
        roomId: 'room456',
        messageId: 'message456',
        newContent: 'Different content',
      );
      when(() => mockMessageServerRepository.editMessage(any())).thenAnswer((_) async {});

      // When
      await useCase.call(differentParams);

      // Then
      verify(() => mockMessageServerRepository.editMessage(differentParams)).called(1);
      verifyNever(() => mockMessageServerRepository.editMessage(testParams));
    });

    test('Given repository call succeeds, When call is executed, Then completes without error', () async {
      // Given
      when(() => mockMessageServerRepository.editMessage(any())).thenAnswer((_) async {});

      // When & Then
      expect(() => useCase.call(testParams), returnsNormally);
      verify(() => mockMessageServerRepository.editMessage(testParams)).called(1);
    });
  });
}
