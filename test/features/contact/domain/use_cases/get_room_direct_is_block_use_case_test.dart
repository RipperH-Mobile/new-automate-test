import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_block_use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetRoomDirectIsBlockUseCase getRoomDirectIsBlockUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getRoomDirectIsBlockUseCase = GetRoomDirectIsBlockUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetRoomDirectIsBlockUseCase', () {
    test(
      'GetRoomDirectIsBlockUseCase case 1: room direct is blocked',
      () async {
        // Given
        when(() => mockContactLocalRepository.isDirectRoomBlocked('1')).thenAnswer((_) => true);

        // When
        final result = getRoomDirectIsBlockUseCase('1');

        // Then
        expect(result, true);
        verify(() => mockContactLocalRepository.isDirectRoomBlocked('1')).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'GetRoomDirectIsBlockUseCase case 1: room direct is not blocked',
      () async {
        // Given
        when(() => mockContactLocalRepository.isDirectRoomBlocked('2')).thenAnswer((_) => false);

        // When
        final result = getRoomDirectIsBlockUseCase('2');

        // Then
        expect(result, false);
        verify(() => mockContactLocalRepository.isDirectRoomBlocked('2')).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}
