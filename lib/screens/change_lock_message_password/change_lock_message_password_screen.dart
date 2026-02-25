import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/change_lock_message_password/change_lock_message_password_controller.dart';
import 'package:uchat/widgets.dart';

class ChangeLockMessagePasswordScreen extends GetView<ChangeLockMessagePasswordController> {
  const ChangeLockMessagePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBar(
        title: AppBarTitle(
          title: controller.args?.oldPassword == null ? 'Set up PIN'.tr : 'Change PIN'.tr,
        ),
        elevation: 0,
        automaticallyImplyLeading: controller.args?.oldPassword != null,
        actions: [
          if (controller.args?.oldPassword == null)
            IconButton(
              onPressed: controller.handleCloseButtonPressed,
              icon: Icon(
                Icons.close,
                color: Colors.black,
                size: 35.spMin,
              ),
            )
        ],
      ),
      child: Column(
        children: [
          if (controller.args?.oldPassword != null) ...[
            SizedBox(height: 12.spMin),
            _buildCurrentPassword(),
          ],
          SizedBox(height: 32.spMin),
          _buildPasswordTextFields(),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildCurrentPassword() {
    return UChatRowMenu(
      title: 'Current PIN'.tr,
      suffixText:
          '${controller.args?.oldPassword?.length ?? 0}/${ChangeLockMessagePasswordController.maxPasswordLength}',
      suffixTextStyle: TextStyle(
        fontSize: 12.sp,
        color: const Color(0xFF666666),
      ),
      subTitle: controller.args?.oldPassword ?? 'Unregistered'.tr,
      subTitleTextStyle: TextStyle(
        fontSize: 14.sp,
      ),
      showArrow: false,
    );
  }

  Widget _buildPasswordTextFields() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        child: SetupPasswordField(
          firstTitle: 'New PIN'.tr,
          secondTitle: 'Confirm PIN'.tr,
          conditionSubtitle: '',
          showNotMatchSubtitle: !controller.passwordIsValid.value,
          showDuplicateSubtitle: false,
          showCheckMarkButton: false,
          showEyeButton: true,
          notMatchSubtitle: 'Password do not match, Please try again.'.tr,
          onNewPasswordChanged: (_) {},
          onConfirmPasswordChanged: controller.onConfirmPinChanged,
          onPasswordValidationChanged: controller.onPasswordValidationChanged,
          spacingBetween: 0,
          validateFirstTextField: false,
          maxLength: ChangeLockMessagePasswordController.maxPasswordLength,
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        child: PrimaryBasicButton(
          title: 'Continue'.tr,
          onPressed: controller.passwordIsValid() ? controller.handleContinuePressed : null,
          width: double.infinity,
          buttonColor: controller.passwordIsValid() ? null : const Color(0xFFE6E6E6),
          textStyle: controller.passwordIsValid() ? null : const TextStyle(color: Color(0xFF999999)),
        ),
      );
    });
  }
}
