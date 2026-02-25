import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/screens/premium_packages/compare/controllers/premium_package_compare_controller.dart';
import 'package:uchat/screens/premium_packages/compare/screens/premium_package_compare_screen.dart';

class SliverAppbarDropdownWidget extends StatelessWidget implements PreferredSizeWidget {
  final PremiumPackageCompareController controller;

  const SliverAppbarDropdownWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: Get.width,
        child: AnimatedSwitcher(
          duration: 500.milliseconds,
          child: controller.isNotOnTopScreen.value
              ? Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            isDismissible: false,
                            barrierColor: Colors.black.withValues(alpha: 0.8),
                            topRadius: const Radius.circular(26),
                            context: context,
                            builder: (context) {
                              return const PremiumPackageCompareScreen()
                                  .buildSelectPackageBottomSheet(isFirstColumn: true, context: context);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE6E6E6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.listPackage[controller.levelFirstPackage.value].choiceName,
                                style: const TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14.spMin,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            topRadius: const Radius.circular(26),
                            context: context,
                            builder: (context) {
                              return const PremiumPackageCompareScreen()
                                  .buildSelectPackageBottomSheet(isFirstColumn: false, context: context);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE6E6E6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          margin: EdgeInsets.only(right: 10.spMin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.listPackage[controller.levelSecondPackage.value].choiceName,
                                style: const TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
