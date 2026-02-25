import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class MockCallLogLocalRepository extends Mock implements CallLogLocalRepository {}

class MockCallLogRelatedDataHelper extends Mock implements CallLogRelatedDataHelper {}

class FakeGetCallLogsByRoomAndFriendIdsRequest extends Fake implements GetCallLogsByRoomAndFriendIdsRequest {}

void main() {
  late SearchLocalCallLogsWithContactUseCase useCase;
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

  setUpAll(() {
    registerFallbackValue(FakeGetCallLogsByRoomAndFriendIdsRequest());
  });

  setUp(() {
    mockCallLogLocalRepository = MockCallLogLocalRepository();
    mockRelatedDataHelper = MockCallLogRelatedDataHelper();
    useCase = SearchLocalCallLogsWithContactUseCase(
      callLogLocalRepository: mockCallLogLocalRepository,
      relatedDataHelper: mockRelatedDataHelper,
    );
  });

  group('call', () {
    test(
      'Given keyword is empty after trim, When use case is called, Then returns empty list without searching related data',
      () async {
        // Given
        const params = SearchLocalCallLogsWithContactUseCaseParams(
          keyword: '   ',
          limit: 10,
        );

        // When
        final result = await useCase(params);

        // Then
        expect(result, isEmpty);
        verifyNever(() => mockRelatedDataHelper.searchRelatedData(any()));
        verifyNever(() => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(any()));
      },
    );

    test(
      'Given no related contacts and rooms found, When use case is called, Then returns empty list without querying local call logs',
      () async {
        // Given
        when(() => mockRelatedDataHelper.searchRelatedData('john'))
            .thenAnswer((_) async => (<ContactEntity>[], <RoomEntity>[]));

        // When
        final result = await useCase(
          const SearchLocalCallLogsWithContactUseCaseParams(keyword: 'john'),
        );

        // Then
        expect(result, isEmpty);
        verify(() => mockRelatedDataHelper.searchRelatedData('john')).called(1);
        verifyNever(() => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(any()));
      },
    );

    test(
      'Given related IDs found but local repository returns empty, When use case is called, Then returns empty list',
      () async {
        // Given
        final contacts = [ContactEntity(id: 'friend-1')];
        final rooms = [const RoomEntity(id: 'room-1', roomType: RoomType.group)];

        when(() => mockRelatedDataHelper.searchRelatedData('john')).thenAnswer((_) async => (contacts, rooms));
        when(() => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(any())).thenAnswer((_) async => []);

        // When
        final result = await useCase(
          const SearchLocalCallLogsWithContactUseCaseParams(keyword: 'john'),
        );

        // Then
        expect(result, isEmpty);
        verify(() => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(any())).called(1);
      },
    );

    test(
      'Given related data and local call logs are available, When use case is called, Then builds request with deduplicated IDs and maps result with room and contact',
      () async {
        // Given
        final contacts = [
          ContactEntity(id: 'friend-1', displayName: 'Friend 1'),
          ContactEntity(id: 'friend-1', displayName: 'Friend 1 duplicate'),
          ContactEntity(id: null),
        ];
        final rooms = [
          const RoomEntity(id: 'room-1', roomType: RoomType.group),
          const RoomEntity(id: 'room-1', roomType: RoomType.group),
        ];

        when(() => mockRelatedDataHelper.searchRelatedData('john')).thenAnswer((_) async => (contacts, rooms));
        when(() => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(any())).thenAnswer((_) async => [tCallLog]);

        // When
        final result = await useCase(
          const SearchLocalCallLogsWithContactUseCaseParams(
            keyword: 'john',
            limit: 20,
          ),
        );

        // Then
        final captured = verify(
          () => mockCallLogLocalRepository.getCallLogsByRoomAndFriendIds(
            captureAny(),
          ),
        ).captured.single as GetCallLogsByRoomAndFriendIdsRequest;

        expect(captured.friendIds, ['friend-1']);
        expect(captured.roomIds, ['room-1']);
        expect(captured.limit, 20);

        expect(result.length, 1);
        expect(result.first.id, 'call-1');
        expect(result.first.contact?.id, 'friend-1');
        expect(result.first.room?.id, 'room-1');
      },
    );
  });
}
