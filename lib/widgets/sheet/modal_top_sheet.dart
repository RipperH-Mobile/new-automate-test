import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

Future<void> showUChatModalTopSheet({
  required List<Widget> menus,
  String? title,
}) async {
  await Get.generalDialog(
    barrierDismissible: true,
    barrierLabel: 'Close'.tr,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return Column(
        children: [
          Container(
            color: UTheme.color.topSheetBackground,
            width: double.infinity,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: UTheme.textTheme.topSheetTitle.copyWith(
                          color: UTheme.color.onTopSheetBackground,
                        ),
                      ),
                    ),
                  Row(children: menus),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
