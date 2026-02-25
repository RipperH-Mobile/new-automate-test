import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/domain/use_cases/get_all_users_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_user_count_use_case.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/clear_all_user_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/remove_account_from_local_use_case.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/home/home_barrel.dart';
import 'package:uchat/lang/lang.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/storage/storage.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class AccountsCenterService {
  static final _log = useLogger();

  // Whether there is at least one logged in account in local db.
  bool haveAccount = false;

  /// Shared cleanup logic for both logout and delete account.
  /// [callServerLogout] - whether to call server logout API (false for delete account since account is already deleted)
  /// [isDebug] - whether to skip certain cleanup steps for debugging
  Future<void> _performCleanup({
    required bool callServerLogout,
    required UserEntity user,
    bool isDebug = false,
  }) async {
    await Orchestrator.run(OrchestratorTaskType.onUnAuthenticated);
    if (!isDebug) {
      await Orchestrator.run(OrchestratorTaskType.onUnAuthenticatedForNormalAccount);
    }

    // Remove account from local db
    await GetIt.I<RemoveAccountFromLocalUseCase>().call(
      RemoveAccountFromLocalParams(accountId: user.id!),
    );
    final userCount = await GetIt.I<GetUserCountUseCase>().call(
      GetUserCountParams(includeHiddenAccount: false),
    );
    // If no more user left, clear pin lock
    if (userCount <= 0) {
      await GetIt.I<SecurityService>().clearPasscode();
      // Clear all hidden user from local.
      await GetIt.I<ClearAllUserUseCase>().call(NoParams());
    }

    // Sign out from firebase
    await FirebaseAuth.instance.signOut();

    // Call server logout API only for normal logout (not for delete account)
    if (callServerLogout) {
      try {
        await GetIt.I<AuthApiServiceNew>().logout();
      } on ApiException catch (e, stackTrace) {
        if (e is ErrorAccountNotFoundException) {
          // This can happen if the account was deleted from another device, or if the token is already invalid.
          // In either case, we can proceed with local cleanup. We log this for debugging purposes.
          _log.e('Account not found during logout', e, stackTrace);
        } else if (e is! InvalidTokenException) {
          // If logout failed due to invalid token, we can ignore it because the token is already invalid.
          rethrow;
        }
      }
    }

    // Clear storage
    UChatStorage.instance.removeUserId();

    await AppBadgePlus.updateBadge(0);

    await DbManager.instance.closeAuthenticatedInstance();

    // Clear authenticated config
    if (!isDebug) {
      await ConfigDb.instance.authenticated.clear();
    }

    final configGeneral = ConfigDb.instance.general;

    // Map of data which must be saved when logout
    Map<String, dynamic> savedData = {
      serverTypeConfigKey: configGeneral.getStringEnvSync(key: serverTypeConfigKey),
      apiCustomTypeConfigKey: configGeneral.getStringEnvSync(key: apiCustomTypeConfigKey),
      socketCustomTypeConfigKey: configGeneral.getStringEnvSync(key: socketCustomTypeConfigKey),
      appLocaleCountryCodeKey: await configGeneral.getString(key: appLocaleCountryCodeKey),
      appLocaleLanguageCodeKey: await configGeneral.getString(key: appLocaleLanguageCodeKey),
      ConfigDb.getEnableTroubleshootEasyAccess(): configGeneral.getStringEnvSync(
        key: ConfigDb.getEnableTroubleshootEasyAccess(),
      ),
      ConfigDb.getPasscodeKey(): await configGeneral.getString(key: ConfigDb.getPasscodeKey()),
      ConfigDb.getPasscodeAutoUseBiometricKey():
          await configGeneral.getBool(key: ConfigDb.getPasscodeAutoUseBiometricKey()),
      ConfigDb.getPasscodeUseBiometricKey(): await configGeneral.getInt(key: ConfigDb.getPasscodeUseBiometricKey()),
    };

    // Clear general config (this clears currentUserConfigKey and currentUserTokenConfigKey)
    if (!isDebug) {
      await configGeneral.clear();
    }

    // Restore saved data after removing everything else
    for (final entry in savedData.entries) {
      await configGeneral.saveConfig(key: entry.key, value: entry.value);
    }
  }

  /// Cleanup local state after account deletion.
  /// This should be called after [DeleteAccountUseCase] completes successfully.
  /// Unlike [logoutCurrentUser], this method does NOT call server logout API
  /// since the account has already been deleted on the server.
  Future<void> cleanupAfterDeleteAccount({required UserEntity user}) async {
    try {
      await UChatLoading.show();
      UserController.instance.startLogout();

      await _performCleanup(callServerLogout: false, user: user);

      UserController.instance.finishLogout(true);

      await UChatLoading.hide();

      await performAfterLogout();
    } catch (e, stackTrace) {
      _log.e('cleanupAfterDeleteAccount error', e, stackTrace);
      UserController.instance.finishLogout(false);
      await UChatLoading.hide();
      rethrow;
    }
  }

  Future<void> logoutCurrentUser({bool isDebug = false, bool showDialog = true}) async {
    if (showDialog) {
      final bool isConfirm = await UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Logout'.tr,
        description: 'Do you want to log out of \nthis device?'.tr,
        confirmText: 'Confirm'.tr,
        cancelText: 'Cancel'.tr,
        confirmTextColor: Get.context!.theme.appColors.textError,
        cancelTextColor: Get.context!.theme.appColors.textLight,
      );
      if (isConfirm) {
        await _logoutCurrentUser(isDebug: isDebug);
      }
    } else {
      await _logoutCurrentUser(isDebug: isDebug);
    }
  }

  Future<void> _logoutCurrentUser({bool isDebug = false}) async {
    try {
      await UChatLoading.show();
      UserController.instance.startLogout();

      // decline call if exist
      await UChatCallController.instance.removeExistingCall();

      final user = UserController.instance.currentUser.value;
      if (user == null) return;

      await _performCleanup(callServerLogout: true, user: user, isDebug: isDebug);

      UserController.instance.finishLogout(true);

      await UChatLoading.hide();

      await performAfterLogout();
    } catch (e, stackTrace) {
      _log.e('logoutCurrentUser error', e, stackTrace);
      UserController.instance.finishLogout(false);
      await UChatLoading.hide();
      rethrow;
    }
  }

  Future<bool> logoutOtherUser(UserEntity user) async {
    final bool isConfirm = await UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Logout'.tr,
      description: 'Do you want to log out of \nthis device?'.tr,
      confirmText: 'Confirm'.tr,
      cancelText: 'Cancel'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
    );
    if (isConfirm) {
      try {
        await UChatLoading.show();

        await GetIt.I<RemoveAccountFromLocalUseCase>().call(
          RemoveAccountFromLocalParams(accountId: user.id!),
        );
        await GetIt.I<AuthApiServiceNew>().logout(accessToken: user.token);

        await UChatLoading.hide();
        return true;
      } on InvalidTokenException catch (_) {
        // If logout failed due to invalid token, we can remove account from local safely because the token is already invalid.
        await GetIt.I<RemoveAccountFromLocalUseCase>().call(
          RemoveAccountFromLocalParams(accountId: user.id!),
        );
        await UChatLoading.hide();
        return true;
      } catch (_) {
        await UChatLoading.hide();
        rethrow;
      }
    }
    return false;
  }

  // user is the user to switch to
  // bottomMargin is optional custom margin for switch to toast ui.
  // showLoading is whether to show UChatLoading or not.
  Future<void> switchAccount(UserEntity user, {double? bottomMargin, bool showLoading = true}) async {
    if (Get.find<UChatCallController>().inCallState) {
      await ActionUnavailableDialog.show();
      return;
    }

    await UserController.instance.switchAccount(
      user,
      bottomMargin: bottomMargin,
      showLoading: showLoading,
    );
  }

  Future<void> performAfterLogout() async {
    final userList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams());
    if (userList.isEmpty) {
      updateHaveAccount(false);
      Get.offAllNamed(Routes.welcome);
    } else if (userList.length == 1) {
      updateHaveAccount(true);
      setAccountAndReturnToHome(userList.first);
    } else {
      updateHaveAccount(true);
      Get.offAllNamed(
        Routes.selectAccount,
        predicate: (route) => route.settings.name == Routes.home,
      );
    }
  }

  Future<void> setAccountAndReturnToHome(UserEntity user, {bool backToHome = true}) async {
    try {
      // Toggle loading screen in home
      HomeController.instance.showSplash();
      // Close all screens and go to home.
      if (backToHome) {
        Get.until((route) => route.settings.name == Routes.home);
      }
      await UserController.instance.setCurrentUser(user, updateLoginAt: false);
      HomeController.instance.hideSplash();
    } catch (e, stackTrace) {
      useLogger().e('setAccountAndReturnToHome error', e, stackTrace);
    }
  }

  void updateHaveAccount(bool value) {
    haveAccount = value;
  }
}
