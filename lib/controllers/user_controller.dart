import 'dart:async';
import 'dart:io';

import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:async/async.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/platform_document_version_entity.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/enums/passcode_biometric.dart';
import 'package:uchat/core/domain/enums/passcode_mode.dart';
import 'package:uchat/core/domain/enums/platform_document.dart';
import 'package:uchat/core/domain/services/dialog_service.dart';
import 'package:uchat/core/domain/services/platform_document_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/screen_lag_contact_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';
import 'package:uchat/core/presentation/arguments/passcode_arguments.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/enum/pay_store_type.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/accounts_center/domain/events/current_account_changed_event.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_any_account_has_shortcut_passcode_use_case.dart';
import 'package:uchat/features/auth/data/models/accepted_platform_document.dart';
import 'package:uchat/features/auth/domain/params/sign_in_to_firebase_params.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_to_firebase_use_case.dart';
import 'package:uchat/features/central_notification/presentation/controller/central_notification_controller.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/presentation/controllers/pending_refund_reason_queue_controller.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/features/sync/data/data_source/remote/firebase_realtime_database_service.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/group_obj_by_month.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/storage/storage.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

import '../controllers.dart';

final _log = useLogger();

const currentUserConfigKey = 'CURRENT_USER_ID';
const currentUserTokenConfigKey = 'CURRENT_USER_TOKEN';
const currentUserSessionIdConfigKey = 'CURRENT_USER_SESSION_ID  ';

// TODO Change this to service.
class UserController extends GetxController with GetSingleTickerProviderStateMixin {
  // Shortcut to this instance
  static UserController get instance => Get.find<UserController>();

  final currentCall = <RoomCallModel>[].obs;
  DateTime? lastSeenCall;

  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();
  final contactDb = GetIt.I<ContactDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();
  final userDb = UserDb();

  final configGeneral = ConfigDb().general;
  final configAuthenticated = ConfigDb().authenticated;

  final currentUser = Rx<UserEntity?>(null);
  final currentToken = Rx<String?>(null);
  final selectedFiles = <MessageFileModel>[].obs;

  final groupedObj = Rxn<GroupObjByMonthModel>();

  int totalNumberTasks = 14;
  final loadingTaskNumber = 0.obs;
  final loadingStatePercentage = 0.obs;
  final loadingTaskStatus = ''.obs;
  final isLoggingOut = false.obs;

  // TODO (improve) Update ways to check whether sync user completed. The current login flow sometimes can get stuck in login welcome when this bool is not reset or set to true.
  bool syncUserCompleted = false;

  StreamSubscription? _userUpdateSub;
  StreamSubscription? _emailOrPasswordNotSet;
  StreamSubscription? _userExpiredSub;

  ScrollController scrollController = ScrollController();

  final accountService = AccountService();
  final roomFileDb = GetIt.I<RoomFileDb>();

  TextEditingController captionCtl = TextEditingController();

  final distanceToFetch = 500;

  final _checkUserCache = AsyncCache<void>.ephemeral();

  bool isFirstTimeLogin = false;

  SettingMyProfileController get settingProfileController {
    if (!Get.isRegistered<SettingMyProfileController>()) {
      Get.put(SettingMyProfileController());
    }

    return Get.find<SettingMyProfileController>();
  }

  InAppPurchaseController get inAppPurchaseCtl {
    if (!Get.isRegistered<InAppPurchaseController>()) {
      Get.put(InAppPurchaseController());
    }

    return Get.find<InAppPurchaseController>();
  }

  /// To check if room message is open more than 10 rooms
  /// if more than 10 rooms, close the first room
  /// to prevent memory leak
  List<String> roomTagOpened = [];

  final currentPhoneNumber = ''.obs;
  final isHidePhoneNumber = false.obs;
  final friendCanSeeMyLastSeen = false.obs;

  final isPasscodeSet = false.obs;
  final isBiometricEnabled = false.obs;
  final isAutoUseBiometric = true.obs;
  final isBiometricSupported = false.obs;
  final biometricType = Rx<PasscodeBiometric>(PasscodeBiometric.none);
  final localAuth = LocalAuthentication();

  SecurityService get securityService => GetIt.I<SecurityService>();

