import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/factories/verify_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock Definitions
class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}
class MockVerifyOtpSettingAccountUseCase extends Mock implements VerifyOtpSettingAccountUseCase {}
class MockSettingAccountOtpVerifyArguments extends Mock implements SettingAccountOtpVerifyArguments {}
class MockOtpEntity extends Mock implements OtpEntity {}
void main() {
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockVerifyOtpSettingAccountUseCase mockVerifyOtpSettingAccountUseCase;
  late MockSettingAccountOtpVerifyArguments mockSettingAccountOtpVerifyArguments;
  late MockOtpEntity mockOtpEntity;

  setUpAll(() {
    registerFallbackValue(VerifyOTPRequest(token: '', otp: '', phoneOrEmail: '', actionName: AuthenticationActionType.forgotPassword));
    registerFallbackValue(VerifyOtpSettingAccountRequest(token: '', otp: ''));
    registerFallbackValue(const VerifyOtpEntity(actionToken: '', actionName: '', accountId: '')); // Use actual entity
    registerFallbackValue(AuthenticationActionType.forgotPassword);
    registerFallbackValue(SelectedOtpType.email);
  });

  setUp(() {
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    mockVerifyOtpSettingAccountUseCase = MockVerifyOtpSettingAccountUseCase();
    mockSettingAccountOtpVerifyArguments = MockSettingAccountOtpVerifyArguments();
    mockOtpEntity = MockOtpEntity();

    // Register mocks with GetIt
    GetIt.I.registerFactory<VerifyOtpUseCase>(() => mockVerifyOtpUseCase);
    GetIt.I.registerFactory<VerifyOtpSettingAccountUseCase>(() => mockVerifyOtpSettingAccountUseCase);
  });

  tearDown(() {
    GetIt.I.reset(); // Reset GetIt after each test
    reset(mockVerifyOtpUseCase);
    reset(mockVerifyOtpSettingAccountUseCase);
    reset(mockSettingAccountOtpVerifyArguments);
    reset(mockOtpEntity);
  });

  group('VerifyOtpUseCaseFactory', () {
    test('Given AuthenticationActionType.forgotPassword, When create is called, Then returns _VerifyOtpForgotPasswordUseCase', () {
      // Given
      final actionType = AuthenticationActionType.forgotPassword;

      // When
      final useCase = VerifyOtpUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IVerifyOtpUseCase>());
      expect(useCase.runtimeType.toString(), '_VerifyOtpForgotPasswordUseCase');
    });

    test('Given any other AuthenticationActionType, When create is called, Then returns _VerifyOtpSettingAccountUseCase', () {
      // Given
      final actionType = AuthenticationActionType.setting; // Example of another type

      // When
      final useCase = VerifyOtpUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IVerifyOtpUseCase>());
      expect(useCase.runtimeType.toString(), '_VerifyOtpSettingAccountUseCase');
    });
  });

  group('_VerifyOtpForgotPasswordUseCase (via factory)', () {
    late IVerifyOtpUseCase forgotPasswordUseCase;

    setUp(() {
      forgotPasswordUseCase = VerifyOtpUseCaseFactory.create(AuthenticationActionType.forgotPassword);
    });

    test('Given SettingAccountOtpVerifyArguments with phone, When createRequest is called, Then returns VerifyOTPRequest with phone details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.phone);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn('1234567890');
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.otp).thenReturn('123456');
      when(() => mockSettingAccountOtpVerifyArguments.otpEntity).thenReturn(mockOtpEntity);
      when(() => mockOtpEntity.token).thenReturn('token_forgot');
      when(() => mockSettingAccountOtpVerifyArguments.actionType).thenReturn(AuthenticationActionType.forgotPassword);
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<VerifyOTPRequest>());
      expect(request.token, 'token_forgot');
      expect(request.otp, '123456');
      expect(request.phoneOrEmail, '1234567890');
      expect(request.actionName, AuthenticationActionType.forgotPassword);
    });

    test('Given SettingAccountOtpVerifyArguments with email, When createRequest is called, Then returns VerifyOTPRequest with email details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.email);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn('test@example.com');
      when(() => mockSettingAccountOtpVerifyArguments.otp).thenReturn('654321');
      when(() => mockSettingAccountOtpVerifyArguments.otpEntity).thenReturn(mockOtpEntity);
      when(() => mockOtpEntity.token).thenReturn('token_forgot_email');
      when(() => mockSettingAccountOtpVerifyArguments.actionType).thenReturn(AuthenticationActionType.forgotPassword);
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<VerifyOTPRequest>());
      expect(request.token, 'token_forgot_email');
      expect(request.otp, '654321');
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.actionName, AuthenticationActionType.forgotPassword);
    });

    test('Given VerifyOTPRequest, When execute is called, Then calls VerifyOtpUseCase and returns VerifyOtpEntity', () async {
      // Given
      final tRequest = VerifyOTPRequest(token: 'token', otp: '123', phoneOrEmail: 'phone', actionName: AuthenticationActionType.forgotPassword);
      final tVerifyOtpEntity = const VerifyOtpEntity(actionToken: 'action_token', actionName: 'forgotPassword', accountId: '123');
      when(() => mockVerifyOtpUseCase.call(any())).thenAnswer((_) async => tVerifyOtpEntity);

      // When
      final result = await (forgotPasswordUseCase as dynamic).execute(tRequest);

      // Then
      expect(result, equals(tVerifyOtpEntity));
      verify(() => mockVerifyOtpUseCase.call(tRequest)).called(1);
    });
  });

  group('_VerifyOtpSettingAccountUseCase (via factory)', () {
    late IVerifyOtpUseCase settingAccountUseCase;

    setUp(() {
      settingAccountUseCase = VerifyOtpUseCaseFactory.create(AuthenticationActionType.setting);
    });

    test('Given SettingAccountOtpVerifyArguments with phone, When createRequest is called, Then returns VerifyOtpSettingAccountRequest with phone details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.phone);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn('0987654321');
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.otp).thenReturn('789012');
      when(() => mockSettingAccountOtpVerifyArguments.otpEntity).thenReturn(mockOtpEntity);
      when(() => mockOtpEntity.token).thenReturn('token_setting');
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<VerifyOtpSettingAccountRequest>());
      expect(request.token, 'token_setting');
      expect(request.otp, '789012');
      expect(request.phoneNumber, '0987654321');
      expect(request.email, isNull);
    });

    test('Given SettingAccountOtpVerifyArguments with email, When createRequest is called, Then returns VerifyOtpSettingAccountRequest with email details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.email);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn('new_setting@example.com');
      when(() => mockSettingAccountOtpVerifyArguments.otp).thenReturn('345678');
      when(() => mockSettingAccountOtpVerifyArguments.otpEntity).thenReturn(mockOtpEntity);
      when(() => mockOtpEntity.token).thenReturn('token_setting_email');
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<VerifyOtpSettingAccountRequest>());
      expect(request.token, 'token_setting_email');
      expect(request.otp, '345678');
      expect(request.phoneNumber, isNull);
      expect(request.email, 'new_setting@example.com');
    });

    test('Given VerifyOtpSettingAccountRequest, When execute is called, Then calls VerifyOtpSettingAccountUseCase and returns VerifyOtpEntity', () async {
      // Given
      final tRequest = VerifyOtpSettingAccountRequest(token: 'token', otp: '123', phoneNumber: 'phone');
      final tVerifyOtpEntity = const VerifyOtpEntity(actionToken: 'action_token_setting', actionName: 'setting', accountId: '456');
      when(() => mockVerifyOtpSettingAccountUseCase.call(any())).thenAnswer((_) async => tVerifyOtpEntity);

      // When
      final result = await (settingAccountUseCase as dynamic).execute(tRequest);

      // Then
      expect(result, equals(tVerifyOtpEntity));
      verify(() => mockVerifyOtpSettingAccountUseCase.call(tRequest)).called(1);
    });
  });
}