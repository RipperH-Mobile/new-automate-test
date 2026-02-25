import 'dart:async';

import 'package:async_queue/async_queue.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/core/exceptions/api_state_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/sync/domain/constants/sync_config.dart';
import 'package:uchat/features/sync/domain/use_cases/fetch_specific_state_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_list.dart';

import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/state_group.dart';
import '../../data/models/payloads/get_state.dart';
import '../constants/db_instance.dart';
import '../repositories/sync_server_repository.dart';
import '../typedefs.dart';

class SyncProcessorService<T extends SimpleUseCase<EventListCallback, UpdateStateModel>> {
  final StateGroup group;

  final AsyncQueue syncQueue = AsyncQueue.autoStart(allowDuplicate: false);
  final AsyncQueue addStateQueue = AsyncQueue(allowDuplicate: false);

  // For saving current state seq
  // -2: not init
  // -1: require to init state
  // 0+: init and set
  final _currentStateSeq = RxInt(-2);

  // For adding state to queue, for double check sequential state.
  // First the value must equal to [_currentStateSeq]
  // Value will be updated when adding state to queue
  final currentAddingStateSeq = RxInt(-1);

  // The value is using for debug sync state first and last seq.
  final _syncingFirstStateSeq = Rx<int?>(null);
  final _syncingLastStateSeq = Rx<int?>(null);

  String? _groupBoxKey;
  Worker? _currentStateSeqWorker;

  Timer? _eventDebounceTimer;
  EventListCallback _tempEventCallbacks = [];

  SyncServerRepository get syncServerRepository => GetIt.I<SyncServerRepository>();

  final isSyncProcessing = false.obs;
  final isAddingQueueProcessing = false.obs;

  ///
  /// Metric for tracking sync state processing
  ///
  final _lastProcessTime = Rx<DateTime?>(null);
  final _lastAddingTime = Rx<DateTime?>(null);
  final _lastFetchTime = Rx<DateTime?>(null);
  final _missingStateCount = 0.obs;
  final _exceedStateCount = 0.obs;

  DateTime? get lastProcessTime => _lastProcessTime.value;

  DateTime? get lastAddingTime => _lastAddingTime.value;

  DateTime? get lastFetchTime => _lastFetchTime.value;

  int get missingStateCount => _missingStateCount.value;

  int get exceedStateCount => _exceedStateCount.value;

  ///
  /// Getter private value
  ///
  int get syncingFirstStateSeq {
    return _syncingFirstStateSeq.value ?? 0;
  }

  int get syncingLastStateSeq {
    return _syncingLastStateSeq.value ?? 0;
  }

  int get currentStateSeq {
    return _currentStateSeq.value;
  }

  SimpleUseCase<EventListCallback, UpdateStateModel> get processStateUseCase {
    return GetIt.I<T>();
  }

  ///
  /// Constructor
  /// For [group] use [StateGroup] enum
  /// For [processStateUseCase] use [SimpleUseCase] with [UpdateStateModel] as input and [EventListCallback] as output
  ///
  SyncProcessorService({required this.group}) {
    // For tracking sync state processing value.

    syncQueue.addQueueListener((event) {
      switch (event.type) {
        case QueueEventType.queueStart:
          isSyncProcessing.value = true;
          break;
        case QueueEventType.queueEnd:
        case QueueEventType.queueStopped:
          isSyncProcessing.value = false;
          break;
        default:
      }
    });

    // Listen to addStateQueue for processing state.
    addStateQueue.addQueueListener((event) {
      switch (event.type) {
        case QueueEventType.queueStart:
          isAddingQueueProcessing.value = true;
          break;
        case QueueEventType.queueEnd:
        case QueueEventType.queueStopped:
          isAddingQueueProcessing.value = false;
          break;
        default:
      }
    });
  }

  void initWorker() {
    // _log.d('[$_group] initWorker');
    _currentStateSeqWorker?.dispose();
    _currentStateSeqWorker = ever(_currentStateSeq, (val) {
      writeCurrentStateSeq(val);
    });
  }

  void disposeWorker() {
    addStateQueue.stop();

    // _log.d('[$_group] disposeWorker');
    _currentStateSeqWorker?.dispose();
    _currentStateSeqWorker = null;
    _eventDebounceTimer?.cancel();
    _tempEventCallbacks = [];

    _groupBoxKey = null;
  }

  Future<void> setCurrentStateSeq(int seq, {useTransaction = true, saveToDb = true}) async {
    // Dispose current worker for prevent loop update.
    _currentStateSeqWorker?.dispose();

    _currentStateSeq(seq);
    currentAddingStateSeq(seq);

    if (saveToDb) {
      await writeCurrentStateSeq(seq, useTransaction: useTransaction);
    }
  }

  Future<void> resetCurrentStateSeq({useTransaction = true, saveToDb = true}) async {
    await setCurrentStateSeq(-2, useTransaction: useTransaction, saveToDb: saveToDb);
  }