  @override
  void onInit() async {
    _userUpdateSub = eventBus.on<UserUpdateEvent>().listen(
      (event) async {
        if (currentUser.value?.id != event.user.id) return;
        final useFirebaseStateChanged = event.user.enabledFeatures?.useFirebaseState != null &&
            currentUser.value?.enabledFeatures?.useFirebaseState != event.user.enabledFeatures?.useFirebaseState;

        currentUser.value = currentUser.value?.update(event.user) ?? event.user;
        if (currentUser.value?.premiumPackage?.subscribeAt?.isAfter(inAppPurchaseCtl.recentlySubscribeDate) == true) {
          UChatLoading.hide();
          if (inAppPurchaseCtl.showSuccessDialog) {
            final id = subscribeProductIdSelector(currentUser.value?.premiumPackage);
            inAppPurchaseCtl.handleSubscriptionEventV2(id);
            inAppPurchaseCtl.showSuccessDialog = false;
          }
        }

        if (event.user.accountSettings?.profile?.hiddenPhoneNumber != isHidePhoneNumber() &&
            event.user.accountSettings?.profile?.hiddenPhoneNumber != null) {
          isHidePhoneNumber(event.user.accountSettings?.profile?.hiddenPhoneNumber);
        }
        if (event.user.accountSettings?.friend?.canFriendSeeMyLastSeen != friendCanSeeMyLastSeen() &&
            event.user.accountSettings?.friend?.canFriendSeeMyLastSeen != null) {
          friendCanSeeMyLastSeen(event.user.accountSettings?.friend?.canFriendSeeMyLastSeen);
        }
        if (useFirebaseStateChanged) {
          if (event.user.enabledFeatures?.useFirebaseState?.enabled == true) {
            GetIt.I<FirebaseRealtimeDatabaseService>().initListener();
          } else {
            GetIt.I<FirebaseRealtimeDatabaseService>().onClearListener();
          }
        }
        int count = await roomSubDb.getAllUnreadCount();
        await AppBadgePlus.updateBadge(count);
      },
    );

    _userExpiredSub = eventBus.on<UserExpiredEvent>().listen(
      (event) {
        GetIt.I<DialogService>().showSessionExpireDialog();
      },
    );

    _emailOrPasswordNotSet = eventBus.on<CheckEmailOrPasswordNotSetEvent>().listen(
      (event) {
        _checkEmailOrPasswordNotSet();
      },
    );

    ever<String?>(currentToken, (token) async {
      _log.d('Change token: from "${currentToken.value}" to "$token"');
      if (token != null) {
        try {
          increaseLoadingProcess();
          loadingTaskStatus('Setting up token.'.tr);
          HttpCaller().updateAccessToken(token);
          SocketCaller().connectWithToken(token);
          // _log.d('Socket connected.');
        } catch (e, stackTrace) {
          _log.e('Set token error.', e, stackTrace);

          eventBus.fire(SocketDisconnectedEvent(
            data: 'Maintenance mode was on',
          ));
        }

        // Check user setting from server
        // Not need to wait.
        increaseLoadingProcess();
        loadingTaskStatus('Getting user info.'.tr);
        await getCurrentUserProfileFromServer();

        AppController.instance.showRefundAndBan();
        // _checkLimitAccount();
      } else {
        HttpCaller().removeAccessToken();
        SocketCaller().disconnect();
        SocketCaller().clearCredential();
      }
    });

    ever<UserEntity?>(currentUser, (user) async {
      await checkPasscodeSetup();
      updatePhoneNumber();
      checkHidePhoneNumberSetting();
      checkFriendCanSeeMyLastSeen();
    });

    ever<bool>(isPasscodeSet, (val) {
      eventBus.fire(PasscodeUpdateEvent(enabled: val));
    });

    super.onInit();
  }

  @override
  void onClose() async {
    await _userUpdateSub?.cancel();
    await _emailOrPasswordNotSet?.cancel();
    await _userExpiredSub?.cancel();

    super.onClose();
  }

  ///
  /// Check if current user is logged in or not from local db
  /// Run only first time when app is opened.
  ///
  Future<void> checkCurrentUser() async {
    await _checkUserCache.fetch(() async {
      _log.d('Called check current user.');
      await _checkCurrentUser();
    }).catchError((e) {
      _log.e('Error checking current user', e);
    });
  }

  ///
  /// Use for init user state
  /// !important: First in AppController for check logged in user.
  ///
  /// Note:
  /// - Remove [RootController().hookUserAfterCheckCurrentUser()] and change to use [
  ///
  Future<void> _checkCurrentUser() async {
    String? userId = await configGeneral.getString(key: currentUserConfigKey);
    String? token = await configGeneral.getString(key: currentUserTokenConfigKey);

    if (userId == null || token == null) {
      return;
    }

    UserEntity? user;
    try {
      final userFromDb = await userDb.getUser(userId);
      if (userFromDb == null) {
        _log.d('Not found user or token for user id: $userId');
        return;
      }

      user = userFromDb.toEntity();
    } catch (e, stackTrace) {
      _log.e('Get user from db error.', e, stackTrace);
      return;
    }

    // If logged in
    currentUser(user);
    currentToken(token);

    // Open new authenticated instance asynchronously
    try {
      await DbManager().openAuthenticatedInstance(userId: user.id!);

      final notiUnreadCount = await ConfigDb().authenticated.getInt(key: notiUnreadCountKey);
      CentralNotificationController.instance.notiUnreadCount(notiUnreadCount ?? 0);
    } catch (e, stackTrace) {
      _log.e(e.toString(), e, stackTrace);
    }

    // getCurrentUserProfileFromServer();
  }

  void onUserLoaded() async {
    if (enableTalker == false) {
      useLogger().setEnableTalker(false);
    }
  }

  Future<void> clearAllAboutUserData() async {
    await DbManager().authenticatedInstance?.writeTxn(() async {
      await roomDb.clearCollection();
      await roomMemberDb.clearCollection();
      await roomSubDb.clearCollection();
      await roomFileDb.clearCollection();
      await contactDb.clearCollection();
    });
  }

