import 'dart:async';
import 'dart:io';

import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:async_queue/async_queue.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_state_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/schema_version.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_bulk_group_permission_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/use_cases/clear_collection_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/put_all_contact_without_txn_use_case.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/features/sync/data/models/payloads/init_state_seqs.dart';
import 'package:uchat/features/sync/domain/events/init_complete_event.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';

import '../../data/models/entities/init_state_model.dart';
import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/state_group.dart';
import '../../data/models/payloads/init_state_contacts.dart';
import '../../data/models/payloads/init_state_rooms.dart';
import '../repositories/sync_server_repository.dart';
import '../use_cases/process_group_default_use_case.dart';
import '../use_cases/process_group_friend_use_case.dart';
import '../use_cases/process_group_message_use_case.dart';
import '../use_cases/process_group_room_subscription_use_case.dart';
import '../use_cases/process_group_room_use_case.dart';
import 'sync_processor_service.dart';

const int networkCheckerIntervalMs = 15000; // Send heartbeat every 15 seconds

/// Helper class to efficiently accumulate rooms data during initialization
class _RoomsDataAccumulator {
  final List<RoomCollection> _rooms = [];
  final List<RoomSubscriptionCollection> _roomSubs = [];
  final List<GroupPermissionEntity> _groupPermissions = [];
  final List<RoomMemberCollection> _members = [];

  void addRooms(List<RoomCollection> rooms) => _rooms.addAll(rooms);

  void addRoomSubs(List<RoomSubscriptionCollection> roomSubs) => _roomSubs.addAll(roomSubs);

  void addGroupPermissions(List<GroupPermissionEntity> permissions) => _groupPermissions.addAll(permissions);

  void addMembers(List<RoomMemberCollection> members) => _members.addAll(members);

  (List<RoomCollection>, List<RoomSubscriptionCollection>, List<GroupPermissionEntity>, List<RoomMemberCollection>)
      toTuple() => (_rooms, _roomSubs, _groupPermissions, _members);
}

///
/// SyncService
/// For process sync state from server by group.
///
class SyncService {
  final Map<String, RoomSubscriptionCollection> tempRoomSubscriptionList = {};
  List<RoomMemberCollection> _tempRoomMembers = [];

  final syncDefaultProcess = SyncProcessorService<ProcessGroupDefaultUseCase>(group: StateGroup.defaultGroup);

  final syncFriendProcess = SyncProcessorService<ProcessGroupFriendUseCase>(group: StateGroup.friend);

  final syncMessageProcess = SyncProcessorService<ProcessGroupMessageUseCase>(group: StateGroup.message);

  final syncRoomProcess = SyncProcessorService<ProcessGroupRoomUseCase>(group: StateGroup.room);

  final syncRoomSubscriptionProcess = SyncProcessorService<ProcessGroupRoomSubscriptionUseCase>(
    group: StateGroup.roomSubscription,
  );

  ///
  /// Getter for sync process
  ///
  List<SyncProcessorService> get syncProcessors {
    return [
      syncDefaultProcess,
      syncFriendProcess,
      syncMessageProcess,
      syncRoomProcess,
      syncRoomSubscriptionProcess,
    ];
  }

  ///
  /// Sync Variables
  ///
  StreamSubscription? _syncRequiredSubscription;
  Worker? _stateSchemaVersionWorker;
  final _stateSchemaVersion = 0.obs;
  final queue = AsyncQueue.autoStart(allowDuplicate: false);
  final isQueueProcessing = false.obs;

  ///
  /// Metric value
  ///
  final _lastSyncTime = Rx<DateTime?>(null);

  DateTime? get lastSyncTime => _lastSyncTime.value;

  ///
  /// Network monitor
  ///
  Timer? _networkCheckerTimer;
  final _lastRunManualSync = Rx<DateTime?>(null);
  final _lastNetworkCheckTime = Rx<DateTime?>(null);

  DateTime? get lastRunManualSync => _lastRunManualSync.value;

  DateTime? get lastNetworkCheckTime => _lastNetworkCheckTime.value;

  ///
  /// Database variables
  ///

  // TODO: Change to use Repository
  UserDb get _userDb => GetIt.I<UserDb>();

  // TODO: Change to use Repository
  RoomDb get _roomDb => GetIt.I<RoomDb>();

  // TODO: Change to use Repository
  RoomMemberDb get _roomMemberDb => GetIt.I<RoomMemberDb>();

  // TODO: Change to use Repository
  RoomSubscriptionDb get _roomSubDb => GetIt.I<RoomSubscriptionDb>();

  // TODO: Change to use Repository
  RoomFileDb get _roomFileDb => GetIt.I<RoomFileDb>();

  // TODO: Change to use Repository
  ContactDb get _contactDb => GetIt.I<ContactDb>();

  // TODO: Change to use Repository
  MessageDb get _messageDb => GetIt.I<MessageDb>();

  bool get isRequireUpdateSchema {
    return _stateSchemaVersion.value != 0 && _stateSchemaVersion.value != currentUpdateStateSchemaVersion;
  }

