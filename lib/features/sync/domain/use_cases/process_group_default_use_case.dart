import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/dialog_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/notification_center_account_deleted_event.dart';
import 'package:uchat/core/event_bus/events/ownership_transferred_event.dart';
import 'package:uchat/core/event_bus/events/pin_message_event.dart';
import 'package:uchat/core/event_bus/events/unpin_all_message_event.dart';
import 'package:uchat/core/event_bus/events/unpin_message_event.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/features/add_contact/domain/events/update_group_member_request_event.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/album/domain/events/album_create_event.dart';
import 'package:uchat/features/album/domain/events/album_image_deleted_event.dart';
import 'package:uchat/features/album/domain/events/album_image_update_event.dart';
import 'package:uchat/features/album/domain/events/album_update_event.dart';
import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/call_log/domain/events/update_notify_new_call_log_event.dart';
import 'package:uchat/features/central_notification/domain/entities/notification_center_account_deleted_entity.dart';
import 'package:uchat/features/chat_folder/domain/entities/room_subscription_with_chat_folder_meta_entity.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/pin_message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/chat_folder_model.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_local_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/sync_message_reaction_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/events/update_room_invite_link_event.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/put_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/read_all_room_in_local_use_case.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/presentation/controllers/reason_refund_coin_controller.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/models/reorder_sticker_model.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sticker_detail_use_case.dart';
import 'package:uchat/features/sync/data/models/entities/ownership_transferred_state_data_model.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/screens/premium_packages/refund_and_ban/controllers/refund_and_ban_controller.dart';
import 'package:uchat/screens/premium_packages/refund_and_ban/screens/premium_package_refund_and_ban.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';

import '../../../../entities/models/contact_model.dart';
import '../../../sticker/data/models/collections/sticker_collection.dart';
import '../../data/models/enum/update_state_type.dart';
import '../typedefs.dart';
import 'sync_handle_update_user_use_case.dart';

class ProcessGroupDefaultUseCase extends SimpleUseCase<EventListCallback, UpdateStateModel> {
  final MessageLocalRepository messageLocalRepository;
  final PinMessageLocalRepository pinMessageLocalRepository;

  ProcessGroupDefaultUseCase({
    required this.messageLocalRepository,
    required this.pinMessageLocalRepository,
  });

  AlbumDb get _albumDb {
    return GetIt.I<AlbumDb>();
  }

  RoomDb get _roomDb {
    return GetIt.I<RoomDb>();
  }

  RoomSubscriptionDb get _roomSubDb {
    return GetIt.I<RoomSubscriptionDb>();
  }

  UserDb get _userDb {
    return GetIt.I<UserDb>();
  }

  StickerDb get _stickerDb {
    return GetIt.I<StickerDb>();
  }

  RoomMemberDb get _roomMemberDb {
    return GetIt.I<RoomMemberDb>();
  }

