import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/validate_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/domain/factories/validate_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock Definitions
class MockValidateForgotPasswordUseCase extends Mock implements ValidateForgotPasswordUseCase {}
class MockValidateNewPasswordUseCase extends Mock implements ValidateNewPasswordUseCase {}
class MockSettingAccountCreateNewPasswordArguments extends Mock implements SettingAccountCreateNewPasswordArguments {}

void main() {
  late MockValidateForgotPasswordUseCase mockValidateForgotPasswordUseCase;
  late MockValidateNewPasswordUseCase mockValidateNewPasswordUseCase;
  late MockSettingAccountCreateNewPasswordArguments mockSettingAccountCreateNewPasswordArguments;

  setUpAll(() {
    registerFallbackValue(ValidateForgotPasswordRequest(accountId: '', token: '', password: ''));
    registerFallbackValue(ValidateNewPasswordRequest(newPassword: ''));
    registerFallbackValue(AuthenticationActionType.forgotPassword);
  });

  setUp(() {
    mockValidateForgotPasswordUseCase = MockValidateForgotPasswordUseCase();
    mockValidateNewPasswordUseCase = MockValidateNewPasswordUseCase();
    mockSettingAccountCreateNewPasswordArguments = MockSettingAccountCreateNewPasswordArguments();

    // Register mocks with GetIt
    GetIt.I.registerFactory<ValidateForgotPasswordUseCase>(() => mockValidateForgotPasswordUseCase);
    GetIt.I.registerFactory<ValidateNewPasswordUseCase>(() => mockValidateNewPasswordUseCase);
  });

  tearDown(() {
    GetIt.I.reset(); // Reset GetIt after each test
    reset(mockValidateForgotPasswordUseCase);
    reset(mockValidateNewPasswordUseCase);
    reset(mockSettingAccountCreateNewPasswordArguments);
  });

  group('ValidateNewPasswordUseCaseFactory', () {
    test('Given AuthenticationActionType.forgotPassword, When create is called, Then returns _ValidateNewPasswordForgotPasswordUseCase', () {
      // Given
      final actionType = AuthenticationActionType.forgotPassword;

      // When
      final useCase = ValidateNewPasswordUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IValidateNewPasswordUseCase>());
      expect(useCase.runtimeType.toString(), '_ValidateNewPasswordForgotPasswordUseCase');
    });

    test('Given any other AuthenticationActionType, When create is called, Then returns _ValidateNewPasswordSettingAccountUseCase', () {
      // Given
      final actionType = AuthenticationActionType.settingPassword; // Example of another type

      // When
      final useCase = ValidateNewPasswordUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IValidateNewPasswordUseCase>());
      expect(useCase.runtimeType.toString(), '_ValidateNewPasswordSettingAccountUseCase');
    });
  });

  group('_ValidateNewPasswordForgotPasswordUseCase (via factory)', () {
    late IValidateNewPasswordUseCase forgotPasswordUseCase;

    setUp(() {
      forgotPasswordUseCase = ValidateNewPasswordUseCaseFactory.create(AuthenticationActionType.forgotPassword);
    });

    test('Given SettingAccountCreateNewPasswordArguments, When createRequest is called, Then returns ValidateForgotPasswordRequest', () {
      // Given
      const newPassword = 'new_password_123';
      when(() => mockSettingAccountCreateNewPasswordArguments.accountId).thenReturn('account123');
      when(() => mockSettingAccountCreateNewPasswordArguments.actionToken).thenReturn('token123');

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(
        params: mockSettingAccountCreateNewPasswordArguments,
        newPassword: newPassword,
      );

      // Then
      expect(request, isA<ValidateForgotPasswordRequest>());
      expect(request.accountId, 'account123');
      expect(request.token, 'token123');
      expect(request.password, newPassword);
    });

    test('Given ValidateForgotPasswordRequest, When execute is called, Then calls ValidateForgotPasswordUseCase', () async {
      // Given
      final tRequest = ValidateForgotPasswordRequest(accountId: 'account123', token: 'token123', password: 'new_password_123');
      when(() => mockValidateForgotPasswordUseCase.call(any())).thenAnswer((_) async {});

      // When
      await (forgotPasswordUseCase as dynamic).execute(tRequest);

      // Then
      verify(() => mockValidateForgotPasswordUseCase.call(tRequest)).called(1);
    });
  });

  group('_ValidateNewPasswordSettingAccountUseCase (via factory)', () {
    late IValidateNewPasswordUseCase settingAccountUseCase;

    setUp(() {
      settingAccountUseCase = ValidateNewPasswordUseCaseFactory.create(AuthenticationActionType.settingPassword);
    });

    test('Given SettingAccountCreateNewPasswordArguments, When createRequest is called, Then returns ValidateNewPasswordRequest', () {
      // Given
      const newPassword = 'new_password_456';

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(
        params: mockSettingAccountCreateNewPasswordArguments,
        newPassword: newPassword,
      );

      // Then
      expect(request, isA<ValidateNewPasswordRequest>());
      expect(request.newPassword, newPassword);
    });

    test('Given ValidateNewPasswordRequest, When execute is called, Then calls ValidateNewPasswordUseCase', () async {
      // Given
      final tRequest = ValidateNewPasswordRequest(newPassword: 'new_password_456');
      when(() => mockValidateNewPasswordUseCase.call(any())).thenAnswer((_) async {});

      // When
      await (settingAccountUseCase as dynamic).execute(tRequest);

      // Then
      verify(() => mockValidateNewPasswordUseCase.call(tRequest)).called(1);
    });
  });
}