import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/params/find_search_message_param.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/find_search_message_use_case.dart';

// Mock classes
class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class FakeFindSearchMessageParam extends Fake implements FindSearchMessageParam {}

void main() {
  late FindSearchMessageUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeFindSearchMessageParam());
  });

  setUp(() {
    mockMessageLocalRepository = MockMessageLocalRepository();
    useCase = FindSearchMessageUseCase(
      messageLocalRepository: mockMessageLocalRepository,
    );
  });

  group('FindSearchMessageUseCase', () {
    final roomId = 'test-room-id';
    final msgId = 'test-msg-id';
    final msgRef = 'test-msg-ref';
    final mockMsg = MessageEntity(id: msgId, ref: msgRef);

    test('Given params with message id is null, then return (false, same message)', () async {
      final mockMsg = MessageEntity(ref: msgRef);
      final params = FindSearchMessageParam(message: mockMsg, roomId: roomId);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result.$1, equals(false));
      expect(result.$2, equals(mockMsg));
      verifyNever(() => mockMessageLocalRepository.getMessageById(id: msgId));
    });

    test(
        'Given params with message id is not null, and got null when called getMessageById from MessageLocalRepository, then return (false, same message)',
        () async {
      final params = FindSearchMessageParam(message: mockMsg, roomId: roomId);

      // Given
      when(() => mockMessageLocalRepository.getMessageById(id: msgId)).thenAnswer((_) async => null);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result.$1, equals(false));
      expect(result.$2, equals(mockMsg));
      verify(() => mockMessageLocalRepository.getMessageById(id: msgId)).called(1);
    });

    test(
        'Given params with message id is not null, and got local message when called getMessageById from MessageLocalRepository, then return (true, local message)',
        () async {
      final mockLocalMsg = MessageEntity(id: msgId, ref: msgRef, files: []);
      final params = FindSearchMessageParam(message: mockMsg, roomId: roomId);

      // Given
      when(() => mockMessageLocalRepository.getMessageById(id: msgId)).thenAnswer((_) async => mockLocalMsg);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result.$1, equals(true));
      expect(result.$2, equals(mockLocalMsg));
      verify(() => mockMessageLocalRepository.getMessageById(id: msgId)).called(1);
    });

    test('should throw exception when repository throws exception', () async {
      final exception = Exception('exception');
      final params = FindSearchMessageParam(message: mockMsg, roomId: roomId);

      // Given
      when(() => mockMessageLocalRepository.getMessageById(id: msgId)).thenThrow(exception);

      // Act & Assert
      expect(() => useCase(params), throwsA(exception));
      verify(() => mockMessageLocalRepository.getMessageById(id: msgId)).called(1);
    });
  });
}
