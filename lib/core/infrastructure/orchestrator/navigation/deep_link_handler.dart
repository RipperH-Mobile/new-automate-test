import 'dart:async';
import 'dart:ui';

import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/presentation/widgets/request_join_group_modal/request_join_group_modal.dart';
import 'package:uchat/entities/models/uri_parameters_model.dart';
import 'package:uchat/features/add_contact/presentation/add_contact_presentation.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';
import 'package:uchat/features/auth/presentation/auth_presentation.dart';
import 'package:uchat/features/auth/presentation/controllers/login/auth_code_controller.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/login/auth_code_screen.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../analytics/logger_service.dart';

class DeepLinkHandler {
  Uri? _initialLink;

  Uri? get initialLink => _initialLink;

  StreamSubscription<Uri?>? _subAppLinks;

  Future<void> initialize() async {
    final appLinks = AppLinks();
    try {
      final initialLinkData = await appLinks.getInitialLink();
      if (initialLinkData != null) {
        _initialLink = initialLinkData;
      }
    } on PlatformException catch (e, stackTrace) {
      useLogger().e('Init uni link error.', e, stackTrace);
    } catch (e, stackTrace) {
      useLogger().e('Catch error deeplink.', e, stackTrace);
    }

    _subAppLinks = appLinks.uriLinkStream.listen(processLink);
  }

  void dispose() {
    _subAppLinks?.cancel();
  }