  bool get isRequireInitState {
    final isDefaultZero = syncDefaultProcess.currentStateSeq == -1;
    final isMessageZero = syncMessageProcess.currentStateSeq == -1;
    final isRoomZero = syncRoomProcess.currentStateSeq == -1;
    final isRoomSubscriptionZero = syncRoomSubscriptionProcess.currentStateSeq == -1;
    final isFriendZero = syncFriendProcess.currentStateSeq == -1;

    useLogger().d(
      'CurrentState: ${syncDefaultProcess.currentStateSeq},  ${syncMessageProcess.currentStateSeq}, ${syncRoomProcess.currentStateSeq}, ${syncRoomSubscriptionProcess.currentStateSeq}, ${syncFriendProcess.currentStateSeq}, \n'
      'isRequireInitState: $isDefaultZero, $isMessageZero, $isRoomZero, $isRoomSubscriptionZero, $isFriendZero, $isRequireUpdateSchema',
    );

    return isDefaultZero ||
        isMessageZero ||
        isRoomZero ||
        isRoomSubscriptionZero ||
        isFriendZero ||
        isRequireUpdateSchema;
  }

  bool get isNotLoadSyncSeq {
    final isDefaultZero = syncDefaultProcess.currentStateSeq == -2;
    final isMessageZero = syncMessageProcess.currentStateSeq == -2;
    final isRoomZero = syncRoomProcess.currentStateSeq == -2;
    final isRoomSubscriptionZero = syncRoomSubscriptionProcess.currentStateSeq == -2;
    final isFriendZero = syncFriendProcess.currentStateSeq == -2;

    useLogger().d(
      'CurrentState: ${syncDefaultProcess.currentStateSeq},  ${syncMessageProcess.currentStateSeq}, ${syncRoomProcess.currentStateSeq}, ${syncRoomSubscriptionProcess.currentStateSeq}, ${syncFriendProcess.currentStateSeq}, \n'
      'isNotLoadSyncSeq: $isDefaultZero, $isMessageZero, $isRoomZero, $isRoomSubscriptionZero, $isFriendZero',
    );

    return isDefaultZero || isMessageZero || isRoomZero || isRoomSubscriptionZero || isFriendZero;
  }

  SyncServerRepository get syncServerRepository => GetIt.I<SyncServerRepository>();

  bool get isSyncProcessing {
    return syncDefaultProcess.isSyncProcessing.value ||
        syncMessageProcess.isSyncProcessing.value ||
        syncRoomProcess.isSyncProcessing.value ||
        syncRoomSubscriptionProcess.isSyncProcessing.value ||
        syncFriendProcess.isSyncProcessing.value;
  }

  int? get stateSchemaVersion {
    return _stateSchemaVersion.value;
  }

  ///
  /// SyncController constructor
  ///
  SyncService() {
    _syncRequiredSubscription = eventBus.on<SyncRequiredEvent>().listen(
      (event) async {
        addSyncQueue();
      },
    );

    queue.addQueueListener((event) {
      switch (event.type) {
        case QueueEventType.queueStart:
          isQueueProcessing.value = true;
          break;
        case QueueEventType.queueEnd:
        case QueueEventType.queueStopped:
          isQueueProcessing.value = false;
          break;
        default:
      }
    });
  }

  ///
  /// [Network monitor]
  /// Start network monitor to check network status.
  /// When socket is not connected or unstable, run sync by manually.
  ///
  void startNetworkMonitor() {
    if (_networkCheckerTimer != null) {
      _networkCheckerTimer?.cancel();
    }

    _networkCheckerTimer = Timer.periodic(
      const Duration(milliseconds: networkCheckerIntervalMs),
      (timer) async {
        _lastNetworkCheckTime.value = DateTime.now();

        final currentUser = UserController.instance.currentUser();
        if (currentUser == null) {
          return;
        }

        if (SocketCaller.instance.isReadyForCall) {
          return;
        }

        // Check sync process
        if (!UserController.instance.useFirebaseState) {
          addSyncQueue();
        }
        _lastRunManualSync.value = DateTime.now();
      },
    );
  }

  void stopNetworkMonitor() {
    _networkCheckerTimer?.cancel();
    _networkCheckerTimer = null;
  }

  ///
  /// Add state to sync process
  /// For process with sync process group.
  ///
  Future<void> addState(UpdateStateModel state) async {
    useLogger().d('addState: $state');
    // print('ZZZ => Add state: $state');
    switch (state.group) {
      case StateGroup.defaultGroup:
        syncDefaultProcess.addState(state: state);
        break;
      case StateGroup.message:
        syncMessageProcess.addState(state: state);
        break;
      case StateGroup.room:
        syncRoomProcess.addState(state: state);
        break;
      case StateGroup.roomSubscription:
        syncRoomSubscriptionProcess.addState(state: state);
        break;
      case StateGroup.friend:
        syncFriendProcess.addState(state: state);
        break;
    }

    _lastSyncTime.value = DateTime.now();
  }

