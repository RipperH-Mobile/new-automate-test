import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/core/data/data_sources/models/payloads/app_version/check_app_version.dart';
import 'package:uchat/core/data/data_sources/remote/app_version_http_data_source.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

// Mock classes
class MockHttpCaller extends Mock implements HttpCaller {}

class MockMetaService extends Mock implements MetaService {}

class MockResponse<T> extends Mock implements Response<T> {}

class MockLoggerService extends Mock implements LoggerService {}

// Fake class for registerFallbackValue
class FakeCheckAppVersionRequest extends Fake implements CheckAppVersionRequest {}

void main() {
  late AppVersionHttpDataSource dataSource;
  late MockHttpCaller mockHttpCaller;
  late MockMetaService mockMetaService;
  late MockLoggerService mockLogger;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeCheckAppVersionRequest());

    // Register mock logger service
    mockLogger = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLogger);
  });

  tearDownAll(() {
    // Reset GetIt instance
    GetIt.I.reset();
  });

  setUp(() {
    mockHttpCaller = MockHttpCaller();
    mockMetaService = MockMetaService();

    // Setup logger mock
    when(() => mockLogger.d(any())).thenReturn(null);

    dataSource = AppVersionHttpDataSource(
      httpCaller: mockHttpCaller,
      metaService: mockMetaService,
    );
  });

  group('AppVersionHttpDataSource with Mocktail', () {
    group('checkAppVersion', () {
      test('should return CheckAppVersionResponse when API call is successful', () async {
        // Arrange
        const currentVersion = '1.0.0';
        const platform = 'ios';

        when(() => mockMetaService.appVersion).thenReturn(currentVersion);
        when(() => mockMetaService.deviceOs).thenReturn(platform);
        when(() => mockMetaService.deviceType).thenReturn(platform.toUpperCase());

        final expectedRequest = CheckAppVersionRequest(
          appName: 'UCHAT_MESSENGER',
          osName: platform.toUpperCase(),
          version: currentVersion,
        );

        final mockResponseData = {
          'appName': 'UCHAT_MESSENGER',
          'osName': platform.toUpperCase(),
          'version': '2.0.0',
          'isForceUpdate': true,
        };

        final mockResponse = _createMockResponse(mockResponseData);

        when(() => mockHttpCaller.post(
              any(),
              data: expectedRequest.toMap(),
            )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.checkAppVersion();

        // Assert
        expect(result, isA<CheckAppVersionResponse>());
        expect(result?.version, '2.0.0');
        expect(result?.isForceUpdate, true);

        verify(() => mockHttpCaller.post(
              any(),
              data: expectedRequest.toMap(),
            )).called(1);
      });

      test('should handle 404 error from API', () async {
        // Arrange
        const currentVersion = '1.0.0';
        const platform = 'android';

        when(() => mockMetaService.appVersion).thenReturn(currentVersion);
        when(() => mockMetaService.deviceOs).thenReturn(platform);
        when(() => mockMetaService.deviceType).thenReturn(platform.toUpperCase());

        when(() => mockHttpCaller.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(ApiException(code: 404, message: 'Not found'));

        // Act & Assert
        expect(
          () => dataSource.checkAppVersion(),
          throwsA(isA<ApiException>().having((e) => e.code, 'code', 404)),
        );
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const currentVersion = '1.0.0';
        const platform = 'ios';

        when(() => mockMetaService.appVersion).thenReturn(currentVersion);
        when(() => mockMetaService.deviceOs).thenReturn(platform);
        when(() => mockMetaService.deviceType).thenReturn(platform.toUpperCase());

        when(() => mockHttpCaller.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => dataSource.checkAppVersion(),
          throwsException,
        );
      });

      test('should send correct request parameters for different platforms', () async {
        // Test for Android
        const androidVersion = '1.2.3';
        const androidPlatform = 'android';

        when(() => mockMetaService.appVersion).thenReturn(androidVersion);
        when(() => mockMetaService.deviceOs).thenReturn(androidPlatform);
        when(() => mockMetaService.deviceType).thenReturn(androidPlatform.toUpperCase());

        final androidRequest = CheckAppVersionRequest(
          appName: 'UCHAT_MESSENGER',
          osName: androidPlatform.toUpperCase(),
          version: androidVersion,
        );

        final mockResponseData = {
          'appName': 'UCHAT_MESSENGER',
          'osName': androidPlatform.toUpperCase(),
          'version': androidVersion,
        };

        final mockResponse = _createMockResponse(mockResponseData);

        when(() => mockHttpCaller.post(
              any(),
              data: androidRequest.toMap(),
            )).thenAnswer((_) async => mockResponse);

        // Act
        await dataSource.checkAppVersion();

        // Assert
        verify(() => mockHttpCaller.post(
              any(),
              data: androidRequest.toMap(),
            )).called(1);

        // Reset mocks
        reset(mockHttpCaller);
        reset(mockMetaService);

        // Reset logger mock
        when(() => mockLogger.d(any())).thenReturn(null);

        // Test for iOS
        const iosVersion = '2.1.0';
        const iosPlatform = 'ios';

        when(() => mockMetaService.appVersion).thenReturn(iosVersion);
        when(() => mockMetaService.deviceOs).thenReturn(iosPlatform);
        when(() => mockMetaService.deviceType).thenReturn(iosPlatform.toUpperCase());

        final iosRequest = CheckAppVersionRequest(
          appName: 'UCHAT_MESSENGER',
          osName: iosPlatform.toUpperCase(),
          version: iosVersion,
        );

        final iosResponseData = {
          'appName': 'UCHAT_MESSENGER',
          'osName': iosPlatform.toUpperCase(),
          'version': iosVersion,
        };

        final iosResponse = _createMockResponse(iosResponseData);

        when(() => mockHttpCaller.post(
              any(),
              data: iosRequest.toMap(),
            )).thenAnswer((_) async => iosResponse);

        // Act
        await dataSource.checkAppVersion();

        // Assert
        verify(() => mockHttpCaller.post(
              any(),
              data: iosRequest.toMap(),
            )).called(1);
      });

      test('should handle response with missing isForceUpdate', () async {
        // Arrange
        const currentVersion = '1.0.0';
        const platform = 'ios';

        when(() => mockMetaService.appVersion).thenReturn(currentVersion);
        when(() => mockMetaService.deviceOs).thenReturn(platform);
        when(() => mockMetaService.deviceType).thenReturn(platform.toUpperCase());

        // Response with missing isForceUpdate field
        final mockResponseData = {
          'appName': 'UCHAT_MESSENGER',
          'osName': platform.toUpperCase(),
          'version': '2.0.0',
          // isForceUpdate is missing
        };

        final mockResponse = _createMockResponse(mockResponseData);

        when(() => mockHttpCaller.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.checkAppVersion();

        // Assert
        expect(result, isA<CheckAppVersionResponse>());
        expect(result?.version, '2.0.0');
        expect(result?.isForceUpdate, null); // Should be null when missing
      });
    });
  });
}

// Helper function to create mock response
Response _createMockResponse(Map<String, dynamic> data) {
  final mockResponse = MockResponse();
  when(() => mockResponse.data).thenReturn({'data': data});
  return mockResponse;
}
