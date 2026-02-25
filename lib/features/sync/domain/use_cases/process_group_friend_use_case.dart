import 'package:get/get.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/central_notification/domain/param/put_all_notification_param.dart';
import 'package:uchat/features/central_notification/domain/use_cases/get_all_notifications_from_local_use_case.dart';
import 'package:uchat/features/central_notification/domain/use_cases/put_all_notifications_to_local_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/delete_contact_without_txn_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_without_txn_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/update_state_type.dart';
import '../events/contact_new_event.dart';
import '../typedefs.dart';
import 'sync_handle_update_user_use_case.dart';

class ProcessGroupFriendUseCase extends SimpleUseCase<EventListCallback, UpdateStateModel> {
  final LoggerService log;
  final EventBus eventBus;
  final RoomSubscriptionDb roomSubDb;
  final RoomMemberDb roomMemberDb;
  final MessageDb messageDb;
  final ContactLocalRepository contactLocalRepository;
  final SyncHandleUpdateUserUseCase syncHandleUpdateUserUseCase;
  final GetContactUseCase getContactUseCase;
  final DeleteContactWithoutTxnUseCase deleteContactWithoutTxnUseCase;
  final PutContactWithoutTxnUseCase putContactWithoutTxnUseCase;
  final GetAllNotificationsFromLocalUseCase getAllNotificationsFromLocalUseCase;
  final PutAllNotificationsToLocalUseCase putAllNotificationsToLocalUseCase;

  ProcessGroupFriendUseCase({
    required this.log,
    required this.eventBus,
    required this.roomSubDb,
    required this.roomMemberDb,
    required this.messageDb,
    required this.contactLocalRepository,
    required this.syncHandleUpdateUserUseCase,
    required this.getContactUseCase,
    required this.deleteContactWithoutTxnUseCase,
    required this.putContactWithoutTxnUseCase,
    required this.getAllNotificationsFromLocalUseCase,
    required this.putAllNotificationsToLocalUseCase,
  });

  @override
  Future<EventListCallback> call(UpdateStateModel state) async {
    final EventListCallback eventList = [];

    switch (state.type) {
      case UpdateStateType.deleteFriend:
        if (state.contact case final contact?) {
          final eventCb = await _deleteContact(contact);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.newFriend:
      case UpdateStateType.updateFriend:
        if (state.contact case final contact?) {
          final eventCb = await _updateContact(contact);
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.updateUser:
        if (state.user case final user?) {
          // print('ZZZ => Friend > UpdateStateType.updateUser');
          final eventCb = await syncHandleUpdateUserUseCase.call(SyncHandleUpdateUserParams(receiveUser: user));
          eventList.addAll(eventCb);
        }
        break;
      default:
        log.w('Skipping state type ${state.type} from ProcessGroupDefaultUseCase');
        break;
    }

    return eventList;
  }

  Future<EventListCallback> _deleteContact(ContactCollection receiveContact) async {
    final EventListCallback eventList = [];

    final id = receiveContact.id;
    if (id == null) {
      return eventList;
    }
    try {
      final contact = await getContactUseCase.call(ContactParams(accountId: id));
      if (contact != null) {
        try {
          final result = await deleteContactWithoutTxnUseCase.call(id);
          if (result) {
            eventList.add(() => eventBus.fire(ContactDeleteEvent(contact: receiveContact)));
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stacktrace) {
          log.e('ErrorDeleteContactWithoutTxnUseCase while deleting contact', e, stacktrace);
        }
      }

      final roomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(id);
      final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(roomId ?? '');
      if (roomSub != null) {
        roomSub.hasFirstOtherInRoom = false;
        await roomSubDb.putRoomSubscriptionWithoutTxn(roomSub);
      }

      // Delete account data from message db
      await messageDb.deleteAccountDataFromMessagesWithoutTxn(id);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stacktrace) {
      log.e('Error GetContactUseCase while deleting contact', e, stacktrace);
    }

    return eventList;
  }

  Future<EventListCallback> _updateContact(ContactCollection receiveContact) async {
    final EventListCallback eventList = [];

    final id = receiveContact.id;

    if (id == null) {
      return eventList;
    }

    final contact = await contactLocalRepository.getContact(id);

    // Is new contact
    if (contact == null) {
      final eventData = await putContactWithoutTxnUseCase.call(receiveContact.toEntity());
      if (eventData != null) {
        eventList.add(() => eventBus.fire(ContactNewEvent(contact: eventData.toCollection())));
      }
    }
    // Is update local contact
    else {
      contact.update(receiveContact, forceUpdateStatus: true);
      final eventData = await putContactWithoutTxnUseCase.call(contact);
      await updateCentralNotificationLocalData(receiveContact);

      if (eventData != null) {
        eventList.add(
          () => eventBus.fire(ContactUpdateEvent(contact: eventData.toCollection())),
        );
      }

      try {
        // Mirror room name from contact name to room sub.
        if (receiveContact.name case final name?) {
          final roomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(id);
          final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(roomId ?? '');
          if (roomSub != null) {
            roomSub.roomName = name;
            await roomSubDb.putRoomSubscriptionWithoutTxn(roomSub);
            eventBus.fire(RoomUpdateSubscriptionEvent(roomSubscription: roomSub.toEntity()));
          }
        }
      } catch (e, stacktrace) {
        log.e('Mirror room name from contact to room sub error', e, stacktrace);
      }

      // If there is nickname update, Update nickname in RoomMemberCollection.
      if (receiveContact.nickname case final nickname?) {
        try {
          final members = await roomMemberDb.getAllMemberWithId(id);
          if (members != null) {
            for (final member in members) {
              member.account?.nickname = nickname;
            }
            await roomMemberDb.updateAllRoomMemberWithoutTxn(members);
          }
        } catch (e, stacktrace) {
          log.e('update nickname in RoomMemberCollection error', e, stacktrace);
        }
      }
    }

    return eventList;
  }

  Future<void> updateCentralNotificationLocalData(ContactCollection receiveContact) async {
    final centralNoti = await getAllNotificationsFromLocalUseCase.call(NoParams());
    for (int i = 0; i < centralNoti.length; i++) {
      if (centralNoti[i].data?.accountId == receiveContact.id) {
        centralNoti[i].data?.displayName = receiveContact.displayName;
        centralNoti[i].data?.avatarId = receiveContact.avatarId;
      }
    }

    await putAllNotificationsToLocalUseCase.call(PutAllNotificationParam(
      notiList: centralNoti,
      isNeedTransaction: false,
    ));
  }
}
