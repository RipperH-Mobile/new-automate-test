import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/sheet/action_sheet_item.dart';

class ActionSheet {
  static Future<void> showMessageActionSheet({
    required BuildContext context,
    void Function()? onOpenChat,
    required void Function() onOpenInfo,
  }) async {
    await show(
      context: context,
      items: [
        ActionSheetItemBox(
          items: [
            if (onOpenChat != null)
              ActionSheetItem(
                title: 'Open chat'.tr,
                onTap: onOpenChat,
              ),
            ActionSheetItem(
              title: 'Details'.tr,
              onTap: onOpenInfo,
            ),
          ],
        ),
      ],
      tag: 'message_action_sheet',
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required List<ActionSheetItemBox> items,
    required String tag,
  }) async {
    final list = items
      ..add(
        ActionSheetItemBox(
          items: [
            ActionSheetItem(
              title: 'Cancel',
              style: TextStyle(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF1552),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    return showGeneralDialog<T?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: tag,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // slide transition
        const begin = Offset(0.0, 1.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.easeOut;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20.spMin),
            child: Material(
              color: Colors.transparent,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 13.spMin,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
