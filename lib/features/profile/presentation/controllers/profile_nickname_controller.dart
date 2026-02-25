import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ProfileNicknameController extends GetxController {
  final String accountId;
  final GetContactUseCase getContactUseCase;
  final UpdateNicknameUseCase updateNicknameUseCase;
  final TaxonomyService taxonomyService;

  ProfileNicknameController({
    required this.accountId,
    required this.getContactUseCase,
    required this.updateNicknameUseCase,
    required this.taxonomyService,
  });

  final inputController = TextEditingController();

  final newNickname = ''.obs;
  final isOriginalName = false.obs;
  final contact = Rx<ContactEntity?>(null);

  String get nickname => contact()?.nickname ?? '';

  @override
  void onInit() async {
    await getContactFromIdToState();
    setNicknameToInputController();
    super.onInit();
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }

  Future<void> getContactFromIdToState() async {
    final result = await getContactUseCase.call(
      ContactParams(accountId: accountId),
    );

    if (result == null) {
      Get.back();
      return;
    }

    contact(result);
  }

  Future<void> setNicknameToInputController() async {
    inputController.text = nickname;
    newNickname(nickname);
  }

  void onNicknameChange(String value) {
    if (isOriginalName.value == true) {
      isOriginalName.value = false;
    }
    newNickname(value);
  }

  void handleClearTextField() {
    inputController.clear();
    newNickname('');
  }

  void revertToOriginalName() {
    final name = contact()?.displayName ?? '';
    isOriginalName.value = true;
    inputController.text = name;
    newNickname(name);
  }

  void handleUpdateNickname() async {
    try {
      if (inputController.text.trim().isEmpty) {
        return;
      }
      await UChatLoading.show(status: 'Updating...'.tr);
      final nickName = inputController.text.trim();

      await updateNicknameUseCase.call(
        UpdateNicknameRequest(
          isOriginalName: isOriginalName.value,
          friendAccountId: accountId,
          nickname: nickName,
        ),
      );
      taxonomyService.sendEvent(
        EventName.editNameSuccessfully,
        eventProperties: EventProperty.editNameSuccessfully('friends'),
      );
      await UChatLoading.success(message: 'Updated'.tr);
      Get.back();
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        await UChatLoading.hide();
        UChatNewDialog.showYouAreOfflineDialog(
          context: Get.context!,
        );
      } else {
        _log.e('handleUpdateNickname error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      }
    }
  }

  void handleOnBack() {
    if (newNickname.value.isNotEmpty && newNickname.value != nickname) {
      UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Discard edit'.tr,
        description: 'Are you sure you want to discard your changes?'.tr,
        isDestructive: true,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
        onConfirm: () {
          Get.back();
        },
      );
    } else {
      Get.back();
    }
  }
}
