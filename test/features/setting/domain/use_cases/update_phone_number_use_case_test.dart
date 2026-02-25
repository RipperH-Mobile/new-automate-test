import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';
import 'package:uchat/features/setting/domain/params/update_phone_number_params.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/features/setting/domain/use_cases/update_phone_number_use_case.dart';

// Mock definitions
class MockSettingServerRepository extends Mock implements SettingServerRepository {}

class FakeUpdatePhoneNumberRequest extends Fake implements UpdatePhoneNumberRequest {}

void main() {
  late UpdatePhoneNumberUseCase useCase;
  late MockSettingServerRepository mockSettingServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeUpdatePhoneNumberRequest());
  });

  setUp(() {
    mockSettingServerRepository = MockSettingServerRepository();
    useCase = UpdatePhoneNumberUseCase(
      settingServerRepository: mockSettingServerRepository,
    );

    // Reset mocks before each test
    reset(mockSettingServerRepository);
  });

  group('UpdatePhoneNumberUseCase', () {
    test(
        'Given valid parameters, When usecase is called, Then creates correct request, calls repository and returns response',
        () async {
      // Given
      const testActionToken = 'test_action_token';
      const testPhoneNumber = '+1234567890';
      final params = UpdatePhoneNumberParams(
        actionToken: testActionToken,
        newPhoneNumber: testPhoneNumber,
      );
      final expectedResponse = UpdatePhoneNumberResponse(
        id: 'test_id',
        phoneNumber: testPhoneNumber,
      );
      when(() => mockSettingServerRepository.updatePhoneNumber(any())).thenAnswer((_) async => expectedResponse);

      // When
      final result = await useCase(params);

      // Then
      expect(result, equals(expectedResponse));
      final captured = verify(() => mockSettingServerRepository.updatePhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as UpdatePhoneNumberRequest;
      expect(capturedRequest.actionToken, equals(testActionToken));
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given repository throws exception, When usecase is called, Then rethrows the exception', () async {
      // Given
      const testActionToken = 'test_action_token';
      const testPhoneNumber = '+1234567890';
      final params = UpdatePhoneNumberParams(
        actionToken: testActionToken,
        newPhoneNumber: testPhoneNumber,
      );
      final testException = Exception('Test error');
      when(() => mockSettingServerRepository.updatePhoneNumber(any())).thenThrow(testException);

      // When
      final call = useCase(params);

      // Then
      await expectLater(call, throwsA(equals(testException)));
      verify(() => mockSettingServerRepository.updatePhoneNumber(any())).called(1);
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given different parameter values, When usecase is called, Then passes correct values to repository',
        () async {
      // Given
      const testActionToken = 'different_token_123';
      const testPhoneNumber = '+44 20 7946 0958';
      final params = UpdatePhoneNumberParams(
        actionToken: testActionToken,
        newPhoneNumber: testPhoneNumber,
      );
      final expectedResponse = UpdatePhoneNumberResponse(
        id: 'test_id_2',
        phoneNumber: testPhoneNumber,
      );
      when(() => mockSettingServerRepository.updatePhoneNumber(any())).thenAnswer((_) async => expectedResponse);

      // When
      final result = await useCase(params);

      // Then
      expect(result, equals(expectedResponse));
      final captured = verify(() => mockSettingServerRepository.updatePhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as UpdatePhoneNumberRequest;
      expect(capturedRequest.actionToken, equals(testActionToken));
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given empty string parameters, When usecase is called, Then passes empty strings to repository', () async {
      // Given
      const testActionToken = '';
      const testPhoneNumber = '';
      final params = UpdatePhoneNumberParams(
        actionToken: testActionToken,
        newPhoneNumber: testPhoneNumber,
      );
      final expectedResponse = UpdatePhoneNumberResponse(
        id: null,
        phoneNumber: null,
      );
      when(() => mockSettingServerRepository.updatePhoneNumber(any())).thenAnswer((_) async => expectedResponse);

      // When
      final result = await useCase(params);

      // Then
      expect(result, equals(expectedResponse));
      final captured = verify(() => mockSettingServerRepository.updatePhoneNumber(captureAny())).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as UpdatePhoneNumberRequest;
      expect(capturedRequest.actionToken, equals(testActionToken));
      expect(capturedRequest.newPhoneNumber, equals(testPhoneNumber));
      verifyNoMoreInteractions(mockSettingServerRepository);
    });

    test('Given repository returns null response, When usecase is called, Then returns the null response', () async {
      // Given
      const testActionToken = 'test_token';
      const testPhoneNumber = '+1234567890';
      final params = UpdatePhoneNumberParams(
        actionToken: testActionToken,
        newPhoneNumber: testPhoneNumber,
      );
      final expectedResponse = UpdatePhoneNumberResponse(id: null, phoneNumber: null);
      when(() => mockSettingServerRepository.updatePhoneNumber(any())).thenAnswer((_) async => expectedResponse);

      // When
      final result = await useCase(params);

      // Then
      expect(result, equals(expectedResponse));
      expect(result.id, isNull);
      expect(result.phoneNumber, isNull);
      verify(() => mockSettingServerRepository.updatePhoneNumber(any())).called(1);
      verifyNoMoreInteractions(mockSettingServerRepository);
    });
  });
}
