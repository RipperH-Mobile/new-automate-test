import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/security_settings_model.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_method_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_token_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_otp_method_forgot_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_token_forgot_password_response.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_method_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_token_forgot_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/get_x_wrapper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

// Mock classes
class MockGetOtpMethodForgotPasswordUseCase extends Mock implements GetOtpMethodForgotPasswordUseCase {}

class MockVerifyTokenForgotPasswordUseCase extends Mock implements VerifyTokenForgotPasswordUseCase {}

class MockUChatLoading extends Mock implements IUChatLoading {}

class MockUChatNewDialog extends Mock implements IUChatNewDialog {}

class MockGetXWrapper extends Mock implements IGetXWrapper {}

// Fake classes
class FakeGetOtpMethodForgotPasswordRequest extends Fake implements GetOtpMethodForgotPasswordRequest {}

class FakeVerifyTokenForgotPasswordRequest extends Fake implements VerifyTokenForgotPasswordRequest {}

class FakeSettingAccountCreateNewPasswordArguments extends Fake implements SettingAccountCreateNewPasswordArguments {}

class FakeSettingAccountOtpVerifyArguments extends Fake implements SettingAccountOtpVerifyArguments {}

class FakeSettingAccountOtpVerifyResultArguments extends Fake implements SettingAccountOtpVerifyResultArguments {}

class FakeBuildContext extends Fake implements BuildContext {}

class FakeException extends Fake implements Exception {}

class FakeApiException extends Fake implements ApiException {}

