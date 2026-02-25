import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart'; // Added for GetIt
import 'package:uchat/api/api.dart'; // For NullResponseException
import 'package:uchat/core/infrastructure/analytics/logger_service.dart'; // Added for LoggerService
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_socket_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/qr_code_login_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/social_auth_api_service.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart'; // Added
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart'; // Added
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/otp_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:uchat/features/auth/data/repositories/auth_server_repository_impl.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_required_response.dart'; // Added
// import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart'; // Ensure this is present
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

// Mock classes
class MockSocketCaller extends Mock implements SocketCaller {}

class MockAuthSocketService extends Mock implements AuthSocketService {}

class MockAuthApiServiceNew extends Mock implements AuthApiServiceNew {}

class MockAccountService extends Mock implements AccountService {}

class MockQrCodeLoginService extends Mock implements QrCodeLoginService {}

class MockConfigInstance extends Mock implements ConfigInstance {}

class MockSocialAuthApiService extends Mock implements SocialAuthApiService {}

class MockLoggerService extends Mock implements LoggerService {} // Added MockLoggerService

class FakeOtpGetSettingAccountRequest extends Fake implements GetOtpSettingAccountRequest {}

class FakeVerifyOtpTwoFaRequest extends Fake implements VerifyOtpSettingAccountRequest {}

class FakeValidateNewPasswordRequest extends Fake implements ValidateNewPasswordRequest {} // Added

class FakeUpdateNewPasswordRequest extends Fake implements UpdateNewPasswordRequest {} // Added

class FakeVerifyPasswordSettingAccountRequest extends Fake implements VerifyPasswordSettingAccountRequest {}

class FakeValidateNewEmailSettingAccountRequest extends Fake implements ValidateNewEmailSettingAccountRequest {}

class FakeUpdateEmailSettingAccountRequest extends Fake implements UpdateEmailSettingAccountRequest {}

class FakeGetOtpTwoFaRequest extends Fake implements GetOtpTwoFaLoginRequest {}

class FakeCheckUserExistWithPasswordRequest extends Fake implements CheckUserExistWithPasswordRequest {}

