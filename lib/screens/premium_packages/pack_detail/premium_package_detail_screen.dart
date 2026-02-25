import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_hero/local_hero.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/entities/enum/subscription_period_type.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/screens/premium_packages/pack_detail/controller/premium_package_detail_controller.dart';
import 'package:uchat/screens/premium_packages/pack_detail/widget/3d_button_widget/pushable_button.dart';
import 'package:uchat/screens/premium_packages/pack_detail/widget/header_curve_background.dart/header_curve_background.dart';
import 'package:uchat/screens/premium_packages/pack_detail/widget/included_feature_box.dart';
import 'package:uchat/screens/premium_packages/pack_detail/widget/subscription_period_button.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';
import 'package:uchat/widgets/effect/blur_box.dart';

class PremiumPackageDetailScreen extends GetView<PremiumPackageDetailController> {
  const PremiumPackageDetailScreen({super.key});

  double get _appBarHeight => controller.appBarHeight;

  double get _customAppBarHeight => controller.customAppBarHeight;

  String get headerDescription =>
      'Unlock more features to elevate your\nexperience with our premium package. Upgrade today!'.tr;

  String get whatsIncludedTitle => 'What\'s included'.tr;

  String get subscribeDescription {
    if (GetPlatform.isIOS) {
      return 'The system will automatically collect money from you. and will renew your membership automatically for the same package period at the same price Until you cancel it in the Manage subscriptions.'
          .tr;
    } else {
      return 'The system will automatically collect money from you. and will renew your membership automatically for the same package period at the same price Until you cancel it in the Manage subscriptions.';
    }
  }

  String get confirmSubscribeLabel {
    final product = controller.currentPackageActual;

    if ((product?.price ?? 0) <= 0) {
      return 'Not Available'.tr;
    }
    if (controller.isSubscribed) {
      return 'Subscribed'.tr;
    }

    String duration = controller.isMonthlySelected() ? 'month'.tr : 'year'.tr;
    final ut = controller.userPackageTierLevel();
    final ct = controller.currentPackageTierLevel();
    if (ut > 0 && ct > ut) {
      return '${'Upgrade to'.tr} ${controller.currentPackageInfo.value?.name?.tr} ${product?.price.toString().pricingFormat ?? 0} ${product?.currency}/$duration';
    }
    return '${'Subscribe for'.tr} ${product?.price.toString().pricingFormat ?? 0} ${product?.currency}/$duration';
  }

  static List<Color> defaultGradient = ['#000000'.hexToColor, '#FFFFFF'.hexToColor];

