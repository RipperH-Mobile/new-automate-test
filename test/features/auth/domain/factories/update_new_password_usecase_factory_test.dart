import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/domain/factories/update_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/update_new_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_confirm_new_password_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock Definitions
class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}
class MockUpdateNewPasswordUseCase extends Mock implements UpdateNewPasswordUseCase {}
class MockSettingAccountConfirmNewPasswordArguments extends Mock implements SettingAccountConfirmNewPasswordArguments {}

void main() {
  late MockForgotPasswordUseCase mockForgotPasswordUseCase;
  late MockUpdateNewPasswordUseCase mockUpdateNewPasswordUseCase;
  late MockSettingAccountConfirmNewPasswordArguments mockSettingAccountConfirmNewPasswordArguments;

  setUpAll(() {
    registerFallbackValue(ForgotPasswordRequest(actionToken: '', phoneOrEmail: '', password: ''));
    registerFallbackValue(UpdateNewPasswordRequest(actionToken: '', newPassword: ''));
    registerFallbackValue(AuthenticationActionType.forgotPassword);
  });

  setUp(() {
    mockForgotPasswordUseCase = MockForgotPasswordUseCase();
    mockUpdateNewPasswordUseCase = MockUpdateNewPasswordUseCase();
    mockSettingAccountConfirmNewPasswordArguments = MockSettingAccountConfirmNewPasswordArguments();

    // Register mocks with GetIt
    GetIt.I.registerFactory<ForgotPasswordUseCase>(() => mockForgotPasswordUseCase);
    GetIt.I.registerFactory<UpdateNewPasswordUseCase>(() => mockUpdateNewPasswordUseCase);
  });

  tearDown(() {
    GetIt.I.reset(); // Reset GetIt after each test
    reset(mockForgotPasswordUseCase);
    reset(mockUpdateNewPasswordUseCase);
    reset(mockSettingAccountConfirmNewPasswordArguments);
  });

  group('UpdateNewPasswordUseCaseFactory', () {
    test('Given AuthenticationActionType.forgotPassword, When create is called, Then returns _UpdateNewPasswordForgotPasswordUseCase', () {
      // Given
      final actionType = AuthenticationActionType.forgotPassword;

      // When
      final useCase = UpdateNewPasswordUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IUpdateNewPasswordUseCase>());
      expect(useCase.runtimeType.toString(), '_UpdateNewPasswordForgotPasswordUseCase');
    });

    test('Given any other AuthenticationActionType, When create is called, Then returns _UpdateNewPasswordSettingAccountUseCase', () {
      // Given
      final actionType = AuthenticationActionType.settingPassword; // Example of another type

      // When
      final useCase = UpdateNewPasswordUseCaseFactory.create(actionType);

      // Then
      expect(useCase, isA<IUpdateNewPasswordUseCase>());
      expect(useCase.runtimeType.toString(), '_UpdateNewPasswordSettingAccountUseCase');
    });
  });

  group('_UpdateNewPasswordForgotPasswordUseCase (via factory)', () {
    late IUpdateNewPasswordUseCase forgotPasswordUseCase;

    setUp(() {
      forgotPasswordUseCase = UpdateNewPasswordUseCaseFactory.create(AuthenticationActionType.forgotPassword);
    });

    test('Given SettingAccountConfirmNewPasswordArguments, When createRequest is called, Then returns ForgotPasswordRequest', () {
      // Given
      const newPassword = 'new_password_123';
      when(() => mockSettingAccountConfirmNewPasswordArguments.actionToken).thenReturn('token123');
      when(() => mockSettingAccountConfirmNewPasswordArguments.phoneOrEmail).thenReturn('test@example.com');

      // When
      final request = (forgotPasswordUseCase as dynamic).createRequest(
        params: mockSettingAccountConfirmNewPasswordArguments,
        newPassword: newPassword,
      );

      // Then
      expect(request, isA<ForgotPasswordRequest>());
      expect(request.actionToken, 'token123');
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.password, newPassword);
    });

    test('Given ForgotPasswordRequest, When execute is called, Then calls ForgotPasswordUseCase', () async {
      // Given
      final tRequest = ForgotPasswordRequest(actionToken: 'token123', phoneOrEmail: 'test@example.com', password: 'new_password_123');
      when(() => mockForgotPasswordUseCase.call(any())).thenAnswer((_) async => true);

      // When
      await (forgotPasswordUseCase as dynamic).execute(tRequest);

      // Then
      verify(() => mockForgotPasswordUseCase.call(tRequest)).called(1);
    });
  });

  group('_UpdateNewPasswordSettingAccountUseCase (via factory)', () {
    late IUpdateNewPasswordUseCase settingAccountUseCase;

    setUp(() {
      settingAccountUseCase = UpdateNewPasswordUseCaseFactory.create(AuthenticationActionType.settingPassword);
    });

    test('Given SettingAccountConfirmNewPasswordArguments, When createRequest is called, Then returns UpdateNewPasswordRequest', () {
      // Given
      const newPassword = 'new_password_456';
      when(() => mockSettingAccountConfirmNewPasswordArguments.actionToken).thenReturn('token456');

      // When
      final request = (settingAccountUseCase as dynamic).createRequest(
        params: mockSettingAccountConfirmNewPasswordArguments,
        newPassword: newPassword,
      );

      // Then
      expect(request, isA<UpdateNewPasswordRequest>());
      expect(request.actionToken, 'token456');
      expect(request.newPassword, newPassword);
    });

    test('Given UpdateNewPasswordRequest, When execute is called, Then calls UpdateNewPasswordUseCase', () async {
      // Given
      final tRequest = UpdateNewPasswordRequest(actionToken: 'token456', newPassword: 'new_password_456');
      when(() => mockUpdateNewPasswordUseCase.call(any())).thenAnswer((_) async {});

      // When
      await (settingAccountUseCase as dynamic).execute(tRequest);

      // Then
      verify(() => mockUpdateNewPasswordUseCase.call(tRequest)).called(1);
    });
  });
}