import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

Future<void> showMenuDialog({
  required String title,
  required List<Widget> options,
}) async {
  await Get.dialog(
    Dialog(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 30,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: UTheme.textTheme.optionsDialogTitle,
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: GestureDetector(
                  //     onTap: () => Get.back(),
                  //     child: Image(
                  //       image: AssetImage('assets/images/cancel_icon.png'),
                  //       width: 18,
                  //       height: 18,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            ...options,
            Container(height: 20),
          ],
        ),
      ),
    ),
  );
}
