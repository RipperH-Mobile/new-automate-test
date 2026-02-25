import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/contacts/contact_list_item_with_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';
import 'setting_hidden_chats_controller.dart';

class SettingHiddenChatsMobileScreen extends GetView<SettingHiddenChatsController> {
  const SettingHiddenChatsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Hidden chats'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          top: AppSpace.space4,
        ),
        child: Obx(
          () {
            if (!controller.isInitialized.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.rooms.isEmpty) {
              return _emptyData(context: context);
            }

            return _chatList(context: context);
          },
        ),
      ),
    );
  }

  Widget _chatList({
    required BuildContext context,
  }) {
    return SettingFrameContainer.withLongList(
      itemCount: controller.rooms.length,
      itemBuilder: (context, index) {
        final room = controller.rooms.elementAt(index);

        return ContactListItemWithButton<RoomCollection>(
          key: ValueKey(room.id),
          data: room,
          showStatusMessage: false,
          avatarRadius: AppRadius.rounded2xl,
          spaceBetweenAvatarAndTitle: AppSpace.space3,
          buttonText: 'Edit'.tr,
          textInButtonColor: context.theme.appColors.textPrimary,
          backgroundButtonColor: context.theme.appColors.buttonSecondary,
          borderButtonColor: context.theme.appColors.border,
          borderRadiusButton: BorderRadius.circular(AppRadius.roundedXl),
          sizeButton: const Size(AppSize.size10, AppSize.size8),
          marginButton: EdgeInsets.zero,
          onPressed: () => controller.handleEditChatDialog(room),
        );
      },
    );
  }

  Widget _emptyData({
    required BuildContext context,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No hidden chat'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          AppText.body4(
            'You don\'t have a hidden any chat'.tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
        ],
      ),
    );
  }
}
