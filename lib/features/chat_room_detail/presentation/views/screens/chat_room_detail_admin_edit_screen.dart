import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_edit_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/custom_admin_title_text_field.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/group_admin_permission_panel.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_admin_profile.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/widgets/button/app_secondary_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ChatRoomDetailAdminEditScreen extends GetView<ChatRoomDetailAdminEditController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailAdminEditScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatRoomDetailAdminEditController>(
        id: ChatRoomDetailAdminEditIds.scaffold,
        tag: tag,
        builder: (controller) {
          return ScaffoldBasic(
            backgroundColor: context.theme.appColors.elevationSurfaceDark,
            resizeToAvoidBottomInset: true,
            appBar: RoomDetailAppBar(
              isSecret: false,
              titleText: 'Edit Admin'.tr,
              onBack: () {
                controller.onBackPressed(context);
              },
              action: () {
                controller.handleEditAdmin();
              },
              actionTextColors: controller.customTitleErrorMsg.isEmpty ? null : context.theme.appColors.textDisable,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RoomDetailAdminProfile(
                    contact: RoomDetailMemberAndPendingModel.fromRoomMemberEntity(
                      controller.member,
                    ).toContactModel(),
                  ),
                  GetBuilder<ChatRoomDetailAdminEditController>(
                      id: ChatRoomDetailAdminEditIds.permissionPanel,
                      tag: tag,
                      builder: (context) {
                        return GroupAdminPermissionPanel(
                          setGroupPermissionsValue: controller.setGroupPermissionsValue,
                          changeGroupInfoValue: controller.changeGroupInfoValue,
                          pinMessagesValue: controller.pinMessagesValue,
                          deleteOtherMessagesValue: controller.deleteOtherMessagesValue,
                          groupMemberSettingValue: controller.groupMemberSettingValue,
                          groupTypeInviteLinkSetting: controller.groupTypeInviteLinkSetting,
                          onSetGroupPermissionsChanged: controller.onSetGroupPermissionsChanged,
                          onChangeGroupInfoChanged: controller.onChangeGroupInfoChanged,
                          onPinMessagesChanged: controller.onPinMessagesChanged,
                          onDeleteOtherMessagesChanged: controller.onDeleteOtherMessagesChanged,
                          onGroupMemberSettingChanged: controller.onGroupMemberSettingChanged,
                          onGroupTypeSettingChanged: controller.onGroupTypeInviteLinkSettingChanged,
                          controllerTag: tag,
                        );
                      }),
                  const SizedBox(height: AppSpace.space4),
                  GetBuilder<ChatRoomDetailAdminEditController>(
                    id: ChatRoomDetailAdminEditIds.customTitleTextField,
                    tag: tag,
                    builder: (controller) {
                      return CustomAdminTitleTextField(
                        textEditingController: controller.customTitleController,
                        onChanged: controller.onCustomTitleChanged,
                        errorMsg: controller.customTitleErrorMsg,
                      );
                    },
                  ),
                  const SizedBox(height: AppSpace.space8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                    child: AppSecondaryButton.error(
                      context: context,
                      label: 'Remove Admin'.tr,
                      onTap: () {
                        controller.handleRemoveAdmin(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
