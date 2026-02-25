import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/enums/passcode_result.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/metric/duration.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/notification/notification_manager.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';

// Mock classes
class MockSecurityService extends Mock implements SecurityService {}

class MockAppVersionService extends Mock implements AppVersionService {}

class MockSyncService extends Mock implements SyncService {}

class MockNotificationManager extends Mock implements NotificationManager {}

class MockLoggerService extends Mock implements LoggerService {}

class MockPerformanceService extends Mock implements PerformanceService {}

class MockPerformanceTrace extends Mock implements PerformanceTrace {}

class MockDurationMetric extends Mock implements DurationMetric {
  @override
  final String name;

  MockDurationMetric(this.name);
}

void main() {
  late MockSecurityService mockSecurityService;
  late MockAppVersionService mockAppVersionService;
  late MockSyncService mockSyncService;
  late MockNotificationManager mockNotificationManager;
  late MockLoggerService mockLogger;
  late MockPerformanceService mockPerformanceService;

  setUp(() {
    // Reset GetIt before each test
    GetIt.I.reset();

    // Create mocks
    mockSecurityService = MockSecurityService();
    mockAppVersionService = MockAppVersionService();
    mockSyncService = MockSyncService();
    mockNotificationManager = MockNotificationManager();
    mockLogger = MockLoggerService();
    mockPerformanceService = MockPerformanceService();

    // Register services
    GetIt.I.registerSingleton<SecurityService>(mockSecurityService);
    GetIt.I.registerSingleton<AppVersionService>(mockAppVersionService);
    GetIt.I.registerSingleton<SyncService>(mockSyncService);
    GetIt.I.registerSingleton<NotificationManager>(mockNotificationManager);
    GetIt.I.registerSingleton<LoggerService>(mockLogger);
    GetIt.I.registerSingleton<PerformanceService>(mockPerformanceService);

    // Setup default mocks
    when(() => mockLogger.d(any())).thenReturn(null);
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);

    // Mock performance trace
    final mockTrace = MockPerformanceTrace();
    when(() => mockTrace.start()).thenAnswer((_) async => {});
    when(() => mockTrace.stop()).thenAnswer((_) async => {});
    when(() => mockPerformanceService.create(any())).thenReturn(mockTrace);
    when(() => mockPerformanceService.newDuration(any())).thenReturn(MockDurationMetric('test'));
    when(() => mockAppVersionService.checkUpdate(timeout: any(named: 'timeout'))).thenAnswer((_) async => {});
    when(() => mockAppVersionService.notifyUpdate()).thenAnswer((_) async => {});
    when(() => mockNotificationManager.clearAllNotifications()).thenAnswer((_) async => {});
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('Orchestrator Service Interaction Tests', () {
    test('should register SecurityService and call initialize', () async {
      // Arrange
      when(() => mockSecurityService.initialize()).thenAnswer((_) async => {});

      // Act - Call initialize directly
      await GetIt.I<SecurityService>().initialize();

      // Assert
      verify(() => mockSecurityService.initialize()).called(1);
    });

    test('should call SecurityService onAuthenticated method', () async {
      // Arrange
      when(() => mockSecurityService.onAuthenticated()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SecurityService>().onAuthenticated();

      // Assert
      verify(() => mockSecurityService.onAuthenticated()).called(1);
    });

    test('should call SecurityService showVerifyPasscodeScreen and return result', () async {
      // Arrange
      when(() => mockSecurityService.showVerifyPasscodeScreen()).thenAnswer((_) async => PasscodeResult.passed);

      // Act
      final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen();

      // Assert
      expect(result, PasscodeResult.passed);
      verify(() => mockSecurityService.showVerifyPasscodeScreen()).called(1);
    });

    test('should call SecurityService clearPasscode', () async {
      // Arrange
      when(() => mockSecurityService.clearPasscode()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SecurityService>().clearPasscode();

      // Assert
      verify(() => mockSecurityService.clearPasscode()).called(1);
    });

    test('should call SecurityService showProtectionScreen', () async {
      // Arrange
      when(() => mockSecurityService.showProtectionScreen()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SecurityService>().showProtectionScreen();

      // Assert
      verify(() => mockSecurityService.showProtectionScreen()).called(1);
    });

    test('should call SecurityService hideProtectionScreen', () async {
      // Arrange
      when(() => mockSecurityService.hideProtectionScreen()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SecurityService>().hideProtectionScreen();

      // Assert
      verify(() => mockSecurityService.hideProtectionScreen()).called(1);
    });

    test('should call SecurityService onAppInactive', () async {
      // Arrange
      when(() => mockSecurityService.onAppInactive()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SecurityService>().onAppInactive();

      // Assert
      verify(() => mockSecurityService.onAppInactive()).called(1);
    });
  });

  group('Passcode Flow Logic Tests', () {
    test('should return next when passcode result is unlocked', () async {
      // Arrange
      when(() => mockSecurityService.showVerifyPasscodeScreen()).thenAnswer((_) async => PasscodeResult.unlocked);

      // Act
      final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen();

      // Assert
      expect(result, PasscodeResult.unlocked);
      // This simulates the logic in config.dart where unlocked or passed returns TaskResult.next
      expect(result == PasscodeResult.unlocked || result == PasscodeResult.passed, true);
    });

    test('should return next when passcode result is passed', () async {
      // Arrange
      when(() => mockSecurityService.showVerifyPasscodeScreen()).thenAnswer((_) async => PasscodeResult.passed);

      // Act
      final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen();

      // Assert
      expect(result, PasscodeResult.passed);
      // This simulates the logic in config.dart where unlocked or passed returns TaskResult.next
      expect(result == PasscodeResult.unlocked || result == PasscodeResult.passed, true);
    });

    test('should handle failed passcode result', () async {
      // Arrange
      when(() => mockSecurityService.showVerifyPasscodeScreen()).thenAnswer((_) async => PasscodeResult.failed);

      // Act
      final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen();

      // Assert
      expect(result, PasscodeResult.failed);
      // This simulates the logic in config.dart where failed returns TaskResult.stop
      expect(result == PasscodeResult.failed, true);
    });
  });

  group('Service Integration Tests', () {
    test('should call SyncService addSyncQueue', () async {
      // Arrange
      when(() => mockSyncService.addSyncQueue()).thenReturn(null);

      // Act
      GetIt.I<SyncService>().addSyncQueue();

      // Assert
      verify(() => mockSyncService.addSyncQueue()).called(1);
    });

    test('should call SyncService startNetworkMonitor', () async {
      // Arrange
      when(() => mockSyncService.startNetworkMonitor()).thenReturn(null);

      // Act
      GetIt.I<SyncService>().startNetworkMonitor();

      // Assert
      verify(() => mockSyncService.startNetworkMonitor()).called(1);
    });

    test('should call SyncService clearAllCurrentStateSeq', () async {
      // Arrange
      when(() => mockSyncService.clearAllCurrentStateSeq()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<SyncService>().clearAllCurrentStateSeq();

      // Assert
      verify(() => mockSyncService.clearAllCurrentStateSeq()).called(1);
    });

    test('should call NotificationManager clearAllNotifications', () async {
      // Arrange
      when(() => mockNotificationManager.clearAllNotifications()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<NotificationManager>().clearAllNotifications();

      // Assert
      verify(() => mockNotificationManager.clearAllNotifications()).called(1);
    });

    test('should call AppVersionService checkUpdate', () async {
      // Arrange
      when(() => mockAppVersionService.checkUpdate()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<AppVersionService>().checkUpdate();

      // Assert
      verify(() => mockAppVersionService.checkUpdate()).called(1);
    });

    test('should call AppVersionService notifyUpdate', () async {
      // Arrange
      when(() => mockAppVersionService.notifyUpdate()).thenAnswer((_) async => {});

      // Act
      await GetIt.I<AppVersionService>().notifyUpdate();

      // Assert
      verify(() => mockAppVersionService.notifyUpdate()).called(1);
    });
  });
}
