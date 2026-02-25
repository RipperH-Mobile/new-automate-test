import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_socket_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/data/repositories/emoji_server_repository_impl.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';

// Mock Definitions
class MockSocketCaller extends Mock implements SocketCaller {}

class MockEmojiApiService extends Mock implements EmojiApiService {}

class MockEmojiSocketService extends Mock implements EmojiSocketService {}

class MockLoggerService extends Mock implements LoggerService {}

// Fake classes for fallback values
class FakeGetEmojiPackagesRequest extends Fake implements GetEmojiPackagesRequest {}

class FakeGetEmojiPackageItemsRequest extends Fake implements GetEmojiPackageItemsRequest {}

class FakeUpdateDefaultEmojiRequest extends Fake implements UpdateDefaultEmojiRequest {}

void main() {
  late EmojiServerRepositoryImpl repository;
  late MockSocketCaller mockSocketCaller;
  late MockEmojiApiService mockEmojiApiService;
  late MockEmojiSocketService mockEmojiSocketService;
  late MockLoggerService mockLoggerService;

  // Test data
  late GetEmojiPackagesRequest tGetEmojiPackagesRequest;
  late GetEmojiPackageItemsRequest tGetEmojiPackageItemsRequest;
  late UpdateDefaultEmojiRequest tUpdateDefaultEmojiRequest;
  late PaginationPayload<EmojiPackageEntity> tEmojiPackageResponseEntity;
  late PaginationPayload<EmojiPackageWithItemsEntity> tEmojiPackageWithItemsResponseEntity;
  late UpdateDefaultEmojiEntity tUpdateDefaultEmojiEntity;

  setUpAll(() {
    registerFallbackValue(FakeGetEmojiPackagesRequest());
    registerFallbackValue(FakeGetEmojiPackageItemsRequest());
    registerFallbackValue(FakeUpdateDefaultEmojiRequest());
  });

  setUp(() {
    mockSocketCaller = MockSocketCaller();
    mockEmojiApiService = MockEmojiApiService();
    mockEmojiSocketService = MockEmojiSocketService();
    mockLoggerService = MockLoggerService();
    repository = EmojiServerRepositoryImpl(
      socketCaller: mockSocketCaller,
      emojiApiService: mockEmojiApiService,
      emojiSocketService: mockEmojiSocketService,
      log: mockLoggerService,
    );

    // Initialize test data
    tGetEmojiPackagesRequest = GetEmojiPackagesRequest(page: 1, pageSize: 10);
    tGetEmojiPackageItemsRequest = GetEmojiPackageItemsRequest(emojiPackageId: 'package123');
    tUpdateDefaultEmojiRequest = UpdateDefaultEmojiRequest(defaultEmojiItems: ['emoji1', 'emoji2']);

    tEmojiPackageResponseEntity = PaginationPayload<EmojiPackageEntity>(
      data: [],
      total: 0,
      page: 1,
      pageSize: 10,
      totalPages: 1,
    );

    tEmojiPackageWithItemsResponseEntity = PaginationPayload<EmojiPackageWithItemsEntity>(
      data: [],
      total: 0,
      page: 1,
      pageSize: 10,
      totalPages: 1,
    );

    tUpdateDefaultEmojiEntity = UpdateDefaultEmojiEntity(
      accountDefaultEmojiItems: [],
    );

    // Reset mocks before each test
    reset(mockSocketCaller);
    reset(mockEmojiApiService);
    reset(mockEmojiSocketService);
    reset(mockLoggerService);
  });

  group('getEmojiPackagesItems', () {
    test(
        'Given socket is ready and socket service returns data, When getEmojiPackagesItems is called, Then returns socket response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => tEmojiPackageWithItemsResponseEntity);

      // When
      final result = await repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(result, equals(tEmojiPackageWithItemsResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verifyNever(() => mockEmojiApiService.getEmojiPackagesItems(any()));
    });

    test('Given socket is not ready, When getEmojiPackagesItems is called, Then uses API service and returns response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => tEmojiPackageWithItemsResponseEntity);

      // When
      final result = await repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(result, equals(tEmojiPackageWithItemsResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verifyNever(() => mockEmojiSocketService.getEmojiPackagesItems(any()));
    });

    test(
        'Given socket is ready but socket service returns null, When getEmojiPackagesItems is called, Then falls back to HTTP and returns HTTP response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => null);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => tEmojiPackageWithItemsResponseEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(result, equals(tEmojiPackageWithItemsResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackagesItems with socket error. fallback to http request...',
            any(that: isA<NullResponseException>()),
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws exception, When getEmojiPackagesItems is called, Then falls back to API service',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => tEmojiPackageWithItemsResponseEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(result, equals(tEmojiPackageWithItemsResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackagesItems with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test('Given API service returns null, When getEmojiPackagesItems is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenAnswer((_) async => null);

      // When
      final call = repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
    });

    test(
        'Given socket service throws and API service returns null, When getEmojiPackagesItems is called, Then throws NullResponseException',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenAnswer((_) async => null);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final call = repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackagesItems with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws ApiException with SERVICE_NOT_FOUND, When getEmojiPackagesItems is called, Then falls back to API service',
        () async {
      // Given
      final apiException = ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenThrow(apiException);
      when(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest))
          .thenAnswer((_) async => tEmojiPackageWithItemsResponseEntity);

      // When
      final result = await repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(result, equals(tEmojiPackageWithItemsResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
    });

    test(
        'Given socket is ready but socket service throws ApiException with different type, When getEmojiPackagesItems is called, Then rethrows exception',
        () async {
      // Given
      final apiException = ApiException(type: 'INVALID_REQUEST', message: 'Invalid request');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).thenThrow(apiException);

      // When
      final call = repository.getEmojiPackagesItems(tGetEmojiPackageItemsRequest);

      // Then
      expect(call, throwsA(equals(apiException)));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackagesItems(tGetEmojiPackageItemsRequest)).called(1);
      verifyNever(() => mockEmojiApiService.getEmojiPackagesItems(any()));
    });
  });

  group('getEmojiPackages', () {
    test(
        'Given socket is ready and socket service returns data, When getEmojiPackages is called, Then returns socket response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest))
          .thenAnswer((_) async => tEmojiPackageResponseEntity);

      // When
      final result = await repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(result, equals(tEmojiPackageResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verifyNever(() => mockEmojiApiService.getEmojiPackages(any()));
    });

    test('Given socket is not ready, When getEmojiPackages is called, Then uses API service and returns response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest))
          .thenAnswer((_) async => tEmojiPackageResponseEntity);

      // When
      final result = await repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(result, equals(tEmojiPackageResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verifyNever(() => mockEmojiSocketService.getEmojiPackages(any()));
    });

    test(
        'Given socket is ready but socket service returns null, When getEmojiPackages is called, Then falls back to HTTP and returns HTTP response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).thenAnswer((_) async => null);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest))
          .thenAnswer((_) async => tEmojiPackageResponseEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(result, equals(tEmojiPackageResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackages with socket error. fallback to http request...',
            any(that: isA<NullResponseException>()),
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws exception, When getEmojiPackages is called, Then falls back to API service',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest))
          .thenAnswer((_) async => tEmojiPackageResponseEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(result, equals(tEmojiPackageResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackages with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test('Given API service returns null, When getEmojiPackages is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).thenAnswer((_) async => null);

      // When
      final call = repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
    });

    test(
        'Given socket service throws and API service returns null, When getEmojiPackages is called, Then throws NullResponseException',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).thenAnswer((_) async => null);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final call = repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockLoggerService.w(
            'getEmojiPackages with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws ApiException with SERVICE_NOT_FOUND, When getEmojiPackages is called, Then falls back to API service',
        () async {
      // Given
      final apiException = ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).thenThrow(apiException);
      when(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest))
          .thenAnswer((_) async => tEmojiPackageResponseEntity);

      // When
      final result = await repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(result, equals(tEmojiPackageResponseEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verify(() => mockEmojiApiService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
    });

    test(
        'Given socket is ready but socket service throws ApiException with different type, When getEmojiPackages is called, Then rethrows exception',
        () async {
      // Given
      final apiException = ApiException(type: 'INVALID_REQUEST', message: 'Invalid request');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).thenThrow(apiException);

      // When
      final call = repository.getEmojiPackages(tGetEmojiPackagesRequest);

      // Then
      expect(call, throwsA(equals(apiException)));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.getEmojiPackages(tGetEmojiPackagesRequest)).called(1);
      verifyNever(() => mockEmojiApiService.getEmojiPackages(any()));
    });
  });

  group('updateDefaultEmoji', () {
    test(
        'Given socket is ready and socket service returns data, When updateDefaultEmoji is called, Then returns socket response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest))
          .thenAnswer((_) async => tUpdateDefaultEmojiEntity);

      // When
      final result = await repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(result, equals(tUpdateDefaultEmojiEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verifyNever(() => mockEmojiApiService.setDefaultEmoji(any()));
    });

    test('Given socket is not ready, When updateDefaultEmoji is called, Then uses API service and returns response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest))
          .thenAnswer((_) async => tUpdateDefaultEmojiEntity);

      // When
      final result = await repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(result, equals(tUpdateDefaultEmojiEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verifyNever(() => mockEmojiSocketService.setDefaultEmoji(any()));
    });

    test(
        'Given socket is ready but socket service returns null, When updateDefaultEmoji is called, Then falls back to HTTP and returns HTTP response',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenAnswer((_) async => null);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest))
          .thenAnswer((_) async => tUpdateDefaultEmojiEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(result, equals(tUpdateDefaultEmojiEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockLoggerService.w(
            'setDefaultEmoji with socket error. fallback to http request...',
            any(that: isA<NullResponseException>()),
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws exception, When updateDefaultEmoji is called, Then falls back to API service',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest))
          .thenAnswer((_) async => tUpdateDefaultEmojiEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(result, equals(tUpdateDefaultEmojiEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockLoggerService.w(
            'setDefaultEmoji with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test('Given API service returns null, When updateDefaultEmoji is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenAnswer((_) async => null);

      // When
      final call = repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
    });

    test(
        'Given socket service throws and API service returns null, When updateDefaultEmoji is called, Then throws NullResponseException',
        () async {
      // Given
      final testException = Exception('Socket error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenThrow(testException);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenAnswer((_) async => null);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final call = repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockLoggerService.w(
            'setDefaultEmoji with socket error. fallback to http request...',
            testException,
            any(),
          )).called(1);
    });

    test(
        'Given socket is ready but socket service throws ApiException with SERVICE_NOT_FOUND, When updateDefaultEmoji is called, Then falls back to API service',
        () async {
      // Given
      final apiException = ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenThrow(apiException);
      when(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest))
          .thenAnswer((_) async => tUpdateDefaultEmojiEntity);

      // When
      final result = await repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(result, equals(tUpdateDefaultEmojiEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verify(() => mockEmojiApiService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
    });

    test(
        'Given socket is ready but socket service throws ApiException with different type, When updateDefaultEmoji is called, Then rethrows exception',
        () async {
      // Given
      final apiException = ApiException(type: 'INVALID_REQUEST', message: 'Invalid request');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).thenThrow(apiException);

      // When
      final call = repository.updateDefaultEmoji(tUpdateDefaultEmojiRequest);

      // Then
      expect(call, throwsA(equals(apiException)));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockEmojiSocketService.setDefaultEmoji(tUpdateDefaultEmojiRequest)).called(1);
      verifyNever(() => mockEmojiApiService.setDefaultEmoji(any()));
    });
  });

  group('constructor', () {
    test('Given valid dependencies, When EmojiServerRepositoryImpl is instantiated, Then creates instance successfully',
        () {
      // Given
      final socketCaller = MockSocketCaller();
      final apiService = MockEmojiApiService();
      final socketService = MockEmojiSocketService();
      final loggerService = MockLoggerService();

      // When
      final repository = EmojiServerRepositoryImpl(
        socketCaller: socketCaller,
        emojiApiService: apiService,
        emojiSocketService: socketService,
        log: loggerService,
      );

      // Then
      expect(repository, isNotNull);
      expect(repository.socketCaller, equals(socketCaller));
      expect(repository.emojiApiService, equals(apiService));
      expect(repository.emojiSocketService, equals(socketService));
      expect(repository.log, equals(loggerService));
    });
  });
}
