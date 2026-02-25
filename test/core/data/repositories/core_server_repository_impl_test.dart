import 'package:flutter_test/flutter_test.dart';

// Removed unused fpdart import
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/data/data_sources/common_service.dart';
import 'package:uchat/core/data/models/responses/get_enabled_country_list_response.dart';
import 'package:uchat/core/data/models/responses/get_public_config_response.dart';
import 'package:uchat/core/data/repositories/core_server_repository_impl.dart';
import 'package:uchat/core/domain/entities/enabled_country_list_entity.dart';
import 'package:uchat/core/domain/entities/public_config_entity.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart'; // Import LoggerService
import 'package:get_it/get_it.dart';

// Mocks
class MockCommonService extends Mock implements CommonService {}

class MockLoggerService extends Mock implements LoggerService {} // Add MockLoggerService
// No need to mock DTOs, we will instantiate them

// Fakes for Entities (if needed for complex verification, but likely not here)
// class FakeEnabledCountryListEntity extends Fake implements EnabledCountryListEntity {} // Keep if needed later
class FakePublicConfigEntity extends Fake implements PublicConfigEntity {}

void main() {
  late CoreServerRepositoryImpl repository;
  late MockCommonService mockCommonService;
  late MockLoggerService mockLoggerService; // Declare mock logger
  // DTO instances, not mocks
  late GetEnabledCountryListResponse testEnabledCountryListDTO;
  late GetPublicConfigResponse testPublicConfigDTO;
  late EnabledCountryListEntity testEnabledCountryListEntity;
  late PublicConfigEntity testPublicConfigEntity;

  // GetIt instance
  final sl = GetIt.instance;

  setUpAll(() {
    // Register mock logger before any tests run
    mockLoggerService = MockLoggerService();
    sl.registerSingleton<LoggerService>(mockLoggerService);

    // Register fallbacks if using any() with custom types (not strictly needed here yet)
    // registerFallbackValue(FakeEnabledCountryListEntity()); // Keep if needed later
    // registerFallbackValue(FakePublicConfigEntity());
  });

  setUp(() {
    // Instantiate mocks
    mockCommonService = MockCommonService();
    // mockLoggerService is already instantiated in setUpAll

    // Instantiate the repository (it will now pick up the registered mock logger)
    repository = CoreServerRepositoryImpl(commonService: mockCommonService);

    // Sample Entities for testing - Use correct parameters and remove const
    testEnabledCountryListEntity = EnabledCountryListEntity(
      countryEnabled: ['US', 'CA'], // Correct parameter name
    );
    testPublicConfigEntity = PublicConfigEntity(
      helpCenterId: 'help123', // Correct parameter name and sample value
      oaSystemAccountId: 'system123', // Correct parameter name and sample value
    );

    // Sample DTO instances
    testEnabledCountryListDTO = GetEnabledCountryListResponse(
      countryEnabled: ['US', 'CA'], // Assuming DTO has similar structure
    );
    testPublicConfigDTO = GetPublicConfigResponse(
      helpCenterId: 'help123', // Assuming DTO has similar structure
      oaSystemAccountId: 'system123', // Assuming DTO has similar structure
    );

    // Reset mocks before each test
    reset(mockCommonService);
    reset(mockLoggerService); // Reset logger mock interactions

    // No need to stub or reset DTO mocks
  });

  group('getEnabledCountry', () {
    test(
        'Given CommonService returns valid DTO, When getEnabledCountry is called, Then returns EnabledCountryListEntity',
        () async {
      // Given
      // Return the actual DTO instance
      when(() => mockCommonService.getInfo()).thenAnswer((_) async => testEnabledCountryListDTO);

      // When
      final result = await repository.getEnabledCountry();

      // Then
      expect(result, isA<EnabledCountryListEntity>());
      expect(result.countryEnabled, equals(testEnabledCountryListEntity.countryEnabled));
      verify(() => mockCommonService.getInfo()).called(1);

      // No need to verify toEntity on a mock DTO
      verifyNoMoreInteractions(mockCommonService);
    });

    test('Given CommonService returns null, When getEnabledCountry is called, Then returns NullResponseException',
        () async {
      // Given
      final exception = NullResponseException();
      when(() => mockCommonService.getInfo()).thenThrow(exception);

      // When & Then
      expect(
        () => repository.getEnabledCountry(),
        throwsA(equals(exception)),
      );
      verify(() => mockCommonService.getInfo()).called(1);
      // No need to verify toEntity on a mock DTO
      verifyNoMoreInteractions(mockCommonService);
    });

    test(
        'Given CommonService throws an exception, When getEnabledCountry is called, Then returns Exception handled by ExceptionHandler',
        () async {
      // Given
      // Use ApiException or another relevant exception type
      final testException = ApiException(message: 'Network Error');
      final handledException = ExceptionHandler.handle(testException); // Get the expected handled exception
      when(() => mockCommonService.getInfo()).thenThrow(testException);

      // When & Then
      expect(
        () => repository.getEnabledCountry(),
        throwsA(equals(handledException)),
      );
      verify(() => mockCommonService.getInfo()).called(1);
      // No need to verify toEntity on mock DTO
      verifyNoMoreInteractions(mockCommonService);
    });
  });

  group('getPublicConfig', () {
    test('Given CommonService returns valid DTO, When getPublicConfig is called, Then returns RPublicConfigEntity',
        () async {
      // Given
      // Return the actual DTO instance
      when(() => mockCommonService.getPublicConfig()).thenAnswer((_) async => testPublicConfigDTO);

      // When
      final result = await repository.getPublicConfig();

      // Then
      expect(result, isA<PublicConfigEntity>());
      expect(result.helpCenterId, equals(testPublicConfigEntity.helpCenterId));
      verify(() => mockCommonService.getPublicConfig()).called(1);
      // No need to verify toEntity on mock DTO
      verifyNoMoreInteractions(mockCommonService);
    });

    test('Given CommonService returns null, When getPublicConfig is called, Then returns NullResponseException',
        () async {
      // Given
      final exception = NullResponseException();
      when(() => mockCommonService.getPublicConfig()).thenThrow(exception);

      // When & Then
      expect(
        () => repository.getPublicConfig(),
        throwsA(equals(exception)),
      );
      verify(() => mockCommonService.getPublicConfig()).called(1);
      // No need to verify toEntity on mock DTO
      verifyNoMoreInteractions(mockCommonService);
    });

    test(
        'Given CommonService throws an exception, When getPublicConfig is called, Then returns Exception handled by ExceptionHandler',
        () async {
      // Given
      // Use ApiException or another relevant exception type
      final testException = ApiException(message: 'Config Fetch Error');
      final handledException = ExceptionHandler.handle(testException); // Get the expected handled exception
      when(() => mockCommonService.getPublicConfig()).thenThrow(testException);

      // When & Then
      expect(
        () => repository.getPublicConfig(),
        throwsA(equals(handledException)),
      );
      verify(() => mockCommonService.getPublicConfig()).called(1);
      // Remove incorrect verifyNever for mockPublicConfigDTO
      verifyNoMoreInteractions(mockCommonService);
    });
  });

  tearDownAll(() {
    // Unregister the mock logger after all tests run
    sl.unregister<LoggerService>();
  });
}
