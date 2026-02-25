import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_subscription_use_case.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late GetRoomSubscriptionUseCase useCase;
  late MockChatRoomLocalRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRoomLocalRepository();
    useCase = GetRoomSubscriptionUseCase(
      chatRoomLocalRepository: mockRepository,
    );
  });

  group('GetRoomSubscriptionUseCase', () {
    const testRoomId = 'test_room_id';
    final testParams = ChatRoomParams(roomId: testRoomId);
    final testRoomSubscription = const RoomSubscriptionEntity(
      roomId: testRoomId,
      // Add other required properties based on your RoomSubscriptionEntity
    );

    test('should return RoomSubscriptionEntity when repository returns subscription', () async {
      // Arrange
      when(() => mockRepository.getRoomSubscription(testRoomId)).thenAnswer((_) async => testRoomSubscription);

      // Act
      final result = await useCase(testParams);

      // Assert
      expect(result, equals(testRoomSubscription));
      verify(() => mockRepository.getRoomSubscription(testRoomId)).called(1);
    });

    test('should return null when repository returns null', () async {
      // Arrange
      when(() => mockRepository.getRoomSubscription(testRoomId)).thenAnswer((_) async => null);

      // Act
      final result = await useCase(testParams);

      // Assert
      expect(result, isNull);
      verify(() => mockRepository.getRoomSubscription(testRoomId)).called(1);
    });

    test('should throw exception when repository throws exception', () async {
      // Arrange
      final exception = Exception('Database error');
      when(() => mockRepository.getRoomSubscription(testRoomId)).thenThrow(exception);

      // Act & Assert
      expect(() => useCase(testParams), throwsA(exception));
      verify(() => mockRepository.getRoomSubscription(testRoomId)).called(1);
    });

    test('should call repository with correct room ID from params', () async {
      // Arrange
      const differentRoomId = 'different_room_id';
      final differentParams = ChatRoomParams(roomId: differentRoomId);
      when(() => mockRepository.getRoomSubscription(differentRoomId)).thenAnswer((_) async => null);

      // Act
      await useCase(differentParams);

      // Assert
      verify(() => mockRepository.getRoomSubscription(differentRoomId)).called(1);
      verifyNever(() => mockRepository.getRoomSubscription(testRoomId));
    });
  });
}
