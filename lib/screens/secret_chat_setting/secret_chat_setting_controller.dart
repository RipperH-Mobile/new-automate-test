import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_secret_room_expire_at_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/end_secret_chat_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_mute_room_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_show_expired_date_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_arguments.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SecretChatSettingController extends GetxController {
  final SecretChatSettingArguments args;

  SecretChatSettingController({required this.args});

  final activeExpireInList = <int>[].obs;

  StreamSubscription? roomUpdateSubscription;
  Timer? roomExpireTimer;

  final selectedExpireIn = RxnInt();
  final isShowExpireTime = false.obs;
  final isTurnOffMessageNotifications = false.obs;
  final isHideMessageNotifications = false.obs;

  String get roomId {
    return args.roomId;
  }

  ChatRoomController? get roomCtl {
    if (Get.isRegistered<ChatRoomController>(tag: roomId)) {
      return Get.find<ChatRoomController>(tag: roomId);
    }
    return null;
  }

  bool get isMobile {
    return GetPlatform.isMobile;
  }

  @override
  void onInit() async {
    int maxSecond = UserController.instance.maxSecond;
    List<int> allExpireTimes = [
      600, // 10 minutes
      1200, // 20 minutes
      1800, // 30 minutes
      3600, // 1 hour
      28800, // 8 hours
      86400, // 1 day
      259200, // 3 days
      432000, // 5 days
      604800, // 1 week
    ];

    activeExpireInList(allExpireTimes.where((time) => time <= maxSecond).toList());

    roomUpdateSubscription = eventBus.on<RoomUpdateEvent>().listen((event) {
      if (event.room.id == roomId && event.room.expireAt != null) {
        initRoomExpireTimer(event.room.expireAt!);
      }
    });

    final roomSubscription = roomCtl?.roomSub();

    initRoomExpireTimer(roomCtl?.room()?.expireAt);
    fetchInitialState();

    /// Init value by followed [roomSubscription] value
    isTurnOffMessageNotifications(roomSubscription?.isMuted ?? false);
    isHideMessageNotifications(roomSubscription?.isHideMessageNotification ?? false);

    super.onInit();
  }

  void fetchInitialState() async {
    // Fetch the initial state from the server
    isShowExpireTime.value = roomCtl?.roomSub()?.isShowExpireTime ?? false;
  }

  @override
  void onClose() {
    roomUpdateSubscription?.cancel();
    roomExpireTimer?.cancel();

    super.onClose();
  }

  void initRoomExpireTimer(DateTime? expireAt) {
    if (expireAt == null) {
      _log.w('expireAt is null in SecretChatSettingController !');
      return;
    }
    roomExpireTimer?.cancel();
    roomExpireTimer = Timer(expireAt.difference(DateTime.now()), () {
      Get.until((route) => route.settings.name == Routes.chatRoomDirect.replaceAll(':id', roomId));
    });
  }

  void handleSecretChatDurationPressed() async {
    await Get.toNamed(Routes.secretChatSettingDuration.replaceAll(':id', roomId));
    selectedExpireIn.value = null;
  }

  void handleChangeExpireAt() async {
    if (selectedExpireIn() == null) return;
    await UChatLoading.show();
    try {
      await GetIt.I<UpdateSecretRoomExpiredAtUseCase>().call(
        UpdateSecretRoomExpireAtRequest(
          roomId: roomId,
          expireIn: selectedExpireIn()!,
        ),
      );
      await UChatLoading.hide();
      Get.back();
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleChangeExpireAt error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> handleToggleShowExpireTime(bool value) async {
    try {
      await GetIt.I<ToggleShowExpiredDateUseCase>().call(
        ToggleShowExpiredDateParams(roomId: roomId, isShowExpireTime: value),
      );

      isShowExpireTime.value = value;
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleToggleShowExpireTime error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> handleToggleTurnOffMessageNotifications(bool value) async {
    try {
      final response = await GetIt.I<ToggleMuteRoomUseCase>().call(ToggleMuteRoomParams(
        roomId: roomId,
        isMuted: value,
      ));
      final isMuted = response ?? false;
      roomCtl!.roomSub()!.isMuted = isMuted;

      isTurnOffMessageNotifications(isMuted);

      /// If [isTurnOffMessageNotifications] is true, [isHideMessageNotificationsDetails] must be false automatically
      if (isMuted == true) handleToggleHideMessageNotifications(!isMuted, isRelated: true);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleToggleTurnOffMessageNotifications error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleToggleHideMessageNotifications(bool value, {bool isRelated = false}) async {
    /// If [isTurnOffMessageNotifications] is true, this toggle can't be tapped
    if (isTurnOffMessageNotifications() && !isRelated) return;

    try {
      final req = ToggleHideMessageNotificationRequest(
        roomId: roomId,
        isHideMessageNotification: value,
      );

      final result = await GetIt.I<ToggleHideMessageNotificationUseCase>().call(req);

      isHideMessageNotifications(result);
      roomCtl!.roomSub()!.isHideMessageNotification = isHideMessageNotifications();
    } on ApiException catch (e, stackTrace) {
      _log.e('handleToggleHideMessageNotifications ApiException error, $e', e, stackTrace);

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleToggleHideMessageNotifications error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleEndSecretChat() async {
    final result = await UChatDialog.showSecretChatConfirmDialog(
      title: 'End secret chat'.tr,
      description: 'Are you sure you want to end\nthis secret chat'.tr,
      confirmText: 'End'.tr,
    );

    if (!result) return;

    try {
      await UChatLoading.show();
      await GetIt.I<EndSecretChatUseCase>().call(EndSecretChatParams(roomId: roomId));

      Get.back();
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleEndSecretChat ApiException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
    await UChatLoading.hide();
  }
}
