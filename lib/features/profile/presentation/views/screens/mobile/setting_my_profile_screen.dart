import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SettingMyProfileScreen extends GetView<SettingMyProfileController> {
  const SettingMyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Edit Profile'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () async {
            await controller.saveNewChange();
          },
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppSpace.space4,
            ),
            // Avatar
            editAvatar(),
            const SizedBox(
              height: AppSpace.space6,
            ),
            CornerBoxMenu(
              children: [
                // Display Name
                Obx(
                  () => CornerBoxMenuItemListTitle.arrow(
                    title: AppText.body3(
                      'Name'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    subtitle: AppText.body1(
                      controller.displayNamePreview.value ?? controller.user?.displayName ?? 'Unknown'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    onTap: () => controller.handleEditDisplayName(),
                  ),
                ),

                // Status Message
                Obx(
                  () => CornerBoxMenuItemListTitle.arrow(
                    title: AppText.body3(
                      'Status'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    subtitle: AppText.body1(
                      controller.descriptionPreview.value ?? 'Status'.tr,
                      color: controller.descriptionPreview.value == null
                          ? context.theme.appColors.textLight
                          : context.theme.appColors.textDarkest,
                      context: context,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => controller.handleEditStatusMessage(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpace.space4,
            ),
            CornerBoxMenu(
              children: [
                // Phone Number
                CornerBoxMenuItemListTitle(
                  title: AppText.body1(
                    'Phone number'.tr,
                    context: context,
                  ),
                  trailing: AppText.body1(
                    controller.userCtl.currentPhoneNumber.value,
                    color: context.theme.appColors.textLighter,
                    context: context,
                  ),
                  onTap: controller.handleCopyPhoneNumber,
                ),

                // UChat ID
                Obx(
                  () => CornerBoxMenuItemListTitle(
                    title: AppText.body1(
                      'UChat ID'.tr,
                      context: context,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.body1(
                          controller.userIdPreview.value ?? controller.user?.username ?? 'No UChat ID'.tr,
                          color: context.theme.appColors.textLighter,
                          context: context,
                        ),
                        const SizedBox(
                          width: AppSpace.space3,
                        ),
                        Assets.vectors.iconArrowBackIos.svg(),
                      ],
                    ),
                    onTap: () => controller.handleEditUsername(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpace.space4,
            ),
            CornerBoxMenu(
              children: [
                // Date of Birth
                Obx(
                  () => CornerBoxMenuItemListTitle(
                    title: AppText.body1(
                      'Date of Birth'.tr,
                      context: context,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.body1(
                          controller.formattedBirthdatePreview,
                          color: context.theme.appColors.textLighter,
                          context: context,
                        ),
                        const SizedBox(
                          width: AppSpace.space3,
                        ),
                        Assets.vectors.iconArrowBackIos.svg(),
                      ],
                    ),
                    onTap: controller.handleEditBirthdate,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget editAvatar() {
    return Column(
      children: [
        Obx(
          () {
            return AvatarWrapper<ContactInterface>(
              data: controller.profilePreview() != null ? null : controller.user?.toContact(),
              radius: 52.spMin,
              hasBorder: false,
              showOnlineStatus: false,
              imageFile: controller.profilePreview(),
            );
          },
        ),
        const SizedBox(
          height: AppSpace.space3,
        ),
        GestureDetector(
          onTap: () {
            controller.onChooseFromLibrary(Get.context!);
          },
          child: AppText.button2Bold(
            'Edit'.tr,
            context: Get.context!,
            color: Get.context!.theme.appColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