  void addInitQueue() {
    // queue.clear();
    queue.addJob((_) async {
      try {
        await _init();
      } catch (e, stackTrace) {
        useLogger().e('_init error.', e, stackTrace);
      }
    }, label: 'init');
  }

  void addSyncQueue() {
    queue.addJob((_) async {
      try {
        await _sync();
      } catch (e, stackTrace) {
        useLogger().e('_sync error', e, stackTrace);
      }
    }, label: 'sync');
  }

  // Private init method use with [sync()] method
  // for init seq number for update state.
  Future<void> _init() async {
    useLogger().d('Init update state record.');
    UserController.instance.syncUserCompleted = false;
    _handleUpdateSchemaOverlay(show: true);

    final customTrace = usePerformance().create('sync-init-state');
    await customTrace.start();

    final authInstance = DbManager().authenticatedInstance;
    if (authInstance == null) {
      await _handleAuthInstanceNull(customTrace);
      return;
    }

    try {
      final res = await _initializeStateFromServer(customTrace);
      if (res == null) return;

      await _updateCurrentStateSeq(authInstance, res);
      await Orchestrator.run(OrchestratorTaskType.onSyncInitBeforeWriteToDb);

      await _processRoomEncryption(res);
      await _clearAndSaveToDatabase(authInstance, res);
      await _finalizeInitialization(res);

      notifyInitComplete(isError: false);
    } catch (e, stackTrace) {
      await _handleInitError(e, stackTrace);
    }

    await customTrace.stop();
  }

  /// Handle authentication instance null scenario
  Future<void> _handleAuthInstanceNull(PerformanceTrace customTrace) async {
    await resetAllCurrentStateSeq(saveToDb: false);
    customTrace.incrementMetric('auth-instance-null', 1);
    await customTrace.stop();
    notifyInitComplete(isError: true);
    _handleUpdateSchemaOverlay(show: false);
  }

  /// Initialize state from server
  Future<InitStateModel?> _initializeStateFromServer(PerformanceTrace customTrace) async {
    final res = InitStateModel();

    final initSeqResponse = await syncServerRepository.initStateSeq();
    if (initSeqResponse == null) {
      useLogger().d('Init state null response.');
      await resetAllCurrentStateSeq();
      customTrace.incrementMetric('init-seq-null', 1);
      await customTrace.stop();
      notifyInitComplete(isError: true);
      _handleUpdateSchemaOverlay(show: false);
      return null;
    }
    HomeController.instance.showUpdatingOverlay(false);

    _populateStateSequences(res, initSeqResponse);
    _logStateSequences(res);
    await _populateInitialData(res);

    return res;
  }

  void notifyInitComplete({required bool isError}) {
    UserController.instance.syncUserCompleted = true;
    eventBus.fire(InitCompleteEvent(isError: isError));
  }

  /// Populate state sequences from response
  void _populateStateSequences(InitStateModel res, InitStateSeqsResponse? initSeqResponse) {
    if (initSeqResponse == null) return;
    res.defaultSeq = initSeqResponse.defaultSeq;
    res.messageSeq = initSeqResponse.messageSeq;
    res.friendSeq = initSeqResponse.friendSeq;
    res.roomSeq = initSeqResponse.roomSeq;
    res.roomSubscriptionSeq = initSeqResponse.roomSubscriptionSeq;
  }

  /// Log state sequences for debugging
  void _logStateSequences(InitStateModel res) {
    useLogger().d(
      'Seq =>'
      '\ndefaultSeq: ${res.defaultSeq}, '
      '\nmessageSeq:  ${res.messageSeq}, '
      '\nfriendSeq: ${res.friendSeq}, '
      '\nroomSeq: ${res.roomSeq}, '
      '\nroomSubscriptionSeq: ${res.roomSubscriptionSeq}',
    );
  }

  /// Populate initial data (rooms, contacts, etc.)
  Future<void> _populateInitialData(InitStateModel res) async {
    final initResult = await Future.wait([
      initStateRooms(),
      initStateContacts(),
    ]);

    final (rooms, roomSubs, groupPermissions, members) = initResult[0] as (
      List<RoomCollection>,
      List<RoomSubscriptionCollection>,
      List<GroupPermissionEntity>,
      List<RoomMemberCollection>,
    );

    res.rooms = rooms;
    res.roomSubs = roomSubs;
    res.contacts = initResult[1] as List<ContactCollection>;
    res.groupPermissions = groupPermissions;
    // Store members in a field for later use
    _tempRoomMembers = members;
  }

  /// Update current state sequences in database transaction
  Future<void> _updateCurrentStateSeq(Isar? authInstance, InitStateModel res) async {
    if (authInstance == null) return;
    await authInstance.writeTxn(() async {
      await _updateProcessStateSeq(syncDefaultProcess, res.defaultSeq);
      await _updateProcessStateSeq(syncMessageProcess, res.messageSeq);
      await _updateProcessStateSeq(syncRoomProcess, res.roomSeq);
      await _updateProcessStateSeq(syncRoomSubscriptionProcess, res.roomSubscriptionSeq);
      await _updateProcessStateSeq(syncFriendProcess, res.friendSeq);
    });
  }

