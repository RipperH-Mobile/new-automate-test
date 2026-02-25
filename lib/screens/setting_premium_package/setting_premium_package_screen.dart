import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_premium_package/setting_premium_package_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

class SettingPremiumPackageScreen extends GetView<SettingPremiumPackageController> {
  const SettingPremiumPackageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      appBar: buildSettingAppBar(
        centerTitle: !isMobile,
        title: 'Premium Packages'.tr,
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: !isMobile
                  ? EdgeInsets.symmetric(
                      horizontal: 31.spMin,
                      vertical: 20.spMin,
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildMenus(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenus(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return [
      const SettingSpacer(),
      UChatRowMenu(
        hasTopBorder: true,
        title: 'Package'.tr,
        suffixText: controller.user?.premiumPackage?.premiumPackageName,
        hasHorizontalBorder: !isMobile,
        hasBottomBorder: true,
        showArrow: false,
      ),
      UChatRowMenu(
        title: 'Extension Date'.tr,
        suffixText: controller.user?.premiumPackage?.expireAt != null
            ? controller.user?.premiumPackage?.expireAt?.format('d MMM yyyy', Get.locale?.toLanguageTag() ?? 'en_US')
            : '',
        hasHorizontalBorder: !isMobile,
        hasBottomBorder: true,
        showArrow: false,
      ),
      SizedBox(
        height: 15.spMin,
      ),
      UChatRowMenu(
        hasTopBorder: true,
        title: 'Cancel Membership'.tr,
        titleTextStyle:
            (controller.user?.premiumPackage?.expireAt != null && controller.user!.premiumPackage!.isAutoRenew == true)
                ? const TextStyle(color: Colors.red)
                : const TextStyle(
                    color: Color(0xFFb3b3b3),
                  ),
        onTap:
            (controller.user?.premiumPackage?.expireAt != null && controller.user!.premiumPackage!.isAutoRenew == true)
                ? controller.handleCancelSubPremium
                : null,
        hasHorizontalBorder: !isMobile,
        hasBottomBorder: controller.user!.premiumPackage!.isAutoRenew == true ? true : false,
        showArrow: false,
      ),
      (controller.user?.premiumPackage?.expireAt != null && controller.user!.premiumPackage!.isAutoRenew == false)
          ? UChatRowMenu(
              height: 50.spMin,
              hasTopBorder: true,
              title: 'Your Premium Package has been canceled.'.tr,
              titleTextStyle: TextStyle(
                color: const Color(0xFFb3b3b3),
                fontSize: 12.spMin,
              ),
              hasHorizontalBorder: !isMobile,
              hasBottomBorder: true,
              hasBorder: false,
              showArrow: false,
            )
          : const SizedBox(),
    ];
  }
}
