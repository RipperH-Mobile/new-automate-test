import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class LogoutController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    Future.delayed(const Duration(seconds: 1), () async {
      try {
        // Must await to ensure logout completes before navigating
        await GetIt.I<AccountsCenterService>().logoutCurrentUser(showDialog: false);
      } catch (e, stackTrace) {
        _log.e('Logout Error.', e, stackTrace);
        // Still navigate to welcome even if logout fails to prevent user from being stuck
        try {
          Get.offAllNamed(Routes.welcome);
        } catch (navError, navStackTrace) {
          _log.e('Get.offAllNamed Error after logout failure.', navError, navStackTrace);
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        }
      }
    });
  }
}
