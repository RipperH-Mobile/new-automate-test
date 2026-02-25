import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_vibranium_shield_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetRoomDirectIsVibraniumShieldUseCase getRoomDirectIsVibraniumShieldUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getRoomDirectIsVibraniumShieldUseCase = GetRoomDirectIsVibraniumShieldUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetRoomDirectIsVibraniumShieldUseCase', () {
    test(
      'GetRoomDirectIsVibraniumShieldUseCase case 1: room direct is isDirectRoomVibraniumShield == true',
      () async {
        // Given
        when(() => mockContactLocalRepository.isDirectRoomVibraniumShield('1')).thenAnswer((_) => true);

        // When
        final result = getRoomDirectIsVibraniumShieldUseCase('1');

        // Then
        expect(result, true);
        verify(() => mockContactLocalRepository.isDirectRoomVibraniumShield('1')).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'GetRoomDirectIsVibraniumShieldUseCase case 2: room direct is isDirectRoomVibraniumShield == false',
      () async {
        // Given
        when(() => mockContactLocalRepository.isDirectRoomVibraniumShield('2')).thenAnswer((_) => false);

        // When
        final result = getRoomDirectIsVibraniumShieldUseCase('2');

        // Then
        expect(result, false);
        verify(() => mockContactLocalRepository.isDirectRoomVibraniumShield('2')).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}
