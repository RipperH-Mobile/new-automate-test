import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_sent_message_media_files_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

void main() {
  late GetAllSentMessageMediaFilesUseCase useCase;
  late MockMessageLocalRepository mockRepository;

  setUp(() {
    mockRepository = MockMessageLocalRepository();
    useCase = GetAllSentMessageMediaFilesUseCase(messageLocalRepository: mockRepository);
  });

  group('GetAllSentMessageMediaFilesUseCase', () {
    const roomId = 'test-room-id';
    final params = GetAllSentMessageMediaFilesParams(roomId: roomId);
    final mockMessages = <MessageEntity>[
      const MessageEntity(
        id: 'message-id-101',
        ref: 'message-ref-101',
        files: [],
      ),
      const MessageEntity(
        id: 'message-id-102',
        ref: 'message-ref-102',
        files: [],
      ),
    ];

    test('should return a list of MessageEntity when repository call is successfully', () async {
      // Arrange
      when(() => mockRepository.getAllSentMessageMediaFiles(roomId)).thenAnswer((_) async => mockMessages);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(mockMessages));
      verify(() => mockRepository.getAllSentMessageMediaFiles(roomId)).called(1);
    });

    test('Given valid params, When repository throws exception, Then use case throws exception', () async {
      final exceptionResult = Exception('exception');

      // Arrange
      when(() => mockRepository.getAllSentMessageMediaFiles(roomId)).thenThrow(exceptionResult);

      // Act & Assert
      expect(() => useCase(params), throwsA(exceptionResult));
      verify(() => mockRepository.getAllSentMessageMediaFiles(roomId)).called(1);
    });
  });
}
