import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class CustomizeEmojiButton extends GetView<CustomizeReactionController> {
  const CustomizeEmojiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!controller.customizing.value) {
          return _buildCustomizeButton();
        } else {
          return _buildSaveAndResetButton();
        }
      },
    );
  }

  Container _buildSaveAndResetButton() {
    return Container(
      padding: EdgeInsets.all(
        20.spMin,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: BasicButton(
                borderColor: const Color(0xFFCCCCCC),
                buttonColor: const Color(0xFFF2F2F2),
                textStyle: const TextStyle(
                  color: Color(0xFF333333),
                ),
                title: 'Set to default'.tr,
                onPressed: () {
                  controller.resetCustomizing();
                },
              ),
            ),
            SizedBox(
              width: 16.spMin,
            ),
            Expanded(
              child: BasicButton(
                buttonColor: UTheme.color.primary,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                title: 'Save'.tr,
                onPressed: controller.saveCustomizing,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCustomizeButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        20.spMin,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: BasicButton(
          buttonColor: Colors.white,
          borderColor: const Color(0xFFCCCCCC),
          textStyle: TextStyle(
            color: UTheme.color.primary,
          ),
          icon: Image.asset(
            'assets/images/customize_emoji_icon.png',
            width: 18.spMin,
            height: 18.spMin,
          ),
          title: 'Customize your emoji'.tr,
          onPressed: controller.startCustomizing,
        ),
      ),
    );
  }
}
