import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/data/repositories/pin_message_server_repository_impl.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';

// Mock Definitions
class MockSocketCaller extends Mock implements SocketCaller {}

class MockChatRoomApiService extends Mock implements ChatRoomApiService {}

class MockChatRoomSocketService extends Mock implements ChatRoomSocketService {}

class MockLoggerService extends Mock implements LoggerService {}

// Fake classes for fallback values
class FakePinMessageRequest extends Fake implements PinMessageRequest {}

class FakeUnpinMessageRequest extends Fake implements UnpinMessageRequest {}

class FakeUnpinAllMessagesRequest extends Fake implements UnpinAllMessagesRequest {}

class FakeGetPinMessagesRequest extends Fake implements GetPinMessagesRequest {}

class FakePinMessageCollection extends Fake implements PinMessageCollection {}

void main() {
  late PinMessageServerRepositoryImpl repository;
  late MockSocketCaller mockSocketCaller;
  late MockChatRoomApiService mockChatRoomApiService;
  late MockChatRoomSocketService mockChatRoomSocketService;
  late MockLoggerService mockLoggerService;

  setUpAll(() {
    registerFallbackValue(FakePinMessageRequest());
    registerFallbackValue(FakeUnpinMessageRequest());
    registerFallbackValue(FakeUnpinAllMessagesRequest());
    registerFallbackValue(FakeGetPinMessagesRequest());
    registerFallbackValue(FakePinMessageCollection());
  });

  setUp(() {
    mockSocketCaller = MockSocketCaller();
    mockChatRoomApiService = MockChatRoomApiService();
    mockChatRoomSocketService = MockChatRoomSocketService();
    mockLoggerService = MockLoggerService();

    // Register LoggerService with GetIt for the repository
    if (GetIt.instance.isRegistered<LoggerService>()) {
      GetIt.instance.unregister<LoggerService>();
    }
    GetIt.instance.registerSingleton<LoggerService>(mockLoggerService);

    repository = PinMessageServerRepositoryImpl(
      socketCaller: mockSocketCaller,
      chatRoomApiService: mockChatRoomApiService,
      chatRoomSocketService: mockChatRoomSocketService,
    );
  });

  tearDown(() {
    reset(mockSocketCaller);
    reset(mockChatRoomApiService);
    reset(mockChatRoomSocketService);
    reset(mockLoggerService);

    // Clean up GetIt
    if (GetIt.instance.isRegistered<LoggerService>()) {
      GetIt.instance.unregister<LoggerService>();
    }
  });

  group('PinMessageServerRepositoryImpl', () {
    group('pinMessage', () {
      final tRequest = PinMessageRequest(
        messageId: 'test-message-id',
        roomId: 'test-room-id',
      );

      final tPinMessageCollection = PinMessageCollection()
        ..id = 'test-pin-id'
        ..ref = 'test-ref'
        ..pinnedBy = 'test-user-id'
        ..roomId = 'test-room-id'
        ..parentId = null
        ..createdAt = null
        ..message = null;

      group('when socket is available', () {
        test('should return PinMessageEntity when socket call succeeds', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.pinMessage(any())).thenAnswer((_) async => tPinMessageCollection);

          // When
          final result = await repository.pinMessage(tRequest);

          // Then
          expect(result, isA<PinMessageEntity>());
          verify(() => mockChatRoomSocketService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.pinMessage(any()));
        });

        test('should fallback to API when socket throws ApiException with SERVICE_NOT_FOUND', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.pinMessage(any()))
              .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
          when(() => mockChatRoomApiService.pinMessage(any())).thenAnswer((_) async => tPinMessageCollection);

          // When
          final result = await repository.pinMessage(tRequest);

          // Then
          expect(result, isA<PinMessageEntity>());
          verify(() => mockChatRoomSocketService.pinMessage(tRequest)).called(1);
          verify(() => mockChatRoomApiService.pinMessage(tRequest)).called(1);
        });

        test('should throw exception when socket throws other ApiException', () async {
          // Given
          final apiException = ApiException(type: 'OTHER_ERROR', message: 'Other error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.pinMessage(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.pinMessage(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomSocketService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.pinMessage(any()));
        });

        test('should throw AppException when socket returns null', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.pinMessage(any())).thenAnswer((_) async => null);

          // When & Then
          expect(
            () => repository.pinMessage(tRequest),
            throwsA(isA<AppException>()),
          );
          verify(() => mockChatRoomSocketService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.pinMessage(any()));
        });
      });

      group('when socket is not available', () {
        test('should use API service when socket is not ready', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.pinMessage(any())).thenAnswer((_) async => tPinMessageCollection);

          // When
          final result = await repository.pinMessage(tRequest);

          // Then
          expect(result, isA<PinMessageEntity>());
          verify(() => mockChatRoomApiService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.pinMessage(any()));
        });

        test('should throw exception when API service throws exception', () async {
          // Given
          final apiException = ApiException(type: 'API_ERROR', message: 'API error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.pinMessage(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.pinMessage(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomApiService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.pinMessage(any()));
        });

        test('should throw AppException when API returns null', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.pinMessage(any())).thenAnswer((_) async => null);

          // When & Then
          expect(
            () => repository.pinMessage(tRequest),
            throwsA(isA<AppException>()),
          );
          verify(() => mockChatRoomApiService.pinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.pinMessage(any()));
        });
      });
    });

    group('unpinMessage', () {
      final tRequest = UnpinMessageRequest(
        pinId: 'test-pin-id',
        roomId: 'test-room-id',
      );

      group('when socket is available', () {
        test('should complete successfully when socket call succeeds', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinMessage(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinMessage(tRequest);

          // Then
          verify(() => mockChatRoomSocketService.unpinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.unpinMessage(any()));
        });

        test('should fallback to API when socket throws ApiException with SERVICE_NOT_FOUND', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinMessage(any()))
              .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
          when(() => mockChatRoomApiService.unpinMessage(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinMessage(tRequest);

          // Then
          verify(() => mockChatRoomSocketService.unpinMessage(tRequest)).called(1);
          verify(() => mockChatRoomApiService.unpinMessage(tRequest)).called(1);
        });

        test('should throw exception when socket throws other ApiException', () async {
          // Given
          final apiException = ApiException(type: 'OTHER_ERROR', message: 'Other error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinMessage(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.unpinMessage(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomSocketService.unpinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.unpinMessage(any()));
        });
      });

      group('when socket is not available', () {
        test('should use API service when socket is not ready', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.unpinMessage(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinMessage(tRequest);

          // Then
          verify(() => mockChatRoomApiService.unpinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.unpinMessage(any()));
        });

        test('should throw exception when API service throws exception', () async {
          // Given
          final apiException = ApiException(type: 'API_ERROR', message: 'API error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.unpinMessage(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.unpinMessage(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomApiService.unpinMessage(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.unpinMessage(any()));
        });
      });
    });

    group('unpinAllMessages', () {
      final tRequest = UnpinAllMessagesRequest(
        roomId: 'test-room-id',
      );

      group('when socket is available', () {
        test('should complete successfully when socket call succeeds', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinAllMessages(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinAllMessages(tRequest);

          // Then
          verify(() => mockChatRoomSocketService.unpinAllMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.unpinAllMessages(any()));
        });

        test('should fallback to API when socket throws ApiException with SERVICE_NOT_FOUND', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinAllMessages(any()))
              .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
          when(() => mockChatRoomApiService.unpinAllMessages(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinAllMessages(tRequest);

          // Then
          verify(() => mockChatRoomSocketService.unpinAllMessages(tRequest)).called(1);
          verify(() => mockChatRoomApiService.unpinAllMessages(tRequest)).called(1);
        });

        test('should throw exception when socket throws other ApiException', () async {
          // Given
          final apiException = ApiException(type: 'OTHER_ERROR', message: 'Other error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.unpinAllMessages(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.unpinAllMessages(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomSocketService.unpinAllMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.unpinAllMessages(any()));
        });
      });

      group('when socket is not available', () {
        test('should use API service when socket is not ready', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.unpinAllMessages(any())).thenAnswer((_) async => {});

          // When
          await repository.unpinAllMessages(tRequest);

          // Then
          verify(() => mockChatRoomApiService.unpinAllMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.unpinAllMessages(any()));
        });

        test('should throw exception when API service throws exception', () async {
          // Given
          final apiException = ApiException(type: 'API_ERROR', message: 'API error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.unpinAllMessages(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.unpinAllMessages(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomApiService.unpinAllMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.unpinAllMessages(any()));
        });
      });
    });

    group('getPinMessages', () {
      final tRequest = GetPinMessagesRequest(
        roomId: 'test-room-id',
      );

      final tPinMessageCollection = PinMessageCollection()
        ..id = 'test-pin-id'
        ..ref = 'test-ref'
        ..pinnedBy = 'test-user-id'
        ..roomId = 'test-room-id'
        ..parentId = null
        ..createdAt = null
        ..message = null;

      final tPaginationResponseFromCollection = PaginationPayload<PinMessageCollection>(
        data: [tPinMessageCollection],
        total: 1,
        page: 1,
        pageSize: 10,
        totalPages: 1,
      );

      group('when socket is available', () {
        test('should return PaginationPayload when socket call succeeds', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any()))
              .thenAnswer((_) async => tPaginationResponseFromCollection);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          expect(result.data?.length, equals(1));
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.getPinMessages(any()));
        });

        test('should fallback to API when socket throws ApiException with SERVICE_NOT_FOUND', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any()))
              .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
          when(() => mockChatRoomApiService.getPinMessages(any()))
              .thenAnswer((_) async => tPaginationResponseFromCollection);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
        });

        test('should throw exception when socket throws other ApiException', () async {
          // Given
          final apiException = ApiException(type: 'OTHER_ERROR', message: 'Other error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.getPinMessages(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.getPinMessages(any()));
        });

        test('should handle socket errors and fallback to API', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any())).thenThrow(Exception('Socket error'));
          when(() => mockChatRoomApiService.getPinMessages(any()))
              .thenAnswer((_) async => tPaginationResponseFromCollection);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
        });

        test('should fallback to API when socket returns null and API succeeds', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any()))
              .thenAnswer((_) => Future<PaginationPayload<PinMessageCollection>?>.value(null));
          when(() => mockChatRoomApiService.getPinMessages(any()))
              .thenAnswer((_) async => tPaginationResponseFromCollection);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
        });

        test('should return empty pagination when socket returns empty data', () async {
          // Given
          final emptyPaginationResponse = PaginationPayload<PinMessageCollection>(
            data: [],
            total: 0,
            page: 1,
            pageSize: 10,
            totalPages: 0,
          );
          when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
          when(() => mockChatRoomSocketService.getPinMessages(any())).thenAnswer((_) async => emptyPaginationResponse);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          expect(result.data?.length, equals(0));
          verify(() => mockChatRoomSocketService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomApiService.getPinMessages(any()));
        });
      });

      group('when socket is not available', () {
        test('should use API service when socket is not ready', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.getPinMessages(any()))
              .thenAnswer((_) async => tPaginationResponseFromCollection);

          // When
          final result = await repository.getPinMessages(tRequest);

          // Then
          expect(result, isA<PaginationPayload<PinMessageEntity>>());
          expect(result.data?.length, equals(1));
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.getPinMessages(any()));
        });

        test('should throw exception when API service throws exception', () async {
          // Given
          final apiException = ApiException(type: 'API_ERROR', message: 'API error');
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.getPinMessages(any())).thenThrow(apiException);

          // When & Then
          expect(
            () => repository.getPinMessages(tRequest),
            throwsA(equals(apiException)),
          );
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.getPinMessages(any()));
        });

        test('should throw AppException when API returns null', () async {
          // Given
          when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
          when(() => mockChatRoomApiService.getPinMessages(any())).thenAnswer((_) async => null);

          // When & Then
          expect(
            () => repository.getPinMessages(tRequest),
            throwsA(isA<AppException>()),
          );
          verify(() => mockChatRoomApiService.getPinMessages(tRequest)).called(1);
          verifyNever(() => mockChatRoomSocketService.getPinMessages(any()));
        });
      });
    });
  });
}
