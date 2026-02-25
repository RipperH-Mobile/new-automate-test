import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/screens/setting_block_friends/setting_block_friends_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/contacts/contact_list_item_with_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class SettingBlockFriendsMobileScreen extends GetView<SettingBlockFriendsController> {
  const SettingBlockFriendsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Blocked accounts'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: Obx(
          () {
            if (!controller.isIntialized.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.contacts.isEmpty) {
              return _emptyData(context: context);
            }

            return _contractList(context: context);
          },
        ),
      ),
    );
  }

  Widget _contractList({
    required BuildContext context,
  }) {
    return SettingFrameContainer.withLongList(
      itemCount: controller.contacts.length,
      itemBuilder: (context, index) {
        final contact = controller.contacts.elementAt(index);

        return ContactListItemWithButton<ContactInterface>(
          key: ValueKey(contact.id),
          data: contact,
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
          onPressed: () => controller.handleUnblock(contact),
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
            'No blocked account'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          AppText.body4(
            'You don\'t have a blocked any account'.tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
        ],
      ),
    );
  }
}
