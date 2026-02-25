import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/widgets/app_text.dart';

class NotFriendBanner extends GetView<ChatRoomController> {
  final VoidCallback onAddFriendPress;
  final VoidCallback handleDeclinePress;
  final VoidCallback? onBlockPress;
  final bool? showOnlyAddBtn;
  final bool isFriendRequesting;

  const NotFriendBanner({
    super.key,
    required this.onAddFriendPress,
    required this.handleDeclinePress,
    this.onBlockPress,
    this.showOnlyAddBtn = false,
    this.isFriendRequesting = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showOnlyAddBtn == true && !isFriendRequesting) {
      return buildOnlyAddBtn(context);
    } else {
      return buildTwoButtons(context);
    }
  }

  Widget buildOnlyAddBtn(BuildContext context) {
    return Container(
      height: 80.spMin,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildButton(
                title: 'Add friend'.tr,
                onPressed: onAddFriendPress,
                backgroundColor: context.theme.appColors.backgroundPrimary,
                textColor: context.theme.appColors.textPrimaryInverse,
                hasBorder: false,
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTwoButtons(BuildContext context) {
    final leftButtonText = isFriendRequesting ? 'Accept'.tr : 'Add Friend'.tr;
    final rightButtonText = isFriendRequesting ? 'Decline'.tr : 'Block'.tr;
    final onRightButtonPressed = isFriendRequesting ? handleDeclinePress : onBlockPress;

    return Container(
      height: 80.spMin,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onAddFriendPress,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.appColors.buttonPrimary,
                    borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                  ),
                  child: Center(
                    child: AppText.body3Bold(
                      leftButtonText,
                      context: context,
                      color: context.theme.appColors.textPrimaryInverse,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.spMin),
            Expanded(
              child: GestureDetector(
                onTap: onRightButtonPressed,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLight,
                    borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                  ),
                  child: Center(
                    child: AppText.body3Bold(
                      rightButtonText,
                      context: context,
                      color: context.theme.appColors.textDarkest,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    Color? textColor,
    Color? backgroundColor,
    void Function()? onPressed,
    bool hasBorder = true,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size.fromHeight(52.spMin)),
        backgroundColor: WidgetStateProperty.all(backgroundColor ?? context.theme.appColors.buttonDefault),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
      ),
      child: Text(
        title,
        style: context.theme.appTexts.button2Bold.copyWith(
          color: textColor ?? context.theme.appColors.textDarkest,
          height: 1,
        ),
      ),
    );
  }
}
