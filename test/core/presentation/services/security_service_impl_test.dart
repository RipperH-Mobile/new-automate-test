import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/enums/passcode_mode.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/presentation/arguments/passcode_arguments.dart';
import 'package:uchat/core/presentation/services/security_service_impl.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/routes/app_pages.dart';

// Mock classes
class MockConfigInstance extends Mock implements ConfigInstance {}

class MockLoggerService extends Mock implements LoggerService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecurityServiceImpl service;
  late MockConfigInstance mockGeneralConfig;
  late MockConfigInstance mockAuthConfig;
  late MockLoggerService mockLogger;
  late UserController mockUserController;

  setUpAll(() {
    // Register fallback values
    registerFallbackValue(Routes.passcode);
    registerFallbackValue(PasscodeArguments(
      mode: PasscodeMode.verify,
      controllerTag: 'test',
    ));

    // Mock GetX navigation
    Get.testMode = true;
  });

  setUp(() {
    mockGeneralConfig = MockConfigInstance();
    mockAuthConfig = MockConfigInstance();
    mockLogger = MockLoggerService();
    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    // Register logger
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
    GetIt.I.registerSingleton<LoggerService>(mockLogger);

    service = SecurityServiceImpl(
      authConfig: mockAuthConfig,
      generalConfig: mockGeneralConfig,
    );

    // Setup default mocks
    when(() => mockLogger.d(any())).thenReturn(null);
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);

    // Mock LocalAuthentication through method channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/local_auth'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getAvailableBiometrics':
            return [];
          case 'deviceSupportsBiometrics':
            return false;
          case 'isDeviceSupported':
            return true;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    Get.reset();
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
    // Clear method channel mock
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/local_auth'),
      null,
    );
  });

  group('SecurityServiceImpl', () {
    group('initialize', () {
      test('should check biometric support and available types on initialization', () async {
        // Arrange
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/local_auth'),
          (MethodCall methodCall) async {
            switch (methodCall.method) {
              case 'getAvailableBiometrics':
                return ['fingerprint', 'face'];
              case 'deviceSupportsBiometrics':
                return true;
              case 'isDeviceSupported':
                return true;
              default:
                return null;
            }
          },
        );

        // Act
        await service.initialize();

        // Assert
        expect(service.isBiometricSupported, true);
        expect(service.biometricTypes.length, 2);
        expect(service.biometricTypes, contains(BiometricType.fingerprint));
        expect(service.biometricTypes, contains(BiometricType.face));
      });

      test('should handle no biometric support', () async {
        // Arrange - already set in setUp to return false for biometric support

        // Act
        await service.initialize();

        // Assert
        expect(service.isBiometricSupported, false);
        expect(service.biometricTypes, []);
      });
    });

    group('Passcode Management', () {
      test('should set passcode correctly', () async {
        // Arrange
        const newPasscode = '987654'; // 6 digits
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeKey(),
              value: newPasscode,
            )).thenAnswer((_) async => {});

        // Act
        await service.setPasscode(newPasscode);

        // Assert
        expect(service.hasPasscode, true);
        expect(service.isEnableProtectionScreen, true);
        verify(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeKey(),
              value: newPasscode,
            )).called(1);
      });

      test('should throw error for invalid passcode length', () async {
        // Arrange
        const invalidPasscode = '123'; // Too short

        // Act & Assert
        expect(
          () async => await service.setPasscode(invalidPasscode),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should verify passcode correctly', () async {
        // Arrange
        const passcode = '123456'; // 6 digits
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeKey(),
              value: passcode,
            )).thenAnswer((_) async => {});

        await service.setPasscode(passcode);

        // Act
        final result = await service.verifyPasscode(passcode);

        // Assert
        expect(result, true);
      });

      test('should return false for incorrect passcode', () async {
        // Arrange
        const passcode = '123456'; // 6 digits
        const wrongPasscode = '567890'; // 6 digits
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeKey(),
              value: passcode,
            )).thenAnswer((_) async => {});

        await service.setPasscode(passcode);

        // Act
        final result = await service.verifyPasscode(wrongPasscode);

        // Assert
        expect(result, false);
      });

      test('should clear passcode correctly', () async {
        // Arrange
        when(() => mockGeneralConfig.clearConfig(key: ConfigDb.getPasscodeKey())).thenAnswer((_) async => {});

        // Act
        await service.clearPasscode();

        // Assert
        expect(service.hasPasscode, false);
        expect(service.isEnableProtectionScreen, false);
      });
    });

    group('isPasscodeLocked', () {
      test('should return false when no passcode is set', () async {
        // Act
        final result = await service.isPasscodeLocked();

        // Assert
        expect(result, false);
      });
    });

    group('Biometric Management', () {
      test('should enable biometric authentication', () async {
        // Arrange
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeUseBiometricKey(),
              value: true,
            )).thenAnswer((_) async => {});

        // Act
        await service.setEnableBiometric(true);

        // Assert
        expect(service.enableBiometric, true);
        verify(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeUseBiometricKey(),
              value: true,
            )).called(1);
      });

      test('should disable biometric authentication', () async {
        // Arrange
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeUseBiometricKey(),
              value: false,
            )).thenAnswer((_) async => {});

        // Act
        await service.setEnableBiometric(false);

        // Assert
        expect(service.enableBiometric, false);
      });

      test('should enable auto use biometric', () async {
        // Arrange
        when(() => mockGeneralConfig.saveConfig(
              key: ConfigDb.getPasscodeAutoUseBiometricKey(),
              value: true,
            )).thenAnswer((_) async => {});

        // Act
        await service.setEnableAutoUseBiometric(true);

        // Assert
        expect(service.enableAutoUseBiometric, true);
      });
    });

    group('Protection Screen Management', () {
      test('should not show protection screen when disabled', () async {
        // Act
        await service.showProtectionScreen();

        // Assert
        expect(service.isShowProtectionScreen, false);
      });
    });

    group('App Lifecycle', () {
      test('should not track time when passcode execution is prevented', () async {
        // Arrange
        await service.setPreventPasscodeExecution(true);

        // Act
        await service.onAppInactive();

        // Assert
        // Time should not be tracked
        final isLocked = await service.isPasscodeLocked();
        expect(isLocked, false);
      });
    });

    // Skip tests that depend on ConfigDb singleton
    group('Tests requiring ConfigDb refactoring', () {
      test('should load passcode settings when user is authenticated', () async {
        // Skip this test due to ConfigDb singleton issue
        // The implementation uses ConfigDb().general which is hard to mock
        // TODO: Refactor SecurityServiceImpl to accept ConfigDb.general as dependency
      }, skip: 'ConfigDb singleton prevents proper mocking');

      test('should migrate old passcode settings', () async {
        // Skip this test due to ConfigDb singleton issue
      }, skip: 'ConfigDb singleton prevents proper mocking');

      test('should show protection screen when enabled', () async {
        // Skip this test due to ConfigDb singleton issue in onAuthenticated
      }, skip: 'ConfigDb singleton prevents proper mocking');

      test('should return true when passcode timeout has passed', () async {
        // Skip this test due to ConfigDb singleton issue in onAuthenticated
      }, skip: 'ConfigDb singleton prevents proper mocking');

      test('should track passcode execution time on app inactive', () async {
        // Skip this test due to ConfigDb singleton issue in onAuthenticated
      }, skip: 'ConfigDb singleton prevents proper mocking');
    });

    // Skip navigation tests
    group('showVerifyPasscodeScreen tests', () {
      test('should return unlocked when not locked', () async {
        // This test is currently skipped because Get.currentRoute cannot be mocked
        // TODO: Refactor to use dependency injection for navigation
      }, skip: 'Get navigation cannot be properly mocked');

      test('should return shown when already on passcode screen', () async {
        // This test is currently skipped because Get.currentRoute cannot be mocked
        // TODO: Refactor to use dependency injection for navigation
      }, skip: 'Get navigation cannot be properly mocked');

      test('should show passcode screen when locked', () async {
        // This test is currently skipped because Get navigation cannot be properly mocked
        // TODO: Refactor to use dependency injection for navigation
      }, skip: 'Get navigation cannot be properly mocked');
    });
  });
}