void main() {
  late AuthServerRepositoryImpl repository;
  late MockAuthApiServiceNew mockAuthApiServiceNew;
  // Mocks for other dependencies, not directly used by the methods under test but required by constructor
  late MockSocketCaller mockSocketCaller;
  late MockAuthSocketService mockAuthSocketService;
  late MockAccountService mockAccountService;
  late MockSocialAuthApiService socialAuthApiService;
  late MockQrCodeLoginService mockQrCodeLoginService;
  late MockConfigInstance mockConfigInstance;
  late MockLoggerService mockLoggerService; // Added mockLoggerService

  setUpAll(() {
    mockLoggerService = MockLoggerService(); // Initialize mockLoggerService
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService); // Register LoggerService
    registerFallbackValue(FakeOtpGetSettingAccountRequest());
    registerFallbackValue(FakeVerifyOtpTwoFaRequest());
    registerFallbackValue(FakeValidateNewPasswordRequest()); // Added
    registerFallbackValue(FakeUpdateNewPasswordRequest()); // Added
    registerFallbackValue(FakeVerifyPasswordSettingAccountRequest());
    registerFallbackValue(FakeValidateNewEmailSettingAccountRequest());
    registerFallbackValue(FakeUpdateEmailSettingAccountRequest());
    registerFallbackValue(FakeGetOtpTwoFaRequest());
    registerFallbackValue(FakeCheckUserExistWithPasswordRequest());
  });

  tearDownAll(() {
    GetIt.I.unregister<LoggerService>(); // Unregister LoggerService
  });

  setUp(() {
    mockSocketCaller = MockSocketCaller();
    mockAuthSocketService = MockAuthSocketService();
    mockAuthApiServiceNew = MockAuthApiServiceNew();
    mockAccountService = MockAccountService();
    socialAuthApiService = MockSocialAuthApiService();
    mockQrCodeLoginService = MockQrCodeLoginService();
    mockConfigInstance = MockConfigInstance();

    repository = AuthServerRepositoryImpl(
      socketCaller: mockSocketCaller,
      authSocketService: mockAuthSocketService,
      authApiServiceNew: mockAuthApiServiceNew,
      accountService: mockAccountService,
      qrCodeLoginService: mockQrCodeLoginService,
      configGeneral: mockConfigInstance,
      socialAuthApiService: socialAuthApiService,
    );
    reset(mockLoggerService); // Reset logger mock if needed, good practice
    // Stub isReadyForCall for mockSocketCaller
    when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
  });

  // Test data for getOtpTwoFa
  final tGetOtpTwoFaRequest = GetOtpSettingAccountRequest(
    phoneNumber: '1234567890',
    actionName: AuthenticationActionType.signin,
  );
  final tOtpResponse = OtpResponse(
    token: 'otp_token',
    ref: 'otp_ref',
    type: 'sms',
    actionToken: 'action_token_otp',
    firstGet: DateTime.now(),
    timeout: DateTime.now().add(const Duration(minutes: 5)),
  );
  final tOtpEntity = tOtpResponse.toEntity();

  // Test data for verifyOtpTwoFa
  final tVerifyOtpTwoFaRequest = VerifyOtpSettingAccountRequest(
    token: 'verify_token',
    otp: '123456',
    phoneNumber: '1234567890',
  );
  final tVerifyOtpResponse = VerifyOtpResponse(
    // Removed const
    actionToken: 'verified_action_token',
    actionName: 'TWO_FA_VERIFIED',
    accountId: 'account_id_123', // Added accountId for completeness
  );
  final tVerifyOtpEntity = tVerifyOtpResponse.toEntity();

  final tGenericException = Exception('Something went wrong');
  final tSocketApiExceptionNotFound = ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found');
  final tSocketApiExceptionOther = ApiException(type: 'OTHER_ERROR', message: 'Other socket error');

  // Test data for validateNewPassword and updateNewPassword
  final tValidateNewPasswordRequest = ValidateNewPasswordRequest(
    // Removed const
    newPassword: 'newPassword123!', // Removed actionToken
  );
  final tUpdateNewPasswordRequest = UpdateNewPasswordRequest(
    // Removed const
    actionToken: 'actionToken',
    newPassword: 'newPassword123!', // Removed confirmNewPassword
  );

  // Test data for checkPasswordRequired
  final tCheckPasswordRequiredResponse = CheckPasswordRequiredResponse(passwordRequired: true);
  final tCheckPasswordRequiredEntity = tCheckPasswordRequiredResponse.toEntity();

  // Test data for verifyPasswordSettingAccount
  final tVerifyPasswordRequest = VerifyPasswordSettingAccountRequest(password: 'password123');
  final tVerifyPasswordUnable2faResponse = VerifyPasswordSettingAccountUnable2faResponse(
    actionToken: 'unable_action_token',
    actionName: AuthenticationActionType.settingPassword, // Corrected enum
  );
  final tVerifyPasswordUnable2faEntity = tVerifyPasswordUnable2faResponse.toEntity();
  final tVerifyPasswordEnable2faResponse = VerifyPasswordSettingAccountEnable2faResponse(
    phoneNumber: '123456789',
    email: 'test@example.com',
  );
  final tVerifyPasswordEnable2faEntity = tVerifyPasswordEnable2faResponse.toEntity();

  // Test data for validateNewEmailSettingAccount
  final tValidateNewEmailRequest = ValidateNewEmailSettingAccountRequest(newEmail: 'new@example.com');

  // Test data for updateEmailSettingAccount
  final tUpdateNewEmailRequest = UpdateEmailSettingAccountRequest(
    actionToken: 'email_action_token',
    newEmail: 'new@example.com',
  );

  final tGetOtpTwoFaLoginRequest = GetOtpTwoFaLoginRequest(
    phoneOrEmail: '1234567890',
    isPhoneNumber: true,
    isEmail: false,
  );

  // Test data for checkPassword - corrected to match actual response structure
  final tCheckPasswordRequest = CheckUserExistWithPasswordRequest(
    phoneOrEmail: 'test@example.com',
    password: 'password123',
  );

  final tUserCollection = UserCollection(
    id: 'user_id',
    username: 'Test User',
    // Add other required UserCollection properties as needed
  );

  final tCheckPasswordUnableResponse = CheckPasswordResponseUnableTwoFa(
    token: 'unable_token',
    account: tUserCollection,
  );
  final tCheckPasswordUnableEntity = tCheckPasswordUnableResponse.toEntity();

  final tCheckPasswordEnableResponse = CheckPasswordResponseEnableTwoFa(
    phoneNumber: '123456789',
    email: 'test@example.com',
  );
  final tCheckPasswordEnableEntity = tCheckPasswordEnableResponse.toEntity();

  group('checkPassword', () {
    test(
        'Given AuthApiServiceNew.checkPassword returns CheckPasswordResponseUnableTwoFa, When repository.checkPassword is called, Then returns CheckPasswordUnableTwoFaEntity',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.checkPassword(any())).thenAnswer((_) async => tCheckPasswordUnableResponse);

      // When
      final result = await repository.checkPassword(tCheckPasswordRequest);

      // Then
      expect(result, isA<CheckPasswordEntityUnableTwoFa>());
      final entity = result as CheckPasswordEntityUnableTwoFa;
      expect(entity.token, tCheckPasswordUnableEntity.token);
      expect(entity.account?.id, tCheckPasswordUnableEntity.account?.id);
      verify(() => mockAuthApiServiceNew.checkPassword(tCheckPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.checkPassword returns CheckPasswordResponseEnableTwoFa, When repository.checkPassword is called, Then returns CheckPasswordEnableTwoFaEntity',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.checkPassword(any())).thenAnswer((_) async => tCheckPasswordEnableResponse);

      // When
      final result = await repository.checkPassword(tCheckPasswordRequest);

      // Then
      expect(result, isA<CheckPasswordEntityEnableTwoFa>());
      final entity = result as CheckPasswordEntityEnableTwoFa;
      expect(entity.phoneNumber, tCheckPasswordEnableEntity.phoneNumber);
      expect(entity.email, tCheckPasswordEnableEntity.email);
      verify(() => mockAuthApiServiceNew.checkPassword(tCheckPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.checkPassword returns null, When repository.checkPassword is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.checkPassword(any())).thenAnswer((_) async => null);

      // When
      final call = repository.checkPassword(tCheckPasswordRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.checkPassword(tCheckPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.checkPassword throws an exception, When repository.checkPassword is called, Then throws the same exception',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.checkPassword(any())).thenThrow(tGenericException);

      // When
      final call = repository.checkPassword(tCheckPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.checkPassword(tCheckPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });

  group('getOtpTwoFa', () {
    // HTTP Path Tests (implicitly when socket isReadyForCall is false or socket fails and falls back)
    // To explicitly test HTTP path when socket is ready but fails, we'd set isReadyForCall to true and make socket fail.
    // The existing tests cover cases where HTTP is the primary/fallback path.

    test(
        'Given AuthApiServiceNew.getOtpTwoFa returns valid OtpResponse (HTTP path), When repository.getOtpTwoFa is called, Then returns OtpEntity',
        () async {
      // Given
      // Explicitly testing HTTP path by making socket not ready
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.getOtpSettingAccount(any())).thenAnswer((_) async => tOtpResponse);

      // When
      final result = await repository.getOtpSettingAccount(tGetOtpTwoFaRequest);

      // Then
      expect(result, isA<OtpEntity>());
      expect(result.token, tOtpEntity.token);
      expect(result.ref, tOtpEntity.ref);
      verify(() => mockAuthApiServiceNew.getOtpSettingAccount(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.getOtpTwoFa returns null (HTTP path), When repository.getOtpTwoFa is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.getOtpSettingAccount(any())).thenAnswer((_) async => null);

      // When
      final call = repository.getOtpSettingAccount(tGetOtpTwoFaRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.getOtpSettingAccount(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.getOtpTwoFa throws an exception (HTTP path), When repository.getOtpTwoFa is called, Then throws the same exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.getOtpSettingAccount(any())).thenThrow(tGenericException);

      // When
      final call = repository.getOtpSettingAccount(tGetOtpTwoFaRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.getOtpSettingAccount(tGetOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    // Socket Path Tests

    test(
        'Given AuthSocketService.getOtpTwoFa returns null (Socket path fallback to HTTP), When repository.getOtpTwoFa is called, Then returns OtpEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthApiServiceNew.getOtpSettingAccount(any()))
          .thenAnswer((_) async => tOtpResponse); // HTTP fallback

      // When
      final result = await repository.getOtpSettingAccount(tGetOtpTwoFaRequest);

      // Then
      expect(result, isA<OtpEntity>());
      expect(result.token, tOtpEntity.token);
      verify(() => mockAuthApiServiceNew.getOtpSettingAccount(tGetOtpTwoFaRequest)).called(1); // Verify HTTP fallback
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });

  group('verifyOtpTwoFa', () {
    // HTTP Path Tests
    test(
        'Given AuthApiServiceNew.verifyOtpTwoFa returns valid VerifyOtpResponse (HTTP path), When repository.verifyOtpTwoFa is called, Then returns VerifyOtpEntity',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any())).thenAnswer((_) async => tVerifyOtpResponse);

      // When
      final result = await repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      expect(result, isA<VerifyOtpEntity>());
      expect(result.actionToken, tVerifyOtpEntity.actionToken);
      expect(result.actionName, tVerifyOtpEntity.actionName);
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyOtpTwoFa(any()));
    });

    test(
        'Given AuthApiServiceNew.verifyOtpTwoFa returns null (HTTP path), When repository.verifyOtpTwoFa is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false); // Moved here
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any())).thenAnswer((_) async => null);

      // When
      final call = repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyOtpTwoFa(any()));
    });

    test(
        'Given AuthApiServiceNew.verifyOtpTwoFa throws an exception (HTTP path), When repository.verifyOtpTwoFa is called, Then throws the same exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false); // Moved here
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any())).thenThrow(tGenericException);

      // When
      final call = repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyOtpTwoFa(any()));
    });

    // Socket Path Tests
    test(
        'Given AuthSocketService.verifyOtpTwoFa returns valid VerifyOtpResponse (Socket path), When repository.verifyOtpTwoFa is called, Then returns VerifyOtpEntity',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyOtpTwoFa(any())).thenAnswer((_) async => tVerifyOtpResponse);

      // When
      final result = await repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      expect(result, isA<VerifyOtpEntity>());
      expect(result.actionToken, tVerifyOtpEntity.actionToken);
      verify(() => mockAuthSocketService.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyOtpTwoFa(any()));
    });

    test(
        'Given AuthSocketService.verifyOtpTwoFa returns null (Socket path fallback to HTTP), When repository.verifyOtpTwoFa is called, Then returns VerifyOtpEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyOtpTwoFa(any())).thenAnswer((_) async => null);
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any()))
          .thenAnswer((_) async => tVerifyOtpResponse); // HTTP fallback

      // When
      final result = await repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      expect(result, isA<VerifyOtpEntity>());
      expect(result.actionToken, tVerifyOtpEntity.actionToken);
      verify(() => mockAuthSocketService.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1); // Verify HTTP fallback
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthSocketService.verifyOtpTwoFa throws SERVICE_NOT_FOUND ApiException (Socket path fallback to HTTP), When repository.verifyOtpTwoFa is called, Then returns VerifyOtpEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyOtpTwoFa(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any()))
          .thenAnswer((_) async => tVerifyOtpResponse); // HTTP fallback

      // When
      final result = await repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      expect(result, isA<VerifyOtpEntity>());
      expect(result.actionToken, tVerifyOtpEntity.actionToken);
      verify(() => mockAuthSocketService.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1); // Verify HTTP fallback
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthSocketService.verifyOtpTwoFa throws other ApiException (Socket path), When repository.verifyOtpTwoFa is called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyOtpTwoFa(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyOtpTwoFa(any()));
    });

    test(
        'Given AuthSocketService.verifyOtpTwoFa throws generic exception (Socket path fallback to HTTP), When repository.verifyOtpTwoFa is called, Then returns VerifyOtpEntity from HTTP and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyOtpTwoFa(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.verifyOtpTwoFa(any()))
          .thenAnswer((_) async => tVerifyOtpResponse); // HTTP fallback
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {}); // Stub logger

      // When
      final result = await repository.verifyOtpTwoFa(tVerifyOtpTwoFaRequest);

      // Then
      expect(result, isA<VerifyOtpEntity>());
      expect(result.actionToken, tVerifyOtpEntity.actionToken);
      verify(() => mockAuthSocketService.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1);
      verify(() => mockAuthApiServiceNew.verifyOtpTwoFa(tVerifyOtpTwoFaRequest)).called(1); // Verify HTTP fallback
      verify(() => mockLoggerService.w(
            'verifyOtpTwoFa with socket error. fallback to http request...',
            tGenericException,
            any(), // Corrected: Use any() for positional arg
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });

  group('validateNewPassword', () {
    test(
        'Given AuthSocketService.validateNewPassword completes, When repository.validateNewPassword is called, Then completes normally (Socket path)',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewPassword(any())).thenAnswer((_) async {});

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.validateNewPassword(any()));
    });

    test(
        'Given AuthSocketService.validateNewPassword throws SERVICE_NOT_FOUND (Socket fallback to HTTP), When repository.validateNewPassword is called, Then HTTP service is called and completes',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewPassword(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.validateNewPassword(any())).thenAnswer((_) async {}); // HTTP fallback success

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthSocketService.validateNewPassword throws other ApiException (Socket path), When repository.validateNewPassword is called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewPassword(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.validateNewPassword(any()));
    });

    test(
        'Given AuthSocketService.validateNewPassword throws generic exception (Socket fallback to HTTP), When repository.validateNewPassword is called, Then HTTP service is called, completes and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewPassword(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.validateNewPassword(any())).thenAnswer((_) async {}); // HTTP fallback success
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verify(() => mockLoggerService.w(
            'validateNewPassword with socket error. fallback to http request...',
            // Incorrect log message from source
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.validateNewPassword completes (HTTP path), When repository.validateNewPassword is called, Then completes normally',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.validateNewPassword(any())).thenAnswer((_) async {});

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.validateNewPassword(any()));
    });

    test(
        'Given AuthApiServiceNew.validateNewPassword throws exception (HTTP path), When repository.validateNewPassword is called, Then throws exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.validateNewPassword(any())).thenThrow(tGenericException);

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.validateNewPassword(any()));
    });
    test(
        'Given AuthSocketService.validateNewPassword throws SERVICE_NOT_FOUND and HTTP throws exception, When repository.validateNewPassword is called, Then throws HTTP exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewPassword(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.validateNewPassword(any())).thenThrow(tGenericException); // HTTP fallback fails

      // When
      final call = repository.validateNewPassword(tValidateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthSocketService.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.validateNewPassword(tValidateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });

  group('updateNewPassword', () {
    test(
        'Given AuthSocketService.updateNewPassword completes, When repository.updateNewPassword is called, Then completes normally (Socket path)',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateNewPassword(any())).thenAnswer((_) async {});

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.updateNewPassword(any()));
    });

    test(
        'Given AuthSocketService.updateNewPassword throws SERVICE_NOT_FOUND (Socket fallback to HTTP), When repository.updateNewPassword is called, Then HTTP service is called and completes',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateNewPassword(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.updateNewPassword(any())).thenAnswer((_) async {}); // HTTP fallback success

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthSocketService.updateNewPassword throws other ApiException (Socket path), When repository.updateNewPassword is called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateNewPassword(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.updateNewPassword(any()));
    });

    test(
        'Given AuthSocketService.updateNewPassword throws generic exception (Socket fallback to HTTP), When repository.updateNewPassword is called, Then HTTP service is called, completes and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateNewPassword(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.updateNewPassword(any())).thenAnswer((_) async {}); // HTTP fallback success
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verify(() => mockLoggerService.w(
            'updateNewPassword with socket error. fallback to http request...', // Incorrect log message from source
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.updateNewPassword completes (HTTP path), When repository.updateNewPassword is called, Then completes normally',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.updateNewPassword(any())).thenAnswer((_) async {});

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.updateNewPassword(any()));
    });

    test(
        'Given AuthApiServiceNew.updateNewPassword throws exception (HTTP path), When repository.updateNewPassword is called, Then throws exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.updateNewPassword(any())).thenThrow(tGenericException);

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.updateNewPassword(any()));
    });
    test(
        'Given AuthSocketService.updateNewPassword throws SERVICE_NOT_FOUND and HTTP throws exception, When repository.updateNewPassword is called, Then throws HTTP exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateNewPassword(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.updateNewPassword(any())).thenThrow(tGenericException); // HTTP fallback fails

      // When
      final call = repository.updateNewPassword(tUpdateNewPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthSocketService.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });

  group('checkPasswordRequired', () {
    test(
        'Given socket is ready and AuthSocketService returns valid response, When checkPasswordRequired is called, Then returns CheckPasswordRequiredEntity from socket',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenAnswer((_) async => tCheckPasswordRequiredResponse);

      // When
      final result = await repository.checkPasswordRequired();

      // Then
      expect(result.passwordRequired, tCheckPasswordRequiredEntity.passwordRequired);
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.checkPasswordRequired());
    });

    test(
        'Given socket is ready and AuthSocketService returns null, When checkPasswordRequired is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenAnswer((_) async => null);

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.checkPasswordRequired());
    });

    test(
        'Given socket is ready and AuthSocketService throws ApiException (not SERVICE_NOT_FOUND), When checkPasswordRequired is called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.checkPasswordRequired());
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException, When checkPasswordRequired is called, Then falls back to HTTP and HTTP returns valid response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.checkPasswordRequired())
          .thenAnswer((_) async => tCheckPasswordRequiredResponse); // HTTP fallback success

      // When
      final result = await repository.checkPasswordRequired();

      // Then
      expect(result.passwordRequired, tCheckPasswordRequiredEntity.passwordRequired);
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException and HTTP returns null, When checkPasswordRequired is called, Then throws NullResponseException from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.checkPasswordRequired())
          .thenAnswer((_) async => null); // HTTP fallback returns null

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException and HTTP throws exception, When checkPasswordRequired is called, Then throws exception from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.checkPasswordRequired()).thenThrow(tGenericException); // HTTP fallback throws

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception, When checkPasswordRequired is called, Then falls back to HTTP, HTTP returns valid response, and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.checkPasswordRequired())
          .thenAnswer((_) async => tCheckPasswordRequiredResponse); // HTTP fallback success
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final result = await repository.checkPasswordRequired();

      // Then
      expect(result.passwordRequired, tCheckPasswordRequiredEntity.passwordRequired);
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verify(() => mockLoggerService.w(
            'checkPasswordRequired with socket error. fallback to http request...',
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception and HTTP returns null, When checkPasswordRequired is called, Then throws NullResponseException from HTTP and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.checkPasswordRequired())
          .thenAnswer((_) async => null); // HTTP fallback returns null
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verify(() => mockLoggerService.w(
            'checkPasswordRequired with socket error. fallback to http request...',
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception and HTTP throws other exception, When checkPasswordRequired is called, Then throws other exception from HTTP and logs warning',
        () async {
      // Given
      final httpException = Exception('HTTP Path Exception');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.checkPasswordRequired()).thenThrow(tGenericException); // Socket throws
      when(() => mockAuthApiServiceNew.checkPasswordRequired()).thenThrow(httpException); // HTTP fallback also throws
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(equals(httpException))); // Should throw the HTTP exception
      verify(() => mockAuthSocketService.checkPasswordRequired()).called(1);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verify(() => mockLoggerService.w(
            'checkPasswordRequired with socket error. fallback to http request...',
            tGenericException, // Logged with the original socket exception
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    // HTTP Path Tests (Socket Not Ready)
    test(
        'Given socket is NOT ready and AuthApiServiceNew returns valid response, When checkPasswordRequired is called, Then returns CheckPasswordRequiredEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.checkPasswordRequired()).thenAnswer((_) async => tCheckPasswordRequiredResponse);

      // When
      final result = await repository.checkPasswordRequired();

      // Then
      expect(result.passwordRequired, tCheckPasswordRequiredEntity.passwordRequired);
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.checkPasswordRequired());
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew returns null, When checkPasswordRequired is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.checkPasswordRequired()).thenAnswer((_) async => null);

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.checkPasswordRequired());
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew throws Exception, When checkPasswordRequired is called, Then throws Exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.checkPasswordRequired()).thenThrow(tGenericException);

      // When
      final call = repository.checkPasswordRequired();

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.checkPasswordRequired()).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.checkPasswordRequired());
    });
  });

  group('verifyPasswordSettingAccount', () {
    test(
        'Given socket is ready and AuthSocketService returns Unable2faResponse, When verifyPasswordSettingAccount is called, Then returns Unable2faEntity from socket',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordUnable2faResponse);

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountUnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountUnable2faEntity;
      expect(entity.actionToken, tVerifyPasswordUnable2faEntity.actionToken);
      expect(entity.actionName, tVerifyPasswordUnable2faEntity.actionName);
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService returns Enable2faResponse, When verifyPasswordSettingAccount is called, Then returns Enable2faEntity from socket',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordEnable2faResponse);

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountEnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountEnable2faEntity;
      expect(entity.phoneNumber, tVerifyPasswordEnable2faEntity.phoneNumber);
      expect(entity.email, tVerifyPasswordEnable2faEntity.email);
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService returns null, When verifyPasswordSettingAccount is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any())).thenAnswer((_) async => null);

      // When
      final call = repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws ApiException (not SERVICE_NOT_FOUND), When verifyPasswordSettingAccount is called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException, When verifyPasswordSettingAccount is called, Then falls back to HTTP and HTTP returns Unable2faResponse',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordUnable2faResponse); // HTTP fallback

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountUnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountUnable2faEntity;
      expect(entity.actionToken, tVerifyPasswordUnable2faEntity.actionToken);
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception (not NullResponseException), When verifyPasswordSettingAccount is called, Then falls back to HTTP, HTTP returns Enable2faResponse, and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordEnable2faResponse); // HTTP fallback
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountEnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountEnable2faEntity;
      expect(entity.email, tVerifyPasswordEnable2faEntity.email);
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verify(() => mockLoggerService.w(
            'checkPasswordRequired with socket error. fallback to http request...',
            // This log message is from the source code
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws NullResponseException, When verifyPasswordSettingAccount is called, Then rethrows NullResponseException',
        () async {
      // Given
      final nullResponseException = NullResponseException();
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.verifyPasswordSettingAccount(any())).thenThrow(nullResponseException);

      // When
      final call = repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthSocketService.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()));
    });

    // HTTP Path Tests
    test(
        'Given socket is NOT ready and AuthApiServiceNew returns Unable2faResponse, When verifyPasswordSettingAccount is called, Then returns Unable2faEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordUnable2faResponse);

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountUnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountUnable2faEntity;
      expect(entity.actionToken, tVerifyPasswordUnable2faEntity.actionToken);
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew returns Enable2faResponse, When verifyPasswordSettingAccount is called, Then returns Enable2faEntity from HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any()))
          .thenAnswer((_) async => tVerifyPasswordEnable2faResponse);

      // When
      final result = await repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      expect(result, isA<VerifyPasswordSettingAccountEnable2faEntity>());
      final entity = result as VerifyPasswordSettingAccountEnable2faEntity;
      expect(entity.email, tVerifyPasswordEnable2faEntity.email);
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew returns null, When verifyPasswordSettingAccount is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any())).thenAnswer((_) async => null);

      // When
      final call = repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyPasswordSettingAccount(any()));
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew throws Exception, When verifyPasswordSettingAccount is called, Then throws Exception',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(any())).thenThrow(tGenericException);

      // When
      final call = repository.verifyPasswordSettingAccount(tVerifyPasswordRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.verifyPasswordSettingAccount(tVerifyPasswordRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.verifyPasswordSettingAccount(any()));
    });
  });

  group('validateNewEmailSettingAccount', () {
    test(
        'Given socket is ready and AuthSocketService.validateNewEmailSettingAccount completes, When called, Then completes normally',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewEmailSettingAccount(any())).thenAnswer((_) async {});

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws ApiException (not SERVICE_NOT_FOUND), When called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewEmailSettingAccount(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException, When called, Then falls back to HTTP and HTTP completes',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewEmailSettingAccount(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any())).thenAnswer((_) async {}); // HTTP fallback

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verify(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception, When called, Then falls back to HTTP, HTTP completes, and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.validateNewEmailSettingAccount(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any())).thenAnswer((_) async {}); // HTTP fallback
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verify(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verify(() => mockLoggerService.w(
            'validateNewEmailSettingAccount with socket error. fallback to http request...',
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    // HTTP Path Tests
    test(
        'Given socket is NOT ready and AuthApiServiceNew.validateNewEmailSettingAccount completes, When called, Then completes normally via HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any())).thenAnswer((_) async {});

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.validateNewEmailSettingAccount(any()));
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew throws Exception, When called, Then throws Exception via HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(any())).thenThrow(tGenericException);

      // When
      final call = repository.validateNewEmailSettingAccount(tValidateNewEmailRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.validateNewEmailSettingAccount(tValidateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.validateNewEmailSettingAccount(any()));
    });
  });

  group('updateEmailSettingAccount', () {
    test(
        'Given socket is ready and AuthSocketService.updateEmailSettingAccount completes, When called, Then completes normally',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateEmailSettingAccount(any())).thenAnswer((_) async {});

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.updateEmailSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws ApiException (not SERVICE_NOT_FOUND), When called, Then rethrows ApiException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateEmailSettingAccount(any())).thenThrow(tSocketApiExceptionOther);

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, throwsA(equals(tSocketApiExceptionOther)));
      verify(() => mockAuthSocketService.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNever(() => mockAuthApiServiceNew.updateEmailSettingAccount(any()));
    });

    test(
        'Given socket is ready and AuthSocketService throws SERVICE_NOT_FOUND ApiException, When called, Then falls back to HTTP and HTTP completes',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateEmailSettingAccount(any())).thenThrow(tSocketApiExceptionNotFound);
      when(() => mockAuthApiServiceNew.updateEmailSettingAccount(any())).thenAnswer((_) async {}); // HTTP fallback

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verify(() => mockAuthApiServiceNew.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given socket is ready and AuthSocketService throws generic Exception, When called, Then falls back to HTTP, HTTP completes, and logs warning',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockAuthSocketService.updateEmailSettingAccount(any())).thenThrow(tGenericException);
      when(() => mockAuthApiServiceNew.updateEmailSettingAccount(any())).thenAnswer((_) async {}); // HTTP fallback
      when(() => mockLoggerService.w(any(), any(), any())).thenAnswer((_) {});

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthSocketService.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verify(() => mockAuthApiServiceNew.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verify(() => mockLoggerService.w(
            'updateEmailSettingAccount with socket error. fallback to http request...',
            tGenericException,
            any(),
          )).called(1);
      verifyNoMoreInteractions(mockAuthSocketService);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    // HTTP Path Tests
    test(
        'Given socket is NOT ready and AuthApiServiceNew.updateEmailSettingAccount completes, When called, Then completes normally via HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.updateEmailSettingAccount(any())).thenAnswer((_) async {});

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.updateEmailSettingAccount(any()));
    });

    test(
        'Given socket is NOT ready and AuthApiServiceNew throws Exception, When called, Then throws Exception via HTTP',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockAuthApiServiceNew.updateEmailSettingAccount(any())).thenThrow(tGenericException);

      // When
      final call = repository.updateEmailSettingAccount(tUpdateNewEmailRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.updateEmailSettingAccount(tUpdateNewEmailRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
      verifyNever(() => mockAuthSocketService.updateEmailSettingAccount(any()));
    });
  });

  group('getOtpTwoFaLogin', () {
    test(
        'Given AuthApiServiceNew.getOtpTwoFaLogin returns valid OtpResponse, When repository.getOtpTwoFaLogin is called, Then returns OtpEntity',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.getOtpTwoFaLogin(any())).thenAnswer((_) async => tOtpResponse);

      // When
      final result = await repository.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest);

      // Then
      expect(result, isA<OtpEntity>());
      expect(result.token, tOtpEntity.token);
      expect(result.ref, tOtpEntity.ref);
      verify(() => mockAuthApiServiceNew.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.getOtpTwoFaLogin returns null, When repository.getOtpTwoFaLogin is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.getOtpTwoFaLogin(any())).thenAnswer((_) async => null);

      // When
      final call = repository.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest);

      // Then
      await expectLater(call, throwsA(isA<NullResponseException>()));
      verify(() => mockAuthApiServiceNew.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });

    test(
        'Given AuthApiServiceNew.getOtpTwoFaLogin throws an exception, When repository.getOtpTwoFaLogin is called, Then throws the same exception',
        () async {
      // Given
      when(() => mockAuthApiServiceNew.getOtpTwoFaLogin(any())).thenThrow(tGenericException);

      // When
      final call = repository.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest);

      // Then
      await expectLater(call, throwsA(equals(tGenericException)));
      verify(() => mockAuthApiServiceNew.getOtpTwoFaLogin(tGetOtpTwoFaLoginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthApiServiceNew);
    });
  });
}
