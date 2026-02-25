import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/api_state_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/data/models/enum/state_group.dart';
import 'package:uchat/features/sync/data/models/enum/update_state_type.dart';
import 'package:uchat/features/sync/domain/constants/sync_config.dart';
import 'package:uchat/features/sync/domain/services/sync_processor_service.dart';
import 'package:uchat/features/sync/domain/typedefs.dart';
import 'package:uchat/features/sync/domain/use_cases/fetch_specific_firebase_state_use_case.dart';
import 'package:uchat/features/sync/domain/use_cases/fetch_specific_state_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

class MockPerformanceService extends Mock implements PerformanceService {}

class MockPerformanceTrace extends Mock implements PerformanceTrace {}

class MockProcessStateUseCase extends Mock implements SimpleUseCase<EventListCallback, UpdateStateModel> {}

class MockLoggerService extends Mock implements LoggerService {}

class MockFetchSpecificFirebaseStateUseCase extends Mock implements FetchSpecificFirebaseStateUseCase {}

class MockFetchSpecificStateUseCase extends Mock implements FetchSpecificStateUseCase {}

class _TestableSyncProcessorService extends SyncProcessorService<MockProcessStateUseCase> {
  _TestableSyncProcessorService({required super.group});

  final List<UpdateStateModel> addedStates = [];
  void Function(UpdateStateModel state)? addStateOverride;
  final List<int> chunkFirstSeqHistory = [];

  @override
  Future<void> addState({
    required UpdateStateModel state,
    UpdateStateModel? lastState,
    PerformanceTrace? customTraceStateSync,
  }) async {
    final chunkHead = syncingFirstStateSeq;
    if (chunkFirstSeqHistory.isEmpty || chunkFirstSeqHistory.last != chunkHead) {
      chunkFirstSeqHistory.add(chunkHead);
    }
    addStateOverride?.call(state);
    addedStates.add(state);
  }
}

class _ProcessingSyncProcessorService extends SyncProcessorService<MockProcessStateUseCase> {
  _ProcessingSyncProcessorService({required super.group});

  @override
  Future<EventListCallback> processState(UpdateStateModel state) async {
    return [];
  }
}

