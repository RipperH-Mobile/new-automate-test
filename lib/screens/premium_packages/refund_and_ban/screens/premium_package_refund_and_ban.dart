import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/api/payloads/premium_package/send_reason_cancel.dart';
import 'package:uchat/api/services/premium_package_service.dart';
import 'package:uchat/screens/premium_packages/refund_and_ban/controllers/refund_and_ban_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets.dart';

class PremiumPackageRefundAndBan extends GetView<RefundAndBanController> {
  const PremiumPackageRefundAndBan(
    this.package,
    this.period, {
    super.key,
  });

  final String package;
  final String period;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
          padding: EdgeInsets.fromLTRB(20.spMin, 30.spMin, 20.spMin, 22.spMin),
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please write the reason for\nrequesting a refund.'.tr,
                  style: const TextStyle(
                    color: Color(0xff1A1A1A),
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 14.spMin),
                GestureDetector(
                  onTap: () {
                    showDialogInfo();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'You\'ve requested a refund of '.tr,
                          style: const TextStyle(
                            color: Color(0xff4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '$package ($period)',
                          style: const TextStyle(
                            color: Color(0xff1A1A1A),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: ', which violates the '.tr,
                          style: const TextStyle(
                            color: Color(0xff4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'terms and condition.'.tr,
                          style: const TextStyle(
                            color: Color(0xff1A1A1A),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: ' Please provide the reason for your request so we can review and process your refund.'
                              .tr,
                          style: const TextStyle(
                            color: Color(0xff4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.spMin),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Reason'.tr,
                        style: const TextStyle(
                          color: Color(0xff1A1A1A),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFF1552),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.spMin),
                SizedBox(
                  height: 120.spMin,
                  child: TextField(
                    controller: controller.reasonTextController,
                    focusNode: controller.reportRemarkFocus,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    maxLines: null,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: controller.onChanged,
                    style: TextStyle(
                      color: UTheme.color.scaffoldOnBackground,
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintStyle: TextStyle(
                        color: UTheme.color.inputHint,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.spMin,
                      ),
                      hintMaxLines: 3,
                      hintText: 'Write a reason'.tr,
                      counterText: '',
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      fillColor: const Color(0xFFF9F9F9),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 24.spMin),
                SizedBox(
                  width: Get.width,
                  height: 60.spMin,
                  child: TextButton(
                    onPressed: () async {
                      if (controller.enableButton.value) {
                        final isSuccess = await PremiumPackageService().sendReasonCancel(
                          request: SendReasonCancelRequest(
                              reason: controller.reasonTextController.text, description: '', type: 'REFUND'),
                        );

                        if (isSuccess == true) {
                          Get.back();

                          UChatDialog.showDialogSendReasonSuccess();
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        controller.enableButton.value ? const Color(0xff0057ff) : const Color(0xFFF2F2F2),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'Send'.tr,
                      style: TextStyle(
                        color: controller.enableButton.value ? Colors.white : const Color(0xFFB3B3B3),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.spMin),
                Center(
                  child: Text(
                    'If you have a problem, please contact our team at\nsupport@uchat.social'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }

  void showDialogInfo() {
    UChatDialog.showCustomDialog(
      child: (_) => Container(
        padding: EdgeInsets.only(left: 20.spMin, right: 20.spMin, bottom: 24.spMin, top: 12.spMin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.cancel,
                    size: 30,
                    color: Color(0xffCCCCCC),
                  )),
            ),
            Text(
              'About Refund'.tr,
              style: const TextStyle(
                color: Color(0xff333333),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10.spMin,
            ),
            Text(
              '- Once a package has been purchased, cancellation or refund is not recommended.\n- If a refund is detected on your account, your service may be suspended.\n- Downgrading to a lower package is not possible unless you cancel your current subscription.\n- When purchasing a new package during an active subscription, the terms and conditions of the Apple Store and Google Play will apply.'
                  .tr
                  .tr,
              style: const TextStyle(
                color: Color(0xff808080),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