  // TODO Unused function ? Shouldn't this be used somewhere ??
  void checkTermVersion() async {
    try {
      final res = await GetIt.I<PlatformDocumentService>().getTermsAndConditionsUrlAndCurrentVersion();
      final currentVersion = res.$2;

      // If acceptedPlatformDocument is null, Throw error because if user doesn't accept term it should be empty list.
      // When acceptedPlatformDocument is null, it means that user data is missing or something is wrong.
      // acceptedPlatformDocument will be an empty list if user never accept term before.
      final termDetail = (currentUser()
          ?.acceptedPlatformDocument!
          .firstWhereOrNull((e) => e.type == PlatformDocumentType.termAndCondition.value));
      bool showBottomSheet = false;
      if (termDetail == null) {
        showBottomSheet = true;
      } else {
        final acceptedMajor = termDetail.major ?? 0;
        final acceptedMinor = termDetail.minor ?? 0;
        final acceptedPatch = termDetail.patch ?? 0;
        showBottomSheet = (acceptedMajor < currentVersion.major) ||
            (acceptedMajor == currentVersion.major && acceptedMinor < currentVersion.minor) ||
            (acceptedMajor == currentVersion.major &&
                acceptedMinor == currentVersion.minor &&
                acceptedPatch < currentVersion.patch);
      }
      if (showBottomSheet) {
        UChatBottomSheet.showTermAndConditionBottomSheet(
          context: Get.context!,
          fileUrl: res.$1,
          onAccept: () {
            acceptTermAndCondition(termDetail);
          },
        );
      }
    } catch (e, stackTrace) {
      _log.e('checkTermVersion error.', e, stackTrace);
    }
  }

  Future<void> acceptTermAndCondition(AcceptedPlatformDocument? termDetail) async {
    try {
      await GetIt.I<PlatformDocumentService>().acceptTermAndCondition(
        PlatformDocumentType.termAndCondition,
        PlatformDocumentVersionEntity(
          major: termDetail!.major!,
          minor: termDetail.minor!,
          patch: termDetail.patch!,
        ),
      );
    } catch (e, stackTrace) {
      _log.e('acceptTermAndCondition error.', e, stackTrace);
    }
  }

  void handleOpenProfilePhoto() {
    final roomContact = RoomContactModel<ContactInterface>(
      data: currentUser.value!.toContact(),
      type: RoomContactType.contact,
      isMe: true,
    );

    MediaViewerService.instance.openMediaViewer<RoomContactModel>(
      initialMedia: roomContact,
      medias: [roomContact],
      openFrom: MediaViewerOpenFrom.profileAvatar,
      showMediaListAndInfo: false,
    );
  }

  void handleOpenCoverPhotoViewer(String photoUrl, bool isMe, bool isAsset) {
    if (currentUser.value == null) return;

    Get.to(
      () => GetBuilder<PhotoViewerController>(
        init: PhotoViewerController(),
        builder: (ctl) {
          ctl.photoDataList.value = [
            PhotoViewerDataModel(
              url: photoUrl,
              hero: 'CONTACT-${currentUser.value?.id ?? const Uuid().v4()}',
              ownerName: currentUser.value?.displayName ?? '',
              isAsset: isAsset,
            ),
          ];
          return PhotoViewerScreen(
            isMyProfile: isMe,
            isShowedMenu: false,
          );
        },
      ),
      fullscreenDialog: true,
      opaque: false,
    );
  }

  Future<UserEntity?> getCurrentUserProfileFromServer() async {
    // Check user setting from server
    try {
      final userFromServer = await AccountService().getProfile().timeout(const Duration(seconds: 10));

      if (userFromServer != null) {
        // _log.d(
        //   'Update user from server:\n'
        //   '${userFromServer.toUserCollection()}',
        // );

        if (userFromServer.currentSessionKeyId != null) {
          await configGeneral.saveConfig(
            key: currentUserSessionIdConfigKey,
            value: userFromServer.currentSessionKeyId,
          );
        }

        final userFromServerCollection = userFromServer.toUserCollection();

        UserCollection localUser = (await userDb.getUser(userFromServer.id!))!;
        localUser.update(userFromServerCollection);

        if (localUser.privateKey == null) {
          final res = await AccountService().getSelfEncryptionKey();
          if (res != null) {
            localUser.privateKey = res.privateKey;
          } else {
            _log.w('getSelfEncryptionKey error response is null');
          }
        }

        // hasEmail(localUser.email != null);
        // hasPassword(localUser.hasPassword ?? false);
        // _log.d('currentUser has email is ${currentUser()?.email}');

        await userDb.putUser(localUser);
        final entity = localUser.toEntity();
        eventBus.fire(UserUpdateEvent(user: entity));
        return entity;
      }
    } on ApiException catch (e, stackTrace) {
      if (e is InvalidTokenException) {
        _log.e('Cannot get user profile: Invalid token', e, stackTrace);
        await GetIt.I<DialogService>().showSessionExpireDialog();
      } else if (e.type == 'ERR_ACCOUNT_NOT_FOUND') {
        _log.e('ERR_ACCOUNT_NOT_FOUND e : ${e.toString()}');
        await GetIt.I<DialogService>().showSessionExpireDialog();
      } else {
        _log.e('getProfile: Cannot get profile.', e, stackTrace);
      }
    } catch (e, stackTrace) {
      // Log only because this logic is interrupt checking user logic.
      _log.e('getProfile: Cannot get user profile.', e, stackTrace);
    }
    return null;
  }

