import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/core/event_bus/events/update_admin_permission_event.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/album/domain/events/album_delete_event.dart';
import 'package:uchat/features/album/domain/events/album_update_event.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_group_permission_use_case.dart';
import 'package:uchat/features/sync/data/models/entities/assign_admin_state_data_model.dart';
import 'package:uchat/features/sync/data/models/entities/remove_member_state_data_model.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/datetime.dart';

import '../../data/models/entities/member_state_data_model.dart';
import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/update_state_type.dart';
import '../typedefs.dart';
import 'sync_handle_update_has_first_other_in_room_use_case.dart';
import 'sync_handle_update_room_use_case.dart';
import 'sync_handle_update_user_use_case.dart';

class ProcessGroupRoomUseCase extends SimpleUseCase<EventListCallback, UpdateStateModel> {
  RoomDb get _roomDb {
    return GetIt.I<RoomDb>();
  }

  RoomMemberDb get _roomMemberDb {
    return GetIt.I<RoomMemberDb>();
  }

  AlbumDb get _albumDb {
    return GetIt.I<AlbumDb>();
  }

  MessageDb get _messageDb {
    return GetIt.I<MessageDb>();
  }

  RoomSubscriptionDb get _roomSubDb {
    return GetIt.I<RoomSubscriptionDb>();
  }

  RoomFileDb get _roomFileDb {
    return GetIt.I<RoomFileDb>();
  }

  UserDb get _userDb {
    return GetIt.I<UserDb>();
  }

  ConfigDb get _configDb {
    return GetIt.I<ConfigDb>();
  }

  SyncHandleUpdateRoomUseCase get _handleUpdateRoom {
    return GetIt.I<SyncHandleUpdateRoomUseCase>();
  }

  SyncHandleUpdateHasFirstOtherInRoomUseCase get _updateHasFirstOtherInRoom {
    return GetIt.I<SyncHandleUpdateHasFirstOtherInRoomUseCase>();
  }