void main() {
  late MockPerformanceService mockPerformanceService;
  late MockPerformanceTrace mockPerformanceTrace;
  late MockLoggerService mockLoggerService;
  late _TestableSyncProcessorService service;

  setUpAll(() {
    registerFallbackValue(
      FetchSpecificFirebaseStateParams(
        start: 0,
        end: 0,
        group: StateGroup.message.value,
      ),
    );
    registerFallbackValue(
      FetchSpecificStateParams(
        start: 0,
        end: 0,
        group: StateGroup.message.value,
      ),
    );
  });

  setUp(() async {
    await GetIt.I.reset();
    mockPerformanceService = MockPerformanceService();
    mockPerformanceTrace = MockPerformanceTrace();
    mockLoggerService = MockLoggerService();

    when(() => mockPerformanceService.create(any())).thenReturn(mockPerformanceTrace);
    when(() => mockPerformanceTrace.start()).thenAnswer((_) async {});
    when(() => mockPerformanceTrace.stop()).thenAnswer((_) async {});

    when(() => mockPerformanceService.newTrace(any())).thenReturn(mockPerformanceTrace);

    when(() => mockPerformanceTrace.start()).thenAnswer((_) async {});
    when(() => mockPerformanceTrace.stop()).thenAnswer((_) async {});

    GetIt.I.registerSingleton<PerformanceService>(mockPerformanceService);
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
  });

  group('sync', () {
    setUp(() {
      service = _TestableSyncProcessorService(group: StateGroup.message);
    });

    test(
      'Given an empty state list, When sync is called, Then no states are enqueued',
      () async {
        // When
        await service.sync([]);

        // Then
        expect(
          service.addedStates,
          isEmpty,
          reason: 'No states should be enqueued when sync receives no items.',
        );
        expect(service.syncingFirstStateSeq, 0);
        expect(service.syncingLastStateSeq, 0);
      },
    );

    test(
      'Given states fewer than the chunk size, When sync is called, Then enqueues every state and updates sequence range',
      () async {
        // Given
        final states = [
          _createState(seq: 1),
          _createState(seq: 2),
          _createState(seq: 3),
        ];

        // When
        await service.sync(states);

        // Then
        expect(
          service.addedStates,
          states,
          reason: 'States should be enqueued in the original order.',
        );
        expect(
          service.syncingFirstStateSeq,
          states.first.seq,
          reason: 'First synced sequence should match the first provided state.',
        );
        expect(
          service.syncingLastStateSeq,
          states.last.seq,
          reason: 'Last synced sequence should match the last provided state.',
        );
      },
    );

    test(
      'Given states exceeding the chunk size, When sync is called, Then processes every chunk sequentially',
      () async {
        // Given
        final totalStates = syncChunkSize + 5;
        final states = List.generate(totalStates, (index) => _createState(seq: index + 1));

        // When
        await service.sync(states);

        // Then
        expect(
          service.addedStates,
          states,
          reason: 'All states across chunks should be enqueued in order.',
        );
        expect(
          service.syncingFirstStateSeq,
          states[syncChunkSize].seq,
          reason: 'Final chunk should update the first syncing sequence.',
        );
        expect(
          service.syncingLastStateSeq,
          states.last.seq,
          reason: 'Last syncing sequence should reflect the final state.',
        );
      },
    );

    test(
      'Given 750 sequential states, When sync is called, Then processes every chunk in order',
      () async {
        // Given
        final totalStates = 750;
        final states = List.generate(totalStates, (index) => _createState(seq: index + 1));

        // When
        await service.sync(states);

        // Then
        expect(
          service.addedStates.length,
          totalStates,
          reason: 'All 750 states should be enqueued across every chunk.',
        );
        expect(
          service.chunkFirstSeqHistory,
          [1, 201, 401, 601],
          reason: 'Chunk boundaries should progress without gaps.',
        );
        expect(
          service.syncingFirstStateSeq,
          601,
          reason: 'Final chunk head should align with the fourth chunk start.',
        );
        expect(service.syncingLastStateSeq, 750);
      },
    );

    test(
      'Given addState throws ApiStateLimitExceedException, When sync is called, Then rethrows and increments exceed counter',
      () async {
        // Given
        final failingState = _createState(seq: 99);
        service.addStateOverride = (_) => throw ApiStateLimitExceedException(
              message: 'limit exceeded',
            );

        // When
        await expectLater(
          () => service.sync([failingState]),
          throwsA(isA<ApiStateLimitExceedException>()),
        );

        // Then
        expect(service.addedStates, isEmpty);
        expect(service.syncingFirstStateSeq, failingState.seq);
        expect(service.syncingLastStateSeq, failingState.seq);
        expect(service.exceedStateCount, 1);
      },
    );

    test(
      'Given addState throws an unexpected error, When sync is called, Then rethrows without incrementing exceed counter',
      () async {
        // Given
        final failingState = _createState(seq: 7);
        service.addStateOverride = (_) => throw Exception('generic failure');

        // When
        await expectLater(
          () => service.sync([failingState]),
          throwsA(isA<Exception>()),
        );

        // Then
        expect(service.addedStates, isEmpty);
        expect(service.syncingFirstStateSeq, failingState.seq);
        expect(service.syncingLastStateSeq, failingState.seq);
        expect(service.exceedStateCount, 0);
      },
    );
  });

  group('addState', () {
    late _ProcessingSyncProcessorService addStateService;
    late MockFetchSpecificFirebaseStateUseCase mockFetchSpecificFirebaseStateUseCase;
    late MockFetchSpecificStateUseCase mockFetchSpecificStateUseCase;

    setUp(() {
      mockFetchSpecificFirebaseStateUseCase = MockFetchSpecificFirebaseStateUseCase();
      mockFetchSpecificStateUseCase = MockFetchSpecificStateUseCase();

      GetIt.I.registerSingleton<FetchSpecificFirebaseStateUseCase>(mockFetchSpecificFirebaseStateUseCase);
      GetIt.I.registerSingleton<FetchSpecificStateUseCase>(mockFetchSpecificStateUseCase);

      when(() => mockFetchSpecificFirebaseStateUseCase.call(any())).thenAnswer((_) async => []);
      when(() => mockFetchSpecificStateUseCase.call(any())).thenAnswer((_) async => []);

      addStateService = _ProcessingSyncProcessorService(group: StateGroup.message);
    });

    test(
      'Given sequential states, When addStateQueue auto run completes, Then emits sequence updates in order',
      () async {
        // Given
        final state1 = _createState(seq: 1);
        final state2 = _createState(seq: 2);
        final state3 = _createState(seq: 3);
        final updates = <int>[];
        final subscription = addStateService.currentAddingStateSeq.listen(updates.add);

        addStateService.addState(state: state1);
        addStateService.addState(state: state2);
        addStateService.addState(state: state3);

        // When
        await addStateService.addStateQueue.startWithAutoRun();

        // Then
        expect(
          updates,
          equals([1, 2, 3]),
          reason: 'States should process sequentially when queued in order.',
        );

        // Cleanup
        await subscription.cancel();
      },
    );

    test(
      'Given states arriving out of order, When missing states are fetched, Then inserts the missing sequence before processing',
      () async {
        // Given
        final state1 = _createState(seq: 1);
        final missingState = _createState(seq: 2);
        final state3 = _createState(seq: 3);
        when(
          () => mockFetchSpecificStateUseCase.call(
            FetchSpecificStateParams(start: 2, end: 2, group: StateGroup.message.value),
          ),
        ).thenAnswer((_) async => [missingState]);

        final updates = <int>[];
        final subscription = addStateService.currentAddingStateSeq.listen(updates.add);

        addStateService.addState(state: state1);
        addStateService.addState(state: state3);
        addStateService.addState(state: missingState);

        // When
        await addStateService.addStateQueue.startWithAutoRun();

        // Then
        expect(
          updates,
          equals([1, 2, 3]),
          reason: 'Queue should fetch and process the missing state before advancing.',
        );

        // Cleanup
        await subscription.cancel();
      },
    );

    test(
      'Given multiple missing states, When fetched from backend, Then processes every sequence in order',
      () async {
        // Given
        final state1 = _createState(seq: 1);
        final missingState2 = _createState(seq: 2);
        final missingState3 = _createState(seq: 3);
        final state4 = _createState(seq: 4);
        when(
          () => mockFetchSpecificStateUseCase.call(
            FetchSpecificStateParams(start: 2, end: 3, group: StateGroup.message.value),
          ),
        ).thenAnswer((_) async => [missingState2, missingState3]);

        final updates = <int>[];
        final subscription = addStateService.currentAddingStateSeq.listen(updates.add);

        addStateService.addState(state: state1);
        addStateService.addState(state: state4);
        addStateService.addState(state: missingState2);
        addStateService.addState(state: missingState3);

        // When
        await addStateService.addStateQueue.startWithAutoRun();

        // Then
        expect(
          updates,
          equals([1, 2, 3, 4]),
          reason: 'All missing states should be inserted in sequence order.',
        );

        // Cleanup
        await subscription.cancel();
      },
    );

    test(
      'Given duplicate states, When addStateQueue runs, Then ignores already processed sequences',
      () async {
        // Given
        final state1 = _createState(seq: 1);
        final state2 = _createState(seq: 2);
        final state3 = _createState(seq: 3);
        final updates = <int>[];
        final subscription = addStateService.currentAddingStateSeq.listen(updates.add);

        addStateService.addState(state: state1);
        addStateService.addState(state: state2);
        addStateService.addState(state: state3);
        addStateService.addState(state: state1);
        addStateService.addState(state: state2);

        // When
        await addStateService.addStateQueue.startWithAutoRun();

        // Then
        expect(
          updates,
          equals([1, 2, 3]),
          reason: 'Duplicate states should be filtered out by the queue.',
        );

        // Cleanup
        await subscription.cancel();
      },
    );
  });

  group('batchEventListCallback', () {
    test(
      'Given an empty callback list, When batchEventListCallback is called, Then no callback executes',
      () {
        fakeAsync((async) {
          // Given
          final service = SyncProcessorService<MockProcessStateUseCase>(
            group: StateGroup.message,
          );
          var executedCount = 0;

          // When
          service.batchEventListCallback([]);
          async.elapse(eventListCallbackDebounceDuration);

          // Then
          expect(
            executedCount,
            0,
            reason: 'Empty batch should not trigger any callbacks.',
          );
        });
      },
    );

    test(
      'Given batched callbacks, When debounce duration elapses, Then executes each callback exactly once',
      () {
        fakeAsync((async) {
          // Given
          final service = SyncProcessorService<MockProcessStateUseCase>(
            group: StateGroup.message,
          );
          final executedOrder = <int>[];

          // When
          service.batchEventListCallback([
            () => executedOrder.add(1),
            () => executedOrder.add(2),
          ]);
          async.elapse(
            eventListCallbackDebounceDuration - const Duration(milliseconds: 10),
          );

          // Then
          expect(
            executedOrder,
            isEmpty,
            reason: 'Callbacks should wait until debounce completes.',
          );

          async.elapse(const Duration(milliseconds: 10));
          expect(
            executedOrder,
            equals([1, 2]),
            reason: 'All callbacks should execute once after the delay.',
          );
        });
      },
    );

    test(
      'Given callbacks added before debounce fires, When another batch arrives, Then it resets the timer and executes combined callbacks',
      () {
        fakeAsync((async) {
          // Given
          final service = SyncProcessorService<MockProcessStateUseCase>(
            group: StateGroup.message,
          );
          final executedOrder = <int>[];

          // When
          service.batchEventListCallback([
            () => executedOrder.add(1),
          ]);
          async.elapse(
            Duration(
              milliseconds: eventListCallbackDebounceDuration.inMilliseconds ~/ 2,
            ),
          );
          service.batchEventListCallback([
            () => executedOrder.add(2),
          ]);

          // Then
          async.elapse(
            eventListCallbackDebounceDuration - const Duration(milliseconds: 1),
          );
          expect(
            executedOrder,
            isEmpty,
            reason: 'Debounce should restart when a new batch is added.',
          );

          async.elapse(const Duration(milliseconds: 1));
          expect(
            executedOrder,
            equals([1, 2]),
            reason: 'All callbacks should run together after the reset delay.',
          );
        });
      },
    );
  });
}

UpdateStateModel _createState({required int seq}) {
  return UpdateStateModel(
    id: 'state-$seq',
    accountId: 'account-1',
    group: StateGroup.message,
    type: UpdateStateType.newMessage,
    seq: seq,
    data: const {'value': 'data'},
  );
}
