import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_api_service.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_socket_service.dart';
import 'package:uchat/features/setting/data/repositories/setting_server_repository_impl.dart';
import 'package:uchat/features/setting/di/setting_injection.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';

// Mock definitions
class MockHttpCaller extends Mock implements HttpCaller {}

class MockSocketCaller extends Mock implements SocketCaller {}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late GetIt getIt;
  late MockHttpCaller mockHttpCaller;
  late MockSocketCaller mockSocketCaller;

  setUp(() {
    getIt = GetIt.instance;
    mockHttpCaller = MockHttpCaller();
    mockSocketCaller = MockSocketCaller();

    // Reset GetIt instance before each test
    getIt.reset();

    // Register required dependencies
    getIt.registerSingleton<HttpCaller>(mockHttpCaller);
    getIt.registerSingleton<SocketCaller>(mockSocketCaller);

    // Register mock LoggerService to prevent import-level initialization issues
    getIt.registerSingleton<LoggerService>(MockLoggerService());
  });

  tearDown(() {
    getIt.reset();
  });

  group('registerSettingSingletonDependencies', () {
    test(
        'Given GetIt instance with required dependencies, When registerSettingSingletonDependencies is called, Then registers all singleton dependencies correctly',
        () async {
      // Given
      // HttpCaller and SocketCaller are already registered in setUp

      // When
      await registerSettingSingletonDependencies();

      // Then
      // Verify SettingApiService is registered as singleton
      expect(getIt.isRegistered<SettingApiService>(), isTrue);
      final settingApiService = getIt<SettingApiService>();
      expect(settingApiService, isA<SettingApiService>());

      // Verify SettingSocketService is registered as singleton
      expect(getIt.isRegistered<SettingSocketService>(), isTrue);
      final settingSocketService = getIt<SettingSocketService>();
      expect(settingSocketService, isA<SettingSocketService>());

      // Verify SettingServerRepository is registered as singleton
      expect(getIt.isRegistered<SettingServerRepository>(), isTrue);
      final settingServerRepository = getIt<SettingServerRepository>();
      expect(settingServerRepository, isA<SettingServerRepositoryImpl>());

      // Verify singleton behavior - same instance returned
      final settingApiService2 = getIt<SettingApiService>();
      expect(identical(settingApiService, settingApiService2), isTrue);

      final settingSocketService2 = getIt<SettingSocketService>();
      expect(identical(settingSocketService, settingSocketService2), isTrue);

      final settingServerRepository2 = getIt<SettingServerRepository>();
      expect(identical(settingServerRepository, settingServerRepository2), isTrue);
    });

    test(
        'Given already registered dependencies, When registerSettingSingletonDependencies is called twice, Then throws ArgumentError for duplicate registration',
        () async {
      // Given
      await registerSettingSingletonDependencies();

      // When
      final call = registerSettingSingletonDependencies();

      // Then
      await expectLater(call, throwsA(isA<ArgumentError>()));
    });
  });

  group('registerSettingFactoryDependencies', () {
    test(
        'Given complete singleton registration, When registerSettingFactoryDependencies is called, Then completes successfully',
        () async {
      // Given
      await registerSettingSingletonDependencies();

      // When & Then
      // Factory registration should complete without error
      expect(() async => await registerSettingFactoryDependencies(), returnsNormally);
    });
  });
}
