import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_nickname_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class ProfileNicknameScreen extends GetView<ProfileNicknameController> {
  const ProfileNicknameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // didPop prevent double pop when user tap back button
        if (!didPop) {
          controller.handleOnBack();
        }
      },
      child: ScaffoldBasic(
        resizeToAvoidBottomInset: false,
        appBar: const _AppBar(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
            vertical: AppSpace.space4,
          ),
          child: Column(
            children: [
              Obx(() {
                return AppTextField.withClear(
                  labelText: 'Name'.tr,
                  hintText: 'Enter name'.tr,
                  textEditController: controller.inputController,
                  inputType: TextInputType.text,
                  onChanged: controller.onNicknameChange,
                  maxLength: AppEnv.displayNameLengthLimit,
                  isShowIcon: controller.newNickname.isNotEmpty,
                  onIconTap: controller.handleClearTextField,
                );
              }),
              Obx(
                () {
                  if (controller.nickname.isNotEmpty) {
                    return GestureDetector(
                      onTap: () {
                        controller.revertToOriginalName();
                      },
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: AppSize.size4,
                            bottom: AppSize.size6,
                          ),
                          child: Row(
                            children: [
                              AppText.body2(
                                'Revert to Original Name:'.tr,
                                context: context,
                                color: context.theme.appColors.textLight,
                                lineHeight: 1,
                              ),
                              Row(
                                children: [
                                  AppText.body2(
                                    ' ${controller.contact.value?.displayName ?? ''}',
                                    context: context,
                                    color: context.theme.appColors.textPrimary,
                                    lineHeight: 1,
                                  ),
                                  Assets.vectors.swapHoriz.svg(
                                    width: AppSize.size4,
                                    colorFilter: ColorFilter.mode(
                                      context.theme.appColors.textPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends GetView<ProfileNicknameController> implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBarDefault(
        title: 'Edit nickname'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () {
            controller.handleOnBack();
          },
        ),
        actionButton: AppControlButton.forward(
          context: context,
          showIcon: false,
          label: 'Done'.tr,
          actionColor: controller.newNickname.isNotEmpty
              ? context.theme.appColors.textPrimary
              : context.theme.appColors.textLight,
          onTap: () {
            controller.handleUpdateNickname();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
