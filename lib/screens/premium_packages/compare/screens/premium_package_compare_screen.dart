import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/controllers/subscription_controller.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';
import 'package:uchat/screens/premium_packages/compare/controllers/premium_package_compare_controller.dart';
import 'package:uchat/screens/premium_packages/compare/widgets/sliver_appbar_dropdown_widget.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app/app_bar_with_call_header.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class PremiumPackageCompareScreen extends GetView<PremiumPackageCompareController> {
  const PremiumPackageCompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Compare'.tr,
          style: const TextStyle(
            color: Color(0xff333333),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      child: Obx(() {
        if (controller.premiumPackages.isEmpty) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return Stack(
          children: [
            CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                AppBarWithCallHeader<SliverAppBar>(
                  height: controller.isNotOnTopScreen.value ? 60 : 0,
                  centerTitle: false,
                  title: SliverAppbarDropdownWidget(
                    controller: controller,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Obx(() {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCompareColumn(
                                level: controller.levelFirstPackage.value, context: context, isFirstColumn: true),
                            buildCompareColumn(
                                level: controller.levelSecondPackage.value, context: context, isFirstColumn: false),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            Obx(() => Visibility(
                  visible: controller.isNotOnTopScreen.value,
                  child: Positioned(
                    bottom: 40.h,
                    right: 20.w,
                    child: Container(
                      height: 48.spMin,
                      width: 48.spMin,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UTheme.color.appBar,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.scrollToTop();
                        },
                        icon: const Icon(Icons.arrow_upward_rounded),
                      ),
                    ),
                  ),
                )),
          ],
        );
      }),
    );
  }

  Widget buildCompareColumn({required int level, required BuildContext context, required bool isFirstColumn}) {
    return Column(
      children: [
        buildPreviewPackage(level: level, context: context, isFirstColumn: isFirstColumn),
        SizedBox(
          height: 12.spMin,
        ),
        ...buildAllAbilityPackage(
          level: level,
        ),
        SizedBox(
          height: 40.spMin,
        )
      ],
    );
  }

  List<Widget> buildAllAbilityPackage({required int level}) {
    List<Widget> allAbilityPackageList = [];

    final contents = controller.premiumPackages.elementAtOrNull(level)?.features?.contents;

    if (contents == null) return allAbilityPackageList;

    contents.asMap().forEach((int index, FeatureFlagBase featureContentDataModel) {
      final compareTheme = controller.premiumPackages.elementAt(level).compareTheme;

      if (compareTheme != null) {
        Color? backgroundColor;
        if (index % 2 == 0) {
          backgroundColor = compareTheme.featureBgEven?.hexToColor ?? Colors.white;
        } else {
          backgroundColor = compareTheme.featureBgOdd?.hexToColor ?? Colors.white;
        }

        Color borderColor = compareTheme.borderColor?.hexToColor ?? Colors.white;
        Color titleColor = compareTheme.titleFeatureColor?.hexToColor ?? Colors.white;
        Color descriptionColor = compareTheme.descriptionFeatureColor?.hexToColor ?? Colors.white;
        allAbilityPackageList.add(
          buildAbilityPackage(
            featureContentDataModel: featureContentDataModel,
            isFirst: index == 0,
            isLast: index == contents.length - 1,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            titleColor: titleColor,
            descriptionColor: descriptionColor,
          ),
        );
      }
    });

    return allAbilityPackageList;
  }

  List<Color> listHexToColor(List<String> codes) {
    List<Color> listColor = [];

    for (final code in codes) {
      listColor.add(Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000));
    }

    return listColor;
  }

  Widget buildPreviewPackage({required int level, required BuildContext context, required bool isFirstColumn}) {
    final compareTheme = controller.premiumPackages.elementAtOrNull(level)?.compareTheme;
    final premiumPackages = controller.premiumPackages.elementAtOrNull(level);

    if (compareTheme == null || premiumPackages == null) {
      return const SizedBox.shrink();
    }

    final productMonthly = SubscriptionController.instance.getActualPackageData(premiumPackages, true);
    final productYearly = SubscriptionController.instance.getActualPackageData(premiumPackages, false);

    return Container(
      width: 189.spMin,
      decoration: BoxDecoration(
        color: compareTheme.featureBgEven?.hexToColor ?? Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: compareTheme.borderColor?.hexToColor ?? Colors.white,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showCupertinoModalBottomSheet(
                isDismissible: false,
                barrierColor: Colors.black.withValues(alpha: 0.8),
                topRadius: const Radius.circular(26),
                context: context,
                builder: (context) {
                  return buildSelectPackageBottomSheet(isFirstColumn: isFirstColumn, context: context);
                },
              );
            },
            child: Container(
                margin: EdgeInsets.only(top: 12.spMin, right: 12.spMin),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Image(
                    image: AssetImage('assets/images/swap_icon.png'),
                    width: 24,
                    height: 24,
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.spMin, top: 0.spMin),
            child: Column(
              children: [
                Image(
                  image: UChatImage.networkProvider(
                    premiumPackages.linkUrl ?? '',
                  ),
                  width: 52,
                  height: 52,
                ),
                SizedBox(
                  height: 12.spMin,
                ),
                Text(
                  level == 0 ? (premiumPackages.name ?? '') : ('${premiumPackages.name} Package'),
                  style: TextStyle(
                    color: compareTheme.titleFeatureColor?.hexToColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5.spMin,
                ),
                Visibility(
                  visible: level != 0,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Text(
                    '@parameters/year'.trParams({
                      'parameters': productYearly?.formattedPrice.toString() ?? '0',
                    }),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff7A8197),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.spMin,
                ),
                Visibility(
                  visible: level != 0,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Text(
                    '@parameters/month'.trParams({
                      'parameters': productMonthly?.formattedPrice.toString() ?? '0',
                    }),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff7A8197),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.spMin,
                ),
                GestureDetector(
                  onTap: () {
                    if (level != 0) {
                      controller.handleOpenPremiumPackageDetailScreen(
                        isFirstColumn ? controller.levelFirstPackage.value : controller.levelSecondPackage.value,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17.spMin, vertical: 4.spMin),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: listHexToColor(compareTheme.viewingBgBtnColor ?? []),
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      level == 0 ? 'Free'.tr : 'View'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius? borderRadius(bool? isFirst, bool? isLast) {
    if (isFirst == true) {
      return const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      );
    } else if (isLast == true) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      );
    }
    return null;
  }

  Widget buildAbilityPackage({
    bool? isFirst = false,
    bool? isLast = false,
    required FeatureFlagBase featureContentDataModel,
    required Color backgroundColor,
    required Color borderColor,
    required Color titleColor,
    required Color descriptionColor,
  }) {
    if (featureContentDataModel.compareThemeContent == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 189.spMin,
      height: 220.spMin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius(isFirst, isLast),
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.spMin, horizontal: 24.spMin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: UChatImage.networkProvider(
              featureContentDataModel.compareThemeContent?.linkUrl ?? '',
            ),
            width: 30,
            height: 30,
          ),
          SizedBox(
            height: 12.spMin,
          ),
          Text(
            Get.locale?.languageCode == 'th'
                ? (featureContentDataModel.compareThemeContent?.title?.th ?? '')
                : (featureContentDataModel.compareThemeContent?.title?.en ?? ''),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: featureContentDataModel.enabled == true ? titleColor : const Color(0xffB3B3B3),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5.spMin,
          ),
          Text(
            Get.locale?.languageCode == 'th'
                ? (featureContentDataModel.compareThemeContent?.description?.th ?? '')
                : (featureContentDataModel.compareThemeContent?.description?.en ?? ''),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: featureContentDataModel.enabled == true ? descriptionColor : const Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectPackageBottomSheet({
    required bool isFirstColumn,
    required BuildContext context,
  }) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(top: 40.spMin, bottom: 40.spMin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Package'.tr,
              style: const TextStyle(
                color: Color(0xff1A1A1A),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24.spMin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [...buildSelectPackageBox(isFirstColumn: isFirstColumn, context: context)],
            ),
            SizedBox(
              height: 60.spMin,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                'Cancel'.tr,
                style: const TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> buildSelectPackageBox({
    required bool isFirstColumn,
    required BuildContext context,
  }) {
    return controller.premiumPackages.mapIndexed((index, premiumPackageCollection) {
      bool isSkip = (isFirstColumn && index == controller.levelSecondPackage.value) ||
          (!isFirstColumn && index == controller.levelFirstPackage.value);
      return GestureDetector(
        onTap: isSkip
            ? null
            : () {
                if (isFirstColumn) {
                  controller.setLevelFirstPackage(index);
                } else {
                  controller.setLevelSecondPackage(index);
                }
                Get.back();
              },
        child: Column(
          children: [
            Opacity(
              opacity: isSkip ? 0.5 : 1,
              child: Image(
                image: UChatImage.networkProvider(premiumPackageCollection.linkUrl ?? ''),
                width: 72,
                height: 72,
              ),
            ),
            SizedBox(height: 10.spMin),
            Text(
              premiumPackageCollection.name ?? '',
              style: TextStyle(
                color: isSkip ? const Color(0xff4D4D4D).withValues(alpha: 0.4) : const Color(0xff1A1A1A),
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
