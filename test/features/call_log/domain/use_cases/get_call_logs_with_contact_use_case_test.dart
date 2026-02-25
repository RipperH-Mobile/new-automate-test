import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class MockCallLogServerRepository extends Mock implements CallLogServerRepository {}

class MockCallLogLocalRepository extends Mock implements CallLogLocalRepository {}

class MockCallLogRelatedDataHelper extends Mock implements CallLogRelatedDataHelper {}

class FakeGetCallLogsParam extends Fake implements GetCallLogsParam {}

void main() {
  late GetCallLogsWithContactUseCase useCase;
  late MockCallLogServerRepository mockCallLogServerRepository;
  late MockCallLogLocalRepository mockCallLogLocalRepository;
  late MockCallLogRelatedDataHelper mockRelatedDataHelper;

  final tCallLog = CallLogEntity(
    id: 'call-1',
    callType: CallType.voice,
    callActionType: CallActionType.incoming,
    roomType: RoomType.direct,
    roomId: 'room-1',
    friendId: 'friend-1',
    historyForAccountId: 'acc-1',
    callCount: 2,
    lastStartedAt: DateTime(2026, 1, 1),
    totalDuration: 20,
  );
  final tRoom = const RoomEntity(id: 'room-1', roomType: RoomType.direct);
  final tContact = ContactEntity(id: 'friend-1', displayName: 'Friend A');

  setUpAll(() {
    registerFallbackValue(FakeGetCallLogsParam());
  });

  setUp(() {
    mockCallLogServerRepository = MockCallLogServerRepository();
    mockCallLogLocalRepository = MockCallLogLocalRepository();
    mockRelatedDataHelper = MockCallLogRelatedDataHelper();
    useCase = GetCallLogsWithContactUseCase(
      callLogServerRepository: mockCallLogServerRepository,
      callLogLocalRepository: mockCallLogLocalRepository,
      relatedDataHelper: mockRelatedDataHelper,
    );
  });

  group('call', () {
    test(
      'Given first page and no action filter with server data, When use case is called, Then clears local, saves logs and returns mapped pagination payload',
      () async {
        // Given
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogEntity>(
            page: 1,
            pageSize: 50,
            total: 1,
            totalPages: 1,
            data: [tCallLog],
          ),
        );
        when(() => mockCallLogLocalRepository.clearCallLogs()).thenAnswer((_) async {});
        when(() => mockCallLogLocalRepository.saveCallLogs([tCallLog])).thenAnswer((_) async {});
        when(() => mockRelatedDataHelper.getRelatedData([tCallLog])).thenAnswer((_) async => ([tRoom], [tContact]));

        // When
        final result = await useCase(
          GetCallLogsWithContactUseCaseParams(page: 1),
        );

        // Then
        final request = verify(
          () => mockCallLogServerRepository.getCallLogs(captureAny()),
        ).captured.single as GetCallLogsParam;
        expect(request.page, 1);
        expect(request.pageSize, 50);
        expect(request.callActionType, isNull);

        verify(() => mockCallLogLocalRepository.clearCallLogs()).called(1);
        verify(() => mockCallLogLocalRepository.saveCallLogs([tCallLog])).called(1);

        expect(result.page, 1);
        expect(result.total, 1);
        expect(result.data?.length, 1);
        expect(result.data?.first.contact?.id, 'friend-1');
        expect(result.data?.first.room?.id, 'room-1');
      },
    );

    test(
      'Given action filter is specified, When use case is called, Then does not clear or save local call logs and returns mapped data',
      () async {
        // Given
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogEntity>(
            page: 1,
            pageSize: 20,
            total: 1,
            totalPages: 1,
            data: [tCallLog],
          ),
        );
        when(() => mockRelatedDataHelper.getRelatedData([tCallLog])).thenAnswer((_) async => ([tRoom], [tContact]));

        // When
        final result = await useCase(
          GetCallLogsWithContactUseCaseParams(
            page: 1,
            pageSize: 20,
            callActionType: CallActionType.missed,
          ),
        );

        // Then
        expect(result.data?.length, 1);
        verifyNever(() => mockCallLogLocalRepository.clearCallLogs());
        verifyNever(() => mockCallLogLocalRepository.saveCallLogs(any()));
      },
    );

    test(
      'Given server throws FailedHostLookupException, When use case is called, Then falls back to local data and returns local pagination payload',
      () async {
        // Given
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenThrow(
          FailedHostLookupException(message: 'offline'),
        );
        when(() => mockCallLogLocalRepository.getAllCallLogs()).thenAnswer((_) async => [tCallLog]);
        when(() => mockRelatedDataHelper.getRelatedData([tCallLog])).thenAnswer((_) async => ([tRoom], [tContact]));

        // When
        final result = await useCase(GetCallLogsWithContactUseCaseParams(page: 2));

        // Then
        expect(result.page, 1);
        expect(result.pageSize, 1);
        expect(result.total, 1);
        expect(result.totalPages, 1);
        expect(result.data?.length, 1);
        verify(() => mockCallLogLocalRepository.getAllCallLogs()).called(1);
      },
    );

    test(
      'Given server throws SocketException, When use case is called, Then falls back to local data',
      () async {
        // Given
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenThrow(
          const SocketException('network down'),
        );
        when(() => mockCallLogLocalRepository.getAllCallLogs()).thenAnswer((_) async => [tCallLog]);
        when(() => mockRelatedDataHelper.getRelatedData([tCallLog])).thenAnswer((_) async => ([tRoom], [tContact]));

        // When
        final result = await useCase(GetCallLogsWithContactUseCaseParams(page: 1));

        // Then
        expect(result.total, 1);
        expect(result.data?.first.id, 'call-1');
      },
    );
  });
}
