import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_permissions_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class ChatRoomDetailGroupPermissionsScreen extends GetView<ChatRoomDetailGroupPermissionsController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailGroupPermissionsScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
      appBar: AppBarDefault(
        title: 'Group permissions'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: controller.onBack,
        ),
        actionButton: _buildDoneButton(context),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.space4),
          child: Obx(() {
            return Skeletonizer(
              enabled: controller.isLoading.value,
              ignoreContainers: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpace.space4,
                children: [
                  _buildCustomizablePermissionsSection(context: context),
                  _buildCustomizablePermissionsEnabled(
                    child: _buildPermissionsList(context: context),
                  ),
                  _buildCustomizablePermissionsEnabled(
                    child: SettingFrameContainer.withChildren(
                      context: context,
                      children: [
                        _buildSetToDefaultButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCustomizablePermissionsSection({
    required BuildContext context,
  }) {
    return Obx(() {
      return SettingFrameContainer.withChildren(
        context: context,
        children: [
          UChatSwitchRowMenu(
            title: 'Customizable Permissions Settings'.tr,
            subTitle:
                'Here, you can manage and tailor permissions for group members to control how they interact with the group.'
                    .tr,
            value: controller.customizablePermissions.value,
            onTap: controller.isEditablePermissions.value ? controller.toggleCustomizablePermissions : null,
            hasBorder: false,
            titleTextStyle: context.theme.appTexts.body1.copyWith(
              color: context.theme.appColors.textDarkest,
            ),
            subTitleTextStyle: context.theme.appTexts.body4.copyWith(
              color: context.theme.appColors.textLight,
            ),
          ),
          // _buildApplyToAdminsSection(),
        ],
      );
    });
  }

  // Widget _buildApplyToAdminsSection() {
  //   return Obx(() {
  //     return UChatSwitchRowMenu(
  //       title: 'Apply to Admins'.tr,
  //       value: controller.applyToAdmins.value,
  //       onTap: controller.toggleApplyToAdmins,
  //       hasBorder: false,
  //       titleTextStyle: Get.context!.theme.appTexts.body1.copyWith(
  //         color: Get.context!.theme.appColors.textDarkest,
  //       ),
  //     );
  //   });
  // }

  Widget _buildPermissionsList({
    required BuildContext context,
  }) {
    return SettingFrameContainer.withChildren(
      context: context,
      children: [
        _buildPermissionRow(
          context: context,
          title: 'Send messages'.tr,
          observable: controller.sendMessages,
          onChanged: controller.toggleSendMessages,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Send media'.tr,
          observable: controller.sendMedia,
          onChanged: controller.toggleSendMedia,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Mention @all'.tr,
          observable: controller.mentionAll,
          onChanged: controller.togglementionAll,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Edit their own sent messages'.tr,
          observable: controller.editOwnMessages,
          onChanged: controller.toggleEditOwnMessages,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Unsend their own sent messages'.tr,
          observable: controller.unsendOwnMessages,
          onChanged: controller.toggleUnsendOwnMessages,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Use emoji reactions'.tr,
          observable: controller.useEmojiReactions,
          onChanged: controller.toggleUseEmojiReactions,
        ),
        _buildPermissionRow(
          context: context,
          title: 'Add / Delete album in group'.tr,
          observable: controller.addDeleteAlbum,
          onChanged: controller.toggleAddDeleteAlbum,
        ),
      ],
    );
  }

  Widget _buildPermissionRow({
    required BuildContext context,
    required String title,
    required RxBool observable,
    required Function(bool?) onChanged,
  }) {
    return Obx(() {
      final isEditable = controller.isEditablePermissions.value;

      return UChatSwitchRowMenu(
        title: title,
        value: observable.value,
        onTap: isEditable ? onChanged : null,
        hasBorder: false,
        titleTextStyle: context.theme.appTexts.body1.copyWith(
          color: context.theme.appColors.textDarkest,
        ),
      );
    });
  }

  Widget _buildSetToDefaultButton(BuildContext context) {
    return Obx(() {
      final isActionable = controller.isEditablePermissions.value && controller.canSetToDefault.value;

      return UChatRowMenu(
        title: 'Set to default'.tr,
        onTap: isActionable ? controller.setToDefault : null,
        showArrow: false,
        titleTextStyle: context.theme.appTexts.body1.copyWith(
          color: isActionable ? context.theme.appColors.textPrimary : context.theme.appColors.textLightest,
        ),
      );
    });
  }

  Widget _buildDoneButton(BuildContext context) {
    return Obx(() {
      if (!controller.isEditablePermissions.value) {
        return const SizedBox.shrink();
      }

      final hasPermissionChanges = controller.hasPermissionChanges.value;

      return AppControlButton.forward(
        context: context,
        onTap: hasPermissionChanges ? controller.onDone : null,
        label: 'Done'.tr,
        actionColor: hasPermissionChanges ? context.theme.appColors.textPrimary : context.theme.appColors.textLightest,
      );
    });
  }

  Widget _buildCustomizablePermissionsEnabled({
    required Widget child,
  }) {
    return Obx(() {
      return AnimatedOpacity(
        opacity: controller.customizablePermissions.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: child,
      );
    });
  }
}
