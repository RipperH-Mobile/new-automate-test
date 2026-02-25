import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_controller.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../../../core/exceptions/exceptions.dart';

final _log = useLogger();

class ChatRoomDetailDirectController extends ChatRoomDetailController {
  ChatRoomDetailDirectController({
    required super.tag,
  });

  final isBlocked = false.obs;

  StreamSubscription? _contactUpdateSubscription;
  StreamSubscription? _contactDeleteSubscription;

  @override
  ChatListController get chatListController {
    return Get.find<ChatListController>();
  }

  bool get isDirectCallAvailable {
    return roomCtl?.isDirectCallAvailable == true;
  }

  @override
  void onInit() async {
    /// [super.onInit()] have to be on the top
    super.onInit();

    ever<ContactCollection?>(contact, onUpdateContact);

    _contactUpdateSubscription = eventBus.on<ContactUpdateEvent>().listen(
      (event) {
        try {
          if (contact()?.id == event.contact.id) {
            _log.d('ContactUpdate: ${event.contact.id} == ${contact()!.id}');
            contact.update((val) {
              if (val == null) {
                val = event.contact;
              } else {
                val.update(event.contact);
              }
            });
          }
        } catch (e, stackTrace) {
          _log.e('On _contactUpdateSubscription error.', e, stackTrace);
        }
      },
    );

    _contactDeleteSubscription = eventBus.on<ContactDeleteEvent>().listen(
      (event) {
        if (contact() == null) return;
        if (room() == null) return;

        if (contact()!.id == event.contact.id) {
          _log.d('ContactDelete: ${event.contact.id} == ${contact()!.id}');
          contact.value = null;
        }
      },
    );
  }

  @override
  void onClose() async {
    await _contactUpdateSubscription?.cancel();
    await _contactDeleteSubscription?.cancel();

    super.onClose();
  }

  @override
  Future<void> initRoomDetailData() async {
    await super.initRoomDetailData();

    getContactToState();
  }

  void getContactToState() async {
    final firstContactId = room()!.firstOtherInRoom?.account?.id;
    if (firstContactId == null || (room()!.isDirect == false && room()!.isSystem == false)) {
      return;
    }

    try {
      final entity = await GetIt.I<GetContactUseCase>().call(ContactParams(accountId: firstContactId));
      final result = entity?.toCollection();
      if (result != null) {
        contact(result);
      }
    } catch (e, stackTrace) {
      _log.e('getContactToState error.', e, stackTrace);
    }
  }


  void onUpdateContact(ContactCollection? updatedContact) async {
    _log.d('onUpdateContact: ${updatedContact?.id}');
    if (updatedContact == null) {
      isBlocked(false);
      return;
    }

    isBlocked(updatedContact.isBlocked);

    if (room() != null) {
      eventBus.fire(RoomUpdateEvent(room: room()!));
    }
  }


  Future<void> handleBlock(String memberId) async {
    try {
      await UChatLoading.show(status: 'Processing...'.tr);
      await GetIt.I<BlockContactUseCase>().call(
        BlockContactParams(contactIds: [memberId]),
      );
      isBlocked(true);
      eventBus.fire(ContactUpdateEvent(
        contact: ContactCollection(
          id: memberId,
          blocked: true,
        ),
      ));
      await UChatLoading.success(message: 'Blocked.'.tr);
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleBlock error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleUnblock(String memberId) async {
    try {
      await UChatLoading.show(status: 'Processing...'.tr);
      await GetIt.I<UnblockContactUseCase>().call(
        UnblockContactParams(contactIds: [memberId]),
      );
      isBlocked(false);
      eventBus.fire(ContactUpdateEvent(
        contact: ContactCollection(
          id: memberId,
          blocked: false,
        ),
      ));
      await UChatLoading.success(message: 'Unblocked.'.tr);
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleUnblock error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    }
  }

  void handleOpenEditNickName() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickEditNameRoomdetails,
        eventProperties: EventProperty.clickEditNameRoomDetails('friends'));
    Get.toNamed(Routes.profileNickname.replaceAll(':id', contact()?.id ?? 'id_not_found'));
  }

  void showDialogBlockUser() {
    if (UChatCallController.instance.roomIsCalling(room()?.id)) {
      ActionUnavailableDialog.show();
      return;
    }
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: isBlocked.value == false
          ? 'Block ‘@userDisplayName‘?'.trParams({
              'userDisplayName': title,
            })
          : 'Unblock ‘@userDisplayName‘?'.trParams({
              'userDisplayName': title,
            }),
      description:
          'This account will no longer be able to contact you on UChat.\n\nTo unblock this account, go to: Settings > Friends > Blocked Accounts.'
              .tr,
      cancelText: 'Cancel'.tr,
      confirmText: isBlocked.value == false ? 'Block' : 'Unblock'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        isBlocked.value == false ? handleBlockUser() : handleUnblock(contact()!.id!);
      },
    );
  }

  Future<void> handleBlockUser() async {
    await UChatLoading.show(status: 'Updating...'.tr);
    final String? contactId = contact()?.id ?? room()?.originalFirstOtherInRoom?.accountId;
    if (contactId == null) {
      await UChatLoading.hide();
      return;
    }
    try {
      await GetIt.I<BlockContactUseCase>().call(BlockContactParams(
        contactIds: [contactId],
      ));
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickBlockcontactRoomdetails);
      await UChatLoading.hide();
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleBlockUser error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handleShareContact() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSharecontactRoomdetails);
    final String? contactId = contact()?.id ?? room()?.originalFirstOtherInRoom?.accountId;
    if (contactId == null) {
      return;
    }
    GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        newMessage: MessageCollection(
          type: MessageType.contact,
          shareContactId: contactId,
          contact: ContactModel(
            id: contactId,
            avatarId: contact()?.avatarId,
            nickname: contact()?.nickname,
            displayName: contact()?.displayName,
            backgroundId: contact()?.backgroundId,
            backgroundBlurhash: contact()?.backgroundBlurhash,
            type: contact()?.type,
            originalStatusMessage: contact()?.statusMessage,
          ),
        ),
      ),
    );
  }

  Future<void> handleReportUserPressed({
    required BuildContext context,
    bool callBackOnOpen = false,
  }) async {
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.clickReportRoomdetails, eventProperties: EventProperty.clickReportRoomDetails('friends'));
    String? contactId = contact()?.id ?? room()?.originalFirstOtherInRoom?.accountId;
    if (contactId == null) {
      return;
    }
    ReportType reportType;

    reportType = ReportType.reportUser;

    MainDialogController.handleOpenDialog(
      context: context,
      reportType: reportType,
      displayName: title,
      userId: contactId,
    );
  }
}