  Future<void> loadCurrentStateSeq() async {
    _groupBoxKey ??= ConfigDb.getBoxStateSeqConfigKey(group);
    int seq = await ConfigDb().authenticated.getInt(key: _groupBoxKey!) ?? -1;

    if (seq == -2) {
      seq = -1;
    }

    useLogger().d('[$group] Load current state seq: $seq');
    _currentStateSeq(seq);
    currentAddingStateSeq(seq);

    addStateQueue.startWithAutoRun();
  }

  Future<void> writeCurrentStateSeq(int seq, {useTransaction = true}) async {
    _groupBoxKey ??= ConfigDb.getBoxStateSeqConfigKey(group);
    if (useTransaction) {
      await ConfigDb().authenticated.saveConfig(key: _groupBoxKey!, value: seq);
    } else {
      await ConfigDb().authenticated.saveConfigWithoutTxn(key: _groupBoxKey!, value: seq);
    }
  }

  Future<void> clearCurrentStateSeq() async {
    _groupBoxKey ??= ConfigDb.getBoxStateSeqConfigKey(group);
    await ConfigDb().authenticated.clearConfigWithoutTxn(key: _groupBoxKey!);
  }

  Future<List<UpdateStateModel>> fetchStates() async {
    final customTrace = usePerformance().create('fetch-state-$group');
    await customTrace.start();

    // When have current seq, update from state list
    final GetStateRequest req = GetStateRequest()
      ..group = group
      ..startSeq = _currentStateSeq() + 1;

    // Fetch state from server
    GetStateResponse? res;

    try {
      // _log.d('Start fetch state...');
      res = await syncServerRepository.fetchStates(req);
      // _log.d('Fetch state completed...');
    } on ApiStateLimitExceedException catch (e, stackTrace) {
      useLogger().d('[$group] Sync new state because STATE_LIMIT_EXCEED...', e, stackTrace);

      await customTrace.stop();
      rethrow;
    } catch (e, stackTrace) {
      useLogger().e('[$group] Call fetchStates error.', e, stackTrace);

      await customTrace.stop();
      rethrow;
    }

    // Fallback for response with null
    // if (res?.states == null) {
    //   await customTrace.stop();
    //   throw ApiStateNullException(message: 'State is null.');
    // }

    await customTrace.stop();
    _lastFetchTime.value = DateTime.now();
    return res?.states ?? [];
  }

  Future<void> sync(List<UpdateStateModel> states) async {
    final stateChunks = states.splitToGroup(syncChunkSize);
    final lastState = states.lastOrNull;

    PerformanceTrace? customTraceStateSync;

    if (lastState != null) {
      final tracingName = 'performance_state_sync_${lastState.group.value.toLowerCase()}';
      customTraceStateSync = usePerformance().newTrace(tracingName, useFpsMonitoring: true);

      await customTraceStateSync.start();
      customTraceStateSync.putMetric('total_states', states.length);
    }

    for (var states in stateChunks) {
      // Process state using queue
      try {
        _syncingFirstStateSeq.value = states.firstOrNull?.seq;
        _syncingLastStateSeq.value = states.lastOrNull?.seq;

        for (var state in states) {
          await addState(
            state: state,
            lastState: lastState,
            customTraceStateSync: customTraceStateSync,
          );
        }
      } on ApiStateLimitExceedException catch (e, stackTrace) {
        useLogger().d('[$group] Sync new state because STATE_LIMIT_EXCEED...', e, stackTrace);
        _exceedStateCount.value++;

        rethrow;
      } catch (e, stackTrace) {
        useLogger().e('[$group] Call addQueue error.', e, stackTrace);

        rethrow;
      }
    }
  }

  Future<void> addState({
    required UpdateStateModel state,
    UpdateStateModel? lastState,
    PerformanceTrace? customTraceStateSync,
  }) {
    final completer = Completer<void>();
    final addToAddStateQueueAt = DateTime.now();

    addStateQueue.addJob((_) async {
      try {
        await _addingState(state, addToAddStateQueueAt, () async {
          if (state.id == lastState?.id) {
            await customTraceStateSync?.stop();
          }
        });
        _lastAddingTime.value = DateTime.now();
        completer.complete();
      } catch (e, stackTrace) {
        useLogger().e('[$group] Add state error.', e, stackTrace);
        completer.completeError(e, stackTrace);
      }
    }, label: state.seq);

    return completer.future;
  }

