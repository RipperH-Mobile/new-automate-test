import 'dart:io';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/maintenance_dialog_data_model.dart';
import 'package:uchat/entities/models/notification_desktop_model.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/call/socket_call_process.dart';
import 'package:uchat/features/central_notification/central_notification_barrel.dart';
import 'package:uchat/features/central_notification/data/data_source/local/central_notification_db.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/features/chat_folder/chat_folder_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/sync_barrel.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SocketHandler {
  /// Instance
  factory SocketHandler() => instance;

  SocketHandler.internal();

  static final SocketHandler instance = SocketHandler.internal();

  /// Variable
  final socketCaller = SocketCaller();
  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();
  final centralNotiDb = GetIt.I<CentralNotificationDb>();

  // final chatFolderDb = ChatFolderDb();

  Socket get socket {
    return SocketCaller().socket;
  }

  ContactsController get contactsCtl {
    return Get.find<ContactsController>();
  }

  void subscribe() {
    socket.emit('call', ['account.subscribe']);
    socket.emit('call', ['announcement.subscribe']);

    if (!socket.hasListeners('update_state')) {
      socket.on('update_state', onUpdateState);
    }

    if (!socket.hasListeners('roomCall')) {
      socket.on('roomCall', onRoomCallEvent);
    }

    if (!socket.hasListeners('announce')) {
      socket.on('announce', onAnnounceEvent);
    }

    if (!socket.hasListeners('room_request_count')) {
      socket.on('room_request_count', onGroupInviteEvent);
    }

    if (!socket.hasListeners('friend_request_count')) {
      socket.on('friend_request_count', onFriendRequestEvent);
    }

    if (!socket.hasListeners('typing_user')) {
      socket.on('typing_user', onTypingUserEvent);
    }

    if (!socket.hasListeners('notification_center')) {
      socket.on('notification_center', onUpdateCentralNotificationEvent);
    }

    if (!socket.hasListeners('coin_update')) {
      socket.on('coin_update', onCoinUpdateEvent);
    }

    if (!socket.hasListeners('account_update')) {
      socket.on('account_update', onAccountUpdateEvent);
    }

    if (!socket.hasListeners('maintenance')) {
      socket.on('maintenance', onMaintenanceModeIsOnEvent);
    }

    if (!socket.hasListeners('waiting_members_update')) {
      socket.on('waiting_members_update', onWaitingMembersUpdateEvent);
    }
    if (!socket.hasListeners('notification_desktop') && Platform.isMacOS) {
      socket.on('notification_desktop', onUpdateCentralNotificationDesktopEvent);
    }

    if (!socket.hasListeners('chatFolder')) {
      socket.on('chatFolder', onChatFolderEvent);
    }
  }

  void unSubscribe() {
    socket.emit('call', ['account.unsubscribe']);
    socket.emit('call', ['announcement.unsubscribe']);

    if (socket.hasListeners('update_state')) {
      socket.off('update_state', onUpdateState);
    }

    if (socket.hasListeners('roomCall')) {
      socket.off('roomCall', onRoomCallEvent);
    }

    if (socket.hasListeners('announce')) {
      socket.off('announce', onAnnounceEvent);
    }

    if (socket.hasListeners('room_request_count')) {
      socket.off('room_request_count', onGroupInviteEvent);
    }

    if (socket.hasListeners('friend_request_count')) {
      socket.off('friend_request_count', onFriendRequestEvent);
    }

    if (socket.hasListeners('typing_user')) {
      socket.off('typing_user', onTypingUserEvent);
    }

    if (socket.hasListeners('notification_center')) {
      socket.off('notification_center', onUpdateCentralNotificationEvent);
    }

    if (socket.hasListeners('coin_update')) {
      socket.off('coin_update', onCoinUpdateEvent);
    }

    if (socket.hasListeners('account_update')) {
      socket.off('account_update', onAccountUpdateEvent);
    }

    if (socket.hasListeners('maintenance')) {
      socket.off('maintenance', onMaintenanceModeIsOnEvent);
    }

    if (socket.hasListeners('waiting_members_update')) {
      socket.off('waiting_members_update', onWaitingMembersUpdateEvent);
    }
    if (socket.hasListeners('notification_desktop') && Platform.isMacOS) {
      socket.off('notification_desktop', onUpdateCentralNotificationDesktopEvent);
    }

    if (socket.hasListeners('chatFolder')) {
      socket.off('chatFolder', onChatFolderEvent);
    }
  }

  Future<void> onUpdateState(data) async {
    if (UserController.instance.useFirebaseState) return;
    try {
      final state = UpdateStateModel.fromMap(data);
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.receiveStateFromSocket,
        eventProperties: EventProperty.stateReceived(state),
      );

      await GetIt.I<SyncService>().addState(state);
    } catch (e, stackTrace) {
      _log.w('Call onUpdateState error.', e, stackTrace);
    }
  }

  Future<void> onRoomCallEvent(data) async {
    try {
      final callEvent = RoomCallModel.fromMap(data['data']);
      await SocketCallProcess.instance.processCallSocket(callEvent);
      // _log.d('room call event: ${callEvent.type}, uuid:${callEvent.liveKitRoomSID}, ski:${callEvent.callOnSessionKeyId}');
      // CallController.instance.addQueue(callEvent);
      // CallController.instance.processQueue();
    } catch (e, stackTrace) {
      _log.w('Call onRoomCallEvent error.', e, stackTrace);
    }
  }

  Future<void> onAnnounceEvent(data) async {
    try {
      _log.d(
        'onAnnounceEvent.\n'
        '$data',
      );
      final announcements = <AnnouncementCollection>[];
      for (Map<String, dynamic> data in data) {
        announcements.add(
          AnnouncementCollection.fromMap(data),
        );
      }
      await AnnouncementDb().putAnnouncements(announcements: announcements);
      eventBus.fire(StartAnnouncementEvent(announcements: announcements));

      // Todo: start announcement
    } catch (e, stackTrace) {
      _log.w('Call onAnnounceEvent error.', e, stackTrace);
    }
  }

  Future<void> onGroupInviteEvent(data) async {
    try {
      if (data == null) return;

      contactsCtl.addNewGroupInviteToList(data);
    } catch (e, stackTrace) {
      _log.w('Call onGroupInviteEvent error', e, stackTrace);
    }
  }

  Future<void> onFriendRequestEvent(data) async {
    try {
      if (data == null) return;

      contactsCtl.addNewFriendRequestToList(data);
    } catch (e, stackTrace) {
      _log.w('Call onFriendRequestEvent error', e, stackTrace);
    }
  }

  Future<void> onTypingUserEvent(data) async {
    final String? accountId = data['_id'];
    final String? roomId = data['roomId'];
    final DateTime? lastTypedAt = strToDateTime(data['lastTypedAt']);
    final bool? isTyping = data['isTyping'];

    if (accountId == null || roomId == null || isTyping == null || (isTyping == true && lastTypedAt == null)) {
      _log.w('onTypingUserEvent data is not valid : $data');
      return;
    }

    final member = await roomMemberDb.getOneMemberInRoom(roomId, accountId);
    if (member != null) {
      if (isTyping) {
        member.lastTypedAt = lastTypedAt;
      } else {
        member.lastTypedAt = null;
      }

      try {
        await roomMemberDb.putRoomMember(member);
      } catch (e, stacktrace) {
        _log.e('put member in onTypingUserEvent error', e, stacktrace);
      }
    } else {
      _log.w('member not found in local db in onTypingUserEvent. roomId : $roomId, accountId : $accountId');
    }

    eventBus.fire(UserInRoomTypingEvent(
      accountId: accountId,
      roomId: roomId,
      lastTypedAt: lastTypedAt,
      isTyping: isTyping,
      displayName: data['displayName'],
    ));
  }

  Future<void> onUpdateCentralNotificationEvent(data) async {
    if (data == null) return;

    try {
      final centralNotiData = CentralNotificationCollection.fromMap(data);
      await GetIt.I<PutNotificationToLocalUseCase>().call(PutNotificationParam(
        notiEntity: centralNotiData.toEntity(),
      ));

      eventBus.fire(CentralNotificationUpdateEvent(centralNoti: centralNotiData));

      final notiUnreadCount = int.tryParse(centralNotiData.notiUnreadCount ?? '0') ?? 0;
      CentralNotificationController.instance.notiUnreadCount(notiUnreadCount);

      final dateTimeNow = DateTime.now().toUtc();
      final createdAt = centralNotiData.createdAt ?? dateTimeNow;
      final lastReadNotiAt = (await ConfigDb().authenticated.getDateTime(key: notiLastReadAtKey)) ?? dateTimeNow;

      if (createdAt.isAfter(lastReadNotiAt)) {
        await ConfigDb().authenticated.saveConfig(key: notiLastReadAtKey, value: createdAt.toUtc());
        await ConfigDb().authenticated.saveConfig(key: notiUnreadCountKey, value: notiUnreadCount);
      }

      eventBus.fire(CentralNotificationLastSeenUpdateEvent());
    } catch (e, stacktrace) {
      _log.e('put contact in onOnlineUserEvent error', e, stacktrace);
    }
  }

  Future<void> onUpdateCentralNotificationDesktopEvent(data) async {
    if (data == null) return;

    final notificationDesktopData = NotificationDesktopDataModel.fromMap(data);
    try {
      eventBus.fire(NotificationDesktopUpdateEvent(notificationDesktop: notificationDesktopData));
    } catch (e, stacktrace) {
      _log.e('onUpdateCentralNotificationDesktopEvent error', e, stacktrace);
    }
  }

  Future<void> onCoinUpdateEvent(data) async {
    if (data == null) return;

    final coinUpdateResponse = CoinUpdateResponse.fromMap(data);

    try {
      eventBus.fire(CoinUpdateEvent(coinUpdateResponse: coinUpdateResponse));
    } catch (e, stacktrace) {
      _log.e('CoinsUpdateEvent error', e, stacktrace);
    }
  }

  Future<void> onWaitingMembersUpdateEvent(data) async {
    if (data == null) return;

    try {
      eventBus.fire(
        WaitingMemberUpdateEvent.fromMap(data),
      );
    } catch (e, stackTrace) {
      _log.e('onWaitingMembersUpdateEvent error', e, stackTrace);
    }
  }

  Future<void> onMaintenanceModeIsOnEvent(data) async {
    if (data == null) return;

    try {
      final maintenance = MaintenanceDialogDataModel.fromMap(
        data,
      );

      _log.d('Maintenance is on: ${maintenance.isMaintenance}');

      final isMaintenance = maintenance.isMaintenance ?? false;
      final currentUserId = UserController.instance.currentUser.value?.id;

      if (isMaintenance && currentUserId != null) {
        _handleMaintenanceMode(maintenance, currentUserId);
      } else {
        SocketCaller.instance.connect();
      }

      eventBus.fire(MaintenanceModeUpdateEvent(
        isMaintenanceOn: maintenance.isMaintenance ?? false,
      ));
    } catch (e) {
      _log.e('onMaintenanceModeIsOnEvent', e);
    }
  }

  void _handleMaintenanceMode(MaintenanceDialogDataModel maintenance, String currentUserId) {
    final isUserInWhitelist = maintenance.whitelist?.contains(currentUserId) ?? false;

    if (!isUserInWhitelist) {
      final message = maintenance.getMessageData(
            AnnouncementController.instance.lang.toUpperCase(),
          ) ??
          maintenance.message ??
          '';

      SocketCaller.instance.disconnect();
      AppController.instance.showMaintenanceDialog(message);
    }
  }

  Future<void> onAccountUpdateEvent(data) async {
    try {
      _log.d(
        'onAccountUpdateEvent.\n'
        '$data',
      );
      // check for 'isBanned' if account has been ban
      if (data['isBanned'] == true) {
        // dialog for banned user
        final descriptionObj = (data['descriptionObj'] as Map<String, dynamic>?);
        final String? content = descriptionObj?[Get.locale?.languageCode.toUpperCase() ?? 'EN'];
        UChatNewDialog.showAccountBannedDialog(
            context: Get.context!,
            content: content,
            onConfirm: () {
              GetIt.I<AccountsCenterService>().logoutCurrentUser(showDialog: false);
            });
      }
    } catch (e, stackTrace) {
      _log.w('Call onAccountUpdateEvent error.', e, stackTrace);
    }
  }

  Future<void> onChatFolderEvent(data) async {
    try {
      _log.d('onChatFolderEvent.\n$data');
      final String eventType = data['type'] != null ? data['type'] as String : '';

      if (data['data'] == null) {
        _log.w('onChatFolderEvent data is null.');
        return;
      }

      // TODO: fire event bus to update chat folder, and handle all in chat folder controller

      switch (eventType) {
        case 'CREATE':
          final Map<String, dynamic> eventData = data['data'] != null ? data['data'] as Map<String, dynamic> : {};
          if (eventData.isEmpty) {
            _log.w('onChatFolderEvent data is empty.');
            return;
          }

          // print('ZZZ => eventData: $eventData');

          final chatFolder = ChatFolderEntity.fromMap(eventData);
          eventBus.fire(ChatFolderCreateEvent(chatFolder: chatFolder));

          break;
        case 'UPDATE':
        // continue to REORDER, process the same as REORDER
        case 'DELETE':
        // continue to REORDER, process the same as REORDER
        case 'REORDER':
          if (data['data'] is! List) {
            _log.w('onChatFolderEvent data is not List.');
            return;
          }

          final chatFolders = (data['data'] as List).map((cf) => ChatFolderEntity.fromMap(cf)).toList();
          eventBus.fire(ChatFolderUpdateEvent(chatFolders: chatFolders.toList()));

          break;
        default:
          break;
      }
    } catch (e, stackTrace) {
      _log.w('Call onChatFolderEvent error.', e, stackTrace);
    }
  }
}