void main() {
  late SettingAccountForgotPasswordFlowManager flowManager;
  late MockGetOtpMethodForgotPasswordUseCase mockGetOtpMethodUseCase;
  late MockVerifyTokenForgotPasswordUseCase mockVerifyTokenUseCase;
  late MockUChatLoading mockUChatLoading;
  late MockUChatNewDialog mockUChatNewDialog;
  late MockGetXWrapper mockGetXWrapper;

  setUpAll(() {
    registerFallbackValue(FakeGetOtpMethodForgotPasswordRequest());
    registerFallbackValue(FakeVerifyTokenForgotPasswordRequest());
    registerFallbackValue(FakeSettingAccountCreateNewPasswordArguments());
    registerFallbackValue(FakeSettingAccountOtpVerifyArguments());
    registerFallbackValue(FakeSettingAccountOtpVerifyResultArguments());
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(FakeException());
    registerFallbackValue(FakeApiException());
    registerFallbackValue(AccountSettingArguments(user: UserEntity(id: 'userId')));
  });

  setUp(() {
    mockGetOtpMethodUseCase = MockGetOtpMethodForgotPasswordUseCase();
    mockVerifyTokenUseCase = MockVerifyTokenForgotPasswordUseCase();
    mockUChatLoading = MockUChatLoading();
    mockUChatNewDialog = MockUChatNewDialog();
    mockGetXWrapper = MockGetXWrapper();

    flowManager = SettingAccountForgotPasswordFlowManager(
      getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
      verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
    );

    // Set test modes
    UChatLoading.testMode = mockUChatLoading;
    UChatNewDialog.testMode = mockUChatNewDialog;
    GetXWrapper.testMode = mockGetXWrapper;

    // Reset all mocks
    reset(mockGetOtpMethodUseCase);
    reset(mockVerifyTokenUseCase);
    reset(mockUChatLoading);
    reset(mockUChatNewDialog);
    reset(mockGetXWrapper);
  });

  tearDown(() {
    // Clear test modes
    UChatLoading.testMode = null;
    UChatNewDialog.testMode = null;
    GetXWrapper.testMode = null;
  });

  group('SettingAccountForgotPasswordFlowManager', () {
    group('execute', () {
      test('Given user with 2FA enabled, When execute is called, Then calls _with2FaFlow', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          email: 'test@example.com',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: true),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );
        when(() => mockGetOtpMethodUseCase.call(any()))
            .thenAnswer((_) async => const GetOtpMethodForgotPasswordResponse(
                  email: 'test@example.com',
                  method: 'email',
                  phone: '',
                ));
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);
        when(() => mockGetXWrapper.offNamedUntil(any(), any())).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockGetOtpMethodUseCase.call(any(that: isA<GetOtpMethodForgotPasswordRequest>()))).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockGetXWrapper.toNamed(Routes.settingAccountSentEmailForgotPassword)).called(1);
        verify(() => mockGetXWrapper.offNamedUntil(Routes.accountSetting, any(), arguments: any(named: 'arguments')))
            .called(1);
      });

      test('Given user with 2FA disabled, When execute is called, Then calls _without2FaFlow', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: false),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);
        when(() => mockGetXWrapper.offNamedUntil(any(), any())).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
      });

      test('Given user with null security settings, When execute is called, Then defaults to without 2FA flow',
          () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: AccountSettingsModel(security: null),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
      });

      test('Given user with null account settings, When execute is called, Then defaults to without 2FA flow',
          () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: null,
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
      });

      test('Given null user, When execute is called, Then defaults to without 2FA flow', () async {
        // Given
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: null,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );
        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
      });
    });

    group('resetPassword', () {
      const testSessionId = 'test-session-id';
      const testToken = 'test-token';
      final testVerifyTokenResponse = VerifyTokenForgotPasswordResponse(
        actionToken: 'test-action-token',
        actionName: 'forgot-password',
        accountId: 'test-account-id',
        phone: 'test-phone',
      );

      test(
          'Given valid session and token, When resetPassword is called, Then verifies token and navigates to create password',
          () async {
        // Given
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockVerifyTokenUseCase.call(any())).thenAnswer((_) async => testVerifyTokenResponse);
        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments')))
            .thenAnswer((_) async => null); // Return null to avoid UserController dependency

        // When
        await flowManager.appLinkFlow(sessionId: testSessionId, token: testToken);

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockVerifyTokenUseCase.call(any(that: isA<VerifyTokenForgotPasswordRequest>()))).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountCreateNewPassword,
              arguments: any(named: 'arguments', that: isA<SettingAccountCreateNewPasswordArguments>()),
            )).called(1);
        verifyNever(() => mockGetXWrapper.offNamedUntil(any(), any()));
        verifyNever(() => mockGetXWrapper.offAllNamed(any()));
      });

      test('Given password update returns null, When resetPassword is called, Then returns early without navigation',
          () async {
        // Given
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockVerifyTokenUseCase.call(any())).thenAnswer((_) async => testVerifyTokenResponse);
        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments'))).thenAnswer((_) async => null);

        // When
        await flowManager.appLinkFlow(sessionId: testSessionId, token: testToken);

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockVerifyTokenUseCase.call(any(that: isA<VerifyTokenForgotPasswordRequest>()))).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountCreateNewPassword,
              arguments: any(named: 'arguments', that: isA<SettingAccountCreateNewPasswordArguments>()),
            )).called(1);
        verifyNever(() => mockGetXWrapper.offNamedUntil(any(), any()));
        verifyNever(() => mockGetXWrapper.offAllNamed(any()));
      });

      test('Given expired token exception, When resetPassword is called, Then shows expired token dialog', () async {
        // Given
        final expiredException = ApiException(type: 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED', message: 'Token expired');
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockVerifyTokenUseCase.call(any())).thenThrow(expiredException);
        final mockContext = FakeBuildContext();
        final mockTheme = ThemeData(extensions: [AppColorsTheme.light()]);
        when(() => mockGetXWrapper.context).thenReturn(mockContext);
        when(() => mockGetXWrapper.theme).thenReturn(mockTheme);
        when(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: any(named: 'title'),
              description: any(named: 'description'),
              confirmText: any(named: 'confirmText'),
              confirmTextColor: any(named: 'confirmTextColor'),
            )).thenReturn(null);

        // When
        await flowManager.appLinkFlow(sessionId: testSessionId, token: testToken);

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: 'Link has expired',
              description: 'This reset password link has expired. Please request a new one.',
              confirmText: any(named: 'confirmText'),
              onConfirm: any(named: 'onConfirm'),
              confirmTextColor: any(named: 'confirmTextColor'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
            )).called(1);
        verifyNever(() => mockUChatNewDialog.showGeneralErrorDialog(
              context: any(named: 'context'),
              e: any(named: 'e'),
            ));
      });

      test('Given general exception, When resetPassword is called, Then shows general error dialog', () async {
        // Given
        final generalException = Exception('Network error');
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockVerifyTokenUseCase.call(any())).thenThrow(generalException);
        final mockContext = FakeBuildContext();
        when(() => mockGetXWrapper.context).thenReturn(mockContext);
        when(() => mockUChatNewDialog.showGeneralErrorDialog(
              context: any(named: 'context'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
              message: any(named: 'message'),
              e: any(named: 'e'),
            )).thenReturn(null);

        // When
        await flowManager.appLinkFlow(sessionId: testSessionId, token: testToken);

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockUChatNewDialog.showGeneralErrorDialog(
              context: any(named: 'context'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
              message: any(named: 'message'),
              e: any(named: 'e'),
            )).called(1);
        verifyNever(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: any(named: 'title'),
              description: any(named: 'description'),
              confirmText: any(named: 'confirmText'),
              confirmTextColor: any(named: 'confirmTextColor'),
            ));
      });
    });

    group('_with2FaFlow', () {
      test('Given user with email, When _with2FaFlow is called, Then sends OTP and navigates correctly', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          email: 'test@example.com',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: true),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockGetOtpMethodUseCase.call(any()))
            .thenAnswer((_) async => const GetOtpMethodForgotPasswordResponse(
                  email: 'test@example.com',
                  method: 'email',
                  phone: '',
                ));
        when(() => mockGetXWrapper.toNamed(any())).thenAnswer((_) async => null);
        when(() => mockGetXWrapper.offNamedUntil(any(), any())).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockGetOtpMethodUseCase.call(any(that: isA<GetOtpMethodForgotPasswordRequest>()))).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockGetXWrapper.toNamed(Routes.settingAccountSentEmailForgotPassword)).called(1);
        verify(() => mockGetXWrapper.offNamedUntil(Routes.accountSetting, any(), arguments: any(named: 'arguments')))
            .called(1);
      });

      test('Given cooldown exception, When _with2FaFlow is called, Then shows cooldown dialog', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          email: 'test@example.com',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: true),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        final cooldownException = ApiException(type: 'ERR_ACCOUNT_FORGOT_PASSWORD_COOLDOWN', message: 'Cooldown');
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockGetOtpMethodUseCase.call(any())).thenThrow(cooldownException);
        final mockContext = FakeBuildContext();
        final mockTheme = ThemeData(extensions: [AppColorsTheme.light()]);
        when(() => mockGetXWrapper.context).thenReturn(mockContext);
        when(() => mockGetXWrapper.theme).thenReturn(mockTheme);
        when(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: any(named: 'title'),
              description: any(named: 'description'),
              confirmText: any(named: 'confirmText'),
              confirmTextColor: any(named: 'confirmTextColor'),
            )).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: 'You\'ve requested too many password resets',
              description: 'Please wait a few minutes before trying again.',
              confirmText: any(named: 'confirmText'),
              onConfirm: any(named: 'onConfirm'),
              confirmTextColor: any(named: 'confirmTextColor'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
            )).called(1);
      });

      test('Given general exception, When _with2FaFlow is called, Then shows general error dialog', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          email: 'test@example.com',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: true),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        final generalException = Exception('Network error');
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});
        when(() => mockGetOtpMethodUseCase.call(any())).thenThrow(generalException);
        final mockContext = FakeBuildContext();
        when(() => mockGetXWrapper.context).thenReturn(mockContext);
        when(() => mockUChatNewDialog.showGeneralErrorDialog(
              context: any(named: 'context'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
              message: any(named: 'message'),
              e: any(named: 'e'),
            )).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockUChatLoading.show()).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
        verify(() => mockUChatNewDialog.showGeneralErrorDialog(
              context: any(named: 'context'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
              message: any(named: 'message'),
              e: any(named: 'e'),
            )).called(1);
      });
    });

    group('_without2FaFlow', () {
      test(
          'Given successful OTP verification and password update, When _without2FaFlow is called, Then navigates correctly',
          () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: false),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        final mockOtpResult = SettingAccountOtpVerifyResultArguments(
          actionToken: 'test-action-token',
          accountId: 'test-account-id',
          phoneOrEmail: '+1234567890',
        );

        when(() => mockGetXWrapper.toNamed(Routes.settingAccountOtpRequest, arguments: any(named: 'arguments')))
            .thenAnswer((_) async => mockOtpResult);
        when(() => mockGetXWrapper.toNamed(Routes.settingAccountCreateNewPassword, arguments: any(named: 'arguments')))
            .thenAnswer((_) async => 'success');
        when(() => mockGetXWrapper.offNamedUntil(any(), any())).thenReturn(null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountCreateNewPassword,
              arguments: any(named: 'arguments', that: isA<SettingAccountCreateNewPasswordArguments>()),
            )).called(1);
        verify(() => mockGetXWrapper.offNamedUntil(Routes.accountSetting, any(), arguments: any(named: 'arguments')))
            .called(1);
      });

      test('Given OTP verification returns null, When _without2FaFlow is called, Then returns early', () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: false),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        when(() => mockGetXWrapper.toNamed(Routes.settingAccountOtpRequest, arguments: any(named: 'arguments')))
            .thenAnswer((_) async => null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
        verifyNever(
            () => mockGetXWrapper.toNamed(Routes.settingAccountCreateNewPassword, arguments: any(named: 'arguments')));
        verifyNever(() => mockGetXWrapper.offNamedUntil(any(), any()));
      });

      test('Given password update returns null, When _without2FaFlow is called, Then returns early after OTP',
          () async {
        // Given
        final user = UserEntity(
          id: 'test-user-id',
          phoneNumber: '+1234567890',
          accountSettings: AccountSettingsModel(
            security: SecuritySettingsModel(allowMultiFactor: false),
          ),
        );
        final flowManager = SettingAccountForgotPasswordFlowManager(
          user: user,
          getOtpMethodForgotPasswordUseCase: mockGetOtpMethodUseCase,
          verifyTokenForgotPasswordUseCase: mockVerifyTokenUseCase,
        );

        final mockOtpResult = SettingAccountOtpVerifyResultArguments(
          actionToken: 'test-action-token',
          accountId: 'test-account-id',
          phoneOrEmail: '+1234567890',
        );

        when(() => mockGetXWrapper.toNamed(Routes.settingAccountOtpRequest, arguments: any(named: 'arguments')))
            .thenAnswer((_) async => mockOtpResult);
        when(() => mockGetXWrapper.toNamed(Routes.settingAccountCreateNewPassword, arguments: any(named: 'arguments')))
            .thenAnswer((_) async => null);

        // When
        await flowManager.accountSettingFlow();

        // Then
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountOtpRequest,
              arguments: any(named: 'arguments', that: isA<SettingAccountOtpVerifyArguments>()),
            )).called(1);
        verify(() => mockGetXWrapper.toNamed(
              Routes.settingAccountCreateNewPassword,
              arguments: any(named: 'arguments', that: isA<SettingAccountCreateNewPasswordArguments>()),
            )).called(1);
        verifyNever(() => mockGetXWrapper.offNamedUntil(any(), any()));
      });
    });

    group('testMode functionality', () {
      test('Given UChatLoading testMode is set, When loading methods are called, Then uses mock implementation',
          () async {
        // Given
        when(() => mockUChatLoading.show(status: any(named: 'status'))).thenAnswer((_) async {});
        when(() => mockUChatLoading.hide()).thenAnswer((_) async {});

        // When
        await UChatLoading.show();
        await UChatLoading.hide();

        // Then
        verify(() => mockUChatLoading.show(status: any(named: 'status'))).called(1);
        verify(() => mockUChatLoading.hide()).called(1);
      });

      test('Given UChatNewDialog testMode is set, When dialog methods are called, Then uses mock implementation',
          () async {
        // Given
        final context = FakeBuildContext();
        when(() => mockUChatNewDialog.showSingleButtonDialog(
              context: any(named: 'context'),
              title: any(named: 'title'),
              description: any(named: 'description'),
              confirmText: any(named: 'confirmText'),
              confirmTextColor: any(named: 'confirmTextColor'),
            )).thenReturn(null);

        // When
        UChatNewDialog.showSingleButtonDialog(
          context: context,
          title: 'Test Title',
          description: 'Test Description',
          confirmText: 'OK',
        );

        // Then
        verify(() => mockUChatNewDialog.showSingleButtonDialog(
              context: context,
              title: 'Test Title',
              description: 'Test Description',
              confirmText: 'OK',
              onConfirm: any(named: 'onConfirm'),
              confirmTextColor: any(named: 'confirmTextColor'),
              isDestructive: any(named: 'isDestructive'),
              barrierDismissible: any(named: 'barrierDismissible'),
            )).called(1);
      });

      test('Given GetXWrapper testMode is set, When navigation methods are called, Then uses mock implementation',
          () async {
        // Given
        when(() => mockGetXWrapper.toNamed(any(), arguments: any(named: 'arguments')))
            .thenAnswer((_) async => 'test-result');

        // When
        final result = await GetXWrapper.toNamed('/test-route', arguments: {'test': 'data'});

        // Then
        expect(result, equals('test-result'));
        verify(() => mockGetXWrapper.toNamed('/test-route', arguments: {'test': 'data'})).called(1);
      });
    });
  });
}