  @override
  Future<EventListCallback> call(UpdateStateModel state) async {
    final EventListCallback eventList = [];
    switch (state.type) {
      // TODO: Improve this to not use state.
      case UpdateStateType.banWarning: // Check
        // check for 'isBanWarning' if account has been warning
        if (state.data['isBanWarning'] == true) {
          UChatDialog.showPopUpAfterConfirmation(
            userDisplayName: '',
            title: 'Refund Requests Prohibited'.tr,
            description:
                'UChat\'s policy prohibits refund requests. \nnon-compliance may lead to account suspension.'.tr,
            buttonColor: const Color(0xFFFF1552),
          );
        }
        break;
      case UpdateStateType.deleteBookmarkEmojiTag: // Check
        final eventCb = await _deleteBookmarkEmojiTag(state.deletedBookmarkEmojiTags);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.updateBookmarkEmojiTag:
        if (state.bookmarkTag case final tag?) {
          final eventCb = await _updateBookmarkEmojiTag(tag);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.newAlbum:
        if (state.album case final album?) {
          final eventCb = await _newAlbum(album);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateAlbum:
        if (state.album case final album?) {
          final eventCb = await _updateAlbum(album);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateImageAlbum:
        if (state.album case final album?) {
          final eventCb = await _updateImageAlbum(album);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.deleteImageAlbum:
        if (state.album case final album?) {
          List<String> deletedImages = List<String>.from(state.data['deletedImages'] ?? []);
          if (deletedImages.isEmpty) {
            useLogger().w(
                'deletedImages data in UpdateStateType.deleteImageAlbum is empty. Please recheck if something went wrong here.');
          }
          final eventCb = await _deleteImageAlbum(album, deletedImages);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.reactMessage:
        final eventCb = await _updateMessageReaction(state);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.refundReason:
        await _showRefundReasonDialog(state);
        break;
      case UpdateStateType.refundReasonPremiumPackage:
        await _handleRefundReasonPremiumPackage(state);
        break;
      case UpdateStateType.rejectSession:
        await _rejectSession(state);
        break;

      case UpdateStateType.updateCoin:
        if (state.coinUpdate case final coin?) {
          final eventCb = await _updateCoinTransaction(coinUpdate: coin);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateSubscriptionChatFolder:
        final eventCb = await _updateChatFolderInRoomSub(state.chatFolderUpdateRoomSubscription);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.updateUser:
        if (state.user case final user?) {
          // print('ZZZ => Default > UpdateStateType.updateUser');
          final eventCb =
              await GetIt.I<SyncHandleUpdateUserUseCase>().call(SyncHandleUpdateUserParams(receiveUser: user));
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.newCallLog:
        if (state.callLog case final callLog?) {
          final eventCb = await _updateCallLog(callLog);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.reorderSticker:
        final eventCb = await _reorderSticker(state.reorderSticker);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.ownershipTransferred:
        if (state.ownershipTransferred case final ownershipTransferred) {
          final eventCb = await updateOwner(ownershipTransferredModel: ownershipTransferred);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.pinMessage:
        if (state.pinMessage case final pinMessage) {
          final eventCb = await updatePinMessage(pinMessage);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.unpinMessage:
        if (state.pinMessage case final pinMessage) {
          final eventCb = await updateUnpinMessage(pinMessage);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.unpinAllMessage:
        if (state.pinMessage case final pinMessage) {
          final eventCb = await updateUnpinAllMessage(pinMessage);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateRoomInviteLink:
        final eventCb = await _updateRoomInviteLink(state.data);
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.updateRoomMemberRequest:
        final eventCb = await _updateRoomMemberRequest(state.data);
        eventList.addAll(eventCb);
        break;

      case UpdateStateType.updateRoomReadAll:
        final eventCb = await _updateRoomReadAll();
        eventList.addAll(eventCb);
        break;
      case UpdateStateType.notificationCenterAccountDeleted:
        if (state.notificationCenterAccountDeleted case final entity) {
          final eventCb = await _notificationCenterAccountDeleted(entity);
          eventList.addAll(eventCb);
        }
        break;
      default:
        useLogger().w('Skipping state type ${state.type} from ProcessGroupDefaultUseCase');
        break;
    }

    return eventList;
  }

  Future<EventListCallback> updateOwner({required OwnershipTransferredStateDataModel ownershipTransferredModel}) async {
    final EventListCallback eventList = [];

    try {
      final newOwnerData = RoomMemberCollection(
        account: ContactModel(id: ownershipTransferredModel.newOwnerAccountId),
        roomId: ownershipTransferredModel.roomId,
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.owner,
          customAdminName: '',
          permissions: ownershipTransferredModel.newOwnerPermissions,
        ),
      );

      await _roomMemberDb.putRoomMemberWithoutTxn(newOwnerData);

      await _roomDb.putRoomWithoutTxn(RoomCollection(
        id: ownershipTransferredModel.roomId,
        ownerId: ownershipTransferredModel.newOwnerAccountId,
      ));

      eventList.add(() => eventBus.fire(OwnershipTransferredEvent()));
    } catch (e, stackTrace) {
      useLogger().e('updateNewOwner error : ', e, stackTrace);
    }

    try {
      final oldOwnerData = RoomMemberCollection(
        account: ContactModel(id: ownershipTransferredModel.oldOwnerAccountId),
        roomId: ownershipTransferredModel.roomId,
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.admin,
          customAdminName: 'Admin',
          permissions: ownershipTransferredModel.oldOwnerPermissions,
        ),
      );

      await _roomMemberDb.putRoomMemberWithoutTxn(oldOwnerData);
    } catch (e, stackTrace) {
      useLogger().e('updateOldOwner error : ', e, stackTrace);
    }

    return eventList;
  }

  Future<EventListCallback> _updateCallLog(CallLogCollection receiveCallLog) async {
    final EventListCallback eventList = [];
    eventList.add(() => eventBus.fire(UpdateNotifyNewCallLogEvent()));
    return eventList;
  }

  Future<EventListCallback> _updateChatFolderInRoomSub(
    List<RoomSubscriptionWithChatFolderMetaEntity>? chatFolderInRoomSubs,
  ) async {
    final EventListCallback eventList = [];

    if (chatFolderInRoomSubs == null || chatFolderInRoomSubs.isEmpty) {
      return eventList;
    }

    for (final roomSubUpdateData in chatFolderInRoomSubs) {
      final id = roomSubUpdateData.roomSubscriptionId;
      final localRoomSub = await _roomSubDb.getRoomSubscriptionWithId(id);
      if (localRoomSub != null) {
        localRoomSub.chatFolders = roomSubUpdateData.chatFolderInRoomSubscriptions
            .map((item) => ChatFolderModel.fromChatFolderMetaEntity(item))
            .toList();
        await _roomSubDb.putRoomSubscriptionWithoutTxn(localRoomSub);
      }
    }

    // eventList.add(() => eventBus.fire(ChatFolderUpdateRoomSubEvent(roomSubscriptions: chatFolderInRoomSubs)));

    return eventList;
  }

  // TODO: refactor
  Future<EventListCallback> _updateImageAlbum(AlbumCollection receiveAlbum) async {
    final EventListCallback eventList = [];

    final roomId = receiveAlbum.roomId;
    final id = receiveAlbum.id;
    if (roomId == null || id == null) {
      return [];
    }

    final localAlbum = await _albumDb.getAlbum(id: id);
    if (localAlbum == null) {
      useLogger().w('Update image album failed. album with id ${receiveAlbum.id} is not existed in local db.');
      return [];
    }

    localAlbum.update(receiveAlbum);

    final eventData = await _albumDb.putAlbumWithoutTxn(localAlbum);
    if (eventData != null) {
      eventList.add(() => eventBus.fire(AlbumImageUpdateEvent(album: eventData.toEntity(), roomId: roomId)));
    }

    return eventList;
  }

  Future<EventListCallback> _updateCoinTransaction({required CoinUpdateResponse coinUpdate}) async {
    return [() => eventBus.fire(CoinUpdateEvent(coinUpdateResponse: coinUpdate))];
  }

  Future<EventListCallback> _updateBookmarkEmojiTag(BookmarkTagModel newTag) async {
    final user = UserController.instance.currentUser();

    if (user == null) return [];

    user.allBookmarkEmojiTags?.add(newTag);
    await _userDb.putUserWithoutTxn(UserCollection.fromEntity(user));

    return [() => eventBus.fire(NewBookmarkTagEvent(newBookmarkTag: newTag))];
  }

  Future<EventListCallback> _updateAlbum(AlbumCollection receiveAlbum) async {
    final EventListCallback eventList = [];

    final roomId = receiveAlbum.roomId;
    final id = receiveAlbum.id;
    if (roomId == null || id == null) {
      return eventList;
    }

    final localAlbum = await _albumDb.getAlbum(id: id);
    if (localAlbum == null) {
      useLogger().w('Update album failed. album with id ${receiveAlbum.id} is not existed in local db.');
      return eventList;
    }

    localAlbum.update(receiveAlbum);
    final eventData = await _albumDb.putAlbumWithoutTxn(localAlbum);
    if (eventData != null) {
      eventList.add(() => eventBus.fire(AlbumUpdateEvent(album: eventData.toEntity(), roomId: roomId)));
    }

    return eventList;
  }

  Future<void> _handleRefundReasonPremiumPackage(UpdateStateModel state) async {
    if (state.accountId == UserController.instance.currentUser()?.id) {
      final premiumPackageName = state.data['premiumPackage']['premiumPackageName'];
      final periodType = state.data['premiumPackage']['periodType'];
      if (UChatScreenUtil.instance.isMobile) {
        // TODO: handle this not in state sync process
        Get.bottomSheet(
            GetBuilder<RefundAndBanController>(
              init: RefundAndBanController(),
              builder: (ctl) {
                return PremiumPackageRefundAndBan(premiumPackageName, periodType);
              },
            ),
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            barrierColor: const Color(0xff000000).withOpacity(0.8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            backgroundColor: const Color(0xffFFFFFF));
      } else {
        // TODO: handle this not in state sync process
        UChatDialog.showCustomDialog(
          init: RefundAndBanController(),
          child: (_) => PremiumPackageRefundAndBan(premiumPackageName, periodType),
          barrierDismissible: false,
        );
      }
    } else {
      useLogger().e('can not open PremiumPackageRefundAndBan');
    }
  }

  Future<void> _showRefundReasonDialog(UpdateStateModel state) async {
    //NOTE.check account id == current id first
    //NOTE.get transactionId and coinAmount from state.data and send that parameters to bottomsheet
    if (state.accountId == UserController.instance.currentUser()?.id) {
      final refundedTransactionId = state.data['_id'];
      final coinAmount = state.data['amount'];
      Get.bottomSheet(
        PopScope(
          canPop: false,
          child: GetBuilder<ReasonRefundCoinController>(
            init: ReasonRefundCoinController(),
            builder: (ctl) {
              return ReasonRefundCoinBottomSheetWidget(
                refundedTransactionId: refundedTransactionId,
                coinAmount: coinAmount,
              );
            },
          ),
        ),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
      );
    } else {
      useLogger().e('Can not _showRefundReasonDialog state.accountId mismatch current user');
    }
  }

  Future<EventListCallback> _updateMessageReaction(UpdateStateModel state) async {
    final EventListCallback eventList = [];
    if (state.updateMessageReaction case final reaction) {
      try {
        final lastEmojis = reaction.lastEmojis;
        final emojiAmount = reaction.emojiAmount;
        List<String>? selectedReactionList;
        String? accountId;

        if (reaction.newEmoji != null) {
          accountId = reaction.newEmoji?.accountId;
        }

        if (reaction.removeEmoji != null) {
          accountId = reaction.removeEmoji?.accountId;
        }

        if (lastEmojis == null || emojiAmount == null) {
          return eventList;
        }

        final currentUserId = UserController.instance.currentUser()?.id ?? '';
        if (currentUserId == accountId) {
          final message = await messageLocalRepository.getMessageById(id: reaction.messageId);

          if (message != null) {
            selectedReactionList = List.from(message.selectedReactionList ?? []);

            if (reaction.newEmoji != null) {
              final newEmojiId = reaction.newEmoji!.emojiId;
              // Prevent duplicate emoji in selectedReactionList
              if (!selectedReactionList.contains(newEmojiId)) {
                selectedReactionList.add(newEmojiId);
              }
            }

            if (reaction.removeEmoji != null) {
              selectedReactionList.removeWhere((e) => e == reaction.removeEmoji?.emojiId);
            }
          }
        }

        if (accountId == null) {
          return eventList;
        }

        await messageLocalRepository.syncMessageReactionData(
          SyncMessageReactionRequest(
            msgId: reaction.messageId,
            roomId: reaction.roomId,
            newEmojiId: reaction.newEmoji?.emojiId,
            removeEmojiId: reaction.removeEmoji?.emojiId,
            accountId: accountId,
            emojiAmount: emojiAmount,
            lastEmojis: lastEmojis.toEntities(),
            selectedReactionList: selectedReactionList,
            isFromSyncProcess: true,
          ),
        );
        eventList.add(
          () => eventBus.fire(
            MessageReactionEvent(
              msgId: reaction.messageId,
              emojiAmount: emojiAmount,
              lastEmojis: lastEmojis.toEntities(),
              removeEmojiId: reaction.removeEmoji?.emojiId,
              selectedReactionList: selectedReactionList,
              accountId: accountId!,
            ),
          ),
        );
      } catch (e) {
        useLogger().e('Sync process error.', e);
      }
    }

    return eventList;
  }

  Future<EventListCallback> _newAlbum(AlbumCollection receiveAlbum) async {
    final EventListCallback eventList = [];

    final roomId = receiveAlbum.roomId;
    final id = receiveAlbum.id;
    if (roomId == null || id == null) {
      return eventList;
    }

    final eventData = await _albumDb.putAlbumWithoutTxn(receiveAlbum);
    if (eventData != null) {
      eventList.add(() => eventBus.fire(AlbumCreateEvent(album: eventData.toEntity(), roomId: roomId)));
    }

    return eventList;
  }

  Future<EventListCallback> _deleteBookmarkEmojiTag(List<BookmarkTagModel> deletedTags) async {
    final EventListCallback eventList = [];

    useLogger().d('Processing deleteBookmarkEmojiTag');
    if (deletedTags.isNotEmpty) {
      for (var tag in deletedTags) {
        if (tag.id case final id?) {
          useLogger().d('Firing BookmarkTagDeletedEvent for tagId: $id');
          eventList.add(() => eventBus.fire(BookmarkTagDeletedEvent(tagId: id)));
        }
      }
    }

    return eventList;
  }

  Future<void> _rejectSession(UpdateStateModel state) async {
    final currentUserSessionId = UserController.instance.currentUser()?.currentSessionKeyId ?? '';
    final displayName = UserController.instance.currentUser()?.displayName ?? '';
    final sessionList = state.data['rows'];

    for (final dataSessionId in sessionList) {
      if (currentUserSessionId == dataSessionId['_id']) {
        GetIt.I<DialogService>().showSessionExpireDialog();

        break;
      }
    }
  }

  Future<EventListCallback> _deleteImageAlbum(AlbumCollection receiveAlbum, List<String> deletedImages) async {
    final EventListCallback eventList = [];

    final roomId = receiveAlbum.roomId;
    final id = receiveAlbum.id;
    if (roomId == null || id == null) {
      return eventList;
    }

    final localAlbum = await _albumDb.getAlbum(id: id);
    if (localAlbum == null) {
      useLogger().w('update album failed. album with id ${receiveAlbum.id} is not existed in local db.');
      return eventList;
    }

    localAlbum.update(receiveAlbum);
    final eventData = await _albumDb.putAlbumWithoutTxn(localAlbum);
    if (eventData != null) {
      eventList.add(
        () => eventBus.fire(
          AlbumImageDeletedEvent(album: eventData.toEntity(), roomId: roomId, deletedImages: deletedImages),
        ),
      );
    }

    return eventList;
  }

  Future<EventListCallback> _reorderSticker(ReorderStickerModel data) async {
    final EventListCallback eventList = [];
    final ids = data.data.map((e) => e.stickerId).toList();
    final localList = await _stickerDb.getAllMyStickerPackWithIds(ids);
    List<MyStickerCollection> updatedList = [];
    for (final pack in data.data) {
      final collection = localList.firstWhereOrNull((e) => e.id == pack.stickerId);
      if (collection != null) {
        // When the sticker pack data is in local db.
        // Update local data with new seq.
        collection.seq = pack.seq;
        updatedList.add(collection);
      } else {
        // When the sticker pack data is not in local db.
        // Fetch sticker data from server and update it with seq.
        try {
          final newStickerPack = await GetIt.I<FetchStickerDetailUseCase>().call(
            FetchStickerDetailParams(stickerPackId: pack.stickerId),
          );
          if (newStickerPack != null) {
            MyStickerCollection newCollection = MyStickerCollection.fromStoreEntity(newStickerPack);
            newCollection.seq = pack.seq;
            updatedList.add(newCollection);
            List<StickerCollection> stickerList =
                newStickerPack.stickerItems.map((item) => StickerCollection.fromEntity(item)).toList();
            // Save sticker items to local db.
            await _stickerDb.updateAllStickersWithoutTxn(stickerList);
            // Link sticker items to the new collection.
            newCollection.stickerItems.addAll(stickerList);
          }
        } catch (e, stackTrace) {
          useLogger().e('Process reorder sticker state error.', e, stackTrace);
        }
      }
    }
    await _stickerDb.putAllMyStickerPacksWithoutTxn(updatedList);
    eventList.add(
      () => eventBus.fire(
        ReorderStickerEvent(),
      ),
    );
    return eventList;
  }

  Future<EventListCallback> updatePinMessage(PinMessageCollection pinMessage) async {
    final EventListCallback eventList = [];
    try {
      // Save to local db
      await pinMessageLocalRepository.pinMessage(
        PinMessageLocalRequest(
          pinMessage: pinMessage.toEntity(),
        ),
        useTxn: false,
      );
      eventList.add(
        () => eventBus.fire(
          PinMessageEvent(
            pinMessage: pinMessage.toEntity(),
          ),
        ),
      );
    } catch (e, stackTrace) {
      useLogger().e('Process pin message state error.', e, stackTrace);
    }
    return eventList;
  }

  Future<EventListCallback> updateUnpinMessage(PinMessageCollection pinMessage) async {
    final EventListCallback eventList = [];
    try {
      final pinId = pinMessage.id;
      final roomId = pinMessage.roomId;
      if (pinId == null || roomId == null) {
        return eventList;
      }
      // Remove from local db
      await pinMessageLocalRepository.unpinMessage(
        UnpinMessageRequest(
          pinId: pinId,
          roomId: roomId,
        ),
        useTxn: false,
      );

      final messageRef = pinMessage.ref;

      if (messageRef == null) {
        return eventList;
      }

      eventList.add(
        () => eventBus.fire(
          UnpinMessageEvent(
            messageRef: messageRef,
            roomId: roomId,
          ),
        ),
      );
    } catch (e, stackTrace) {
      useLogger().e('Process unpin message state error.', e, stackTrace);
    }
    return eventList;
  }

  Future<EventListCallback> updateUnpinAllMessage(PinMessageCollection pinMessage) async {
    final EventListCallback eventList = [];
    try {
      final roomId = pinMessage.roomId;
      if (roomId == null) {
        return eventList;
      }
      // Remove all pin message in the room from local db
      await pinMessageLocalRepository.unpinAllMessagesInRoom(
        UnpinAllMessagesRequest(
          roomId: roomId,
        ),
        useTxn: false,
      );

      eventList.add(
        () => eventBus.fire(
          UnpinAllMessageEvent(
            roomId: roomId,
          ),
        ),
      );
    } catch (e, stackTrace) {
      useLogger().e('Process unpin all message state error.', e, stackTrace);
    }
    return eventList;
  }

  Future<EventListCallback> _updateRoomInviteLink(Map<String, dynamic> data) async {
    final EventListCallback eventList = [];
    try {
      final roomInviteLink = RoomInviteLinkEntity.fromMap(data);
      final updatedRoomInviteLink = await GetIt.I<PutRoomInviteLinkUseCase>().call(
        PutRoomInviteLinkParams(roomInviteLink: roomInviteLink),
      );
      if (updatedRoomInviteLink == null) {
        return [];
      }

      eventList.add(
        () => eventBus.fire(UpdateRoomInviteLinkEvent(roomInviteLink: updatedRoomInviteLink)),
      );
      return eventList;
    } catch (e, stackTrace) {
      useLogger().e('Process update room invite link state error.', e, stackTrace);
      return [];
    }
  }

  Future<EventListCallback> _updateRoomMemberRequest(Map<String, dynamic> data) async {
    final EventListCallback eventList = [];

    try {
      eventList.add(
        () => eventBus.fire(UpdateGroupMemberRequestEvent(
          roomId: data['roomId'],
          requestId: data['requestId'],
          accountId: data['accountId'],
          type: GroupRequestType.from(data['type']),
        )),
      );
      return eventList;
    } catch (e, stackTrace) {
      useLogger().e('Process update room member request state error.', e, stackTrace);
      return [];
    }
  }

  Future<EventListCallback> _updateRoomReadAll() async {
    final EventListCallback eventList = [];

    try {
      await GetIt.I<ReadAllRoomInLocalUseCase>().call(const ReadAllRoomInLocalParams(withTxn: false));
      return eventList;
    } catch (e, stackTrace) {
      useLogger().e('Process update room read all state error.', e, stackTrace);
      return [];
    }
  }

  // fire event NotificationCenterAccountDeletedEvent
  Future<EventListCallback> _notificationCenterAccountDeleted(NotificationCenterAccountDeletedEntity entity) async {
    final EventListCallback eventList = [];

    try {
      eventList.add(
        () => eventBus.fire(
          NotificationCenterAccountDeletedEvent(
            entity: entity,
          ),
        ),
      );
      return eventList;
    } catch (e, stackTrace) {
      useLogger().e('Process notification center account deleted state error.', e, stackTrace);
      return [];
    }
  }
}
