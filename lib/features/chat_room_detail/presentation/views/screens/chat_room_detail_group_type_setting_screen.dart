import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_type_setting_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/selection_group_menu.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class ChatRoomDetailGroupTypeSettingScreen extends GetView<ChatRoomDetailGroupTypeSettingController> {
  const ChatRoomDetailGroupTypeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Group type'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: controller.onBack,
        ),
        actionButton: GetBuilder<ChatRoomDetailGroupTypeSettingController>(
          id: ChatRoomDetailGroupTypeSettingIds.doneButton,
          builder: (ctl) {
            return AppControlButton.forward(
              context: context,
              onTap: ctl.isChanged ? ctl.onDone : null,
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
            GetBuilder<ChatRoomDetailGroupTypeSettingController>(
              id: ChatRoomDetailGroupTypeSettingIds.groupTypeSelection,
              builder: (ctl) {
                return SelectionGroupMenu(
                  selectedValue: controller.selectedGroupType,
                  onChanged: controller.onSelectGroupType,
                  choices: [
                    SelectionMenuChoice<RoomAccessType>(
                      value: RoomAccessType.private,
                      title: 'Private'.tr,
                    ),
                    SelectionMenuChoice<RoomAccessType>(
                      value: RoomAccessType.public,
                      title: 'Public'.tr,
                    ),
                  ],
                );
              },
            ),
            AppSpace.space2.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: AppText.caption1(
                'Private groups can only be joined by people who have been invited to the group or have been granted permission to join by the admin.'
                    .tr,
                context: context,
                color: context.theme.appColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