  @override
  Future<EventListCallback> call(UpdateStateModel state) async {
    final EventListCallback eventList = [];
    switch (state.type) {
      case UpdateStateType.addRoomMember:
        if (state.membersData case final memberData?) {
          final eventCb = await _addRoomMember(memberData);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.deleteAlbum:
        if (state.album case final album?) {
          final eventCb = await _deleteAlbum(album);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.deleteImage:
        // TODO (sync refactor) Recheck what to do with this state.
        break;
      case UpdateStateType.deleteRoom:
        if (state.room case final room?) {
          final eventCb = await _deleteRoom(
            room,
            state.data['lastSequence'],
            isDeleteInContact: false,
          );
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.newRoom:
      case UpdateStateType.updateRoom:
      case UpdateStateType.updateAdminsRoom:
        if (state.room case final room?) {
          final eventCb = await _handleUpdateRoom.call(SyncHandleUpdateRoomParams(
            receiveRoom: room,
            roomSubInRoom: state.roomSubInRoom,
            isNewRoom: state.type == UpdateStateType.newRoom,
          ));
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.removeRoomMember:
        if (state.removeMembersData case final memberData?) {
          final eventCb = await _removeRoomMember(memberData);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateInvitedUser:
        if (state.user case final user?) {
          final eventCb = await _updateUser(user);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateMembersAlbum:
        if (state.album case final album?) {
          final eventCb = await _updateAlbum(album);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateRoomMember:
        if (state.membersData case final memberData?) {
          final eventCb = await _updateRoomMember(memberData);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateRoomMemberLastSeen:
        final eventCb = await _updateRoomMemberLastSeen(state.data);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.updateUser:
        if (state.user case final user?) {
          // print('ZZZ => Room > UpdateStateType.updateUser');
          final eventCb =
              await GetIt.I<SyncHandleUpdateUserUseCase>().call(SyncHandleUpdateUserParams(receiveUser: user));
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateUserDeletedRoom:
        // TODO (sync refactor) Recheck what to do with this state.
        break;

      case UpdateStateType.assignRoomAdmin:
        if (state.assignAdmin case final assignAdmin) {
          final eventCb = await _updateRoomMemberRole(
            assignAdmin,
            role: RoomMemberRole.admin,
            type: UpdateStateType.assignRoomAdmin,
            customTitle: assignAdmin.customTitle,
          );
          eventList.addAll(eventCb);
        }
        break;

      case UpdateStateType.revokeRoomAdmin:
        if (state.assignAdmin case final assignAdmin) {
          final eventCb = await _updateRoomMemberRole(
            assignAdmin,
            role: RoomMemberRole.member,
            type: UpdateStateType.revokeRoomAdmin,
            customTitle: null,
          );
          eventList.addAll(eventCb);
        }
        break;

      case UpdateStateType.updateRoomAdminPermissions:
        if (state.assignAdmin case final assignAdmin) {
          final eventCb = await _updateRoomMemberRole(
            assignAdmin,
            role: RoomMemberRole.admin,
            type: UpdateStateType.updateRoomAdminPermissions,
            customTitle: assignAdmin.customTitle,
          );
          eventList.addAll(eventCb);
        }
        break;

      case UpdateStateType.updateRoomPermissions:
        if (state.updateRoomPermissions case final permissions) {
          try {
            await GetIt.I<UpdateGroupPermissionUseCase>().call(
              UpdateGroupPermissionParams(
                permission: permissions,
                persistences: {GroupPermissionPersistence.local},
              ),
            );
          } catch (e, stackTrace) {
            useLogger().e('Error processing updateRoomPermissions state: $e', e, stackTrace);
          }
        }
        break;

      default:
        useLogger().w('Skipping state type ${state.type} from ProcessGroupRoomUseCase');
        break;
    }

    return eventList;
  }

  Future<EventListCallback> _updateRoomMemberRole(
    AssignAdminStateDataModel assignAdmin, {
    required RoomMemberRole role,
    required UpdateStateType type,
    String? customTitle,
  }) async {
    final EventListCallback eventList = [];

    final updateMember = await _roomMemberDb.getOneMemberInRoom(
      assignAdmin.roomId,
      assignAdmin.adminAccountIds,
    );

    if (updateMember != null) {
      updateMember.groupRole = updateMember.groupRole?.copyWith(
        role: role,
        customAdminName: customTitle,
        permissions: assignAdmin.permissions,
      );

      await _roomMemberDb.updateAllRoomMemberWithoutTxn([updateMember]);

      switch (type) {
        case UpdateStateType.assignRoomAdmin:
          eventList.add(
            () => eventBus.fire(
              AssignAdminEvent(
                roomId: assignAdmin.roomId,
                member: updateMember,
              ),
            ),
          );
          break;
        case UpdateStateType.revokeRoomAdmin:
          eventList.add(
            () => eventBus.fire(
              RevokeAdminEvent(
                roomId: assignAdmin.roomId,
                member: updateMember,
              ),
            ),
          );
          break;
        case UpdateStateType.updateRoomAdminPermissions:
          eventList.add(
            () => eventBus.fire(
              UpdateAdminPermissionEvent(
                roomId: assignAdmin.roomId,
                member: updateMember,
              ),
            ),
          );
          break;
        default:
          break;
      }
    }

    return eventList;
  }

  Future<EventListCallback> _addRoomMember(MemberStateDataModel memberData) async {
    final EventListCallback eventList = [];
    final room = await _roomDb.getRoom(memberData.roomId);
    if (room != null) {
      for (final member in memberData.members) {
        member.roomType = room.roomType;
      }
      await _roomMemberDb.updateAllRoomMemberWithoutTxn(memberData.members);

      // Update the number of users request to join room.
      room.memberRequestCount = memberData.memberRequestCount;
      if (memberData.memberCount != null) {
        room.memberCount = memberData.memberCount;
      }

      RoomCollection? eventData = await _roomDb.putRoomWithoutTxn(room);
      if (eventData != null) {
        eventList.add(
          () => eventBus.fire(
            AddRoomMemberEvent(
              roomId: eventData.id!,
              member: memberData.members,
              memberRequestCount: eventData.memberRequestCount,
            ),
          ),
        );
        eventList.add(
          () => eventBus.fire(RoomUpdateEvent(room: eventData)),
        );
      }

      await _updateHasFirstOtherInRoom.call(memberData.roomId);
    } else {
      useLogger().w(
        'room : ${memberData.roomId} not found in local db when processing AddRoomMember state',
      );
    }

    return eventList;
  }

  Future<EventListCallback> _removeRoomMember(RemoveMemberStateDataModel memberData) async {
    final EventListCallback eventList = [];
    final isSelfRemoved = memberData.memberIds.any((element) {
      return UserController.instance.isCurrentUser(element);
    });
    final room = await _roomDb.getRoom(memberData.roomId);
    if (isSelfRemoved && room != null) {
      // Current user in this state data means that current user got kicked out
      // of this room.

      eventList.addAll(
        await _deleteRoom(
          room,
          null,
          deleteFromLocal: true,
          isDeleteInContact: true,
        ),
      );
      return eventList;
    }
    if (room != null) {
      for (final accountId in memberData.memberIds) {
        await _roomMemberDb.deleteMemberWithoutTxn('$accountId-${memberData.roomId}');
      }
      if (memberData.memberCount != null) {
        room.memberCount = memberData.memberCount;
      }
      if (memberData.isAccountDeleted) {
        await Future.wait(
          memberData.memberIds.map((memberId) => _messageDb.deleteAccountDataFromMessagesWithoutTxn(memberId)),
        );
      }
      final eventData = await _roomDb.putRoomWithoutTxn(room);
      eventList.add(
        () => eventBus.fire(
          RemoveRoomMemberEvent(
            roomId: memberData.roomId,
            memberIds: memberData.memberIds,
            isAccountDeleted: memberData.isAccountDeleted,
          ),
        ),
      );
      if (eventData != null) {
        eventList.add(
          () => eventBus.fire(
            RoomUpdateEvent(room: eventData),
          ),
        );
      }
      await _updateHasFirstOtherInRoom(memberData.roomId);
    } else {
      useLogger().w(
        'room : ${memberData.roomId} not found in local db when processing RemoveRoomMember state',
      );
    }

    return eventList;
  }

  Future<EventListCallback> _deleteAlbum(AlbumCollection receiveAlbum) async {
    final roomId = receiveAlbum.roomId;
    final id = receiveAlbum.id;
    if (roomId == null || id == null) {
      return [];
    }

    await _albumDb.deleteAlbumWithoutTxn(id: id);

    return [
      () => eventBus.fire(AlbumDeleteEvent(album: receiveAlbum.toEntity(), roomId: roomId)),
    ];
  }

  Future<EventListCallback> _deleteRoom(
    RoomCollection receiveRoom,
    String? lastSequence, {
    bool deleteFromLocal = false,
    bool isDeleteInContact = false,
  }) async {
    final id = receiveRoom.id;
    if (id == null) {
      useLogger().w('room id is null when processing deleteRoom state');
      return [];
    }

    bool isHaveNewerMessage = false;
    if (lastSequence != null) {
      int lastSequenceFromServer = int.parse(lastSequence, radix: 16);

      final lastMessageInRoomLocalDB = await _messageDb.getLastSequenceByRoom(roomId: id);

      if ((lastMessageInRoomLocalDB?.sequence ?? 0) > lastSequenceFromServer) {
        isHaveNewerMessage = true;
      }
      if (isHaveNewerMessage) {
        // NOTE.need this because multiple device need to clear message local too
        await _messageDb.deleteMessageByRoomWithoutTxnBeforeSequence(
          roomId: id,
          lastSequenceFromServer: lastSequenceFromServer,
        );
      } else {
        await _messageDb.deleteMessageByRoomWithoutTxn(roomId: id);
      }
    } else {
      await _messageDb.deleteMessageByRoomWithoutTxn(roomId: id);
    }

    final EventListCallback eventList = [];

    eventList.add(
      () => eventBus.fire(NewRoomAfterDeleteEvent(roomId: id)),
    );
    // When delete group there are 2 cases
    // 1.delete last message of my subscription to `null` but keep room in local db. This case is when delete chat room history.
    // 2.delete room in local db. This case is when leave room or kicked out of room.
    bool? isGroup = receiveRoom.isGroup;
    bool? isSecretRoom = receiveRoom.isSecretRoom;
    bool? isBookmarkRoom = receiveRoom.isBookmark;

    // if room type from update state is null, check from local db
    if (receiveRoom.roomType == null) {
      final localRoom = await _roomDb.getRoom(receiveRoom.id!);

      isGroup = localRoom?.isGroup ?? false;
      isSecretRoom = localRoom?.isSecretRoom ?? false;
      isBookmarkRoom = localRoom?.isBookmark ?? false;
    }

    if ((isGroup == true && !deleteFromLocal) || isSecretRoom == true || isBookmarkRoom == true) {
      final roomSub = await _roomSubDb.getRoomSubscriptionWithRoomId(receiveRoom.id ?? '');
      if (roomSub != null) {
        roomSub.lastMessage = null;
        roomSub.isLocalDeleting = false;
        await _roomSubDb.putRoomSubscriptionWithoutTxn(
          roomSub,
          replaceData: true,
        );

        /// When remove bookmark chat room
        /// update all of messages that [bookmarkMessageId] isn't null to null
        if (isBookmarkRoom) {
          final originalMessages = await _messageDb.getAllOriginalMessagesOfBookmark();

          for (final message in originalMessages) {
            message.bookmarkMessageId = '';
            await _messageDb.putMessageWithoutTxn(message);
          }
        }
      }
      await _roomDb.putRoomWithoutTxn(receiveRoom);
    } else {
      if (!isHaveNewerMessage) {
        await _roomDb.deleteRoomWithoutTxn(id);
        await _roomSubDb.deleteRoomSubWithRoomIdWithoutTxn(id);
        await _roomMemberDb.deleteMemberInRoomWithoutTxn(id);
      } else {
        final roomSub = await _roomSubDb.getRoomSubscriptionWithRoomId(id);

        roomSub?.isLocalDeleting = false;
        roomSub?.isRoomDeleted = false;

        await _roomSubDb.putRoomSubscriptionWithoutTxn(
          roomSub!,
        );
      }
    }

    // Remove all room file data in this room.
    await _roomFileDb.deleteAllFileInRoomWithoutTxn(id);
    final fileSeqConfigKey = ConfigDb.getBoxFileFirstSequenceConfigKey(id);
    _configDb.authenticated.clearConfigWithoutTxn(key: fileSeqConfigKey);

    if (!isBookmarkRoom && !isSecretRoom) {
      await _messageDb.deleteBookmarkMessagesByOriginalRoomIdWithoutTxn(roomId: id);

      final bookmarkMsgCount = await _messageDb.getAllBookmarkMessagesCount();

      if (bookmarkMsgCount == 0) {
        final bookmarkRoom = await _roomDb.getBookmarkRoom();
        final bookmarkRoomId = bookmarkRoom?.id;

        if (bookmarkRoomId != null) {
          final bookmarkRoomSub = await _roomSubDb.getRoomSubscriptionWithRoomId(bookmarkRoomId);
          if (bookmarkRoomSub != null) {
            bookmarkRoomSub.lastMessage = null;
            await _roomSubDb.putRoomSubscriptionWithoutTxn(bookmarkRoomSub, replaceData: true);
          }
        }
      }
    }

    if (isGroup) {
      eventList.add(
        () => eventBus.fire(RoomDeleteEvent(roomId: id, isDeleteInContact: isDeleteInContact)),
      );
    }

    return eventList;
  }

  Future<EventListCallback> _updateUser(UserCollection receiveUser) async {
    final EventListCallback eventList = [];

    if (receiveUser.id == UserController.instance.currentUser()?.id && receiveUser.isDeleted == true) {
      if (UserController.instance.isLoggingOut.isFalse) {
        eventBus.fire(UserExpiredEvent());
      }
      useLogger().d('from sync isDeletedAcc ${receiveUser.isDeleted}');
    } else {
      final UserCollection? eventData = await _userDb.putUserWithoutTxn(
        receiveUser,
      );

      if (eventData != null) {
        eventList.add(
          () => eventBus.fire(
            UserUpdateEvent(user: eventData.toEntity()),
          ),
        );
      }
    }

    return eventList;
  }

  Future<EventListCallback> _updateAlbum(AlbumCollection receiveAlbum) async {
    final EventListCallback eventList = [];
    if (receiveAlbum.roomId == null || receiveAlbum.id == null) {
      return [];
    }

    final localAlbum = await _albumDb.getAlbum(
      id: receiveAlbum.id!,
    );
    if (localAlbum == null) {
      useLogger().w(
        'update album failed. album with id ${receiveAlbum.id} is not existed in local db.',
      );
      return [];
    }
    localAlbum.update(receiveAlbum);
    final eventData = await _albumDb.putAlbumWithoutTxn(localAlbum);
    if (eventData != null) {
      eventList.add(
        () => eventBus.fire(AlbumUpdateEvent(
          album: eventData.toEntity(),
          roomId: eventData.roomId!,
        )),
      );
    }

    return eventList;
  }

  Future<EventListCallback> _updateRoomMember(MemberStateDataModel memberData) async {
    try {
      final room = await _roomDb.getRoom(memberData.roomId);
      if (room != null) {
        for (final member in memberData.members) {
          member.roomType = room.roomType;
        }
      }
      await _roomMemberDb.updateAllRoomMemberWithoutTxn(memberData.members);
    } catch (e, stacktrace) {
      useLogger().e('putAllRoomMember error', e, stacktrace);
    }

    return [
      () => eventBus.fire(UpdateRoomMemberEvent(roomId: memberData.roomId, members: memberData.members)),
    ];
  }

  Future<EventListCallback> _updateRoomMemberLastSeen(Map<String, dynamic> data) async {
    final EventListCallback eventList = [];

    final roomId = data['_id'];
    final accountId = data['accountId'];
    DateTime? lastSeenMessageAt = strToDateTime(data['lastSeenMessageAt']);
    if (lastSeenMessageAt == null) {
      useLogger().w(
        'lastSeenMessageAt is null when processing state updateRoomMemberLastSeen',
      );
      return [];
    }
    final member = await _roomMemberDb.getOneMemberInRoom(roomId, accountId);
    if (member != null) {
      member.lastSeenMessageAt = lastSeenMessageAt;
      await _roomMemberDb.putRoomMemberWithoutTxn(member);
      eventList.add(
        () => eventBus.fire(
          UpdateRoomMemberEvent(
            roomId: roomId,
            members: [member],
          ),
        ),
      );
    }

    return eventList;
  }
}
