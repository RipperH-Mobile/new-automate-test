import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/domain/params/check_new_phone_number_params.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/features/setting/domain/use_cases/check_new_phone_number_use_case.dart';

// Mock definitions
class MockSettingServerRepository extends Mock implements SettingServerRepository {}

class FakeCheckNewPhoneNumberRequest extends Fake implements CheckNewPhoneNumberRequest {}

void main() {
  late CheckNewPhoneNumberUseCase useCase;
  late MockSettingServerRepository mockSettingServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeCheckNewPhoneNumberRequest());
  });

  setUp(() {
    mockSettingServerRepository = MockSettingServerRepository();
    useCase = CheckNewPhoneNumberUseCase(
      settingServerRepository: mockSettingServerRepository,
    );

    // Reset mocks before each test
    reset(mockSettingServerRepository);
  });

  group('CheckNewPhoneNumberUseCase', () {
    test('Given valid parameters, When usecase is called, Then creates correct request and calls repository', () async {
      // Given
      const testPhoneNumber = '+1234567890';
      final params = CheckNewPhoneNumberParams(newPhoneNumber: testPhoneNumber);
      when(() => mockSettingServerRepository.checkNewPhoneNumber(any())).thenAnswer((_) async {});

      // When
      await useCase(params);

      // Then
      final captured = verify(() => mockSettingServerRepository.checkNewPhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as CheckNewPhoneNumberRequest;
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given repository throws exception, When usecase is called, Then rethrows the exception', () async {
      // Given
      const testPhoneNumber = '+1234567890';
      final params = CheckNewPhoneNumberParams(newPhoneNumber: testPhoneNumber);
      final testException = Exception('Test error');
      when(() => mockSettingServerRepository.checkNewPhoneNumber(any())).thenThrow(testException);

      // When
      final call = useCase(params);

      // Then
      await expectLater(call, throwsA(equals(testException)));
      verify(() => mockSettingServerRepository.checkNewPhoneNumber(any())).called(1);
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given different phone number format, When usecase is called, Then passes correct phone number to repository',
        () async {
      // Given
      const testPhoneNumber = '+44 20 7946 0958';
      final params = CheckNewPhoneNumberParams(newPhoneNumber: testPhoneNumber);
      when(() => mockSettingServerRepository.checkNewPhoneNumber(any())).thenAnswer((_) async {});

      // When
      await useCase(params);

      // Then
      final captured = verify(() => mockSettingServerRepository.checkNewPhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as CheckNewPhoneNumberRequest;
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given empty phone number, When usecase is called, Then passes empty string to repository', () async {
      // Given
      const testPhoneNumber = '';
      final params = CheckNewPhoneNumberParams(newPhoneNumber: testPhoneNumber);
      when(() => mockSettingServerRepository.checkNewPhoneNumber(any())).thenAnswer((_) async {});

      // When
      await useCase(params);

      // Then
      final captured = verify(() => mockSettingServerRepository.checkNewPhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as CheckNewPhoneNumberRequest;
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });
  });
}
