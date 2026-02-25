import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/edit_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/edit_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/remove_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_edit_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_abstract_controller.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ChatRoomDetailAdminEditIds {
  ChatRoomDetailAdminEditIds._();

  static const String permissionPanel = 'chatRoomDetailAdminEditPermissionPanel';
  static const String customTitleTextField = 'chatRoomDetailAdminEditCustomTitleTextField';
  static const String scaffold = 'chatRoomDetailAdminEditScaffold';
}

class ChatRoomDetailAdminEditController extends ChatRoomDetailAdminAbstractController {
  final ChatRoomDetailAdminEditArgument args;
  final EditGroupAdminUseCase editGroupAdminUseCase;
  final RemoveGroupAdminUseCase removeGroupAdminUseCase;

  RoomMemberEntity get member {
    return args.member;
  }

  ChatRoomDetailAdminEditController({
    required this.args,
    required this.editGroupAdminUseCase,
    required this.removeGroupAdminUseCase,
  });

  @override
  void onInit() async {
    if (member.groupRole?.customAdminName != null) {
      customTitleController.text = member.groupRole!.customAdminName!;
    }
    setGroupPermissionsValue = member.groupRole?.permissions?.setGroupPermissions ?? false;
    changeGroupInfoValue = member.groupRole?.permissions?.changeGroupInfo ?? false;
    pinMessagesValue = member.groupRole?.permissions?.pinMessages ?? false;
    deleteOtherMessagesValue = member.groupRole?.permissions?.deleteOtherMessages ?? false;
    groupMemberSettingValue = member.groupRole?.permissions?.groupMemberSetting ?? false;
    groupTypeInviteLinkSetting = member.groupRole?.permissions?.groupTypeInviteLinkSetting ?? false;
    update([ChatRoomDetailAdminEditIds.permissionPanel]);

    super.onInit();
  }

  void handleEditAdmin() async {
    if (customTitleErrorMsg.isNotEmpty) return;
    try {
      await editGroupAdminUseCase.call(EditGroupAdminRequest(
        roomId: args.roomId,
        accountId: args.member.account.id ?? '',
        permissions: GroupAdminPermissionModel(
          setGroupPermissions: setGroupPermissionsValue,
          changeGroupInfo: changeGroupInfoValue,
          pinMessages: pinMessagesValue,
          deleteOtherMessages: deleteOtherMessagesValue,
          groupMemberSetting: groupMemberSettingValue,
          groupTypeInviteLinkSetting: groupTypeInviteLinkSetting,
        ),
        customAdminName: customTitleController.text.trim().isEmpty ? 'Admin' : customTitleController.text.trim(),
      ));

      Get.back();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_ACCOUNT_NOT_MEMBER_OR_ALREADY_HAS_ROLE') {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'This user is not member of this room'.tr,
        );
      } else if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
        useLogger().e('Edit admin ApiException.', e, stackTrace);
      }
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      useLogger().e('Edit admin error.', e, stackTrace);
    }
  }

  void handleRemoveAdmin(BuildContext context) async {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Remove ‘@name’ from administrators?'.trParams({
        'name': member.account.name ?? 'Unknown',
      }),
      description: 'This user will no longer be able to manage users, settings, or perform administrative tasks.'.tr,
      confirmText: 'Remove'.tr,
      confirmTextColor: context.theme.appColors.textError,
      onConfirm: () async {
        final memberId = args.member.account.id;
        if (memberId == null) {
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
          useLogger().e('Member Id is null when trying to remove admin.');
          return;
        }
        try {
          await removeGroupAdminUseCase.call(
            RemoveGroupAdminRequest(
              roomId: args.roomId,
              accountId: memberId,
            ),
          );
          Get.back();
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_ACCOUNT_NOT_MEMBER_OR_ALREADY_HAS_ROLE') {
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              message: 'This user is not member of this room'.tr,
            );
          } else if (e.type == 'ERR_PERMISSION_DENIED') {
            UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          } else {
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
            useLogger().e('Remove admin ApiException.', e, stackTrace);
          }
        } catch (e, stackTrace) {
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
          useLogger().e('Remove admin error.', e, stackTrace);
        }
      },
    );
  }

  @override
  void onSetGroupPermissionsChanged(bool? value) {
    super.onSetGroupPermissionsChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onChangeGroupInfoChanged(bool? value) {
    super.onChangeGroupInfoChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onPinMessagesChanged(bool? value) {
    super.onPinMessagesChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onDeleteOtherMessagesChanged(bool? value) {
    super.onDeleteOtherMessagesChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onGroupMemberSettingChanged(bool? value) {
    super.onGroupMemberSettingChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onMuteMembersChanged(bool? value) {
    super.onMuteMembersChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onEnableDisableSlowModeChanged(bool? value) {
    super.onEnableDisableSlowModeChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onGroupTypeInviteLinkSettingChanged(bool? value) {
    super.onGroupTypeInviteLinkSettingChanged(value);
    update([ChatRoomDetailAdminEditIds.permissionPanel]);
  }

  @override
  void onCustomTitleChanged(String value) {
    super.onCustomTitleChanged(value);
    update([ChatRoomDetailAdminEditIds.customTitleTextField, ChatRoomDetailAdminEditIds.scaffold]);
  }
}