  Future<void> setCurrentUser(UserEntity user, {String? token, bool updateLoginAt = true}) async {
    await ScreenLagContactPerformanceService.mainTrace.start();
    ScreenLagContactPerformanceService.mainTrace.putMainTraceAttribute(
      userId: user.id ?? 'unknown',
      appState: 'sign-in',
    );

    increaseLoadingProcess();
    loadingTaskStatus('Saving user config.'.tr);
    await configGeneral.saveConfig(
      key: currentUserConfigKey,
      value: user.id,
    );

    increaseLoadingProcess();
    loadingTaskStatus('Setting up current user.'.tr);
    await loadUser(user, token: token, updateLoginAt: updateLoginAt);
  }

  Future<void> loadUser(
    UserEntity user, {
    bool isDebug = false,
    String? token,
    bool updateLoginAt = false,
  }) async {
    final fromUserId = currentUser()?.id;
    final toUserId = user.id;
    final toToken = token ?? user.token;

    // Check only real user changed.
    final isUserChanged = fromUserId != null && fromUserId != toUserId;
    isFirstTimeLogin = !isUserChanged;
    _log.d(
      'Set current user to mem id: ${user.id},\n'
      'isUserChanged: $isUserChanged',
    );

    // Check if before is not equal given [user]
    if (isUserChanged) {
      try {
        // Close previous authenticated instance asynchronously
        await DbManager().closeAuthenticatedInstance(userId: fromUserId);
      } catch (e, stackTrace) {
        _log.e(e.toString(), e, stackTrace);
      }

      increaseLoadingProcess();
      loadingTaskStatus('Resetting badge.'.tr);

      try {
        if (!Platform.isWindows) {
          // Remove badge asynchronously
          await AppBadgePlus.updateBadge(0);
        }
      } catch (e, stackTrace) {
        _log.w('Cannot remove badge.', e, stackTrace);
      }
    }

    increaseLoadingProcess();
    loadingTaskStatus('Setting up local db.'.tr);
    try {
      // Open new authenticated instance asynchronously
      await DbManager().openAuthenticatedInstance(userId: user.id!);
    } catch (e, stackTrace) {
      _log.e(e.toString(), e, stackTrace);
    }

    increaseLoadingProcess();
    loadingTaskStatus('Current user setting done.'.tr);

    // Set current user
    currentUser(user);

    // Handle change token
    if (toToken != null) {
      try {
        _log.d('Set token: $toToken');
        await configGeneral.saveConfig(
          key: currentUserTokenConfigKey,
          value: toToken,
        );
        await configGeneral.saveConfig(
          key: currentUserSessionIdConfigKey,
          value: user.currentSessionKeyId,
        );

        increaseLoadingProcess();
        loadingTaskStatus('Saving user token.'.tr);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', toToken);
        prefs.setBool('isTestMode', !AppEnv.isProd);
        UChatStorage.instance.setUserId(user.id!);

        currentToken(toToken);
      } catch (e, stackTrace) {
        _log.e('Cannot run set token process.', e, stackTrace);
      }

      // Update user token because token is possibility to change from old value.
      user = user.copyWith(token: toToken, loginAt: updateLoginAt ? DateTime.now() : null);

      // Set current user
      currentUser(user);

      try {
        if (!isDebug || fromUserId == null) {
          await userDb.putUser(UserCollection.fromEntity(user));
        } else {
          await userDb.replaceUser(fromUserId, (UserCollection.fromEntity(user)));
        }
      } catch (e, stackTrace) {
        _log.e('Cannot put user to db.', e, stackTrace);
      }
    } else {
      _log.d('token is null.');
    }

    // Sign in to Firebase.
    if (user.id != null && user.firebaseToken != null) {
      try {
        await GetIt.I<SignInToFirebaseUseCase>().call(SignInToFirebaseParams(
          signInUserId: user.id!,
          token: user.firebaseToken!,
        ));
      } catch (e, stackTrace) {
        _log.e('sign in to firebase error.', e, stackTrace);
      }
    } else {
      _log.e(
          'Can not sign in to firebase because id or firebase token is null. id : ${user.id} firebase token : ${user.firebaseToken}');
    }
    increaseLoadingProcess();
    loadingTaskStatus('Setting up user data.'.tr);

    await Orchestrator.run(OrchestratorTaskType.onAuthenticated);

    // Defer non-critical operations
    Future.microtask(() async {
      // OneSignal initialization

      // _log.d(
      //   'Onesignal\n'
      //   'setExternalUserId: ${user.id!}\n'
      //   'SessionKeyId: ${user.currentSessionKeyId}',
      // );

      // if iOS remove external id in OneSignal
      increaseLoadingProcess();
      loadingTaskStatus('Calling voip setting up.'.tr);

      // Proceed to Home Screen
      useLogger().d('isLoggingOut: ${isLoggingOut()}');
      if (isLoggingOut.isFalse) {
        eventBus.fire(UserLoggedInEvent(user: user));
      }
      increaseLoadingProcess();
      loadingTaskStatus('Start setting up notification.'.tr);
    });
  }

  void startLogout() {
    isLoggingOut(true);
  }

  void finishLogout(bool isSuccess) {
    if (isSuccess) {
      currentUser.value = null;
      currentToken.value = null;
    }
    isLoggingOut(false);
  }

