import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_abstract_controller.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ChatRoomDetailAdminAddIds {
  ChatRoomDetailAdminAddIds._();

  static const String permissionPanel = 'chatRoomDetailPermissionPanel';
  static const String customTitleTextField = 'chatRoomDetailCustomTitleTextField';
  static const String scaffold = 'chatRoomDetailAdminAddScaffold';
}

class ChatRoomDetailAdminAddController extends ChatRoomDetailAdminAbstractController {
  final ChatRoomDetailAdminAddArgument args;

  RoomDetailMemberAndPendingModel get member {
    return args.member;
  }

  ChatRoomDetailAdminAddController({
    required this.args,
  });

  void handleAddAdmin() async {
    if (customTitleErrorMsg.isNotEmpty) return;
    try {
      await GetIt.I<AddGroupAdminUseCase>().call(
        AddGroupAdminRequest(
          roomId: args.roomId,
          accountId: args.member.accountId,
          permissions: GroupAdminPermissionModel(
            setGroupPermissions: setGroupPermissionsValue,
            changeGroupInfo: changeGroupInfoValue,
            pinMessages: pinMessagesValue,
            deleteOtherMessages: deleteOtherMessagesValue,
            groupMemberSetting: groupMemberSettingValue,
            groupTypeInviteLinkSetting: groupTypeInviteLinkSetting,
          ),
          customAdminName: customTitleController.text.trim().isEmpty ? 'Admin' : customTitleController.text.trim(),
        ),
      );

      Get.close(2);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_ACCOUNT_NOT_MEMBER_OR_ALREADY_HAS_ROLE') {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'This user is not member of this room or is already an admin'.tr,
        );
      } else if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
        useLogger().e('handleAddAdmin ApiException.', e, stackTrace);
      }
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      useLogger().e('handleAddAdmin error.', e, stackTrace);
    }
  }

  @override
  void onSetGroupPermissionsChanged(bool? value) {
    super.onSetGroupPermissionsChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onChangeGroupInfoChanged(bool? value) {
    super.onChangeGroupInfoChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onPinMessagesChanged(bool? value) {
    super.onPinMessagesChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onDeleteOtherMessagesChanged(bool? value) {
    super.onDeleteOtherMessagesChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onGroupMemberSettingChanged(bool? value) {
    super.onGroupMemberSettingChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onMuteMembersChanged(bool? value) {
    super.onMuteMembersChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onEnableDisableSlowModeChanged(bool? value) {
    super.onEnableDisableSlowModeChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onGroupTypeInviteLinkSettingChanged(bool? value) {
    super.onGroupTypeInviteLinkSettingChanged(value);
    update([ChatRoomDetailAdminAddIds.permissionPanel]);
  }

  @override
  void onCustomTitleChanged(String value) {
    super.onCustomTitleChanged(value);
    update([ChatRoomDetailAdminAddIds.customTitleTextField, ChatRoomDetailAdminAddIds.scaffold]);
  }
}