  bool get disableSubscribeBtn {
    return controller.isSubscribed || (controller.currentPackageActual?.price ?? 0) <= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LocalHeroScope(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        child: controller.isInitialing.value
            ? ScaffoldBasic(
                backgroundColor: controller.currentPackageTheme?.bgColor?.firstOrNull?.hexToColor ?? Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocalHero(
                        tag: 'star_icon_${controller.currentPackageId}',
                        child: Image.asset(
                          UChatAssetPath.premiumPackageStarIcon,
                          height: 70.spMin,
                          width: 70.spMin,
                        ),
                      ),
                      Obx(() {
                        return LocalHero(
                          tag: 'package_name_${controller.currentPackageId}',
                          child: buildPackageName(),
                        );
                      })
                    ],
                  ),
                ),
              )
            : ScaffoldBasic(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: bottomNavBarWidget(),
                child: NestedScrollView(
                  controller: controller.scrollPageCtl,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      buildAppBar(),
                    ];
                  },
                  body: Obx(() {
                    return HeaderCurveBackground(
                      size: Size(Get.width, _appBarHeight),
                      // backgroundColor: Colors.transparent,
                      backgroundColor:
                          controller.currentPackageTheme?.bgHeaderColor?.lastOrNull?.hexToColor ?? Colors.white,
                      gradientColors:
                          controller.currentPackageTheme?.bgColor?.map((e) => e.hexToColor).toList() ?? defaultGradient,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: controller.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.premiumPackages.length,
                            itemBuilder: (context, index) {
                              return ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 42.spMin),
                                children: [
                                  SizedBox(height: 15.spMin),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 45),
                                    child: Text(
                                      headerDescription,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.spMin,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  buildSubscriptionTypeSelector(), // monthly, yearly
                                  buildWhatsIncludedList(),
                                ],
                              );
                            },
                          ),
                          Visibility(
                            visible: controller.isShowScrollToTopBtn(),
                            child: FadeIn(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.scrollPageCtl.animateTo(
                                        0,
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: BlurBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.4),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_upward,
                                            size: 20.spMin,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      blurWeight: 10,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
      );
    });
  }

  Widget bottomNavBarWidget() {
    return Container(
      color: const Color(0xFFF2F2F2),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 13.spMin,
            left: 20.spMin,
            right: 20.spMin,
            bottom: 10.spMin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subscribeDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.spMin,
                  fontWeight: FontWeight.w500,
                  color: '#81515C'.hexToColor,
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 12.spMin),
              Stack(
                children: [
                  Obx(() {
                    return PushableButton(
                      onPressed: disableSubscribeBtn
                          ? null
                          : () {
                              controller.subscriptionController.subscribe(controller.currentPackageActual!);
                            },
                      border: BorderRadius.circular(20),
                      hslColor: HSLColor.fromColor(
                        disableSubscribeBtn
                            ? '#B3B3B3'.hexToColor
                            : controller.currentPackageTheme?.bgSubscribeBtn?.hexToColor ?? Colors.white,
                      ),
                      height: 70,
                      child: controller.isInitialing()
                          ? const Center(child: CupertinoActivityIndicator())
                          : AutoSizeText(
                              confirmSubscribeLabel,
                              minFontSize: 5,
                              maxFontSize: 16,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SliverAppBar(
      expandedHeight: _appBarHeight,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor:
          controller.currentPackageInfo.value?.packDetailTheme?.bgHeaderColor?.elementAtOrNull(1)?.hexToColor ??
              Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Container(
            height: _customAppBarHeight,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Obx(() {
              return Row(
                children: [
                  if (!controller.showCustomAppBar())
                    AnimatedOpacity(
                      duration: const Duration(microseconds: 300),
                      opacity: controller.isFirstPage ? .4 : 1,
                      child: GestureDetector(
                        onTap: controller.previousPage,
                        child: Container(
                          height: 30.spMin,
                          width: 30.spMin,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8, right: 10, bottom: 8),
                            child: Image.asset(
                              UChatAssetPath.arrowPreviousRoundedIcon,
                              color: controller.currentPackageTheme?.bgColor?.firstOrNull?.hexToColor
                                      .withValues(alpha: .5) ??
                                  Colors.black12,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      width: 25.spMin,
                    ), // 25 is the width of the back button
                  SizedBox(width: 10.spMin),
                  Expanded(
                    child: buildPackageName(),
                  ),
                  SizedBox(width: 10.spMin),
                  if (!controller.showCustomAppBar())
                    AnimatedOpacity(
                      opacity: controller.isLastPage ? .4 : 1,
                      duration: const Duration(microseconds: 300),
                      child: GestureDetector(
                        onTap: controller.nextPage,
                        child: Container(
                          height: 30.spMin,
                          width: 30.spMin,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, left: 10, right: 8, bottom: 8),
                            child: Image.asset(
                              UChatAssetPath.arrowNextRoundedIcon,
                              color: controller.currentPackageTheme?.bgColor?.firstOrNull?.hexToColor
                                      .withValues(alpha: .5) ??
                                  Colors.black12,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 20,
                        child: Image.asset(
                          UChatAssetPath.crossIcon,
                          width: 20.spMin,
                          height: 20.spMin,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
        centerTitle: true,
        background: Obx(() {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                    controller.currentPackageTheme?.bgHeaderColor?.map((e) => e.hexToColor).toList() ?? defaultGradient,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Star icon
                  Positioned(
                    top: 24.spMin,
                    right: 0,
                    left: 0,
                    child: SafeArea(
                      child: LocalHero(
                        tag: 'star_icon_${controller.currentPackageId}',
                        child: Image.asset(
                          UChatAssetPath.premiumPackageStarIcon,
                          height: 70.spMin,
                          width: 70.spMin,
                        ),
                      ),
                    ),
                  ),

                  // Back button
                  Positioned(
                    right: 24.spMin,
                    top: 10.spMin,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          UChatAssetPath.crossIcon,
                          width: 16.spMin,
                          height: 16.spMin,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildSubscriptionTypeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: BouncingGesture(
              onTap: () {
                controller.isMonthlySelected(true);
              },
              bouncingDurationMilliseconds: 150,
              upperBound: 0.04,
              child: Obx(() {
                final product =
                    controller.subscriptionController.getActualPackageData(controller.currentPackageInfo.value!, true);
                return SubscriptionPeriodButton(
                  price: product?.price ?? 0,
                  available: controller.isMonthlySelected(),
                  period: SubscriptionPeriodType.month,
                  currency: product?.currency ?? 'THB',
                  chipLabel: 'Popular'.tr,
                  chipBackgroundColor: '#4378FF'.hexToColor,
                  backgroundInnerColor:
                      controller.currentPackageTheme?.bgRectMonthly?.map((e) => e.hexToColor).toList(),
                );
              }),
            ),
          ),
          SizedBox(width: 16.spMin),
          Expanded(
            child: BouncingGesture(
              onTap: () {
                controller.isMonthlySelected(false);
              },
              bouncingDurationMilliseconds: 150,
              upperBound: 0.04,
              child: Obx(() {
                final product =
                    controller.subscriptionController.getActualPackageData(controller.currentPackageInfo.value!, false);
                final productMonthly =
                    controller.subscriptionController.getActualPackageData(controller.currentPackageInfo.value!, true);
                String? chipLabel;
                if (product?.price != null && productMonthly?.price != null) {
                  if (product!.price > 0 && productMonthly!.price > 0) {
                    final save = 100 - (product.price / (productMonthly.price * 12) * 100);
                    chipLabel = 'Save @number%'.trParams({'number': save.toStringAsFixed(0)});
                  }
                }
                return SubscriptionPeriodButton(
                  price: product?.price ?? 0,
                  available: controller.isMonthlySelected() == false,
                  period: SubscriptionPeriodType.year,
                  currency: product?.currency ?? 'THB',
                  chipLabel: chipLabel,
                  chipBackgroundColor: '#FF144C'.hexToColor,
                  backgroundInnerColor: controller.currentPackageTheme?.bgRectYearly?.map((e) => e.hexToColor).toList(),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWhatsIncludedList() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: controller.currentPackageTheme?.bgWhatIsInclude?.hexToColor ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              whatsIncludedTitle,
              style: TextStyle(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.spMin),
          ...List.generate(controller.currentPackageInfo.value?.features?.contents?.length ?? 0, (index) {
            final feature = controller.currentPackageInfo.value?.features?.contents?.elementAtOrNull(index);
            if (feature == null || feature.enabled != true) return const SizedBox();
            return FadeInUp(
              from: (index + (50 * (index + 1))).toDouble(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IncludedFeatureBox(
                  title: (Get.locale?.languageCode == 'th'
                          ? feature.detailThemeContentModel?.title?.th
                          : feature.detailThemeContentModel?.title?.en) ??
                      '',
                  description: (Get.locale?.languageCode == 'th'
                          ? feature.detailThemeContentModel?.description?.th
                          : feature.detailThemeContentModel?.description?.en) ??
                      '',
                  imageUrl: feature.detailThemeContentModel?.linkUrl ?? '',
                  // TODO: added icon bg color as well.
                  bgColor: controller.currentPackageTheme?.bgWhatIsIncludeItem?.hexToColor ?? Colors.white,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildPackageName({double fontSize = 30}) {
    return Obx(() {
      if (controller.showCustomAppBar()) {
        return Center(
          child: Text(
            '${controller.currentPackageInfo.value?.name ?? ""} ${'Package'}',
            style: TextStyle(
              fontSize: fontSize * 0.7,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Stack(
              children: [
                Text(
                  controller.currentPackageInfo.value?.name ?? '',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  controller.currentPackageInfo.value?.name ?? '',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: controller.currentPackageTheme?.shadowSubscribeBtn?.hexToColor ?? Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Text(
                controller.currentPackageInfo.value?.name ?? '',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.black,
                ),
              ),
              Text(
                controller.currentPackageInfo.value?.name ?? '',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ],
      );
    });
  }
}