  /// check whether [id] is the id of current user or not
  bool isCurrentUser(String id) {
    return currentUser()?.id == id;
  }

  bool get isLoggedIn {
    return currentUser.value != null && currentToken.value != null;
  }

  bool get enableCall {
    return enabledFeatures?.call?.enabled ?? false;
  }

  bool get enableCallTestType {
    return enabledFeatures?.call?.isTest ?? false;
  }

  @Deprecated('Use enableChatFolderV2 instead')
  bool get enableChatFolder {
    return enabledFeatures?.chatFolder?.enabled ?? false;
  }

  @Deprecated('Use maxChatFolderV2 instead')
  int get maxChatFolder {
    return enabledFeatures?.chatFolder?.maxChatFolder ?? 10;
  }

  bool get enableChatFolderV2 {
    return enabledFeatures?.chatFolderV2?.enabled ?? false;
  }

  int get maxChatFolderV2 {
    return enabledFeatures?.chatFolderV2?.maxChatFolder ?? 10;
  }

  int get maxPin {
    return enabledFeatures?.pin?.maxPin ?? 10;
  }

  int get maxSecond {
    return enabledFeatures?.secretRoom?.maxSecond ?? 86400;
  }

  int get maxRoomInChatFolder {
    return enabledFeatures?.chatFolder?.maxRoomInChatFolder ?? 100;
  }

  bool get enableCoin {
    return enabledFeatures?.coin?.enabled ?? false;
  }

  bool get enableHelpCenter {
    return enabledFeatures?.helpCenter?.enabled ?? false;
  }

  bool get previewFont {
    return enabledFeatures?.previewFont?.enabled ?? false;
  }

  bool get enableHoldChat {
    return enabledFeatures?.holdChat?.enabled ?? true;
  }

  bool get enableHoldChatWithScroll {
    return enabledFeatures?.holdChat?.withScroll ?? false;
  }

  int get maxMultipleAccount {
    return enabledFeatures?.multipleAccount?.maxMultipleAccount ?? 2;
  }

  bool get enableLockMessage {
    return enabledFeatures?.lockMessage?.enabled ?? false;
  }

  bool get enableMultipleAccount {
    return enabledFeatures?.multipleAccount?.enabled ?? false;
  }

  bool get enableUseShortcutPasscode {
    return enabledFeatures?.multipleAccount?.canUseShortCutPasscode ?? true;
  }

  bool get enableUseHideFromList {
    return enabledFeatures?.multipleAccount?.canHideFromList ?? false;
  }

  bool get enableNewMessageAnimation {
    final newMessageFeature = enabledFeatures?.newMessage;
    return (newMessageFeature?.enabled ?? false) && (newMessageFeature?.animation ?? false);
  }

  bool get enableNewMessageSound {
    final newMessageFeature = enabledFeatures?.newMessage;
    return (newMessageFeature?.enabled ?? false) && (newMessageFeature?.sound ?? false);
  }

  bool get enablePremiumStore {
    return enabledFeatures?.premiumStore?.enabled ?? false;
  }

  bool get enableBookmark {
    return enabledFeatures?.bookmark?.enabled ?? false;
  }

  bool get enableBookmarkTag {
    return enabledFeatures?.bookmark?.emojiTag ?? false;
  }

  bool get enableReactMessage {
    return enabledFeatures?.reactMessage?.enabled ?? false;
  }

  bool get enableSecretChat {
    return enabledFeatures?.secretRoom?.enabled ?? false;
  }

  bool get isSubscribeApple {
    return currentUser()?.premiumPackage?.payStore == PayStoreType.apple;
  }

  bool get isSubscribeGoogle {
    return currentUser()?.premiumPackage?.payStore == PayStoreType.google;
  }

  bool get isCrossDoingProcess {
    return (GetPlatform.isAndroid && isSubscribeApple) || (GetPlatform.isIOS && isSubscribeGoogle);
  }

  String subscribeProductIdSelector(PremiumPackageModel? model) {
    if (isSubscribeGoogle) {
      return model?.googleProductId ?? '';
    } else if (isSubscribeApple) {
      return model?.appleProductId ?? '';
    }
    return '';
  }

  bool get enableTalker {
    return enabledFeatures?.talker?.enabled ?? false;
  }

  bool get enableTroubleshoot {
    return enabledFeatures?.troubleshoot?.enabled ?? false;
  }

  bool get enableUploadPro {
    return enabledFeatures?.uploadPro?.enabled ?? false;
  }

  bool get googleAccountLinked {
    return currentUser()?.linkAccounts?.google?.email != null;
  }

  bool get appleIdLinked {
    return currentUser()?.linkAccounts?.apple?.id != null;
  }

  bool get facebookAccountLinked {
    return currentUser()?.linkAccounts?.facebook?.email != null;
  }

  bool get enableGroupPermission {
    return enabledFeatures?.groupPermission?.enabled ?? false;
  }

  bool get useFirebaseState {
    return enabledFeatures?.useFirebaseState?.enabled ?? false;
  }

