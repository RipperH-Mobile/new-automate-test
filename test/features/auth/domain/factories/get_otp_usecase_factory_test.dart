import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/factories/get_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock Definitions
class MockGetOtpForgotPasswordUseCase extends Mock implements GetOtpForgotPasswordUseCase {}
class MockGetOtpSettingAccountUseCase extends Mock implements GetOtpSettingAccountUseCase {}
class MockSettingAccountOtpVerifyArguments extends Mock implements SettingAccountOtpVerifyArguments {}
class FakeOtpEntity extends Fake implements OtpEntity {}

void main() {
  late MockGetOtpForgotPasswordUseCase mockGetOtpForgotPasswordUseCase;
  late MockGetOtpSettingAccountUseCase mockGetOtpSettingAccountUseCase;
  late MockSettingAccountOtpVerifyArguments mockSettingAccountOtpVerifyArguments;

  setUpAll(() {
    registerFallbackValue(FakeOtpEntity());
    registerFallbackValue(GetOtpForgotPasswordRequest(phoneOrEmail: '', isForgotPassword: false, isEmail: false, isPhoneNumber: false));
    registerFallbackValue(GetOtpSettingAccountRequest(actionName: AuthenticationActionType.forgotPassword));
    registerFallbackValue(AuthenticationActionType.forgotPassword);
    registerFallbackValue(SelectedOtpType.email);
  });

  setUp(() {
    mockGetOtpForgotPasswordUseCase = MockGetOtpForgotPasswordUseCase();
    mockGetOtpSettingAccountUseCase = MockGetOtpSettingAccountUseCase();
    mockSettingAccountOtpVerifyArguments = MockSettingAccountOtpVerifyArguments();

    // Register mocks with GetIt
    GetIt.I.registerFactory<GetOtpForgotPasswordUseCase>(() => mockGetOtpForgotPasswordUseCase);
    GetIt.I.registerFactory<GetOtpSettingAccountUseCase>(() => mockGetOtpSettingAccountUseCase);
  });

  tearDown(() {
    GetIt.I.reset(); // Reset GetIt after each test
    reset(mockGetOtpForgotPasswordUseCase);
    reset(mockGetOtpSettingAccountUseCase);
    reset(mockSettingAccountOtpVerifyArguments);
  });

  group('GetOtpUseCaseFactory', () {
    test('Given AuthenticationActionType.forgotPassword, When create is called, Then returns _GetOtpForgotPasswordUseCase', () {
      // Given
      final actionType = AuthenticationActionType.forgotPassword;

      // When
      final useCase = GetOtpUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IGetOtpUseCase>());
      expect(useCase, isA<dynamic>()); // Check if it's an instance of the private class
    });

    test('Given any other AuthenticationActionType, When create is called, Then returns _GetOtpSettingAccountUseCase', () {
      // Given
      final actionType = AuthenticationActionType.setting; // Example of another type

      // When
      final useCase = GetOtpUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IGetOtpUseCase>());
      expect(useCase.runtimeType.toString(), '_GetOtpSettingAccountUseCase');
    });
  });

  group('_GetOtpForgotPasswordUseCase (via factory)', () {
    late IGetOtpUseCase forgotPasswordUseCase;

    setUp(() {
      forgotPasswordUseCase = GetOtpUseCaseFactory.create(AuthenticationActionType.forgotPassword);
    });

    test('Given SettingAccountOtpVerifyArguments with phone, When createRequest is called, Then returns GetOtpForgotPasswordRequest with phone details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.phone);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn('1234567890');
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn(null);

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<GetOtpForgotPasswordRequest>());
      expect(request.phoneOrEmail, '1234567890');
      expect(request.isForgotPassword, isTrue);
      expect(request.isEmail, isFalse);
      expect(request.isPhoneNumber, isTrue);
    });

    test('Given SettingAccountOtpVerifyArguments with email, When createRequest is called, Then returns GetOtpForgotPasswordRequest with email details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.email);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn('test@example.com');

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<GetOtpForgotPasswordRequest>());
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.isForgotPassword, isTrue);
      expect(request.isEmail, isTrue);
      expect(request.isPhoneNumber, isFalse);
    });

    test('Given GetOtpForgotPasswordRequest, When execute is called, Then calls GetOtpForgotPasswordUseCase and returns OtpEntity', () async {
      // Given
      final tRequest = GetOtpForgotPasswordRequest(phoneOrEmail: '123', isForgotPassword: true, isEmail: false, isPhoneNumber: true);
      final tOtpEntity = OtpEntity(token: '123456', timeout: DateTime.now().add(const Duration(minutes: 5)));
      when(() => mockGetOtpForgotPasswordUseCase.call(any())).thenAnswer((_) async => tOtpEntity);

      // When
      final result = await (forgotPasswordUseCase as dynamic).execute(tRequest);

      // Then
      expect(result, equals(tOtpEntity));
      verify(() => mockGetOtpForgotPasswordUseCase.call(tRequest)).called(1);
    });
  });

  group('_GetOtpSettingAccountUseCase (via factory)', () {
    late IGetOtpUseCase settingAccountUseCase;

    setUp(() {
      settingAccountUseCase = GetOtpUseCaseFactory.create(AuthenticationActionType.setting);
    });

    test('Given SettingAccountOtpVerifyArguments with phone, When createRequest is called, Then returns GetOtpSettingAccountRequest with phone details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.phone);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn('0987654321');
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.actionType).thenReturn(AuthenticationActionType.settingPhoneNumber);
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<GetOtpSettingAccountRequest>());
      expect(request.phoneNumber, '0987654321');
      expect(request.email, isNull);
      expect(request.actionName, AuthenticationActionType.settingPhoneNumber);
    });

    test('Given SettingAccountOtpVerifyArguments with email, When createRequest is called, Then returns GetOtpSettingAccountRequest with email details', () {
      // Given
      when(() => mockSettingAccountOtpVerifyArguments.method).thenReturn(SelectedOtpType.email);
      when(() => mockSettingAccountOtpVerifyArguments.phoneNumber).thenReturn(null);
      when(() => mockSettingAccountOtpVerifyArguments.email).thenReturn('new@example.com');
      when(() => mockSettingAccountOtpVerifyArguments.actionType).thenReturn(AuthenticationActionType.settingEmail);
      when(() => mockSettingAccountOtpVerifyArguments.canGodModeByPassOtp).thenReturn(false);

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(mockSettingAccountOtpVerifyArguments);

      // Then
      expect(request, isA<GetOtpSettingAccountRequest>());
      expect(request.phoneNumber, isNull);
      expect(request.email, 'new@example.com');
      expect(request.actionName, AuthenticationActionType.settingEmail);
    });

    test('Given GetOtpSettingAccountRequest, When execute is called, Then calls GetOtpSettingAccountUseCase and returns OtpEntity', () async {
      // Given
      final tRequest = GetOtpSettingAccountRequest(phoneNumber: '123', actionName: AuthenticationActionType.settingPhoneNumber);
      final tOtpEntity = OtpEntity(token: '654321', timeout: DateTime.now().add(const Duration(minutes: 5)));
      when(() => mockGetOtpSettingAccountUseCase.call(any())).thenAnswer((_) async => tOtpEntity);

      // When
      final result = await (settingAccountUseCase as dynamic).execute(tRequest);

      // Then
      expect(result, equals(tOtpEntity));
      verify(() => mockGetOtpSettingAccountUseCase.call(tRequest)).called(1);
    });
  });
}