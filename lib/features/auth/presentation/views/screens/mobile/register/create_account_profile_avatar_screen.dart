import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_profile_avatar_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class CreateAccountProfileAvatarScreen extends GetView<CreateAccountProfileAvatarController> {
  const CreateAccountProfileAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Create Account'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        actionButton: AppControlButton.forward(
          context: context,
          label: 'Later'.tr,
          onTap: controller.onContinue,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space6,
          right: AppSpace.space6,
          top: AppSpace.space4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText.heading4(
                      'Add Profile Picture'.tr,
                      context: context,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpace.space2,
                      ),
                      child: AppText.body3(
                        'Your profile picture will be visible to everyone \nand you can edit it later.'.tr,
                        context: context,
                        color: context.theme.appColors.textLight,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: AppSpace.space6,
                    ),
                    const SizedBox(
                      height: AppSpace.space2,
                    ),
                    Obx(
                      () => controller.selectedAvatar.value != null
                          ? CircleAvatar(
                              radius: AppSpace.space16,
                              backgroundImage: FileImage(controller.selectedAvatar.value!),
                            )
                          : Image.asset(
                              'assets/images/v2/default_avatar.png',
                              width: AppSpace.space32,
                              height: AppSpace.space32,
                            ),
                    ),
                    const SizedBox(
                      height: AppSpace.space8,
                    ),
                    Container(
                      width: 380,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: context.theme.appColors.backgroundNeutralLightest,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: AppSpace.spacePx,
                            color: context.theme.appColors.border,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => controller.onChooseFromLibrary(context),
                            child: Container(
                              width: double.infinity,
                              height: AppSpace.space16,
                              padding: const EdgeInsets.all(
                                AppSpace.space4,
                              ),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText.button2(
                                    'Choose from library'.tr,
                                    context: context,
                                    color: context.theme.appColors.textDarkest,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: AppSpace.spacePx,
                          ),
                          InkWell(
                            onTap: () => controller.onTakePhoto(context),
                            child: Container(
                              width: double.infinity,
                              height: AppSpace.space16,
                              padding: const EdgeInsets.all(
                                AppSpace.space4,
                              ),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText.button2(
                                    'Take Photo'.tr,
                                    context: context,
                                    color: context.theme.appColors.textDarkest,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpace.space4),
                    Obx(
                      () {
                        if (controller.selectedAvatar.value == null) {
                          return const SizedBox.shrink();
                        } else {
                          return GestureDetector(
                            onTap: controller.removePicture,
                            child: Container(
                              width: double.infinity,
                              height: AppSpace.space16,
                              padding: const EdgeInsets.all(
                                AppSpace.space4,
                              ),
                              decoration: ShapeDecoration(
                                color: context.theme.appColors.backgroundNeutralLightest,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: AppSpace.spacePx,
                                    color: context.theme.appColors.border,
                                  ),
                                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                                ),
                              ),
                              child: Center(
                                child: AppText.button2(
                                  'Remove Picture'.tr,
                                  context: context,
                                  color: context.theme.appColors.textError,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => AppFilledButton.primary(
                context: context,
                label: 'Done'.tr,
                onTap: controller.isButtonEnabled.value ? controller.onContinue : null,
              ),
            ),
            const SizedBox(
              height: AppSpace.space8,
            ),
          ],
        ),
      ),
    );
  }
}