  Future<void> _addingState(
    UpdateStateModel state,
    DateTime addToAddStateQueueAt,
    Future<void> Function() onProcessStateCompleted,
  ) async {
    // Check continuity for state seq
    final seq = state.seq;
    final currentAddingStateSeqValue = currentAddingStateSeq();
    useLogger().i('[$group] adding state seq: $seq (current: $currentAddingStateSeqValue)');
    int missingStateCount = 0;
    List<String> missingStateList = [];
    final startAddStateAt = DateTime.now();
    if (currentAddingStateSeqValue > -1) {
      /// Example
      /// case 1 : current state is 5 new state is 3 (somehow state 3 is slower than state 5) -> 5 - 3 = 2
      /// case 2 : current state is 5 new state is 5 -> 5 - 5 = 0
      /// case 3 : current state is 5 new state is 8 -> 5 - 8 = -3
      /// case 4 : current state is 5 new state is 6 -> 5 - 6 = -1
      if (currentAddingStateSeqValue - seq >= 0) {
        /// case 1 and case 2
        /// If new state is older than or equal current state, This state is already processed and can be skipped.
        return;
      } else if (currentAddingStateSeqValue - seq < -1) {
        /// case 3
        /// If new state skip some state seq, Fetch missing state from server and process the missing state first.
        _missingStateCount.value++;
        final missingTrace = usePerformance().create('sync-missing-state-$group');
        await missingTrace.start();
        missingTrace.incrementMetric('count', 1);

        useLogger().i('[$group] found missing state from [${currentAddingStateSeq()}] to [${seq - 1}]');
        final specificStart = currentAddingStateSeq() + 1;
        final specificEnd = seq - 1;

        try {
          // Fetch missing states
          // Check _fetchSpecificState function logic is the same with  FetchSpecificStateUseCase.
          // TODO (firebase) Remove old fetch specific state use case when fetch from firebase is stable.
          final params = FetchSpecificStateParams(start: specificStart, end: specificEnd, group: group.value);
          final missingStates = await GetIt.I<FetchSpecificStateUseCase>().call(params);
          // final params = FetchSpecificFirebaseStateParams(start: specificStart, end: specificEnd, group: group.value);
          // final missingStates = await GetIt.I<FetchSpecificFirebaseStateUseCase>().call(params);

          // Add missing states to queue
          if (missingStates != null) {
            missingStateCount = missingStates.length;
            missingStateList = missingStates.map((e) => '${e.type}-${e.seq}').toList();
            for (final missingState in missingStates) {
              syncQueue.addJob((_) async {
                try {
                  // print('ZZZ => Adding missing state: $state');
                  final eventCbList = await processState(missingState);
                  await batchEventListCallback(eventCbList);
                } catch (e, stackTrace) {
                  useLogger().e('[$group] Process missing state error.', e, stackTrace);
                }
              }, label: missingState.seq);
              currentAddingStateSeq(missingState.seq);
            }
          } else {
            useLogger().e(
              'Missing states is null, cannot process missing states., this error should make sync fail or message lost.',
            );
          }
        } catch (e, stackTrace) {
          useLogger().e('[$group] Cannot run syncSpecific.', e, stackTrace);
          rethrow;
        } finally {
          await missingTrace.stop();
        }
      }

      /// Case 4
      /// If new state is the next state of current state, just process the state.
    }

    final addToSyncQueueAt = DateTime.now();
    syncQueue.addJob((_) async {
      try {
        // print('ZZZ => Adding state: $state');
        final startProcessAt = DateTime.now();
        final eventCbList = await processState(state);
        final processCompletedAt = DateTime.now();
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.processStateCompleted,
          eventProperties: EventProperty.processStateCompleted(
            state: state,
            addToAddStateQueueAt: addToAddStateQueueAt,
            startAddStateAt: startAddStateAt,
            addToSyncQueueAt: addToSyncQueueAt,
            startProcessAt: startProcessAt,
            processCompletedAt: processCompletedAt,
            missingStateCount: missingStateCount,
            missingStateList: missingStateList,
          ),
        );
        await batchEventListCallback(eventCbList);
        onProcessStateCompleted();
      } catch (e, stackTrace) {
        useLogger().e('[$group] Process state error.', e, stackTrace);
      }
    }, label: state.seq);
    currentAddingStateSeq(state.seq);
  }

  Future<EventListCallback> processState(UpdateStateModel state) async {
    EventListCallback eventCbList = [];
    try {
      final Isar? instance;
      if (useGeneralDbInstance.contains(state.type)) {
        instance = DbManager().generalInstance;
      } else {
        instance = DbManager().authenticatedInstance;
      }

      if (instance == null) {
        throw 'Cannot get db instance.';
      }

      await instance.writeTxn(() async {
        try {
          eventCbList = await processStateUseCase.call(state);
        } catch (e, stackTrace) {
          useLogger().e('[$group] Process state error.', e, stackTrace);
        }
      });

      _lastProcessTime.value = DateTime.now();
      _currentStateSeq(state.seq);
    } catch (e, stackTrace) {
      useLogger().e('[$group] Process state error.', e, stackTrace);
    }

    return eventCbList;
  }

  Future<void> batchEventListCallback(EventListCallback eventCbList) async {
    if (eventCbList.isEmpty) return;

    _tempEventCallbacks += eventCbList;
    _eventDebounceTimer?.cancel();
    _eventDebounceTimer = Timer(eventListCallbackDebounceDuration, () async {
      final callbacksToRun = _tempEventCallbacks.toList();
      _tempEventCallbacks = [];

      for (final eventCb in callbacksToRun) {
        eventCb();
      }
    });
  }
}
