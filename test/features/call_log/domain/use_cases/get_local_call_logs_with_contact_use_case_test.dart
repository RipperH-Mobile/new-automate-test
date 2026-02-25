import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class MockCallLogLocalRepository extends Mock implements CallLogLocalRepository {}

class MockCallLogRelatedDataHelper extends Mock implements CallLogRelatedDataHelper {}

void main() {
  late GetLocalCallLogsWithContactUseCase useCase;
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
    callCount: 1,
    lastStartedAt: DateTime(2026, 1, 1),
    totalDuration: 10,
  );

  final tRoom = const RoomEntity(id: 'room-1', roomType: RoomType.direct);
  final tContact = ContactEntity(id: 'friend-1', displayName: 'Friend A');

  setUp(() {
    mockCallLogLocalRepository = MockCallLogLocalRepository();
    mockRelatedDataHelper = MockCallLogRelatedDataHelper();
    useCase = GetLocalCallLogsWithContactUseCase(
      callLogLocalRepository: mockCallLogLocalRepository,
      relatedDataHelper: mockRelatedDataHelper,
    );
  });

  group('call', () {
    test(
      'Given local repository returns empty list, When use case is called, Then returns empty list and does not request related data',
      () async {
        // Given
        when(
          () => mockCallLogLocalRepository.getAllCallLogs(
            limit: 20,
            callActionType: CallActionType.missed,
          ),
        ).thenAnswer((_) async => []);

        // When
        final result = await useCase(
          const GetLocalCallLogsWithContactUseCaseParams(
            limit: 20,
            callActionType: CallActionType.missed,
          ),
        );

        // Then
        expect(result, isEmpty);
        verify(
          () => mockCallLogLocalRepository.getAllCallLogs(
            limit: 20,
            callActionType: CallActionType.missed,
          ),
        ).called(1);
        verifyNever(() => mockRelatedDataHelper.getRelatedData(any()));
      },
    );

    test(
      'Given local repository returns call logs, When use case is called, Then maps call logs with related contact and room data',
      () async {
        // Given
        when(
          () => mockCallLogLocalRepository.getAllCallLogs(
            limit: 50,
            callActionType: null,
          ),
        ).thenAnswer((_) async => [tCallLog]);
        when(() => mockRelatedDataHelper.getRelatedData([tCallLog])).thenAnswer((_) async => ([tRoom], [tContact]));

        // When
        final result = await useCase(
          const GetLocalCallLogsWithContactUseCaseParams(),
        );

        // Then
        expect(result.length, 1);
        expect(result.first.id, tCallLog.id);
        expect(result.first.room?.id, tRoom.id);
        expect(result.first.contact?.id, tContact.id);
        verify(() => mockRelatedDataHelper.getRelatedData([tCallLog])).called(1);
      },
    );
  });
}
