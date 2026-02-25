import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class MockCallLogServerRepository extends Mock implements CallLogServerRepository {}

class MockCallLogRelatedDataHelper extends Mock implements CallLogRelatedDataHelper {}

class FakeGetCallLogsParam extends Fake implements GetCallLogsParam {}

void main() {
  late SearchCallLogsWithContactUseCase useCase;
  late MockCallLogServerRepository mockCallLogServerRepository;
  late MockCallLogRelatedDataHelper mockRelatedDataHelper;

  final tCallLog = CallLogEntity(
    id: 'call-1',
    callType: CallType.voice,
    callActionType: CallActionType.incoming,
    roomType: RoomType.direct,
    roomId: 'room-1',
    friendId: 'contact-50',
    historyForAccountId: 'acc-1',
    callCount: 1,
    lastStartedAt: DateTime(2026, 1, 1),
    totalDuration: 25,
  );

  setUpAll(() {
    registerFallbackValue(FakeGetCallLogsParam());
  });

  setUp(() {
    mockCallLogServerRepository = MockCallLogServerRepository();
    mockRelatedDataHelper = MockCallLogRelatedDataHelper();
    useCase = SearchCallLogsWithContactUseCase(
      callLogServerRepository: mockCallLogServerRepository,
      relatedDataHelper: mockRelatedDataHelper,
    );
  });

  group('call', () {
    test(
      'Given no matched contacts and rooms, When use case is called, Then returns empty pagination and does not call server repository',
      () async {
        // Given
        when(() => mockRelatedDataHelper.searchRelatedData('john', limit: 500))
            .thenAnswer((_) async => (<ContactEntity>[], <RoomEntity>[]));

        // When
        final result = await useCase(
          SearchCallLogsWithContactUseCaseParams(keyword: 'john', page: 1),
        );

        // Then
        expect(result.total, 0);
        expect(result.totalPages, 0);
        expect(result.data, isEmpty);
        verifyNever(() => mockCallLogServerRepository.getCallLogs(any()));
      },
    );

    test(
      'Given first chunk returns call logs, When use case is called, Then returns mapped pagination immediately',
      () async {
        // Given
        final contacts = [ContactEntity(id: 'contact-1', displayName: 'Contact 1')];
        final rooms = [const RoomEntity(id: 'room-1', roomType: RoomType.group)];

        when(() => mockRelatedDataHelper.searchRelatedData('john', limit: 500))
            .thenAnswer((_) async => (contacts, rooms));
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogEntity>(
            page: 1,
            pageSize: 20,
            total: 1,
            totalPages: 1,
            data: [
              CallLogEntity(
                id: tCallLog.id,
                callType: tCallLog.callType,
                callActionType: tCallLog.callActionType,
                roomType: tCallLog.roomType,
                roomId: tCallLog.roomId,
                friendId: 'contact-1',
                historyForAccountId: tCallLog.historyForAccountId,
                callCount: tCallLog.callCount,
                lastStartedAt: tCallLog.lastStartedAt,
                totalDuration: tCallLog.totalDuration,
              ),
            ],
          ),
        );

        // When
        final result = await useCase(
          SearchCallLogsWithContactUseCaseParams(
            keyword: 'john',
            page: 1,
            pageSize: 20,
          ),
        );

        // Then
        expect(result.total, 1);
        expect(result.data?.length, 1);
        expect(result.data?.first.contact?.id, 'contact-1');
        verify(() => mockCallLogServerRepository.getCallLogs(any())).called(1);
      },
    );

    test(
      'Given first chunk is empty and second chunk has result, When use case is called, Then queries next chunk and returns second chunk result',
      () async {
        // Given
        final contacts = List.generate(
          51,
          (index) => ContactEntity(id: 'contact-$index', displayName: 'C$index'),
        );
        when(() => mockRelatedDataHelper.searchRelatedData('john', limit: 500))
            .thenAnswer((_) async => (contacts, <RoomEntity>[]));

        when(() => mockCallLogServerRepository.getCallLogs(any())).thenAnswer(
          (invocation) async {
            final param = invocation.positionalArguments.first as GetCallLogsParam;
            if (param.accountIds?.length == 1) {
              return PaginationPayload<CallLogEntity>(
                page: 1,
                pageSize: 20,
                total: 1,
                totalPages: 1,
                data: [tCallLog],
              );
            }

            return PaginationPayload<CallLogEntity>(
              page: 1,
              pageSize: 20,
              total: 0,
              totalPages: 0,
              data: [],
            );
          },
        );

        // When
        final result = await useCase(
          SearchCallLogsWithContactUseCaseParams(
            keyword: 'john',
            page: 1,
            pageSize: 20,
          ),
        );

        // Then
        expect(result.total, 1);
        expect(result.data?.length, 1);
        verify(() => mockCallLogServerRepository.getCallLogs(any())).called(2);
      },
    );

    test(
      'Given all chunks return empty, When use case is called, Then returns empty pagination',
      () async {
        // Given
        final contacts = [ContactEntity(id: 'contact-1')];
        final rooms = [const RoomEntity(id: 'room-1', roomType: RoomType.group)];
        when(() => mockRelatedDataHelper.searchRelatedData('john', limit: 500))
            .thenAnswer((_) async => (contacts, rooms));
        when(() => mockCallLogServerRepository.getCallLogs(any())).thenAnswer(
          (_) async => PaginationPayload<CallLogEntity>(
            page: 1,
            pageSize: 50,
            total: 0,
            totalPages: 0,
            data: [],
          ),
        );

        // When
        final result = await useCase(
          SearchCallLogsWithContactUseCaseParams(keyword: 'john', page: 2),
        );

        // Then
        expect(result.page, 2);
        expect(result.total, 0);
        expect(result.totalPages, 0);
        expect(result.data, isEmpty);
      },
    );
  });
}
