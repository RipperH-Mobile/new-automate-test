import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/features/setting/domain/use_cases/check_can_change_phone_number_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock definitions
class MockSettingServerRepository extends Mock implements SettingServerRepository {}

void main() {
  late CheckCanChangePhoneNumberUseCase useCase;
  late MockSettingServerRepository mockSettingServerRepository;

  setUp(() {
    mockSettingServerRepository = MockSettingServerRepository();
    useCase = CheckCanChangePhoneNumberUseCase(
      settingServerRepository: mockSettingServerRepository,
    );

    // Reset mocks before each test
    reset(mockSettingServerRepository);
  });

  group('CheckCanChangePhoneNumberUseCase', () {
    test(
        'Given repository succeeds, When usecase is called with NoParams, Then calls repository and completes successfully',
        () async {
      // Given
      when(() => mockSettingServerRepository.checkCanChangePhoneNumber()).thenAnswer((_) async {});

      // When
      await useCase(NoParams());

      // Then
      verify(() => mockSettingServerRepository.checkCanChangePhoneNumber()).called(1);
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given repository throws exception, When usecase is called with NoParams, Then rethrows the exception',
        () async {
      // Given
      final testException = Exception('Test error');
      when(() => mockSettingServerRepository.checkCanChangePhoneNumber()).thenThrow(testException);

      // When
      final call = useCase(NoParams());
      await expectLater(call, throwsA(equals(testException)));
      // Then
      verify(() => mockSettingServerRepository.checkCanChangePhoneNumber()).called(1);
      verifyNoMoreInteractions(mockSettingServerRepository);
    });
  });
}
