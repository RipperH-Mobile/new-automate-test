import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/premium_cancel/premium_cancel_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/checkbox/round_checkbox.dart';

class PremiumCancelScreen extends GetView<PremiumCancelController> {
  const PremiumCancelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      backgroundColor: Colors.white,
      appBar: buildSettingAppBar(
        centerTitle: !isMobile,
        title: 'Cancel Membership'.tr,
        borderBottom: 0,
      ),
      bottomNavigationBar: buildBottom(),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              margin: !isMobile
                  ? EdgeInsets.symmetric(
                      horizontal: 31.spMin,
                      vertical: 20.spMin,
                    )
                  : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 31.spMin,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...buildMenus(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildMenus(BuildContext context) {
    return [
      const SettingSpacer(),
      Text(
        'Sorry to see you go'.tr,
        style: TextStyle(
          fontSize: 18.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 10.spMin,
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'You\'ve cancelled your Premium subscription which will end on '.tr,
              style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w400, color: const Color(0xff4D4D4D)),
            ),
            TextSpan(
              text: controller.expiredDate.toString(),
              style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10.spMin,
      ),
      Text(
        'You will lose all Premium benefits if you cancel.'.tr,
        style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w500, color: const Color(0xffff1552)),
      ),
      const SettingDivider(),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.spMin),
        child: Container(
          width: Get.width,
          height: 1,
          color: const Color(0xFFE6E6E6),
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'What\'s the main reason for canceling membership? '.tr,
              style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            TextSpan(
              text: '(Please select 1 option)'.tr,
              style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.w400, color: const Color(0xff4D4D4D)),
            ),
          ],
        ),
      ),
      buildCheckBox(text: 'Don\'t want to pay the current price'.tr, number: 1),
      buildCheckBox(text: 'Don\'t use premium benefit'.tr, number: 2),
      buildCheckBox(text: 'Subscribed by mistake'.tr, number: 3),
      buildCheckBox(text: 'Don\'t want to answer'.tr, number: 4),
      buildCheckBox(text: 'Other'.tr, number: 5),
    ];
  }

  Widget buildCheckBox({required String text, required int number}) {
    return GestureDetector(
      onTap: () {
        controller.isCheck(number);
        controller.txtReason(text);
      },
      child: Column(
        children: [
          SizedBox(height: 20.spMin),
          Container(
            width: Get.width,
            height: 60.spMin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.spMin),
              border: Border.all(width: 1, color: const Color(0xFFE6E6E6)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff4D4D4D),
                      ),
                    ),
                    Obx(() {
                      return UChatRoundCheckBox(
                        size: 26.spMin,
                        onTap: (value) {
                          controller.isCheck(number);
                        },
                        isChecked: controller.isCheck() == number,
                        checkedWidget: Image.asset(
                          'assets/images/v2/checkbox_cancel_member.png',
                        ),
                        checkedColor: Colors.white,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 10,
            blurRadius: 7,
            offset: const Offset(0, 9), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 31),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.spMin),
          child: GestureDetector(
            child: Obx(() {
              return Container(
                decoration: BoxDecoration(
                  color: controller.isCheck() != 0 ? const Color(0xffFF1552) : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12.spMin),
                ),
                child: Center(
                  child: Text(
                    'Continue cancellation'.tr,
                    style: TextStyle(
                      color: controller.isCheck() != 0 ? Colors.white : const Color(0xFF999999),
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
            onTap: () {
              controller.isCheck() != 0 ? controller.handleConfirm() : () {};
            },
          ),
        ),
      ),
    );
  }
}
