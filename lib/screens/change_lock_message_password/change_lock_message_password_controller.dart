import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_lock_message_password_request.dart';
import 'package:uchat/screens/change_lock_message_password/change_lock_message_password_arguments.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChangeLockMessagePasswordController extends GetxController {
  final args = Get.arguments as ChangeLockMessagePasswordArguments?;
  final passwordIsValid = false.obs;
  final pin = ''.obs;
  static const int maxPasswordLength = 30;

  void handleCloseButtonPressed() async {
    final isConfirm = await UChatDialog.showDialog(
      title: 'Discard set up password'.tr,
      description: 'Do you want to discard this password setup ?'.tr,
      confirmText: 'Discard'.tr,
      confirmButtonColor: UChatDialog.redDialogButtonColor,
    );
    if (isConfirm) {
      Get.back();
    }
  }

  void onConfirmPinChanged(String? value) {
    pin.value = value ?? '';
  }

  void onPasswordValidationChanged(bool? value) {
    if (value != null) {
      passwordIsValid.value = value;
    }
  }

  void handleContinuePressed() async {
    try {
      await UChatLoading.show();
      // TODO (refactor clean) Refactor this to use case.
      final res = await GetIt.I<ChatRoomApiService>().setLockMessagePassword(
        SetLockMessagePasswordRequest(
          roomId: args?.roomId ?? '',
          password: pin.value,
        ),
      );
      if (res == true) {
        final roomSubDb = GetIt.I<RoomSubscriptionDb>();
        final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(args?.roomId ?? '');
        if (roomSub != null) {
          roomSub.password = pin.value;
          await roomSubDb.putRoomSubscription(roomSub);
        }
      }
      await UChatLoading.success();
      Get.back(result: true);
    } on ApiValidationException catch (e, stackTrace) {
      _log.e('Change lock message password ApiValidationException error.', e, stackTrace);
      await UChatLoading.hide();
      UChatDialog.showExceptionDialog(
        description: 'PIN must be less than or equal to @length characters long'.trParams({
          'length': ChangeLockMessagePasswordController.maxPasswordLength.toString(),
        }),
        showReportBugWidget: false,
      );
    } catch (e, stackTrace) {
      _log.e('Change lock message password error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    }
  }
}
