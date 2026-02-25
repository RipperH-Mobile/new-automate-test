import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/domain/use_cases/get_hidden_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/remove_friend_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/unhide_contact_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingHiddenFriendsController extends GetxController {
  final isIntialized = false.obs;
  final contacts = <ContactCollection>[].obs;
  final selectedContacts = <ContactCollection>[].obs;

  AppSettingsController get appSettingsController => Get.find<AppSettingsController>();

  StreamSubscription? _contactUpdateSubscription;

  @override
  void onInit() async {
    isIntialized.value = false;
    _contactUpdateSubscription = eventBus.on<ContactUpdateEvent>().listen((event) {
      if (event.contact.isHidden == false) {
        contacts.removeWhere((e) => e.id == event.contact.id);
      }
    });

    await getContactsToState();
    super.onInit();
    isIntialized.value = true;
  }

  @override
  void onClose() {
    _contactUpdateSubscription?.cancel();
    super.onClose();
  }

  Future<void> getContactsToState() async {
    try {
      final entityList = await GetIt.I<GetHiddenContactUseCase>().call(NoParams());
      final contactResult = entityList.toCollections();
      contacts(contactResult);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('getContactsToState error.', e, stackTrace);
    }
  }

  void handleBack() {
    Get.back();
  }

  void handleSelectCheckbox(ContactCollection contact) {
    bool isSelected = selectedContacts.contains(contact);

    if (isSelected) {
      selectedContacts.remove(contact);
    } else {
      selectedContacts.add(contact);
    }
  }

  void handleUnhide(ContactCollection contact) {
    UChatNewDialog.showMultipleActionsDialog(
      context: Get.context,
      title: 'Edit @name account'.trParams({
        'name': contact.name ?? '',
      }),
      description: 'Change setting @name account'.trParams({
        'name': contact.name ?? '',
      }),
      actions: [
        UChatNewDialogAction(
          title: AppText.button2Bold(
            context: Get.context!,
            'Unhide'.tr,
            color: Get.context?.theme.appColors.textPrimary,
          ),
          onPressed: () => onConfirmUnhide(contact),
        ),
        UChatNewDialogAction(
          title: AppText.button2Bold(
            context: Get.context!,
            'Delete'.tr,
            color: Get.context?.theme.appColors.textError,
          ),
          onPressed: () => handleRemoveFriend(contact),
        ),
        UChatNewDialogAction(
          title: AppText.button2Bold(
            context: Get.context!,
            'Cancel'.tr,
            color: Get.context?.theme.appColors.textLighter,
          ),
        ),
      ],
    );
  }

  void onConfirmUnhide(ContactCollection contact) async {
    try {
      UChatLoading.show(status: 'Updating...'.tr);

      await GetIt.I<UnhideContactUseCase>().call(UnHideContactRequest(friendAccountIds: [contact.id!]));

      selectedContacts.clear();

      UChatLoading.success(message: 'Updated'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleUnhide error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleRemoveFriend(ContactInterface contact) async {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Delete this account'.tr,
      description: 'Do you want to unfriend “@name” and remove it from your friends list?'.trParams({
        'name': contact.name ?? '',
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Delete'.tr,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      confirmTextColor: Get.context!.theme.appColors.textError,
      isDestructive: true,
      onConfirm: () async {
        try {
          UChatLoading.show(status: 'Processing...'.tr);

          final result = await GetIt.I<RemoveFriendUseCase>().call(RemoveFriendRequest(friendAccountId: contact.id!));

          if (result) {
            contacts.removeWhere((e) => e.id == contact.id);
            UChatLoading.success(message: 'This friend has been removed'.tr);
          } else {
            UChatLoading.success(message: 'Friend removing failed'.tr);
          }
        } catch (e, stackTrace) {
          handleException(e, onUnknownException: () async {
            _log.e('handleRemoveFriend error.', e, stackTrace);
            await UChatLoading.hide();
            await UChatLoading.failed(message: 'Friend removing failed'.tr);
          });
        }
      },
    );
  }
}
