import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/contact/presentation/controllers/reason_refund_coin_controller.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ReasonRefundCoinBottomSheetWidget extends GetView<ReasonRefundCoinController> {
  const ReasonRefundCoinBottomSheetWidget({
    super.key,
    required this.refundedTransactionId,
    required this.coinAmount,
  });
  final String refundedTransactionId;
  final int coinAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6.sh,
      padding: const EdgeInsets.symmetric(vertical: AppSpace.space6, horizontal: AppSpace.space4),
      margin: const EdgeInsets.symmetric(vertical: AppSpace.space6, horizontal: AppSpace.space4),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.all(Radius.circular(AppSpace.space6.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.title3(
              'Please write the reason for requesting a refund'.tr,
              context: context,
            ),
            const SizedBox(height: AppSpace.space2),
            RichText(
              text: TextSpan(
                text: 'You have made a refund request for @coinAmount coins. which violates the '.trParams({
                  'coinAmount': '$coinAmount',
                }),
                style: DefaultTextStyle.of(context).style.copyWith(
                      color: context.theme.appColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                children: [
                  TextSpan(
                    text: 'Terms and condition.'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        UChatNewDialog.showSingleButtonCustomDialog(
                          context: context,
                          title: 'About Coin'.tr,
                          description: AppText.body4(
                            '- Coins purchased in UChat are non-refundable under any circumstances.\n\n- To transfer purchased coins when changing devices or phone numbers, you must link your UChat account to an email first.\n\n- Purchased coins will only be stored in the same operating system. When logging in on a different operating system, those coins will not be usable.'
                                .tr,
                            context: context,
                            color: context.theme.appColors.textLight,
                          ),
                          confirmTextColor: context.theme.appColors.textPrimary,
                        );
                      },
                  ),
                  TextSpan(
                    text: ' Please write a reason for your coin refund request.'.tr,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.space2),
            AppText.body3(
              'If you have a problem, please contact our team at support@uchat.social'.tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
            const SizedBox(height: AppSpace.space6),
            SizedBox(
              height: 220.spMin,
              child: TextField(
                onChanged: (text) => controller.checkTextField(text.trim()),
                controller: controller.reasonController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpace.space3.r),
                    borderSide: BorderSide(
                      color: context.theme.appColors.border,
                      width: 0.5,
                    ),
                  ),
                  alignLabelWithHint: true,
                  hintText: 'Write a reason'.tr,
                  hintStyle: TextStyle(
                    color: context.theme.appColors.textDisable,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.only(top: AppSpace.space3, left: AppSpace.space4),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.space6),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.sendRefundReason(refundedTransactionId);
                },
                child: Container(
                  width: double.infinity,
                  height: 52.spMin,
                  decoration: BoxDecoration(
                    color: controller.isReasonInvalid.value
                        ? context.theme.appColors.buttonDisable
                        : context.theme.appColors.buttonPrimary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: AppText.title3(
                    'Send'.tr,
                    context: context,
                    color: controller.isReasonInvalid.value
                        ? context.theme.appColors.textDisable
                        : context.theme.appColors.textPrimaryInverse,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
