import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_invite_link_setting_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/selection_group_menu.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ChatRoomDetailGroupInviteLinkSettingScreen extends GetView<ChatRoomDetailGroupInviteLinkSettingController> {
  final VoidCallback? onBack;

  const ChatRoomDetailGroupInviteLinkSettingScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Invite link'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () {
            if (onBack != null) {
              onBack!();
            } else {
              Get.back();
            }
          },
        ),
        actionButton: GetBuilder<ChatRoomDetailGroupInviteLinkSettingController>(
          builder: (ctl) {
            return AppControlButton.forward(
              context: context,
              onTap: ctl.isChanged ? ctl.onDoneSettingInviteLink : null,
              label: 'Done'.tr,
              actionColor: ctl.isChanged ? context.theme.appColors.textPrimary : context.theme.appColors.textLightest,
            );
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
        child: Column(
          children: [
            GetBuilder<ChatRoomDetailGroupInviteLinkSettingController>(
              builder: (ctl) {
                return SelectionGroupMenu(
                  selectedValue: ctl.selectedInviteLinkStatus,
                  onChanged: ctl.onSelectInviteLinkStatus,
                  choices: [
                    SelectionMenuChoice<InviteLinkStatus>(
                      value: InviteLinkStatus.on,
                      title: 'On'.tr,
                    ),
                    SelectionMenuChoice<InviteLinkStatus>(
                      value: InviteLinkStatus.off,
                      title: 'Off'.tr,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
