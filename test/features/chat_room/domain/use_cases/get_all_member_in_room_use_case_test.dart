import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_member_in_room_use_case.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late GetAllMemberInRoomUseCase useCase;
  late MockChatRoomLocalRepository mockRepository;

  setUpAll(() {
    // Register mock logger before any tests run
    GetIt.I.registerSingleton<LoggerService>(MockLoggerService());
  });

  setUp(() {
    mockRepository = MockChatRoomLocalRepository();
    useCase = GetAllMemberInRoomUseCase(chatRoomLocalRepository: mockRepository);
  });

  group('GetAllMemberInRoomUseCase', () {
    const roomId = 'test-room-id';
    final params = ChatRoomParams(roomId: roomId);
    final mockMembers = [
      RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.group,
        account: ContactModel(
          id: 'account-1',
          displayName: 'User One',
        ),
      ),
      RoomMemberEntity(
        roomId: roomId,
        roomType: RoomType.group,
        account: ContactModel(
          id: 'account-2',
          displayName: 'User Two',
        ),
      ),
    ];

    test('should return a list of RoomMemberEntity when repository call is successful', () async {
      // Arrange
      when(() => mockRepository.getAllMemberInRoom(roomId)).thenAnswer((_) async => mockMembers);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(mockMembers));
      verify(() => mockRepository.getAllMemberInRoom(roomId)).called(1);
    });

    test('should return an empty list when repository returns null', () async {
      // Arrange
      when(() => mockRepository.getAllMemberInRoom(roomId)).thenAnswer((_) async => null);

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isEmpty);
      verify(() => mockRepository.getAllMemberInRoom(roomId)).called(1);
    });

    test('should return an empty list and log error when an exception is thrown', () async {
      // Arrange
      when(() => mockRepository.getAllMemberInRoom(roomId)).thenThrow(Exception('Test exception'));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isEmpty);
      verify(() => mockRepository.getAllMemberInRoom(roomId)).called(1);
    });
  });
}