  /// TODO: there is a lot of duplicated code similar this method in [ContactAddByQrController],
  /// TODO: consider refactoring (qrController()?.scannedDataStream.listen((scanData))
  void processLink(Uri? uri) async {
    useLogger().d('processLink called with ${uri?.path}');
    if (uri == null) {
      return;
    }

    // Convert deep-link scheme to https scheme
    if (uri.scheme.isNotEmpty) {
      final currentScheme = uri.scheme.toLowerCase();

      // If the scheme is our custom scheme, convert it to https scheme
      // because we handle bas on https scheme at below.
      if (currentScheme == AppEnv.schemeDeepLink.toLowerCase()) {
        // Handle custom scheme deep link
        String uriFullPath = uri.toString();
        uriFullPath = uriFullPath.replaceFirst(currentScheme, 'https');
        uri = Uri.parse(uriFullPath);
      }
    }

    // Check link is "username" for add friend.
    final link = uri.toString();
    final baseLink = normalizeUri(uri).toString();
    final addFriendLink = normalizeUri(Uri.parse(AppEnv.addFriendPrefix)).toString();
    final stickerSharingLink = normalizeUri(Uri.parse(AppEnv.stickerSharingPrefix)).toString();
    final desktopLoginLink = normalizeUri(Uri.parse(AppEnv.desktopLoginPrefix)).toString();
    final oaLoginLink = normalizeUri(Uri.parse(AppEnv.oaLoginPrefix)).toString();
    final authCodeLink = normalizeUri(Uri.parse(AppEnv.authCodePrefix)).toString();
    final resetPasswordLink = normalizeUri(Uri.parse(AppEnv.resetPasswordPrefix)).toString();
    final roomInviteLink = normalizeUri(Uri.parse(AppEnv.roomInviteLinkPrefix)).toString();

    if (baseLink.startsWith(addFriendLink)) {
      try {
        if (GetIt.I<HttpCaller>().accessToken == null) {
          /// The only 2 case where access token is null should be when user is not logged in or when app is not finish
          /// initializing data when app is opened.
          /// In first case, App shouldn't show profile screen to add friend because user is not logged in.
          /// In second case, We will call process link after passcode is checked (PasscodeActivatedEvent's callback)
          /// When opening app, This function is called twice. First from PasscodeActivatedEvent's callback. Second from
          /// (I think) appLinks.uriLinkStream.listen and this one is called too early. Even before access token in http caller
          /// is set up. This is the reason why we need to check if access token is null to skip process link.
          useLogger().d('Access token is null, Skipping process link...');
          return;
        }
        final usernameDL = link.substring(AppEnv.addFriendPrefix.length);

        useLogger().d('Add friend prefix: ${AppEnv.addFriendPrefix}');
        useLogger().d('link: $link');
        useLogger().d('Username from deep link: $usernameDL');

        if (usernameDL == UserController.instance.currentUser()!.username!) {
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            message: 'You cannot add yourself as a friend.'.tr,
          );
          return;
        }

        final req = SearchContactRequest(
          username: usernameDL,
          type: searchTypeUsername,
        );

        final res = await GetIt.I<SearchContactUseCase>().call(req);
        final contactId = res.contact?.id;
        if (contactId == null) {
          return;
        }
        GetIt.I<ProfileService>().openProfileScreen(
          contactId: contactId,
        );
      } on FailedHostLookupException catch (e, stackTrace) {
        useLogger().d('UChat deep link launcher failed, no internet.', e, stackTrace);
        if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e,
          );
        } else {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        }
      } on ApiException catch (e, _) {
        if (e.type == 'ERR_ACCOUNT_NOT_FOUND') {
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            message: 'User not found'.tr,
            e: e,
          );
          return;
        }
      } catch (e, stackTrace) {
        useLogger().e('UChat deep link launcher error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      }

      return;
    }

    // Sticker sharing
    if (baseLink.startsWith(stickerSharingLink)) {
      final stickerPackId = link.substring(AppEnv.stickerSharingPrefix.length);

      if (!Get.isRegistered<StickerStoreController>()) {
        Get.put(StickerStoreController());
      }
      Get.find<StickerStoreController>().onGoToStickerDetail(stickerPackId: stickerPackId);
      return;
    }

    // Desktop app login
    if (baseLink.startsWith(desktopLoginLink)) {
      final UriParametersModel queryParameters = UriParametersModel.fromMap(uri.queryParameters);

      // TODO: delete if not use anymore
      // LoginController loginController;
      // if (!Get.isRegistered<LoginController>()) {
      //   loginController = Get.put(LoginController(authService: AuthService.instance));
      // } else {
      //   loginController = Get.find<LoginController>();
      // }

      // LoginWithPhoneNumberController loginWithPhoneNumberController;
      // if (!Get.isRegistered<LoginWithPhoneNumberController>()) {
      //   loginWithPhoneNumberController = Get.put(LoginWithPhoneNumberController(
      //     authServerRepository: GetIt.I<AuthServerRepositoryImpl>(),
      //     getEnabledCountryListUseCase: GetIt.I<GetEnabledCountryListUseCase>(),
      //   ));
      // } else {
      //   loginWithPhoneNumberController = Get.find<LoginWithPhoneNumberController>();
      // }

      bool isQrExpire = queryParameters.expiryData.isBefore(DateTime.now());

      if (isQrExpire) {
        UChatDialog.showDialogQRCodeExpire();
      } else {
        // TODO: delete if not use anymore
        // await loginController.handleDesktopLogin(queryParameters);

        // await loginWithPhoneNumberController.handleDesktopLogin(queryParameters);
      }

      return;
    }

    if (baseLink.startsWith(oaLoginLink)) {
      useLogger().d('deep link scan: $link');
      String? token = uri.queryParameters['token'];
      await showCupertinoModalBottomSheet(
        isDismissible: false,
        barrierColor: const Color(0xff000000).withValues(alpha: 0.8),
        topRadius: const Radius.circular(20),
        expand: false,
        context: Get.context!,
        builder: (_) {
          return GetBuilder<OALoginController>(
            init: OALoginController(
              token: token ?? '',
            ),
            builder: (_) {
              return const OALoginScreen();
            },
          );
        },
      );
      return;
    }

    if (baseLink.startsWith(authCodeLink)) {
      useLogger().d('deep link scan: $link');
      String? token = uri.queryParameters['token'];
      await showCupertinoModalBottomSheet(
        isDismissible: false,
        barrierColor: const Color(0xff000000).withValues(alpha: 0.8),
        topRadius: const Radius.circular(20),
        expand: false,
        context: Get.context!,
        builder: (_) {
          return GetBuilder<AuthCodeController>(
            init: AuthCodeController(
              token: token ?? '',
            ),
            builder: (_) {
              return const AuthCodeScreen();
            },
          );
        },
      );
      return;
    }

    if (baseLink.startsWith(roomInviteLink)) {
      await RequestJoinGroupModal.show(Get.context!, inviteLink: link);
      return;
    }

    if (baseLink.startsWith(resetPasswordLink)) {
      final flowManager = GetIt.I<SettingAccountForgotPasswordFlowManager>();

      flowManager.appLinkFlow(
        sessionId: uri.queryParameters['sid'] ?? '',
        token: uri.queryParameters['token'] ?? '',
      );
    }
  }

  Uri normalizeUri(Uri uri) {
    // Normalize scheme (HTTPS)
    var normalizedScheme = uri.scheme.toLowerCase();
    // Normalize host (remove 'www.' if exists)
    var normalizedHost = uri.host.startsWith('www.') ? uri.host.substring(4) : uri.host.toLowerCase();
    // Normalize the path (remove redundant slashes)
    var normalizedPath = uri.pathSegments.isEmpty ? '/' : uri.pathSegments.join('/');
    // Normalize query parameters (sort them)
    var normalizedQuery = uri.queryParameters.isNotEmpty
        ? Uri(
            queryParameters:
                Map.fromEntries(uri.queryParameters.entries.toList()..sort((a, b) => a.key.compareTo(b.key))))
        : null;
    // Rebuild the URI using normalized components
    return Uri(
      scheme: normalizedScheme,
      host: normalizedHost,
      path: normalizedPath,
      queryParameters: normalizedQuery?.queryParameters,
    );
  }
}
