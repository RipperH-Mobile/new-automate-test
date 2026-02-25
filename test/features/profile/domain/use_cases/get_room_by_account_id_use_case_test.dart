import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/use_cases/get_room_by_account_id_use_case.dart';

// Mock Definitions
class MockProfileLocalRepository extends Mock implements ProfileLocalRepository {}

class FakeRoomEntity extends Fake implements RoomEntity {}

void main() {
  late GetRoomByAccountIdUseCase useCase;
  late MockProfileLocalRepository mockProfileLocalRepository;
  late RoomEntity tRoomEntity;
  const tAccountId = 'account123';

  setUpAll(() {
    registerFallbackValue(FakeRoomEntity());
  });

  setUp(() {
    mockProfileLocalRepository = MockProfileLocalRepository();
    useCase = GetRoomByAccountIdUseCase(
      profileLocalRepository: mockProfileLocalRepository,
    );
    tRoomEntity = const RoomEntity(
      id: 'room123',
    );
    reset(mockProfileLocalRepository);
  });

  group('GetRoomByAccountIdUseCase', () {
    test('Given repository returns a RoomEntity, When useCase is called with account ID, Then returns the RoomEntity',
        () async {
      // Given
      when(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).thenAnswer((_) async => tRoomEntity);

      // When
      final result = await useCase(tAccountId);

      // Then
      expect(result, equals(tRoomEntity));
      verify(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).called(1);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });

    test('Given repository returns null, When useCase is called with account ID, Then returns null', () async {
      // Given
      when(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).thenAnswer((_) async => null);

      // When
      final result = await useCase(tAccountId);

      // Then
      expect(result, isNull);
      verify(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).called(1);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });

    test('Given repository throws an exception, When useCase is called with account ID, Then exception is propagated',
        () async {
      // Given
      final exception = Exception('Database error');
      when(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).thenThrow(exception);

      // When
      call() => useCase(tAccountId);

      // Then
      expect(call, throwsA(equals(exception)));
      verify(() => mockProfileLocalRepository.getRoomByAccountId(tAccountId)).called(1);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });
  });
}
