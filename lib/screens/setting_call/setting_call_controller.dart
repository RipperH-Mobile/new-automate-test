import 'dart:async';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingCallController extends GetxController {
  final isAllowIncomingCall = false.obs;
  final isAllowCallkit = false.obs;

  StreamSubscription? _userUpdateSubscription;

  @override
  void onInit() {
    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.accountSettings?.call?.allowIncomingCall != isAllowIncomingCall() &&
          event.user.accountSettings?.call?.allowIncomingCall != null) {
        isAllowIncomingCall(event.user.accountSettings?.call?.allowIncomingCall);
      }
      if (event.user.accountSettings?.call?.allowCallKit != isAllowCallkit() &&
          event.user.accountSettings?.call?.allowCallKit != null) {
        isAllowCallkit(event.user.accountSettings?.call?.allowCallKit);
      }
    });

    checkAllowIncomingCall();
    checkAllowCallkit();
    super.onInit();
  }

  @override
  void onClose() async {
    await _userUpdateSubscription?.cancel();
    super.onClose();
  }

  void toggleAllowIncomingCall(bool? value) async {
    try {
      if (value == null) return;
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickAllowCall,
          eventProperties: EventProperty.clickAllowCall(value ? 'enabled' : 'disabled'));
      await UChatLoading.show(status: 'Saving...'.tr);

      await GetIt.I<AuthServerRepository>().updateAccountSetting(UpdateAccountSettingRequest.create(
        call: CallSettingsModel(allowIncomingCall: value),
      ));

      isAllowIncomingCall.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('toggleAllowIncomingCall error.', e, stacktrace);
        // isAllowIncomingCall.value = !isAllowIncomingCall.value;
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void toggleAllowCallkit(bool? value) async {
    try {
      if (value == null) return;
      await UChatLoading.show(status: 'Saving...'.tr);

      await GetIt.I<AuthServerRepository>().updateAccountSetting(UpdateAccountSettingRequest.create(
        call: CallSettingsModel(allowCallKit: value),
      ));

      isAllowCallkit.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('toggleAllowCallkit error.', e, stacktrace);
        // isAllowCallkit.value = !isAllowCallkit.value;
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void checkAllowIncomingCall() {
    isAllowIncomingCall(
      UserController.instance.currentUser()?.accountSettings?.call?.allowIncomingCall ?? false,
    );
  }

  void checkAllowCallkit() {
    isAllowCallkit(
      UserController.instance.currentUser()?.accountSettings?.call?.allowCallKit ?? false,
    );
  }

  void openCallLogFile() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/call_log.txt';
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      // TODO refactor to use function showFileOptionsDialog from RoomDetailFileListController here
      UChatDialog.showDialog(description: 'Can not open this file. (no app to open)'.tr, title: 'Alert'.tr);
    }
  }
}
