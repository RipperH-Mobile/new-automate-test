import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/data_source/local/call_log_db.dart';
import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/data/repositories/call_log_local_repository_impl.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';

class MockCallLogDb extends Mock implements CallLogDb {}

class FakeGetCallLogsByRoomAndFriendIdsRequest extends Fake implements GetCallLogsByRoomAndFriendIdsRequest {}

void main() {
  late CallLogLocalRepositoryImpl repository;
  late MockCallLogDb mockCallLogDb;

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
    mockCallLogDb = MockCallLogDb();
    repository = CallLogLocalRepositoryImpl(callLogDb: mockCallLogDb);
  });

  group('getAllCallLogs', () {
    test(
      'Given filter arguments, When method is called, Then delegates to callLogDb and returns db result',
      () async {
        // Given
        when(
          () => mockCallLogDb.getAllCallLogs(
            limit: 20,
            callActionType: CallActionType.missed,
          ),
        ).thenAnswer((_) async => [tCallLog]);

        // When
        final result = await repository.getAllCallLogs(
          limit: 20,
          callActionType: CallActionType.missed,
        );

        // Then
        expect(result, [tCallLog]);
        verify(
          () => mockCallLogDb.getAllCallLogs(
            limit: 20,
            callActionType: CallActionType.missed,
          ),
        ).called(1);
      },
    );
  });

  group('getCallLogsByRoomAndFriendIds', () {
    test(
      'Given request object, When method is called, Then delegates to callLogDb with same request',
      () async {
        // Given
        const request = GetCallLogsByRoomAndFriendIdsRequest(
          roomIds: ['room-1'],
          friendIds: ['friend-1'],
          limit: 10,
        );
        when(() => mockCallLogDb.getCallLogsByRoomAndFriendIds(request)).thenAnswer((_) async => [tCallLog]);

        // When
        final result = await repository.getCallLogsByRoomAndFriendIds(request);

        // Then
        expect(result, [tCallLog]);
        verify(() => mockCallLogDb.getCallLogsByRoomAndFriendIds(request)).called(1);
      },
    );
  });

  group('saveCallLogs', () {
    test(
      'Given call log entities, When method is called, Then maps to collections and stores them in db',
      () async {
        // Given
        when(() => mockCallLogDb.putAllCallLogs(any())).thenAnswer((_) async {});

        // When
        await repository.saveCallLogs([tCallLog]);

        // Then
        final captured =
            verify(() => mockCallLogDb.putAllCallLogs(captureAny())).captured.single as List<CallLogCollection>;
        expect(captured.length, 1);
        expect(captured.first.id, tCallLog.id);
        expect(captured.first.roomId, tCallLog.roomId);
      },
    );
  });

  group('delegation methods', () {
    test(
      'Given call log id, When getCallLog is called, Then delegates to db and returns db value',
      () async {
        // Given
        when(() => mockCallLogDb.getCallLog('call-1')).thenAnswer((_) async => tCallLog);

        // When
        final result = await repository.getCallLog('call-1');

        // Then
        expect(result, tCallLog);
        verify(() => mockCallLogDb.getCallLog('call-1')).called(1);
      },
    );

    test(
      'Given call log id, When deleteCallLog is called, Then delegates to db and returns delete result',
      () async {
        // Given
        when(() => mockCallLogDb.deleteCallLog('call-1')).thenAnswer((_) async => true);

        // When
        final result = await repository.deleteCallLog('call-1');

        // Then
        expect(result, isTrue);
        verify(() => mockCallLogDb.deleteCallLog('call-1')).called(1);
      },
    );

    test(
      'Given ids list, When deleteAllCallLogs is called, Then delegates to db deleteAllCallLogs',
      () async {
        // Given
        when(() => mockCallLogDb.deleteAllCallLogs(['a', 'b'])).thenAnswer((_) async {});

        // When
        await repository.deleteAllCallLogs(['a', 'b']);

        // Then
        verify(() => mockCallLogDb.deleteAllCallLogs(['a', 'b'])).called(1);
      },
    );

    test(
      'Given repository instance, When clearCallLogs is called, Then delegates to db clearCollection',
      () async {
        // Given
        when(() => mockCallLogDb.clearCollection()).thenAnswer((_) async {});

        // When
        await repository.clearCallLogs();

        // Then
        verify(() => mockCallLogDb.clearCollection()).called(1);
      },
    );
  });
}
