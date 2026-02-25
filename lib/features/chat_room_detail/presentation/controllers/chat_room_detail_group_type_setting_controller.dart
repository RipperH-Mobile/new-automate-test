import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/change_group_access_type_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_group_type_setting_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailGroupTypeSettingIds {
  static const backButton = 'back_button';
  static const doneButton = 'done_button';
  static const groupTypeSelection = 'group_type_selection';
}

class ChatRoomDetailGroupTypeSettingController extends GetxController {
  late String roomId;
  RoomAccessType groupType = RoomAccessType.private;

  RoomAccessType selectedGroupType = RoomAccessType.private;

  @override
  onInit() {
    super.onInit();

    if (Get.arguments is! ChatRoomDetailGroupTypeSettingArgument) {
      Get.back();
    } else {
      final args = Get.arguments as ChatRoomDetailGroupTypeSettingArgument;
      roomId = args.roomId;
      groupType = args.groupType;
      selectedGroupType = groupType;
    }
  }

  bool get isChanged => groupType != selectedGroupType;

  ChatRoomDetailGroupController? get chatRoomDetailController {
    if (!Get.isRegistered<ChatRoomDetailGroupController>(tag: roomId)) {
      return null;
    }

    return Get.find<ChatRoomDetailGroupController>(tag: roomId);
  }

  Future<void> onSelectGroupType(RoomAccessType type) async {
    selectedGroupType = type;
    update([
      ChatRoomDetailGroupTypeSettingIds.doneButton,
      ChatRoomDetailGroupTypeSettingIds.groupTypeSelection,
    ]);
  }

  void onBack() {
    Get.back();
  }

  Future<void> onDone() async {
    try {
      if (chatRoomDetailController?.currentUserMemberData.value?.ableToAccessGroupTypeInviteLinkSetting == false) {
        await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      UChatLoading.show();

      final updatedRoomType = await GetIt.I<ChangeGroupAccessTypeUseCase>().call(
        ChangeGroupAccessTypeRequest(
          roomId: roomId,
          accessType: selectedGroupType,
        ),
      );

      chatRoomDetailController?.room.update(
        (room) {
          if (room != null) {
            room.accessType = updatedRoomType;
          }
        },
      );

      Get.back();
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      }

      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      _log.e('onDone ChangeGroupAccessTypeRequest ApiException.', e, stackTrace);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('onDone ChangeGroupAccessTypeRequest error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    } finally {
      UChatLoading.hide();
    }
  }
}