  /// Update individual process state sequence
  Future<void> _updateProcessStateSeq(SyncProcessorService processor, int? seq) async {
    if (seq != null && seq > 0) {
      await processor.setCurrentStateSeq(seq, useTransaction: false);
    } else {
      await processor.resetCurrentStateSeq(useTransaction: false);
    }
  }

  /// Process room encryption and room names
  Future<void> _processRoomEncryption(InitStateModel res) async {
    if (res.rooms case final rooms?) {
      await _processRoomNames(rooms, res.roomSubs, _tempRoomMembers);
      await _processRoomCrypto(rooms, res.roomSubs);
    }
  }

  /// Process room names for direct rooms
  Future<void> _processRoomNames(
    List<RoomCollection> rooms,
    List<RoomSubscriptionCollection>? roomSubs,
    List<RoomMemberCollection> roomMembers,
  ) async {
    try {
      await Future.wait(rooms.map((room) async {
        if (room.isGroup) return;

        final index = rooms.indexOf(room);
        final hasFirstOtherInRoom = roomMembers.length > 1;

        roomSubs?[index].hasFirstOtherInRoom = hasFirstOtherInRoom;
        roomSubs?[index].roomName = _generateRoomName(room, roomMembers);
      }));
    } catch (e, stackTrace) {
      useLogger().e('Fetch room member error.', e, stackTrace);
    }
  }

  /// Generate room name based on room type and members
  String? _generateRoomName(RoomCollection room, List<RoomMemberCollection> members) {
    if (room.originalRoomName != null) {
      return room.originalRoomName;
    }

    if (room.roomType == RoomType.direct || room.roomType == RoomType.directSecret) {
      final friendMember = members.firstWhereOrNull((member) {
        return member.accountId != UserController.instance.currentUser.value?.id;
      });

      if (friendMember != null) {
        return friendMember.account?.name ?? friendMember.account?.username;
      } else {
        return 'UNKNOWN'.tr.toUpperCase();
      }
    } else if (room.roomType == RoomType.group) {
      return 'UNTITLED'.tr;
    }

    return null;
  }

  /// Process room crypto keys and decrypt messages
  Future<void> _processRoomCrypto(
    List<RoomCollection> rooms,
    List<RoomSubscriptionCollection>? roomSubs,
  ) async {
    if (roomSubs == null) return;

    try {
      await Future.wait(roomSubs.map((roomSub) async {
        final index = roomSubs.indexOf(roomSub);
        final room = rooms[index];

        final newRoom = await _createRoomCryptoKey(room);
        if (newRoom != null) {
          await _decryptLastMessage(roomSub, newRoom);
          rooms[index] = newRoom;
        }
      }));
    } catch (e, stackTrace) {
      useLogger().e('Create room encryption key error', e, stackTrace);
    }
  }

  /// Create crypto key for a room
  Future<RoomCollection?> _createRoomCryptoKey(RoomCollection room) async {
    try {
      if (room.isSecretRoom) {
        return await EncryptHelper.instance.createSecretRoomCryptoKey(
          room,
          useTransaction: false,
          saveToLocalDb: false,
        );
      } else {
        return await EncryptHelper.instance.createRoomCryptoKey(
          room,
          useTransaction: false,
          saveToLocalDb: false,
        );
      }
    } catch (e, stackTrace) {
      useLogger().e('Create room encryption key error', e, stackTrace);
      return null;
    }
  }