  Future<void> switchAccount(UserEntity user, {double? bottomMargin, bool showLoading = true}) async {
    // Not accept switch from non user (when [currentUser()] is null) to given user.
    if (currentUser() == null) return;

    try {
      if (showLoading) {
        await UChatLoading.show(status: 'Updating...'.tr);
      }

      await Orchestrator.run(OrchestratorTaskType.onUnAuthenticated);

      await setCurrentUser(user, token: user.token, updateLoginAt: false);

      AppToast.showSwitchAccountToast(
        context: Get.context!,
        displayName: user.displayName ?? '',
        avatarUrl: user.avatarUrl,
        bottomMargin: bottomMargin,
      );

      eventBus.fire(CurrentAccountChangedEvent(user));
      await UChatLoading.hide();
    } catch (e, stackTrace) {
      _log.e('switchAccount error', e, stackTrace);
      await UChatLoading.hide();
      handleException(e, onUnknownException: () => UChatLoading.failed());
    }
  }

  EnabledFeaturesModel? get enabledFeatures {
    return currentUser()?.enabledFeatures;
  }

  void increaseLoadingProcess() {
    loadingTaskNumber(loadingTaskNumber() + 1);
  }

  // เก็บไว้ก่อนเผื่อใช้งาน
  // void _checkLimitAccount() async {
  //   try {
  //     final allUsers = await _userDb.getAllUser();
  //     final masterAccount = await _userDb.getMasterAccount();
  //
  //     // Change to master account token
  //     HttpCaller.instance.updateAccessToken(masterAccount?.token ?? '');
  //     final masterAccountFromServer = await AccountService.instance.getProfileHttp();
  //
  //     // Change to current user token
  //     HttpCaller.instance.updateAccessToken(currentUser()?.token ?? '');
  //
  //     if (masterAccountFromServer?.limitMultipleAccount != null) {
  //       int limit = masterAccountFromServer!.limitMultipleAccount!;
  //       if (allUsers.length > limit) {
  //         final userRange = allUsers.sublist(limit);
  //         bool foundCurrentUser = false;
  //
  //         for (final user in userRange) {
  //           if (user.isMaster ?? false) continue;
  //
  //           // Check if current user is in the list
  //           foundCurrentUser = isCurrentUser(user.id ?? '');
  //
  //           // Change to other users token
  //           HttpCaller.instance.updateAccessToken(user.token ?? '');
  //           await AuthService.instance.logout();
  //
  //           // remove account data
  //           await UserDb().deleteUser(user.isarId);
  //           eventBus.fire(MultiAccountRemoveEvent(user: user));
  //         }
  //
  //         if (foundCurrentUser) {
  //           // Change from current user to master account
  //           await switchAccount(masterAccount!);
  //         }
  //       }
  //     }
  //   } catch (e, stackTrace) {
  //     handleException(e, onUnknownException: () {
  //       _log.e('checkLimitAccount error.', e, stackTrace);
  //     });
  //   }
  // }

  void fetchPendingRefundReasons() async {
    if (currentUser.value == null) return;
    try {
      final response = await GetIt.I<FetchPendingRefundReasonUseCase>()
          .call(const CoinPendingRefundReasonRequest(pageSize: 5, page: 1));

      if (response != null) {
        // Handle the response, e.g., update the UI with the data
        final queueController = Get.put(PendingRefundReasonQueueController());
        for (final refundReason in response.rows) {
          queueController.addRefundReasonToQueue(refundReason.id, refundReason.amount);
        }
      }
    } catch (e, stackTrace) {
      // Handle the error, e.g., show an error message
      _log.e('can not fetchPendingRefundReasons', e, stackTrace);
    }
  }

  void _checkEmailOrPasswordNotSet() {
    if (currentUser()?.email == null || currentUser()?.hasPassword != true) {
      String text = '';
      if (currentUser()?.email == null) {
        text += 'email'.tr;
      }
      if (currentUser()?.hasPassword != true) {
        if (text.isNotEmpty) {
          text += ' ${'and'.tr} ';
        }
        text += 'password'.tr;
      }
      UChatDialog.showEmailOrPasswordNotSetDialog(text);
    }
  }

/*━━━━━━━━━━  HANDLE PHONE NUMBER  ━━━━━━━━━*/
  void updatePhoneNumber() {
    final rawPhoneNumber = currentUser.value?.phoneNumber;

    if (rawPhoneNumber == null || rawPhoneNumber.isEmpty) {
      currentPhoneNumber('Phone number not found'.tr);
      return;
    }

    try {
      final parsed = dlib.PhoneNumberUtil.instance.parse(rawPhoneNumber, 'ZZ');
      final formatted = dlib.PhoneNumberUtil.instance.format(parsed, dlib.PhoneNumberFormat.international);

      currentPhoneNumber(formatted); // “+66 81 234 5678”
    } catch (e, st) {
      _log.w('Could not format phone "$rawPhoneNumber":', e, st);
      currentPhoneNumber(rawPhoneNumber); // fall back to raw string
    }
  }

  void copyPhoneNumberToClipboard(BuildContext context) async {
    // Check if phone number is available and not the fallback message
    final phoneNumber = currentUser.value?.phoneNumber;

    if (phoneNumber == null || phoneNumber.isEmpty) {
      // Don't copy if no phone number
      return;
    }

    try {
      // haptic feedback for better UX
      HapticFeedback.lightImpact();

      // Copy the formatted phone number to clipboard
      await Clipboard.setData(ClipboardData(text: currentPhoneNumber.value));

      // Show success toast
      AppToast.showToast(
        context: context,
        message: 'Copied to clipboard'.tr,
        icon: Assets.vectors.contentCopy.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconPrimaryInverse,
            BlendMode.srcIn,
          ),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('Failed to copy phone number to clipboard', e, stackTrace);
    }
  }

