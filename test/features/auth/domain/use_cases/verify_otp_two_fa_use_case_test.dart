import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_setting_account_use_case.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

class FakeVerifyOtpTwoFaRequest extends Fake implements VerifyOtpSettingAccountRequest {}

void main() {
  late VerifyOtpSettingAccountUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeVerifyOtpTwoFaRequest());
  });

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = VerifyOtpSettingAccountUseCase(authServerRepository: mockAuthServerRepository);
  });

  // Test data
  const tVerifyOtpEntity = VerifyOtpEntity(
    actionToken: 'test_action_token',
    actionName: 'TWO_FA_VERIFIED', // Example action name
    accountId: 'test_account_id',
  );

  final tVerifyOtpTwoFaRequestPhoneNumber = VerifyOtpSettingAccountRequest(
    token: 'test_token',
    otp: '123456',
    phoneNumber: '1234567890',
  );

  final tVerifyOtpTwoFaRequestEmail = VerifyOtpSettingAccountRequest(
    token: 'test_token',
    otp: '123456',
    email: 'test@example.com',
  );

  final tException = Exception('Verification failed');

  group('VerifyOtpTwoFaUseCase', () {
    test(
        'Given AuthServerRepository returns VerifyOtpEntity, When use case is called with phone number, Then returns VerifyOtpEntity',
        () async {
      // Given
      when(() => mockAuthServerRepository.verifyOtpTwoFa(any())).thenAnswer((_) async => tVerifyOtpEntity);

      // When
      final result = await useCase(tVerifyOtpTwoFaRequestPhoneNumber);

      // Then
      expect(result, equals(tVerifyOtpEntity));
      verify(() => mockAuthServerRepository.verifyOtpTwoFa(tVerifyOtpTwoFaRequestPhoneNumber)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository returns VerifyOtpEntity, When use case is called with email, Then returns VerifyOtpEntity',
        () async {
      // Given
      when(() => mockAuthServerRepository.verifyOtpTwoFa(any())).thenAnswer((_) async => tVerifyOtpEntity);

      // When
      final result = await useCase(tVerifyOtpTwoFaRequestEmail);

      // Then
      expect(result, equals(tVerifyOtpEntity));
      verify(() => mockAuthServerRepository.verifyOtpTwoFa(tVerifyOtpTwoFaRequestEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository throws an exception, When use case is called with phone number, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.verifyOtpTwoFa(any())).thenThrow(tException);

      // When
      final call = useCase(tVerifyOtpTwoFaRequestPhoneNumber);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.verifyOtpTwoFa(tVerifyOtpTwoFaRequestPhoneNumber)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository throws an exception, When use case is called with email, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.verifyOtpTwoFa(any())).thenThrow(tException);

      // When
      final call = useCase(tVerifyOtpTwoFaRequestEmail);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.verifyOtpTwoFa(tVerifyOtpTwoFaRequestEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });
}
