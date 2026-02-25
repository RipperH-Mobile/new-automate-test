import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/multiple_account_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/accounts_center/accounts_center_barrel.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/features/sync/domain/events/init_complete_event.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class LoginWelcomeController extends GetxController {
  final LoginWelcomeArguments args;

  StreamSubscription? _initCompleteSubscription;

  LoginWelcomeController({
    required this.args,
  });

  UserController get userCtl => Get.find<UserController>();

  @override
  void onInit() async {
    _initCompleteSubscription = eventBus.on<InitCompleteEvent>().listen(
      (event) async {
        Get.offAllNamed(Routes.home);
        UserController.instance.fetchPendingRefundReasons();
      },
    );

    // TODO (improve) Refactor skip login welcome logic or maybe remove this screen.
    /// In case sync is already completed, There is no need to do anything in this screen. Skip this screen and go to home.
    UserController.instance.checkAndResetUserSyncCompleted(
      onSyncComplete: () {
        // Ensure navigation happens after the current frame. Because onInit might be called during build.
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   Get.offAllNamed(Routes.home);
        //   UserController.instance.fetchPendingRefundReasons();
        // });
        return;
      },
      onSyncNotComplete: () {},
    );

    UserController.instance.loadingTaskNumber(0);
    UserController.instance.increaseLoadingProcess();
    UserController.instance.loadingTaskStatus('Setting up user.'.tr);

    if (args.waitSyncUserOnly) {
      return;
    }

    try {
      await process();
      // await downloadDefaultSticker();
    } catch (e, stackTrace) {
      _log.e('Login welcome error', e, stackTrace);
    }

    super.onInit();
  }

  @override
  void onClose() {
    _initCompleteSubscription?.cancel();
    super.onClose();
  }

  Future<void> process() async {
    if (args.user == null) {
      return;
    }

    try {
      UserEntity? user = args.user!;
      user = await GetIt.I<ProcessBeforeAddAccountUseCase>().call(
        ProcessBeforeAddAccountParams(
          user: user,
        ),
      );

      await UserController.instance.setCurrentUser(
        user,
        token: user.token ?? args.token,
      );
    } on MultipleAccountLimitExceedException catch (_) {
      Get.offAllNamed(Routes.home);
      Get.toNamed(Routes.accountsCenter);
      UChatNewDialog.showSingleButtonDialogV2(
        context: Get.context!,
        title: 'You have added the maximum of accounts'.tr,
        description: 'You cannot add more account'.tr,
      );
    } catch (e, stackTrace) {
      _log.e('Process in login welcome error', e, stackTrace);
      Get.offAllNamed(Routes.welcome);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }
}
