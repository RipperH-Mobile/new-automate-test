import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_sending_message_use_case.dart';

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockMessageEntity extends Mock implements MessageEntity {
  @override
  final bool isSendFailed;

  MockMessageEntity({this.isSendFailed = false});

  MessageCollection toCollection() {
    final collection = MessageCollection();
    collection.isSendFailed = isSendFailed;
    return collection;
  }
}

void main() {
  late GetSendingMessageUseCase useCase;
  late MockMessageLocalRepository mockRepository;

  setUp(() {
    mockRepository = MockMessageLocalRepository();

    // Register the mock repository with GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<MessageLocalRepository>()) {
      getIt.unregister<MessageLocalRepository>();
    }
    getIt.registerFactory<MessageLocalRepository>(() => mockRepository);

    useCase = GetSendingMessageUseCase();
  });

  tearDown(() {
    final getIt = GetIt.instance;
    if (getIt.isRegistered<MessageLocalRepository>()) {
      getIt.unregister<MessageLocalRepository>();
    }
  });

  group('call', () {
    final roomId = 'test-room-id';
    final params = ChatRoomParams(roomId: roomId);

    test('Given repository returns empty list, When useCase is called, Then returns empty tuple', () async {
      // Given
      when(() => mockRepository.getAllSendingMessage(roomId)).thenAnswer((_) async => []);

      // When
      final result = await useCase(params);

      // Then
      expect(result.$1, isEmpty);
      expect(result.$2, isEmpty);
      verify(() => mockRepository.getAllSendingMessage(roomId)).called(1);
    });

    test(
        'Given repository returns sending messages, When useCase is called, Then separates sending and failed messages',
        () async {
      // Given
      final sendingEntity1 = MockMessageEntity(isSendFailed: false);
      final sendingEntity2 = MockMessageEntity(isSendFailed: false);
      final failedEntity1 = MockMessageEntity(isSendFailed: true);
      final failedEntity2 = MockMessageEntity(isSendFailed: true);

      when(() => mockRepository.getAllSendingMessage(roomId))
          .thenAnswer((_) async => [sendingEntity1, failedEntity1, sendingEntity2, failedEntity2]);

      // When
      final result = await useCase(params);

      // Then
      expect(result.$1.length, equals(2)); // Sending messages
      expect(result.$2.length, equals(2)); // Failed messages
      for (final message in result.$1) {
        expect(message.isSendFailed, isFalse);
      }
      for (final message in result.$2) {
        expect(message.isSendFailed, isTrue);
      }
      verify(() => mockRepository.getAllSendingMessage(roomId)).called(1);
    });

    test('Given repository throws exception, When useCase is called, Then returns empty tuple', () async {
      // Given
      when(() => mockRepository.getAllSendingMessage(roomId)).thenThrow(Exception('Test error'));

      // When
      final result = await useCase(params);

      // Then
      expect(result.$1, isEmpty);
      expect(result.$2, isEmpty);
      verify(() => mockRepository.getAllSendingMessage(roomId)).called(1);
    });
  });
}
