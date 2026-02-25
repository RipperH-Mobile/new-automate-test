import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/reset_social_auth_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_apple_provider_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_apple_server_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_facebook_provider_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_facebook_server_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_google_provider_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_google_server_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_out_with_google_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_with_phone_number_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/welcome_arguments.dart';
import 'package:uchat/features/auth/presentation/views/widgets/started_bottom_sheet.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/bottom_sheet/app_floating_bottom_sheet.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeController extends GetxController {
  final _log = useLogger();

  final testModeToggleCount = 0.obs;
  TextEditingController inputApiUrl = TextEditingController();
  TextEditingController inputSocketUrl = TextEditingController();
  TextEditingController inputDomainUrl = TextEditingController();
  final isInputApiUrlCorrect = true.obs;
  final isInputSocketUrlCorrect = true.obs;
  final isAddAccount = false.obs;
  final isInputDomainUrlCorrect = true.obs;

  @override
  onInit() {
    super.onInit();
    if (UChatScreenUtil.instance.isDesktopPlatform) {
      windowManager.setSize(const Size(820, 560));
      windowManager.setResizable(false);
    } else {
      resetSocialAuth();
    }

    if (Get.arguments != null && Get.arguments is WelcomeArguments) {
      final args = Get.arguments as WelcomeArguments;
      isAddAccount(args.isAddAccount);
    }
  }

  Future<void> resetSocialAuth() async {
    try {
      await GetIt.I<ResetSocialAuthUseCase>().call(NoParams());
    } catch (e, stackTrace) {
      _log.e('Reset social auth error', e, stackTrace);
    }
  }

  void onSignInByGoogleAccount() async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContinueSignUp,
      eventProperties: EventProperty.clickContinueSignUp('google'),
    );
    await UChatLoading.show();

    try {
      final providerResponse = await GetIt.I<SignInWithGoogleProviderUseCase>().call(NoParams());
      await _handleGoogleSignInServerResponse(providerResponse);
    } catch (e) {
      await UChatLoading.hide();
      _log.e('Google sign in error', e);
    }
  }

  Future<void> _handleGoogleSignInServerResponse(LinkAccountAuthEntity providerResponse) async {
    try {
      final serverResponse = await GetIt.I<SignInWithGoogleServerUseCase>().call(providerResponse.token!);
      await UChatLoading.hide();
      _routeTo(serverResponse);
    } catch (e) {
      await UChatLoading.hide();
      _handleGoogleSignInError(e, providerResponse);
    }
  }

  void _handleGoogleSignInError(dynamic e, LinkAccountAuthEntity providerResponse) async {
    if (e is ApiException) {
      switch (e.type) {
        case 'ERR_ACCOUNT_GMAIL_ALREADY_EXIST':
          UChatDialog.showExceptionDialog(
            title: 'This Google account is already in use'.tr,
            description:
                'This account cannot be linked to your UChat account because this Google account is already linked to another account'
                    .tr,
          );
          await GetIt.I<SignOutWithGoogleUseCase>().call(NoParams());
          break;

        case 'ERR_ACCOUNT_NOT_FOUND':
        case 'ERR_USER_NOT_FOUND':
          if (UserController.instance.currentUser() != null) {
            await UChatDialog.showAccountNotRegister();
            Get.until((route) => Get.currentRoute == Routes.accountsCenter || Get.currentRoute == Routes.home);
          } else {
            Get.toNamed(
              Routes.loginWithPhoneNumber,
              arguments: LoginWithPhoneNumberArguments(
                linkAccountModel: providerResponse,
              ),
            );
          }
          break;

        default:
          UChatDialog.showExceptionDialog(
            description: 'Failed to @type account with @account. Please try again'.trParams({
              'type': 'link'.tr,
              'account': 'Google account',
            }),
          );
          await GetIt.I<SignOutWithGoogleUseCase>().call(NoParams());
          break;
      }
    }
  }

  void onSignInByAppleId() async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContinueSignUp,
      eventProperties: EventProperty.clickContinueSignUp('apple'),
    );
    await UChatLoading.show();

    try {
      final providerResponse = await GetIt.I<SignInWithAppleProviderUseCase>().call(NoParams());
      await _handleAppleSignInServerResponse(providerResponse);
    } catch (e) {
      await UChatLoading.hide();
    }
  }

  Future<void> _handleAppleSignInServerResponse(LinkAccountAuthEntity providerResponse) async {
    try {
      final response = await GetIt.I<SignInWithAppleServerUseCase>().call(providerResponse.token!);
      await UChatLoading.hide();
      _routeTo(response);
    } catch (e) {
      await UChatLoading.hide();
      _handleAppleSignInError(e, providerResponse);
    }
  }

  void _handleAppleSignInError(dynamic e, LinkAccountAuthEntity providerResponse) async {
    if (e is ApiException) {
      switch (e.type) {
        case 'ERR_ACCOUNT_APPLE_ID_ALREADY_EXIST':
          UChatDialog.showExceptionDialog(
            title: 'This apple id is already in use'.tr,
            description:
                'This account cannot be linked to your UChat account because this apple id is already linked to another account'
                    .tr,
          );
          break;

        case 'ERR_ACCOUNT_NOT_FOUND':
        case 'ERR_USER_NOT_FOUND':
          if (UserController.instance.currentUser() != null) {
            await UChatDialog.showAccountNotRegister();
            Get.until((route) => Get.currentRoute == Routes.accountsCenter || Get.currentRoute == Routes.home);
          } else {
            Get.toNamed(
              Routes.loginWithPhoneNumber,
              arguments: LoginWithPhoneNumberArguments(
                linkAccountModel: providerResponse,
              ),
            );
          }
          break;

        default:
          handleException(
            e,
            onUnknownException: () {
              _log.e('linkOrSignInWithAppleId ApiException unknown error', e);
              UChatDialog.showExceptionDialog(
                description: 'Failed to @type account with @account. Please try again'.trParams({
                  'type': 'link'.tr,
                  'account': 'Apple id',
                }),
              );
            },
          );
          break;
      }
    }
  }

  void _routeTo(AuthLoginEntity res) {
    GetIt.I<TaxonomyService>().sendEvent(EventName.loginSucceeded);
    Get.offAllNamed(
      Routes.loginWelcome,
      arguments: LoginWelcomeArguments(
        user: res.toUserEntity(),
        waitSyncUserOnly: false,
      ),
    );
  }

  void handleLogin(BuildContext context) {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickGetStarted);

    AppFloatingBottomSheet.show(
      context: context,
      child: StartedBottomSheet(
        isAddAccount: isAddAccount.value,
      ),
    );
  }

  void handleToggleTestMode() async {
    testModeToggleCount(testModeToggleCount() + 1);

    if (testModeToggleCount() == 10) {
      dialogToggleEnvMode();

      EasyDebounce.debounce('clearDebugTapCount', const Duration(seconds: 1), () async {
        testModeToggleCount(0);
      });
    }

    useLogger().close();
    useLogger().initialize();
  }

  Future<void> signInWithFacebook() async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContinueSignUp,
      eventProperties: EventProperty.clickContinueSignUp('facebook'),
    );
    await UChatLoading.show();

    try {
      final providerResponse = await GetIt.I<SignInWithFacebookProviderUseCase>().call(null);
      await _handleFacebookSignInServerResponse(providerResponse);
    } catch (e) {
      await UChatLoading.hide();
    }
  }

  Future<void> _handleFacebookSignInServerResponse(LinkAccountAuthEntity providerResponse) async {
    try {
      final socialSignInResponse = await GetIt.I<SignInWithFacebookServerUseCase>().call(providerResponse.token!);
      await UChatLoading.hide();
      _routeTo(socialSignInResponse);
    } catch (e) {
      await UChatLoading.hide();
      _handleFacebookSignInError(e, providerResponse);
    }
  }

  void _handleFacebookSignInError(dynamic e, LinkAccountAuthEntity providerResponse) async {
    if (e is ApiException) {
      switch (e.type) {
        case 'ERR_ACCOUNT_FACEBOOK_ALREADY_EXIST':
          UChatDialog.showExceptionDialog(
            title: 'This Facebook account is already in use'.tr,
            description:
                'This account cannot be linked to your UChat account because this Facebook account is already linked to another account'
                    .tr,
          );
          break;

        case 'ERR_ACCOUNT_NOT_FOUND':
        case 'ERR_USER_NOT_FOUND':
          if (UserController.instance.currentUser() != null) {
            await UChatDialog.showAccountNotRegister();
            Get.until((route) => Get.currentRoute == Routes.accountsCenter || Get.currentRoute == Routes.home);
          } else {
            Get.toNamed(
              Routes.loginWithPhoneNumber,
              arguments: LoginWithPhoneNumberArguments(
                linkAccountModel: providerResponse,
              ),
            );
          }
          break;

        default:
          handleException(
            e,
            onUnknownException: () {
              _log.e('linkOrSignInWithFacebook ApiException unknown error', e);
              UChatDialog.showExceptionDialog(
                description: 'Failed to @type account with @account. Please try again'.trParams({
                  'type': 'link'.tr,
                  'account': 'Facebook',
                }),
              );
            },
          );
          break;
      }
    }
  }

  void signInWithEmail() {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContinueSignUp,
      eventProperties: EventProperty.clickContinueSignUp('email'),
    );
    Get.back();
    Get.toNamed(Routes.loginWithEmail);
  }

  void signInWithPhoneNumber() {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContinueSignUp,
      eventProperties: EventProperty.clickContinueSignUp('phone number'),
    );
    Get.back();
    Get.toNamed(Routes.loginWithPhoneNumber);
  }
}
