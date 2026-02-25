import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

class FakeGetOtpTwoFaRequest extends Fake implements GetOtpTwoFaLoginRequest {}

void main() {
  late GetOtpTwoFaLoginUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;
  late GetOtpTwoFaLoginRequest tGetOtpTwoFaRequest;
  late OtpEntity tOtpEntity;

  setUpAll(() {
    registerFallbackValue(FakeGetOtpTwoFaRequest());
  });

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = GetOtpTwoFaLoginUseCase(authServerRepository: mockAuthServerRepository);
    tGetOtpTwoFaRequest = GetOtpTwoFaLoginRequest(
      phoneOrEmail: 'test@example.com',
      isEmail: true,
      isPhoneNumber: false,
    );
    tOtpEntity = OtpEntity(
      token: 'test_otp_token_123',
      ref: 'ref_123',
      type: 'email',
      firstGet: DateTime(2025, 6, 16, 12, 0, 0),
      timeout: DateTime(2025, 6, 16, 12, 10, 0),
      actionToken: 'action_token_123',
    );
    reset(mockAuthServerRepository);
  });

  group('GetOtpTwoFaLoginUseCase', () {
    test('Given valid GetOtpTwoFaRequest, When call is executed, Then returns OtpEntity from repository', () async {
      // Given
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).thenAnswer((_) async => tOtpEntity);

      // When
      final result = await useCase.call(tGetOtpTwoFaRequest);

      // Then
      expect(result, equals(tOtpEntity));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given repository throws Exception, When call is executed, Then re-throws the same Exception', () async {
      // Given
      final testException = Exception('Network error');
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).thenThrow(testException);

      // When
      call() => useCase.call(tGetOtpTwoFaRequest);

      // Then
      expect(call, throwsA(equals(testException)));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given repository throws AuthException, When call is executed, Then re-throws AuthException', () async {
      // Given
      final authException = Exception('Authentication failed');
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).thenThrow(authException);

      // When
      call() => useCase.call(tGetOtpTwoFaRequest);

      // Then
      expect(call, throwsA(equals(authException)));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given phone number request, When call is executed, Then passes correct parameters to repository', () async {
      // Given
      final phoneRequest = GetOtpTwoFaLoginRequest(
        phoneOrEmail: '+1234567890',
        isPhoneNumber: true,
        isEmail: false,
      );
      final phoneOtpEntity = OtpEntity(
        token: 'phone_otp_token_456',
        ref: 'phone_ref_456',
        type: 'phone',
        firstGet: DateTime(2025, 6, 17, 15, 30, 0),
        timeout: DateTime(2025, 6, 17, 15, 40, 0),
        actionToken: 'phone_action_token_456',
      );
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(phoneRequest)).thenAnswer((_) async => phoneOtpEntity);

      // When
      final result = await useCase.call(phoneRequest);

      // Then
      expect(result, equals(phoneOtpEntity));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(phoneRequest)).called(1);
      verifyNever(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest));
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given email request, When call is executed, Then passes correct parameters to repository', () async {
      // Given
      final emailRequest = GetOtpTwoFaLoginRequest(
        phoneOrEmail: 'different@example.com',
        isEmail: true,
        isPhoneNumber: false,
      );
      final emailOtpEntity = OtpEntity(
        token: 'email_otp_token_789',
        ref: 'email_ref_789',
        type: 'email',
        firstGet: DateTime(2025, 6, 18, 10, 15, 0),
        timeout: DateTime(2025, 6, 18, 10, 25, 0),
        actionToken: 'email_action_token_789',
      );
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(emailRequest)).thenAnswer((_) async => emailOtpEntity);

      // When
      final result = await useCase.call(emailRequest);

      // Then
      expect(result, equals(emailOtpEntity));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(emailRequest)).called(1);
      verifyNever(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest));
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given request with null optional fields, When call is executed, Then passes request to repository', () async {
      // Given
      final requestWithNulls = GetOtpTwoFaLoginRequest(
        phoneOrEmail: 'user@example.com',
        isEmail: null,
        isPhoneNumber: null,
      );
      final nullFieldsOtpEntity = OtpEntity(
        token: 'null_fields_token_999',
        ref: 'null_fields_ref_999',
        type: 'unknown',
        firstGet: DateTime(2025, 6, 19, 8, 45, 0),
        timeout: DateTime(2025, 6, 19, 8, 55, 0),
        actionToken: 'null_fields_action_token_999',
      );
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(requestWithNulls))
          .thenAnswer((_) async => nullFieldsOtpEntity);

      // When
      final result = await useCase.call(requestWithNulls);

      // Then
      expect(result, equals(nullFieldsOtpEntity));
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(requestWithNulls)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given repository returns OtpEntity with null fields, When call is executed, Then returns the OtpEntity as-is',
        () async {
      // Given
      const otpEntityWithNulls = OtpEntity(
        token: 'valid_token',
        ref: null,
        type: null,
        firstGet: null,
        timeout: null,
        actionToken: null,
      );
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest))
          .thenAnswer((_) async => otpEntityWithNulls);

      // When
      final result = await useCase.call(tGetOtpTwoFaRequest);

      // Then
      expect(result, equals(otpEntityWithNulls));
      expect(result.token, equals('valid_token'));
      expect(result.ref, isNull);
      expect(result.type, isNull);
      expect(result.firstGet, isNull);
      expect(result.timeout, isNull);
      expect(result.actionToken, isNull);
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given repository returns OtpEntity with all null fields, When call is executed, Then returns the OtpEntity as-is',
        () async {
      // Given
      const completelyNullOtpEntity = OtpEntity();
      when(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest))
          .thenAnswer((_) async => completelyNullOtpEntity);

      // When
      final result = await useCase.call(tGetOtpTwoFaRequest);

      // Then
      expect(result, equals(completelyNullOtpEntity));
      expect(result.token, isNull);
      expect(result.ref, isNull);
      expect(result.type, isNull);
      expect(result.firstGet, isNull);
      expect(result.timeout, isNull);
      expect(result.actionToken, isNull);
      verify(() => mockAuthServerRepository.getOtpTwoFaLogin(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });

  group('GetOtpTwoFaLoginUseCase constructor', () {
    test('Given valid AuthServerRepository, When constructor is called, Then creates instance successfully', () {
      // Given
      final repository = MockAuthServerRepository();

      // When
      final instance = GetOtpTwoFaLoginUseCase(authServerRepository: repository);

      // Then
      expect(instance, isA<GetOtpTwoFaLoginUseCase>());
      expect(instance.authServerRepository, equals(repository));
    });
  });
}