  /// Decrypt last message if encrypted
  Future<void> _decryptLastMessage(RoomSubscriptionCollection roomSub, RoomCollection newRoom) async {
    try {
      final lastMessage = roomSub.lastMessage;
      if (lastMessage != null && lastMessage.type == MessageType.text && lastMessage.isEncrypted == true) {
        final message = lastMessage.message;
        final ref = lastMessage.ref;

        if (message != null && ref != null && message.isNotEmpty == true) {
          lastMessage.message = await EncryptHelper.instance.decrypt(
            text: message,
            cryptoKey: (await newRoom.getRoomCryptoKeyObj())!,
            messageRef: ref,
          );
          lastMessage.isDecryptFailed = false;
        }
      }
    } catch (e, stackTrace) {
      final message = roomSub.lastMessage;
      useLogger().e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'sync message is ${message?.message}',
          additionalData: {
            'message': message?.toMap(),
            'room': newRoom.toMap(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      roomSub.lastMessage?.isDecryptFailed = true;
    }
  }

  /// Clear collections and save data to database
  Future<void> _clearAndSaveToDatabase(Isar? authInstance, InitStateModel res) async {
    if (authInstance == null) return;
    // Clear existing data
    await authInstance.writeTxn(() async {
      await _roomDb.clearCollection();
      await _roomMemberDb.clearCollection();
      await _roomSubDb.clearCollection();
      await _roomFileDb.clearCollection();
      await _contactDb.clearCollection();
    }, silent: true);

    // Save new data
    await authInstance.writeTxn(() async {
      useLogger().d('Starting transaction...');
      try {
        await _saveRoomData(res);
        await _saveContactData(res);
        await _saveGroupPermissions(res);
        useLogger().d('Transaction completed successfully.');
      } catch (e, stacktrace) {
        useLogger().e('Init state error write tx', e, stacktrace);
      }
    });
  }

  /// Save room-related data to database
  Future<void> _saveRoomData(InitStateModel res) async {
    if (res.rooms case final rooms?) {
      await _roomDb.putAllRoomWithoutTxn(rooms);
      await _roomMemberDb.putAllRoomMemberWithoutTxn(_tempRoomMembers);

      if (res.roomSubs case final roomSubs?) {
        await _roomSubDb.putAllRoomSubWithoutTxn(roomSubs);
      }
    }
  }

  /// Save contact data to database
  Future<void> _saveContactData(InitStateModel res) async {
    await GetIt.I<ClearCollectionUseCase>().call(NoParams());
    if (res.contacts != null) {
      await GetIt.I<PutAllContactWithoutTxnUseCase>().call(res.contacts!.toEntities());
    }
  }

  /// Save group permissions to database
  Future<void> _saveGroupPermissions(InitStateModel res) async {
    if (res.groupPermissions case final groupPermissions?) {
      await GetIt.I<UpdateBulkGroupPermissionUseCase>().call(
        UpdateBulkGroupPermissionParams(
          permissions: groupPermissions,
          persistences: {GroupPermissionPersistence.local},
        ),
      );
    }
  }

  /// Finalize initialization process
  Future<void> _finalizeInitialization(InitStateModel res) async {
    useLogger().d('Before process res room.');

    // Initialize room messages asynchronously
    if (res.roomSubs case final roomSubs?) {
      _initRoomMessage(roomSubs).then((value) {
        useLogger().d('Process preload message completed.');
      }).catchError((e, stackTrace) {
        useLogger().e('Call initRoomMessage error.', e, stackTrace);
      });
    }

    // Update app badge count
    if (!Platform.isWindows) {
      final badgeCount = await _roomSubDb.getAllUnreadCount();
      await AppBadgePlus.updateBadge(badgeCount);
    }

    _handleUpdateSchemaOverlay(show: false);
    _stateSchemaVersion(currentUpdateStateSchemaVersion);

    await Orchestrator.run(OrchestratorTaskType.onSyncInitAfterWriteToDb);
    eventBus.fire(ContactListRequireRefreshEvent());
  }

  /// Handle initialization error
  Future<void> _handleInitError(Object e, StackTrace stackTrace) async {
    useLogger().e('Call _init error.', e, stackTrace);
    notifyInitComplete(isError: true);
    await resetAllCurrentStateSeq();
  }

  /// Handle update schema overlay visibility
  void _handleUpdateSchemaOverlay({required bool show}) {
    if (isRequireUpdateSchema) {
      if (show) {
        HomeController.instance.showUpdatingOverlay(true);
      } else {
        HomeController.instance.hideUpdatingOverlay();
      }
    }
  }

  Future<
      (
        List<RoomCollection>,
        List<RoomSubscriptionCollection>,
        List<GroupPermissionEntity>,
        List<RoomMemberCollection>,
      )> initStateRooms() async {
    final trace = usePerformance().create('init-state-rooms');
    await trace.start();

    try {
      // Fetch first page to get total pages
      final firstPageResponse = await _fetchRoomsPage(1);
      if (firstPageResponse == null) {
        useLogger().w('Failed to fetch first page of rooms');
        return (
          <RoomCollection>[],
          <RoomSubscriptionCollection>[],
          <GroupPermissionEntity>[],
          <RoomMemberCollection>[]
        );
      }

      final totalPages = firstPageResponse.totalPages;
      useLogger().d('Fetching $totalPages pages of room data');

      // Process first page
      final roomsData = _RoomsDataAccumulator();
      _processRoomsPageData(firstPageResponse.data?.toList(), roomsData);

      // Fetch remaining pages if needed
      if (totalPages > 1) {
        await _fetchRemainingRoomPages(roomsData, totalPages);
      }

      final result = roomsData.toTuple();
      useLogger().d(
        'Init rooms completed: ${result.$1.length} rooms, ${result.$2.length} subscriptions, '
        '${result.$3.length} permissions, ${result.$4.length} members',
      );

      return result;
    } catch (e, stackTrace) {
      useLogger().e('Error initializing room state', e, stackTrace);
      return (<RoomCollection>[], <RoomSubscriptionCollection>[], <GroupPermissionEntity>[], <RoomMemberCollection>[]);
    } finally {
      await trace.stop();
    }
  }

  /// Fetch a specific page of rooms data
  Future<PaginationPayload<InitStateRoomsResponse>?> _fetchRoomsPage(int page) async {
    try {
      return await syncServerRepository.initStateRooms(InitStateRoomsRequest(page: page));
    } catch (e, stackTrace) {
      useLogger().e('Failed to fetch rooms page $page', e, stackTrace);
      return null;
    }
  }

  /// Fetch all remaining pages concurrently for better performance
  Future<void> _fetchRemainingRoomPages(_RoomsDataAccumulator accumulator, int totalPages) async {
    // Create batch requests for better performance
    const batchSize = 5; // Limit concurrent requests to avoid overwhelming server

    for (int startPage = 2; startPage <= totalPages; startPage += batchSize) {
      final endPage = (startPage + batchSize - 1).clamp(startPage, totalPages);
      final pageRequests = <Future<PaginationPayload<InitStateRoomsResponse>?>>[];

      // Create batch of concurrent requests
      for (int page = startPage; page <= endPage; page++) {
        UserController.instance.loadingTaskStatus('Loading....'.tr);
        UserController.instance.loadingStatePercentage((page / totalPages * 100).ceil());
        pageRequests.add(_fetchRoomsPage(page));
      }

      // Wait for batch to complete
      final responses = await Future.wait(pageRequests);

      // Process all responses in the batch
      for (final response in responses) {
        if (response?.data != null) {
          _processRoomsPageData(response?.data?.toList(), accumulator);
        }
      }
    }
  }

  /// Process data from a single page response
  void _processRoomsPageData(List<InitStateRoomsResponse>? data, _RoomsDataAccumulator accumulator) {
    if (data == null) return;

    // Pre-allocate lists for better performance
    final roomsToAdd = <RoomCollection>[];
    final roomSubsToAdd = <RoomSubscriptionCollection>[];
    final membersToAdd = <RoomMemberCollection>[];
    final permissionsToAdd = <GroupPermissionEntity>[];

    // Process all items in single pass for better performance
    for (final item in data) {
      try {
        // Extract required data
        roomsToAdd.add(item.room);
        roomSubsToAdd.add(item.roomSub);

        // Add members if present
        if (item.members != null) {
          membersToAdd.addAll(item.members!);
        }

        // Add group permission if present
        if (item.groupPermission != null) {
          permissionsToAdd.add(item.groupPermission!);
        }
      } catch (e, stackTrace) {
        useLogger().w('Error processing room item', e, stackTrace);
        // Continue processing other items
      }
    }

    // Add all processed items to accumulator
    accumulator.addRooms(roomsToAdd);
    accumulator.addRoomSubs(roomSubsToAdd);
    accumulator.addMembers(membersToAdd);
    accumulator.addGroupPermissions(permissionsToAdd);
  }

  Future<List<ContactCollection>> initStateContacts() async {
    final trace = usePerformance().create('init-state-contacts');
    await trace.start();

    try {
      // Fetch first page to get total pages
      final firstPageResponse = await _fetchContactsPage(1);
      if (firstPageResponse == null) {
        useLogger().w('Failed to fetch first page of contacts');
        return <ContactCollection>[];
      }

      final contacts = <ContactCollection>[];

      // Process first page
      _processContactsPageData(firstPageResponse.data?.toList(), contacts);

      final totalPages = firstPageResponse.totalPages;
      useLogger().d('Fetching $totalPages pages of contact data');

      // Fetch remaining pages concurrently if needed
      if (totalPages > 1) {
        await _fetchRemainingContactsPages(contacts, totalPages);
      }

      useLogger().d('Init contacts completed: ${contacts.length} contacts');
      return contacts;
    } catch (e, stackTrace) {
      useLogger().e('Error initializing contacts state', e, stackTrace);
      return <ContactCollection>[];
    } finally {
      await trace.stop();
    }
  }

  /// Fetch a specific page of contacts data
  Future<PaginationPayload<InitStateContactsResponse>?> _fetchContactsPage(int page) async {
    try {
      return await syncServerRepository.initStateContacts(InitStateContactsRequest(page: page));
    } catch (e, stackTrace) {
      useLogger().e('Failed to fetch contacts page $page', e, stackTrace);
      return null;
    }
  }

  /// Fetch remaining contact pages concurrently
  Future<void> _fetchRemainingContactsPages(List<ContactCollection> contacts, int totalPages) async {
    const batchSize = 5; // Limit concurrent requests

    for (int startPage = 2; startPage <= totalPages; startPage += batchSize) {
      final endPage = (startPage + batchSize - 1).clamp(startPage, totalPages);
      final pageRequests = <Future<dynamic>>[];

      // Create batch of concurrent requests
      for (int page = startPage; page <= endPage; page++) {
        UserController.instance.loadingTaskStatus('Loading...');
        UserController.instance.loadingStatePercentage((page / totalPages * 100).ceil());
        pageRequests.add(_fetchContactsPage(page));
      }

      // Wait for batch to complete and process results
      final responses = await Future.wait(pageRequests);
      for (final response in responses) {
        if (response?.data != null) {
          _processContactsPageData(response.data, contacts);
        }
      }
    }
  }

  /// Process contacts data from a single page response
  void _processContactsPageData(List<InitStateContactsResponse>? data, List<ContactCollection> contacts) {
    if (data == null) return;

    try {
      final contactsToAdd = data.map((e) => e.contact!).cast<ContactCollection>().toList();
      contacts.addAll(contactsToAdd);
    } catch (e, stackTrace) {
      useLogger().w('Error processing contacts page data', e, stackTrace);
      // Process items individually as fallback
      for (final item in data) {
        try {
          if (item.contact != null) {
            contacts.add(item.contact!);
          }
        } catch (itemError) {
          useLogger().w('Error processing individual contact item', itemError);
          // Continue processing other items
        }
      }
    }
  }

  Future<void> _sync() async {
    if (UserController.instance.currentUser() == null) {
      /// If sync is called when user is not logged in, stop syncing because there is no user there is nothing to sync.
      return;
    }

    if (isNotLoadSyncSeq) {
      await onUserLoaded();
    }

    // Check current state seq
    if (isRequireInitState) {
      final requireInitStateTrace = usePerformance().newTrace('require-init-state');
      await requireInitStateTrace.start();

      useLogger().d('Init new state...');
      try {
        addInitQueue();
        return;
      } catch (e, stackTrace) {
        useLogger().e('Cannot init new state', e, stackTrace);
        // TODO: Handle this error.
        rethrow;
      } finally {
        await requireInitStateTrace.stop();
      }
    }
    final customTrace = usePerformance().newTrace('sync-state');
    await customTrace.start();

    /// [SyncProcess]
    /// Run sync function
    bool isStateLimitExceed = false;

    try {
      final messageStateResult = await syncMessageProcess.fetchStates();
      await syncMessageProcess.sync(messageStateResult);

      final result = await Future.wait([
        syncRoomSubscriptionProcess.fetchStates(),
        syncDefaultProcess.fetchStates(),
        syncRoomProcess.fetchStates(),
        syncFriendProcess.fetchStates(),
      ]);
      await syncRoomSubscriptionProcess.sync(result[0]);
      await syncDefaultProcess.sync(result[1]);
      await syncRoomProcess.sync(result[2]);
      await syncFriendProcess.sync(result[3]);

      // Call notify init complete to trigger go to home screen in login welcome screen when adding account in multiple account feature
      // In some cases when adding existing account, init state is not needed and only sync is called. So we need to call notify init complete here.
      notifyInitComplete(isError: false);
      HomeController.instance.hideSplash();
    } on ApiStateLimitExceedException catch (e, stackTrace) {
      useLogger().d('Sync new state because STATE_LIMIT_EXCEED...', e, stackTrace);
      isStateLimitExceed = true;
    } catch (e, stackTrace) {
      useLogger().e('Call sync error.', e, stackTrace);
      await customTrace.stop();
      // Call notify init complete to trigger go to home screen in login welcome screen when adding account in multiple account feature
      // In some cases when adding existing account, init state is not needed and only sync is called. So we need to call notify init complete here.
      notifyInitComplete(isError: true);
      rethrow;
    } finally {
      _lastSyncTime.value = DateTime.now();
    }

    // When sync has result STATE_LIMIT_EXCEED.
    if (isStateLimitExceed) {
      try {
        addInitQueue();
        return;
      } catch (e, stackTrace) {
        useLogger().e('Call sync error.', e, stackTrace);
        await customTrace.stop();
        rethrow;
      }
    }

    await customTrace.stop();
  }

  void dispose() {
    _syncRequiredSubscription?.cancel();
  }

  void disposeSyncProcess() {
    /// [SyncProcess]
    /// Sync process dispose worker
    syncDefaultProcess.disposeWorker();
    syncMessageProcess.disposeWorker();
    syncRoomProcess.disposeWorker();
    syncRoomSubscriptionProcess.disposeWorker();
    syncFriendProcess.disposeWorker();

    stopNetworkMonitor();
  }

  Future<void> onUserLoaded() async {
    useLogger().d('Run onSetCurrentUserToMemory.');

    final currentUser = UserController.instance.currentUser();
    if (currentUser == null) {
      return;
    }

    _stateSchemaVersionWorker?.dispose();
    _stateSchemaVersionWorker = null;

    disposeSyncProcess();

    useLogger().d(
      '[User logged in event]\n'
      'UserID: ${currentUser.id},\n'
      'SchemaVersion: ${currentUser.schemaVersion}',
    );

    /// [SyncProcess]
    /// Sync process load current state seq
    await Future.wait([
      syncDefaultProcess.loadCurrentStateSeq(),
      syncMessageProcess.loadCurrentStateSeq(),
      syncRoomProcess.loadCurrentStateSeq(),
      syncRoomSubscriptionProcess.loadCurrentStateSeq(),
      syncFriendProcess.loadCurrentStateSeq(),
    ]);

    syncDefaultProcess.initWorker();
    syncMessageProcess.initWorker();
    syncRoomProcess.initWorker();
    syncRoomSubscriptionProcess.initWorker();
    syncFriendProcess.initWorker();

    _loadCurrentStateAndSchemaVersionWorkerFromUser(UserCollection.fromEntity(currentUser));
    _initCurrentStateAndSchemaVersionWorker();

    if (isRequireUpdateSchema) {
      HomeController.instance.showUpdatingOverlay(true);
    }
  }

  void _loadCurrentStateAndSchemaVersionWorkerFromUser(UserCollection user) {
    final loadSchemaVersion = user.schemaVersion ?? 0;
    _stateSchemaVersion(loadSchemaVersion);
  }

  void _initCurrentStateAndSchemaVersionWorker() {
    _stateSchemaVersionWorker = ever(_stateSchemaVersion, (val) {
      UserEntity? currentUser = UserController.instance.currentUser.value;
      // _log.i('stateSchemaVersionWorker: currentUser: ${currentUser?.id}, $val');

      if (currentUser != null) {
        currentUser = currentUser.copyWith(
          schemaVersion: val,
        );
        _userDb.putUser(UserCollection.fromEntity(currentUser));
      }
    });
  }

  // TODO: Please improve this logic
  Future<void> _initRoomMessage(List<RoomSubscriptionCollection> roomSubs) async {
    await DbManager().authenticatedInstance?.writeTxn(() async {
      await _messageDb.clearCollection();
      useLogger().d('Cleared messages.');
    });

    roomSubs.sort((b, a) {
      if (a.roomLocalDateTime == null && b.roomLocalDateTime == null) {
        return -1;
      } else if (a.roomLocalDateTime == null && b.roomLocalDateTime != null) {
        return -1;
      } else if (a.roomLocalDateTime != null && b.roomLocalDateTime == null) {
        return 1;
      }

      final aCreatedAt = a.roomLocalDateTime!;
      final bCreatedAt = b.roomLocalDateTime!;

      return aCreatedAt.compareTo(bCreatedAt);
    });

    final roomForInitial = roomSubs.filter((room) {
      return room.isPinned == true;
    }).toList();
    roomForInitial.addAll(roomSubs.filter((room) {
      return room.isPinned != true;
    }).take(10));

    // print('ZZZ => Room for initial: ${roomForInitial.length} items.');

    final List<MessageCollection> messageFromInitial = [];
    await Future.wait(roomForInitial.map((room) async {
      final id = room.roomId;
      if (id == null) {
        return;
      }

      try {
        final result = await MessageService().fetchMessagesFromServer(id);
        if (result?.messages case final messages?) {
          messageFromInitial.addAll(messages);
        }
      } catch (e, stackTrace) {
        useLogger().e('Call fetchMessagesFromServer error.', e, stackTrace);
      }
    }));

    await DbManager().authenticatedInstance?.writeTxn(() async {
      await _messageDb.putAllMessagesWithoutTxn(messageFromInitial);
      try {
        await _initRoomSubOldestMessageSequence(roomForInitial, messageFromInitial);
      } catch (e, stackTrace) {
        useLogger().e('Call _initRoomSubOldestMessageSequence error.', e, stackTrace);
      }
    });
  }

  Future<void> _initRoomSubOldestMessageSequence(
    List<RoomSubscriptionCollection> roomSubs,
    List<MessageCollection> messageFromInitial,
  ) async {
    for (final roomSub in roomSubs) {
      final messages = messageFromInitial.where((e) => e.roomId == roomSub.roomId).toList();

      if (messages.isNotEmpty) {
        roomSub.newestMsgSeq = messages.firstOrNull?.sequence;
        roomSub.oldestMsgSeq = messages.lastOrNull?.sequence;
        await GetIt.I<RoomSubLocalRepository>().putRoomSubscriptionWithoutTxn(roomSub.toEntity());
      }
    }
  }

  Future<void> clearAllCurrentStateSeq() async {
    await DbManager().authenticatedInstance?.writeTxn(() async {
      await syncDefaultProcess.clearCurrentStateSeq();
      await syncMessageProcess.clearCurrentStateSeq();
      await syncRoomProcess.clearCurrentStateSeq();
      await syncRoomSubscriptionProcess.clearCurrentStateSeq();
      await syncFriendProcess.clearCurrentStateSeq();
    });
  }

  Future<void> resetAllCurrentStateSeq({bool saveToDb = true}) async {
    await DbManager().authenticatedInstance?.writeTxn(() async {
      await syncDefaultProcess.resetCurrentStateSeq(useTransaction: false, saveToDb: saveToDb);
      await syncMessageProcess.resetCurrentStateSeq(useTransaction: false, saveToDb: saveToDb);
      await syncRoomProcess.resetCurrentStateSeq(useTransaction: false, saveToDb: saveToDb);
      await syncRoomSubscriptionProcess.resetCurrentStateSeq(useTransaction: false, saveToDb: saveToDb);
      await syncFriendProcess.resetCurrentStateSeq(useTransaction: false, saveToDb: saveToDb);
    });
  }
}
