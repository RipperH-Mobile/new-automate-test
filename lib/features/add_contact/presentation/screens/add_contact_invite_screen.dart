import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/app_text.dart';

class AddContactInviteScreen extends StatelessWidget {
  final void Function() onShare;
  final void Function() onCopy;

  const AddContactInviteScreen({
    required this.onShare,
    required this.onCopy,
    super.key,
  });

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppSpace.space4.spMin),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildButton(
            context: context,
            title: 'Share'.tr,
            onTap: onShare,
            icon: Assets.vectors.shareIcon.svg(
              height: AppSize.size6.spMin,
              width: AppSize.size6.spMin,
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.spMin,
            decoration: ShapeDecoration(
              color: context.theme.appColors.border,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          _buildButton(
            context: context,
            title: 'Copy'.tr,
            onTap: onCopy,
            icon: Assets.vectors.copyIcon.svg(
              height: AppSize.size6.spMin,
              width: AppSize.size6.spMin,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String title,
    required Widget icon,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: context.theme.appColors.backgroundNeutralLightest,
        height: AppSize.size12.spMin,
        width: 330.spMin,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            icon,
            AppSpace.space4.horizontalSpace,
            AppText.body1(
              title,
              color: context.theme.appColors.textDarkest,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
