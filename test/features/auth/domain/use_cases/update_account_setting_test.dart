import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/account/update_account_setting.dart';
import 'package:uchat/api/payloads/account/user_response.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_socket_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/qr_code_login_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/social_auth_api_service.dart';
import 'package:uchat/features/auth/data/repositories/auth_server_repository_impl.dart';
import 'package:uchat/entities/services/config_db.dart';

// Mock classes
class MockAccountService extends Mock implements AccountService {}

class MockSocketCaller extends Mock implements SocketCaller {}

class MockAuthSocketService extends Mock implements AuthSocketService {}

class MockAuthApiServiceNew extends Mock implements AuthApiServiceNew {}

class MockQrCodeLoginService extends Mock implements QrCodeLoginService {}

class MockConfigGeneral extends Mock implements ConfigInstance {}

class MockSocialAuthApiService extends Mock implements SocialAuthApiService {}

class MockLoggerService extends Mock implements LoggerService {} // Add MockLoggerService

// Fake classes for complex types
class FakeUpdateAccountSettingRequest extends Fake implements UpdateAccountSettingRequest {}

void main() {
  late AuthServerRepositoryImpl repository;
  late MockAccountService mockAccountService;
  late MockSocketCaller mockSocketCaller;
  late MockAuthSocketService mockAuthSocketService;
  late MockAuthApiServiceNew mockAuthApiServiceNew;
  late MockQrCodeLoginService mockQrCodeLoginService;
  late MockConfigGeneral mockConfigGeneral;
  late MockSocialAuthApiService mockSocialAuthApiService;

  late UpdateAccountSettingRequest testRequest;
  late UserResponse testUserResponse;
  late MockLoggerService mockLogger;
  // GetIt instance
  final sl = GetIt.instance;

  setUpAll(() {
    // Register mock logger before any tests run
    mockLogger = MockLoggerService();
    sl.registerSingleton<LoggerService>(mockLogger);

    registerFallbackValue(FakeUpdateAccountSettingRequest());
  });

  setUp(() {
    mockAccountService = MockAccountService();
    mockSocketCaller = MockSocketCaller();
    mockAuthSocketService = MockAuthSocketService();
    mockAuthApiServiceNew = MockAuthApiServiceNew();
    mockQrCodeLoginService = MockQrCodeLoginService();
    mockConfigGeneral = MockConfigGeneral();
    mockSocialAuthApiService = MockSocialAuthApiService();

    repository = AuthServerRepositoryImpl(
      accountService: mockAccountService,
      socketCaller: mockSocketCaller,
      authSocketService: mockAuthSocketService,
      authApiServiceNew: mockAuthApiServiceNew,
      qrCodeLoginService: mockQrCodeLoginService,
      configGeneral: mockConfigGeneral,
      socialAuthApiService: mockSocialAuthApiService,
    );

    // Create test data
    testRequest = UpdateAccountSettingRequest.create(
      profile: ProfileSettingsModel(
        enabled: true,
        hiddenPhoneNumber: false,
      ),
    );

    testUserResponse = UserResponse(
      id: 'test-user-id',
      username: 'testuser',
      displayName: 'Test User',
      email: 'test@example.com',
      statusMessage: 'Test Status',
    );
  });

  group('AuthServerRepository updateAccountSetting()', () {
    group('constructor', () {
      test('Given valid AccountService, When repository is created, Then initializes correctly', () {
        // Given
        final accountService = MockAccountService();
        final socketCaller = MockSocketCaller();
        final authSocketService = MockAuthSocketService();
        final authApiServiceNew = MockAuthApiServiceNew();
        final qrCodeLoginService = MockQrCodeLoginService();
        final configGeneral = MockConfigGeneral();

        repository = AuthServerRepositoryImpl(
          accountService: accountService,
          socketCaller: socketCaller,
          authSocketService: authSocketService,
          authApiServiceNew: authApiServiceNew,
          qrCodeLoginService: qrCodeLoginService,
          configGeneral: configGeneral,
          socialAuthApiService: mockSocialAuthApiService,
        );

        // Then
        expect(repository, isNotNull);
        expect(repository.accountService, equals(accountService));
      });
    });

    group('updateAccountSetting', () {
      test(
          'Given valid request and successful service response, When updateAccountSetting is called, Then returns UserResponse',
          () async {
        // Given
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(testRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(testRequest)).called(1);
      });

      test(
          'Given valid request but service returns null, When updateAccountSetting is called, Then throws NullResponseException',
          () async {
        // Given
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => null);

        // When/Then
        await expectLater(
          () => repository.updateAccountSetting(testRequest),
          throwsA(isA<NullResponseException>()),
        );
        verify(() => mockAccountService.updateAccountSetting(testRequest)).called(1);
      });

      test('Given service throws exception, When updateAccountSetting is called, Then rethrows the exception',
          () async {
        // Given
        final testException = Exception('Service error');
        when(() => mockAccountService.updateAccountSetting(any())).thenThrow(testException);

        // When/Then
        await expectLater(
          () => repository.updateAccountSetting(testRequest),
          throwsA(equals(testException)),
        );
        verify(() => mockAccountService.updateAccountSetting(testRequest)).called(1);
      });

      test(
          'Given request with profile settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final profileRequest = UpdateAccountSettingRequest.create(
          profile: ProfileSettingsModel(
            enabled: true,
            hiddenPhoneNumber: true,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(profileRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(profileRequest)).called(1);
      });

      test(
          'Given request with chat settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final chatRequest = UpdateAccountSettingRequest.create(
          chat: ChatSettingsModel(
            enabled: true,
            chatFolder: false,
            showCategory: true,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(chatRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(chatRequest)).called(1);
      });

      test(
          'Given request with notification settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final notificationRequest = UpdateAccountSettingRequest.create(
          notification: NotificationSettingsModel(
            enabled: true,
            hiddenMessage: false,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(notificationRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(notificationRequest)).called(1);
      });

      test(
          'Given request with security settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final securityRequest = UpdateAccountSettingRequest.create(
          security: SecuritySettingsModel(
            enabled: true,
            allowMultiFactor: false,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(securityRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(securityRequest)).called(1);
      });

      test(
          'Given request with friend settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final friendRequest = UpdateAccountSettingRequest.create(
          friend: FriendSettingsModel(
            enabled: true,
            canFriendSeeMyLastSeen: false,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(friendRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(friendRequest)).called(1);
      });

      test(
          'Given request with call settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final callRequest = UpdateAccountSettingRequest.create(
          call: CallSettingsModel(
            enabled: true,
            allowCallKit: true,
            allowIncomingCall: true,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(callRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(callRequest)).called(1);
      });

      test(
          'Given request with multiple settings, When updateAccountSetting is called, Then passes correct request to service',
          () async {
        // Given
        final multipleRequest = UpdateAccountSettingRequest.create(
          profile: ProfileSettingsModel(
            enabled: true,
            hiddenPhoneNumber: false,
          ),
          chat: ChatSettingsModel(
            enabled: true,
            chatFolder: true,
            showCategory: false,
          ),
          notification: NotificationSettingsModel(
            enabled: false,
            hiddenMessage: true,
          ),
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => testUserResponse);

        // When
        final result = await repository.updateAccountSetting(multipleRequest);

        // Then
        expect(result, equals(testUserResponse));
        verify(() => mockAccountService.updateAccountSetting(multipleRequest)).called(1);
      });

      test(
          'Given service returns UserResponse with different data, When updateAccountSetting is called, Then returns the actual response',
          () async {
        // Given
        final differentUserResponse = UserResponse(
          id: 'different-id',
          username: 'differentuser',
          displayName: 'Different User',
          email: 'different@example.com',
          statusMessage: 'Different Status',
        );
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => differentUserResponse);

        // When
        final result = await repository.updateAccountSetting(testRequest);

        // Then
        expect(result, equals(differentUserResponse));
        expect(result?.id, equals('different-id'));
        expect(result?.username, equals('differentuser'));
        expect(result?.displayName, equals('Different User'));
        verify(() => mockAccountService.updateAccountSetting(testRequest)).called(1);
      });

      test(
          'Given service call is made multiple times, When updateAccountSetting is called, Then each call is independent',
          () async {
        // Given
        final firstResponse = UserResponse(
          id: 'first-id',
          displayName: 'First User',
        );
        final secondResponse = UserResponse(
          id: 'second-id',
          displayName: 'Second User',
        );

        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => firstResponse);

        // When - First call
        final firstResult = await repository.updateAccountSetting(testRequest);

        // Then - First call
        expect(firstResult, equals(firstResponse));

        // Given - Second call setup
        when(() => mockAccountService.updateAccountSetting(any())).thenAnswer((_) async => secondResponse);

        // When - Second call
        final secondResult = await repository.updateAccountSetting(testRequest);

        // Then - Second call
        expect(secondResult, equals(secondResponse));
        verify(() => mockAccountService.updateAccountSetting(testRequest)).called(2);
      });
    });
  });
}