  /*━━━━━━━━━━  HANDLE DATE OF BIRTH ━━━━━━━━━*/
  String get formattedBirthDate {
    final birthDate = currentUser()?.birthDate;
    if (birthDate == null || birthDate.isEmpty) {
      return 'Not set up'.tr;
    }

    try {
      DateTime dateTime = DateTime.parse(birthDate);
      return DateFormat('MMM dd, yyyy', Get.locale?.languageCode ?? 'en').format(dateTime);
    } catch (e) {
      return 'Not set up'.tr;
    }
  }

  /*━━━━━━━━━━  HANDLE TOGGLE SHOW ONLINE STATUS  ━━━━━━━━━*/

  void checkFriendCanSeeMyLastSeen() {
    friendCanSeeMyLastSeen(
      currentUser.value?.accountSettings?.friend?.canFriendSeeMyLastSeen ?? false,
    );
  }

  void handleToggleFriendCanSeeMyLastSeen(bool? value) async {
    try {
      if (value == null) return;

      await AccountService().updateAccountSetting(
        UpdateAccountSettingRequest.create(
          friend: FriendSettingsModel(canFriendSeeMyLastSeen: value),
        ),
      );
      friendCanSeeMyLastSeen.value = value;
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.clickShowStatus,
        eventProperties: EventProperty.clickShowStatus(value ? 'enabled' : 'disabled'),
      );

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleFriendCanSeeMyLastSeen error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  /*━━━━━━━━━━  HANDLE TOGGLE HIDE PHONE NUMBER  ━━━━━━━━━*/

  void checkHidePhoneNumberSetting() {
    isHidePhoneNumber(
      currentUser.value?.accountSettings?.profile?.hiddenPhoneNumber ?? false,
    );
  }

  void handleToggleHidePhoneNumber(bool? value) async {
    try {
      if (value == null) return;

      await AccountService.instance.updateAccountSetting(
        UpdateAccountSettingRequest.create(
          profile: ProfileSettingsModel(hiddenPhoneNumber: value),
        ),
      );
      isHidePhoneNumber.value = value;

      GetIt.I<TaxonomyService>().sendEvent(
        EventName.clickHidePhoneNumber,
        eventProperties: EventProperty.clickHidePhoneNumber(value ? 'enabled' : 'disabled'),
      );

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleHidePhoneNumber error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  /*━━━━━━━━━━  HANDLE PASSCODE LOCK ━━━━━━━━━*/

  Future<void> checkPasscodeSetup() async {
    await securityService.initialize();

    useLogger().d(
        'checkPasscodeSetup, hasPasscode: ${securityService.hasPasscode}, enableBiometric: ${securityService.enableBiometric}, isBiometricSupported: ${securityService.isBiometricSupported}, enableAutoUseBiometric: ${securityService.enableAutoUseBiometric}');
    isPasscodeSet(securityService.hasPasscode);
    isBiometricEnabled(securityService.enableBiometric);
    isBiometricSupported(securityService.isBiometricSupported);
    isAutoUseBiometric(securityService.enableAutoUseBiometric);

    if (GetPlatform.isIOS) {
      if (securityService.biometricTypes.contains(BiometricType.face)) {
        // Face ID.
        biometricType(PasscodeBiometric.faceId);
      } else if (securityService.biometricTypes.contains(BiometricType.fingerprint)) {
        // Touch ID.
        biometricType(PasscodeBiometric.touchId);
      } else {
        isBiometricSupported(false);
      }
    } else if (GetPlatform.isAndroid) {
      if (securityService.biometricTypes.contains(BiometricType.strong) ||
          securityService.biometricTypes.contains(BiometricType.weak)) {
        biometricType(PasscodeBiometric.fingerprint);
      } else {
        isBiometricSupported(false);
      }
    }
  }

  Future<bool> proveBiometricBeforeEnableDisable() async {
    try {
      eventBus.fire(PasscodePreventEvent(preventActivate: true));

      final result = await localAuth.authenticate(
        options: const AuthenticationOptions(biometricOnly: true),
        localizedReason: 'Please authenticate to enable @bioMetricType for authentication.'.trParams({
          'bioMetricType': biometricType.value.toString(),
        }),
      );

      return result;
    } catch (e, stackTrace) {
      _log.e('Call proveBiometricBeforeEnableDisable error', e, stackTrace);
      return false;
    }
  }

  void handlePasscodeLock(bool? value) async {
    await checkPasscodeSetup(); // Ensure we have latest status

    if (!isPasscodeSet.value) {
      // User doesn't have passcode, go to toggle screen
      Get.toNamed(Routes.passcodeToggle);
    } else {
      // User has passcode, verify first then go to toggle screen
      await Get.toNamed(
        Routes.passcode,
        arguments: PasscodeArguments(
          mode: PasscodeMode.verify,
          controllerTag: const Uuid().v4(),
          whenPassed: () async {
            Get.back(); // Close passcode screen
            Get.toNamed(Routes.passcodeToggle); // Go to toggle screen
          },
        ),
      );
    }
  }

  void handlePasscodeToggle(bool value) async {
    if (value) {
      // User wants to enable passcode
      await Get.toNamed(
        Routes.passcode,
        arguments: PasscodeArguments(
          mode: PasscodeMode.setup,
          controllerTag: const Uuid().v4(),
          whenPassed: () async {
            Get.back(); // Close passcode setup screen
            // Auto-enable biometric if available after first-time passcode setup
            await autoEnableBiometricAfterPasscodeSetup();
            await checkPasscodeSetup(); // Refresh status
            // Stay on PasscodeToggleScreen to show updated UI
          },
        ),
      );
    } else {
      // Show confirmation dialog only when user has set shortcut passcode to any account.
      if (await GetIt.I<GetAnyAccountHasShortcutPasscodeUseCase>().call(NoParams())) {
        final isConfirm = await UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Confirm Pin lock disable?'.tr,
          description:
              'Turning off PIN Lock will delete all Shortcut Passcodes. You\'ll need to set them up again if you turn it back on'
                  .tr,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
        );
        if (isConfirm != true) {
          // User cancelled disable action
          return;
        }
      }

      // User wants to disable passcode - skip verification since they're on toggle screen
      await Get.toNamed(
        Routes.passcode,
        arguments: PasscodeArguments(
          mode: PasscodeMode.disable,
          controllerTag: const Uuid().v4(),
          skipPasscodeVerification: true,
          whenPassed: () async {
            Get.back(); // Close passcode screen
            await securityService.clearPasscode();
            await securityService.setEnableBiometric(false);
            await securityService.setEnableAutoUseBiometric(false);
            await checkPasscodeSetup(); // Refresh status
            await securityService.clearShortcutPasscode();
          },
        ),
      );
    }
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickPasscode,
      eventProperties: EventProperty.clickPasscode(value ? 'enabled' : 'disabled'),
    );
  }

  Future<void> autoEnableBiometricAfterPasscodeSetup() async {
    try {
      // Check if device supports biometric authentication
      final isAvailable = await localAuth.isDeviceSupported();
      final canCheckBiometrics = await localAuth.canCheckBiometrics;

      useLogger().d(
          'autoEnableBiometricAfterPasscodeSetup - isAvailable: $isAvailable, canCheckBiometrics: $canCheckBiometrics');

      if (isAvailable && canCheckBiometrics) {
        // Check what types of biometrics are available
        final availableBiometrics = await localAuth.getAvailableBiometrics();

        useLogger().d('Available biometrics: $availableBiometrics');

        if (availableBiometrics.isNotEmpty) {
          // Enable biometric using existing methods
          await securityService.setEnableBiometric(true);
          await securityService.setEnableAutoUseBiometric(true);

          useLogger().d('Biometric automatically enabled after passcode setup');

          // Update local state immediately
          isBiometricEnabled(true);
          isAutoUseBiometric(true);
          isBiometricSupported(true);

          // Update biometric type for UI display
          if (GetPlatform.isIOS) {
            if (availableBiometrics.contains(BiometricType.face)) {
              biometricType(PasscodeBiometric.faceId);
            } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
              biometricType(PasscodeBiometric.touchId);
            }
          } else if (GetPlatform.isAndroid) {
            if (availableBiometrics.contains(BiometricType.strong) ||
                availableBiometrics.contains(BiometricType.weak)) {
              biometricType(PasscodeBiometric.fingerprint);
            }
          }

          useLogger().d('Biometric type set to: ${biometricType.value}');
        } else {
          useLogger().d('No biometrics available on device');
        }
      } else {
        useLogger().d('Device does not support biometric authentication');
      }
    } catch (e, stackTrace) {
      useLogger().e('Error auto-enabling biometric:', e, stackTrace);
    }
  }

