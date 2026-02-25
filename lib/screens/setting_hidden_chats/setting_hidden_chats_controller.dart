import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_all_message_in_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/delete_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingHiddenChatsController extends GetxController {
  final isMobile = UChatScreenUtil.instance.isMobile;

  final roomDb = GetIt.I<RoomDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final rooms = <RoomCollection>[].obs;
  final roomSubs = <RoomSubscriptionCollection>[].obs;
  final selectedRooms = <RoomCollection>[].obs;

  final isInitialized = false.obs;

  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _roomDeleteSubscription;

  @override
  void onInit() async {
    _roomUpdateSubscription = eventBus.on<RoomUpdateSubscriptionEvent>().listen((event) {
      getRoomSubsToState();
    });
    _roomDeleteSubscription = eventBus.on<RoomDeleteEvent>().listen((event) {
      getRoomSubsToState();
    });

    await getRoomSubsToState();

    super.onInit();
  }

  @override
  void onClose() {
    _roomUpdateSubscription?.cancel();
    _roomDeleteSubscription?.cancel();
    super.onClose();
  }

  AppSettingsController get appSettingsController => Get.find<AppSettingsController>();

  Future<void> getRoomSubsToState() async {
    isInitialized.value = false;

    final roomSubResult = await roomSubDb.getAllHiddenRoomSub();
    final newRoomList = <RoomCollection>[];

    for (final roomSub in roomSubResult) {
      final room = await roomDb.getRoom(roomSub.roomId ?? '');
      if (room != null) {
        newRoomList.add(room);
      }
    }

    roomSubs(roomSubResult);
    rooms(newRoomList);

    isInitialized.value = true;
  }

  void handleSelectCheckbox(RoomCollection room) {
    bool isSelected = selectedRooms.contains(room);

    if (isSelected) {
      selectedRooms.remove(room);
    } else {
      selectedRooms.add(room);
    }
  }

  void handleEditChatDialog(RoomCollection room) {
    UChatNewDialog.showMultipleActionsDialog(
      context: Get.context,
      title: 'Edit @name chat'.trParams({'name': room.roomName ?? ''}),
      description: 'Change setting @name chat'.trParams({'name': room.roomName ?? ''}),
      actions: [
        UChatNewDialogAction(
          title: AppText.button2Bold(
            'Unhide'.tr,
            color: Get.context?.theme.appColors.textPrimary,
            context: Get.context!,
          ),
          onPressed: () => handleUnhide(room),
        ),
        UChatNewDialogAction(
          title: AppText.button2Bold(
            'Delete'.tr,
            color: Get.context?.theme.appColors.textError,
            context: Get.context!,
          ),
          onPressed: () => handleDeleteRoom(room),
        ),
        UChatNewDialogAction(
          title: AppText.button2Bold(
            'Cancel'.tr,
            color: Get.context?.theme.appColors.textLighter,
            context: Get.context!,
          ),
        ),
      ],
    );
  }

  void handleUnhide(RoomCollection room, {bool isHideToast = false}) async {
    try {
      await GetIt.I<ToggleHideRoomUseCase>().call(ToggleHideRoomRequest(roomId: room.id!, isHidden: false));

      if (isHideToast) return;

      AppToast.showToast(
        context: Get.context!,
        message: 'Unhidden successfully'.tr,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleUnhide error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleDeleteRoom(RoomCollection room) async {
    try {
      handleUnhide(room, isHideToast: true);
      await GetIt.I<DeleteAllMessageInRoomUseCase>().call(room.id!);
      try {
        await GetIt.I<DeleteRoomUseCase>().call(room);
      } on FailedHostLookupException catch (e, stackTrace) {
        useLogger().d('showDialogDeleteChat failed, no internet.', e, stackTrace);
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } catch (e, stackTrace) {
        useLogger().e('showDialogDeleteChat error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      }

      // When delete group,
      // keep room in local db by set last message of my subscription to `null`.
      if (room.isGroup) {
        final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(room.id ?? '');
        if (roomSub != null) {
          roomSub.lastMessage = null;
          await roomSubDb.putRoomSubscription(roomSub);
        }
      } else {
        await GetIt.I<RoomDb>().deleteRoom(room.id!);
      }
      // Remove all room file data from this room
      await GetIt.I<RoomFileDb>().deleteAllFileInRoom(room.id!);
      rooms.remove(room);

      AppToast.showToast(
        context: Get.context!,
        message: 'Successfully'.tr,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleDeleteRoom error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleBack() {
    if (!isMobile) {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingChat);
    } else {
      Get.back();
    }
  }
}
