import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget _blurBox({required Widget widget}) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black.withValues(alpha: 0.2), Colors.black.withValues(alpha: 0.3)]),
            borderRadius: BorderRadius.circular(25),
          ),
          child: widget,
        ),
      ),
    ),
  );
}

Future<void> blurBgDialog({
  Widget? animation,
  Widget? text,
  Widget? actionButton,
  void Function()? onClose,
  bool barrierDismissible = false,
}) async {
  await Get.dialog(
    PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) {
        onClose?.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 2 - 110),
            //use 2 _blurBox as stack to fix animation transition not smooth and flowing.
            child: _blurBox(
              widget: SizedBox(
                width: 210.spMin,
                child: Stack(
                  children: [
                    _blurBox(
                        widget: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          animation ?? Container(),
                          const SizedBox(height: 10),
                          text ?? Container(),
                          //Buttons
                          actionButton ?? Container(),
                        ],
                      ),
                    )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white.withValues(alpha: 0.2), // Button color
                            child: InkWell(
                              splashColor: Colors.black, // Splash color
                              onTap: () {
                                Get.back();
                                onClose?.call();
                              },
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white.withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInBack,
    barrierDismissible: barrierDismissible,
  );
}
