import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/screens/premium_packages/store/widgets/product_preview_widget.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets.dart';

import 'store_controller.dart';

class PremiumPackagesStoreScreen extends GetView<PremiumPackagesStoreController> {
  const PremiumPackagesStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: const Color(0xffD0D6DE),
      child: CustomScrollView(
        slivers: [
          AppBarWithCallHeader<SliverAppBar>(
            centerTitle: true,
            expandedHeight: 100,
            height: 100,
            automaticallyImplyLeading: false,
            title: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 30.spMin,
                          width: 80.spMin,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: ['#77839A'.hexToColor, '#404652'.hexToColor],
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Upgrade'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 50.spMin,
                          child: AppBarBackButton(
                            onPressed: controller.handleBack,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.settingPremiumPacksCompareStore);
                          },
                          child: Container(
                            height: 25.spMin,
                            width: 90.spMin,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.change_circle,
                                  color: Colors.white,
                                  size: 25.spMin,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    'Compare'.tr,
                                    maxLines: 1,
                                    maxFontSize: 14,
                                    minFontSize: 2,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SelectableText.rich(
                    TextSpan(
                        text: 'UChat'.tr,
                        style: TextStyle(
                          fontSize: 20.spMin,
                          color: UTheme.color.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              fontSize: 20.spMin,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Premium Packages'.tr,
                            style: TextStyle(
                              fontSize: 20.spMin,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                  5.verticalSpace,
                  Text(
                    'Unlock more features to elevate your experience'.tr,
                    style: TextStyle(
                      fontSize: 14.spMin,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              top: false,
              child: Obx(() {
                return controller.isInitial()
                    ? const Center(child: CupertinoActivityIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.premiumPackages.isEmpty)
                            Center(
                              child: Text('No packages available'.tr),
                            )
                          else
                            ...List.generate(
                              controller.premiumPackages.length,
                              (index) {
                                final product = controller.premiumPackages.elementAtOrNull(index);
                                final theme = product?.storeTheme;
                                if (product == null ||
                                    theme == null ||
                                    product.name?.toLowerCase().contains('free') == true) {
                                  return const SizedBox();
                                }
                                return ProductPreviewWidget(
                                  actualMonthlyPrice:
                                      controller.subscriptionController.getActualPackageData(product, true)?.price ?? 0,
                                  actualYearlyPrice:
                                      controller.subscriptionController.getActualPackageData(product, false)?.price ??
                                          0,
                                  actualCurrency:
                                      controller.subscriptionController.getActualPackageData(product, true)?.currency ??
                                          '',
                                  product: product,
                                  theme: theme,
                                  onTap: () {
                                    controller.handleOpenPremiumPackageDetailScreen(index);
                                  },
                                );
                              },
                            ),
                        ],
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
