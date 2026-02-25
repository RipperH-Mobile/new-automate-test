import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/domain/use_cases/link_account_with_google_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_google_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class LinkAccountWithGoogleController extends GetxController {
  final LinkAccountWithGoogleArguments args;

  LinkAccountWithGoogleController({
    required this.args,
  });

  void onContinue() async {
    try {
      await GetIt.I<LinkAccountWithGoogleUseCase>().call(args.linkAccountModel.token!);
      if (args.setupPassword) {
        Get.offAllNamed(Routes.setupPasswordNew);
      } else {
        goToHome();
      }
    } catch (e) {
      _log.e('link account with google', e);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void goToHome() {
    if (args.setupPassword) {
      Get.offAllNamed(Routes.setupPasswordNew);
    } else {
      UserController.instance.checkAndResetUserSyncCompleted(
        onSyncComplete: () {
          Get.offAllNamed(Routes.home);
        },
        onSyncNotComplete: () {
          Get.offAllNamed(
            Routes.loginWelcome,
            arguments: LoginWelcomeArguments(
              user: args.user,
              waitSyncUserOnly: true,
            ),
          );
        },
      );
    }
  }
}
