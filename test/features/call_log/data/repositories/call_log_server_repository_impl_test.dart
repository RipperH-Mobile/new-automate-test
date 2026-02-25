import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/app_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_api_service.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_socket_service.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/data/models/models/call_log_model.dart';
import 'package:uchat/features/call_log/data/models/requests/delete_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/requests/get_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/responses/delete_call_log_response.dart';
import 'package:uchat/features/call_log/data/repositories/call_log_server_repository_impl.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';

class MockSocketCaller extends Mock implements SocketCaller {}

class MockCallLogApiService extends Mock implements CallLogApiService {}

class MockCallLogSocketService extends Mock implements CallLogSocketService {}

class MockLoggerService extends Mock implements LoggerService {}

class FakeDeleteCallLogRequest extends Fake implements DeleteCallLogRequest {}

class FakeGetCallLogRequest extends Fake implements GetCallLogRequest {}

void main() {
  late CallLogServerRepositoryImpl repository;
  late MockSocketCaller mockSocketCaller;
  late MockCallLogApiService mockCallLogApiService;
  late MockCallLogSocketService mockCallLogSocketService;
  late MockLoggerService mockLoggerService;

  final tDeleteResponse = DeleteCallLogResponse(
    totalDeleted: 2,
    code: 200,
    type: 'ok',
    metadata: const {},
  );

  final tCallLogModel = CallLogModel(
    id: 'call-1',
    callType: CallType.voice,
    callActionType: CallActionType.incoming,
    roomType: RoomType.direct,
    roomId: 'room-1',
    friendId: 'friend-1',
    historyForAccountId: 'acc-1',
    callCount: 1,
    lastStartedAt: DateTime(2026, 1, 1),
    totalDuration: 30,
  );

  setUpAll(() {
    registerFallbackValue(FakeDeleteCallLogRequest());
    registerFallbackValue(FakeGetCallLogRequest());
  });

  setUp(() {
    mockSocketCaller = MockSocketCaller();
    mockCallLogApiService = MockCallLogApiService();
    mockCallLogSocketService = MockCallLogSocketService();
    mockLoggerService = MockLoggerService();
    repository = CallLogServerRepositoryImpl(
      socketCaller: mockSocketCaller,
      callLogApiService: mockCallLogApiService,
      callLogSocketService: mockCallLogSocketService,
      log: mockLoggerService,
    );
  });

  group('deleteCallLogs', () {
    test(
      'Given socket is ready and socket response exists, When deleteCallLogs is called, Then returns socket response and does not call api',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.deleteCallLogs(any())).thenAnswer((_) async => tDeleteResponse);

        // When
        final result = await repository.deleteCallLogs(callLogIds: ['a', 'b']);

        // Then
        expect(result, 2);
        verify(() => mockCallLogSocketService.deleteCallLogs(any())).called(1);
        verifyNever(() => mockCallLogApiService.deleteCallLogs(any()));
      },
    );

    test(
      'Given socket is ready and service not found error occurs, When deleteCallLogs is called, Then falls back to api response',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.deleteCallLogs(any())).thenThrow(
          ApiException(message: 'not found', type: 'SERVICE_NOT_FOUND'),
        );
        when(() => mockCallLogApiService.deleteCallLogs(any())).thenAnswer((_) async => tDeleteResponse);

        // When
        final result = await repository.deleteCallLogs(callLogIds: ['a']);

        // Then
        expect(result, 2);
        verify(() => mockCallLogApiService.deleteCallLogs(any())).called(1);
      },
    );

    test(
      'Given socket is ready and non service-not-found ApiException occurs, When deleteCallLogs is called, Then rethrows exception',
      () async {
        // Given
        final exception = ApiException(message: 'unauthorized', type: 'UNAUTHORIZED');
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.deleteCallLogs(any())).thenThrow(exception);

        // When
        final action = repository.deleteCallLogs(callLogIds: ['a']);

        // Then
        await expectLater(action, throwsA(same(exception)));
        verifyNever(() => mockCallLogApiService.deleteCallLogs(any()));
      },
    );

    test(
      'Given socket is not ready and api returns null, When deleteCallLogs is called, Then throws handled AppException',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
        when(() => mockCallLogApiService.deleteCallLogs(any())).thenAnswer((_) async => null);

        // When
        final action = repository.deleteCallLogs();

        // Then
        await expectLater(action, throwsA(isA<AppException>()));
      },
    );
  });

  group('getCallLogs', () {
    test(
      'Given socket is ready and socket response exists, When getCallLogs is called, Then returns mapped entity payload from socket',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogModel>(
            page: 1,
            pageSize: 50,
            total: 1,
            totalPages: 1,
            data: [tCallLogModel],
          ),
        );

        // When
        final result = await repository.getCallLogs(
          const GetCallLogsParam(page: 1, pageSize: 50),
        );

        // Then
        expect(result.total, 1);
        expect(result.data?.length, 1);
        expect(result.data?.first.id, 'call-1');
        expect(result.data?.first.friendId, 'friend-1');
        verify(() => mockCallLogSocketService.getCallLogs(any())).called(1);
        verifyNever(() => mockCallLogApiService.getCallLogs(any()));
      },
    );

    test(
      'Given socket is ready and service not found error occurs, When getCallLogs is called, Then falls back to api response',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.getCallLogs(any())).thenThrow(
          ApiException(message: 'not found', type: 'SERVICE_NOT_FOUND'),
        );
        when(() => mockCallLogApiService.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogModel>(
            page: 1,
            pageSize: 50,
            total: 1,
            totalPages: 1,
            data: [tCallLogModel],
          ),
        );

        // When
        final result = await repository.getCallLogs(
          const GetCallLogsParam(page: 1),
        );

        // Then
        expect(result.total, 1);
        verify(() => mockCallLogApiService.getCallLogs(any())).called(1);
      },
    );

    test(
      'Given socket is ready and non service-not-found ApiException occurs, When getCallLogs is called, Then rethrows exception',
      () async {
        // Given
        final exception = ApiException(message: 'forbidden', type: 'FORBIDDEN');
        when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
        when(() => mockCallLogSocketService.getCallLogs(any())).thenThrow(exception);

        // When
        final action = repository.getCallLogs(const GetCallLogsParam(page: 1));

        // Then
        await expectLater(action, throwsA(same(exception)));
      },
    );

    test(
      'Given socket is not ready and api returns null, When getCallLogs is called, Then throws handled AppException',
      () async {
        // Given
        when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
        when(() => mockCallLogApiService.getCallLogs(any())).thenAnswer((_) async => null);

        // When
        final action = repository.getCallLogs(const GetCallLogsParam(page: 1));

        // Then
        await expectLater(action, throwsA(isA<AppException>()));
      },
    );
  });
}
