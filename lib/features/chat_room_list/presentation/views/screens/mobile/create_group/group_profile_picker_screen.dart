import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class GroupProfilePickerScreen extends GetView<GroupProfilePickerScreenController> {
  const GroupProfilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: _buildAppBar(context),
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      bottomSheet: _buildBottomSheet(context),
      child: Obx(() {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space05,
            vertical: AppSpace.space05,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
          ),
          itemCount: controller.defaultGroupAvatarImages.length,
          itemBuilder: (context, index) {
            final defaultGroupAvatar = controller.defaultGroupAvatarImages[index];

            // isSelected if it matches the currently selectedDefaultAvatar
            final isSelected = controller.selectedDefaultAvatar.value == defaultGroupAvatar;

            return GestureDetector(
              onTap: () {
                controller.handleSelectDefaultPhoto(defaultGroupAvatar);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: UChatImage.network(
                      defaultGroupAvatar,
                      cache: true,
                    ),
                  ),
                  // If selected, add a semi-transparent overlay
                  if (isSelected)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                    ),
                  // If selected, show a check icon
                  if (isSelected)
                    Center(
                      child: Image.asset(
                        'assets/images/v2/new_check_icon.png',
                        width: AppSize.size8,
                        height: AppSize.size8,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  AppBarDefault _buildAppBar(BuildContext context) {
    return AppBarDefault(
      title: 'Group profile Picture'.tr,
      leadingButton: AppControlButton.back(
        context: context,
        onTap: () => Get.back(),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpace.space28,
      padding: const EdgeInsets.only(
        top: AppSpace.space3,
        left: AppSpace.space4,
        right: AppSpace.space4,
        bottom: AppSpace.space10,
      ),
      decoration: BoxDecoration(
        color: context.theme.appColors.buttonSecondary,
        boxShadow: [
          BoxShadow(
            color: context.theme.appColors.borderDisable,
            blurRadius: AppSpace.space4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(
            context: context,
            title: 'Take a Photo'.tr,
            onTap: () => controller.handleCapturePhotoFromCamera(context),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          _buildButton(
            context: context,
            title: 'Choose from Library'.tr,
            onTap: () => controller.handleSelectPhotoFromGallery(context),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String title,
    required void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52.spMin,
          decoration: ShapeDecoration(
            color: context.theme.appColors.buttonSecondary,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: AppSpace.spacePx,
                color: context.theme.appColors.border,
              ),
              borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title.tr,
                style: TextStyle(
                  color: context.theme.appColors.textDarkest,
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
