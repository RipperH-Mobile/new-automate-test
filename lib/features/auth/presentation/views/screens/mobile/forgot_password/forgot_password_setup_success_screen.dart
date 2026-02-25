import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class ForgotPasswordSetupSuccessScreen extends StatelessWidget {
  const ForgotPasswordSetupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarDefault(
        title: 'Forgot Password'.tr,
        automaticallyImplyLeading: false,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.space4),
        child: Column(
          children: [
            const SizedBox(
              height: AppSpace.space14,
            ),
            Image.asset(
              'assets/images/change_password_success.png',
              width: 92.spMin,
              height: 115.spMin,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            AppText.heading4(
              'Password reset successful'.tr,
              context: context,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            AppText.body3(
              'You have successfully reset your password. You can log in to your account using your new password.'.tr,
              context: context,
              color: AppColorsTheme.light().textLight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpace.space10,
            ),
            AppFilledButton.primary(
              context: context,
              onTap: () {
                // TODO: When call this page from setting, we need to go back to setting screen
                if (UserController.instance.currentUser() != null) {
                  Get.offAllNamed(Routes.home);
                } else {
                  Get.offAllNamed(Routes.welcome);
                }
              },
              label: 'Done'.tr,
            )
          ],
        ),
      ),
    );
  }
}
