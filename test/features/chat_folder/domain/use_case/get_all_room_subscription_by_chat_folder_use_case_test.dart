import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_folder/domain/use_cases/get_all_room_subscription_by_chat_folder_use_case.dart';
import 'package:uchat/features/chat_room/data/models/models/chat_folder_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late GetAllRoomSubscriptionByChatFolderUseCase useCase;
  late MockChatRoomLocalRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRoomLocalRepository();
    useCase = GetAllRoomSubscriptionByChatFolderUseCase(
      chatRoomLocalRepository: mockRepository,
    );
  });

  group('GetAllRoomSubscriptionByChatFolderUseCase', () {
    const chatFolderId = 'test-folder-id';
    final params = GetAllRoomSubscriptionByChatFolderParams(
      chatFolderId: chatFolderId,
    );

    test('should return list of ChatFolderMetaWithRoomSubscriptionEntity when repository call is successful', () async {
      // Arrange
      final mockChatFolder = ChatFolderModel(
        folderId: chatFolderId,
        isPinned: true,
      );

      final mockRoomSubscriptions = [
        RoomSubscriptionEntity(
          id: 'room-1',
          chatFolders: [mockChatFolder],
        ),
        RoomSubscriptionEntity(
          id: 'room-2',
          chatFolders: [mockChatFolder],
        ),
      ];

      when(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).thenAnswer((_) async => mockRoomSubscriptions);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, hasLength(2));
      expect(result[0].chatFolderId, equals(chatFolderId));
      expect(result[0].roomSubscription?.id, equals('room-1'));
      expect(result[0].isPinned, isTrue);
      expect(result[1].chatFolderId, equals(chatFolderId));
      expect(result[1].roomSubscription?.id, equals('room-2'));
      expect(result[1].isPinned, isTrue);

      verify(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).called(1);
    });

    test('should return list with isPinned false when chatFolder is not found', () async {
      // Arrange
      final mockRoomSubscriptions = [
        const RoomSubscriptionEntity(
          id: 'room-1',
          chatFolders: [], // Empty chatFolders
        ),
        const RoomSubscriptionEntity(
          id: 'room-2',
          chatFolders: null, // Null chatFolders
        ),
      ];

      when(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).thenAnswer((_) async => mockRoomSubscriptions);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, hasLength(2));
      expect(result[0].isPinned, isFalse);
      expect(result[1].isPinned, isFalse);

      verify(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).called(1);
    });

    test('should pass isPinned parameter to repository when provided', () async {
      // Arrange
      final paramsWithPinned = GetAllRoomSubscriptionByChatFolderParams(
        chatFolderId: chatFolderId,
        isPinned: true,
      );

      when(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: true,
          )).thenAnswer((_) async => []);

      // Act
      await useCase(paramsWithPinned);

      // Assert
      verify(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: true,
          )).called(1);
    });

    test('should return empty list when repository returns empty list', () async {
      // Arrange
      when(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).thenAnswer((_) async => []);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isEmpty);

      verify(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).called(1);
    });

    test('should handle mixed scenario with found and not found chatFolders', () async {
      // Arrange
      final foundChatFolder = ChatFolderModel(
        folderId: chatFolderId,
        isPinned: true,
      );

      final differentChatFolder = ChatFolderModel(
        folderId: 'different-folder-id',
        isPinned: false,
      );

      final mockRoomSubscriptions = [
        RoomSubscriptionEntity(
          id: 'room-1',
          chatFolders: [foundChatFolder], // Has matching folder
        ),
        RoomSubscriptionEntity(
          id: 'room-2',
          chatFolders: [differentChatFolder], // Has different folder
        ),
      ];

      when(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).thenAnswer((_) async => mockRoomSubscriptions);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, hasLength(2));
      expect(result[0].isPinned, isTrue); // Found matching folder
      expect(result[1].isPinned, isFalse); // Didn't find matching folder

      verify(() => mockRepository.getRoomSubscriptionByChatFolder(
            chatFolderId: chatFolderId,
            isPinned: null,
          )).called(1);
    });
  });
}