  void handleSetNewPasscode() async {
    await Get.toNamed(
      Routes.passcode,
      arguments: PasscodeArguments(
        mode: PasscodeMode.change,
        controllerTag: const Uuid().v4(),
        skipPasscodeVerification: true,
        whenPassed: () async {
          Get.back(); // Close passcode screen
          await checkPasscodeSetup(); // Refresh status
        },
      ),
    );
  }

  void handleToggleBiometric() async {
    final enable = !isBiometricEnabled();

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickUseTouchAndFaceId,
      eventProperties: EventProperty.clickUseTouchAndFaceId(enable ? 'enabled' : 'disabled'),
    );

    securityService.setPreventPasscodeExecution(true);
    final isProved = await proveBiometricBeforeEnableDisable();
    securityService.setPreventPasscodeExecution(false);

    if (!isProved) return;

    if (enable) {
      await securityService.setEnableBiometric(true);
      await checkPasscodeSetup();
    } else {
      await securityService.setEnableBiometric(false);
      isBiometricEnabled(false);
    }
  }

  void checkAndResetUserSyncCompleted({
    required Function onSyncComplete,
    required Function onSyncNotComplete,
  }) async {
    if (syncUserCompleted) {
      await onSyncComplete();
      // Reset syncUserCompleted after check to reset for next time.
      syncUserCompleted = false;
    } else {
      await onSyncNotComplete();
    }
  }
}
