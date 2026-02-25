import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_setting_account_use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

class FakeGetOtpTwoFaRequest extends Fake implements GetOtpSettingAccountRequest {}

void main() {
  late GetOtpSettingAccountUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUpAll(() {
    // Register fallback values for any custom types used with `any()` or `captureAny()`
    // if GetOtpTwoFaRequest is complex or has many variations.
    // For this case, direct argument matching or specific instances are preferred.
    // However, if `any(named: 'params')` were used, this would be necessary.
    registerFallbackValue(FakeGetOtpTwoFaRequest());
  });

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = GetOtpSettingAccountUseCase(authServerRepository: mockAuthServerRepository);
  });

  // Test data
  const tOtpEntity = OtpEntity(
    token: 'test_token',
    ref: 'test_ref',
    type: 'sms',
    firstGet: null, // Using null as DateTime can be tricky to match exactly
    timeout: null, // Using null for simplicity in this example
    actionToken: 'test_action_token',
  );

  final tGetOtpTwoFaRequestPhoneNumber = GetOtpSettingAccountRequest(
    phoneNumber: '1234567890',
    actionName: AuthenticationActionType.settingPhoneNumber,
  );

  final tGetOtpTwoFaRequestEmail = GetOtpSettingAccountRequest(
    email: 'test@example.com',
    actionName: AuthenticationActionType.settingPhoneNumber,
  );

  final tException = Exception('Something went wrong');

  group('GetOtpTwoFaUseCase', () {
    test(
        'Given AuthServerRepository returns OtpEntity, When use case is called with phone number, Then returns OtpEntity',
        () async {
      // Given
      when(() => mockAuthServerRepository.getOtpSettingAccount(any())).thenAnswer((_) async => tOtpEntity);

      // When
      final result = await useCase(tGetOtpTwoFaRequestPhoneNumber);

      // Then
      expect(result, equals(tOtpEntity));
      verify(() => mockAuthServerRepository.getOtpSettingAccount(tGetOtpTwoFaRequestPhoneNumber)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given AuthServerRepository returns OtpEntity, When use case is called with email, Then returns OtpEntity',
        () async {
      // Given
      when(() => mockAuthServerRepository.getOtpSettingAccount(any())).thenAnswer((_) async => tOtpEntity);

      // When
      final result = await useCase(tGetOtpTwoFaRequestEmail);

      // Then
      expect(result, equals(tOtpEntity));
      verify(() => mockAuthServerRepository.getOtpSettingAccount(tGetOtpTwoFaRequestEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given AuthServerRepository throws an exception, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.getOtpSettingAccount(any())).thenThrow(tException);

      // When
      final call = useCase(tGetOtpTwoFaRequestPhoneNumber);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.getOtpSettingAccount(tGetOtpTwoFaRequestPhoneNumber)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository throws an exception for email request, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.getOtpSettingAccount(any())).thenThrow(tException);

      // When
      final call = useCase(tGetOtpTwoFaRequestEmail);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.getOtpSettingAccount(tGetOtpTwoFaRequestEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });
}
