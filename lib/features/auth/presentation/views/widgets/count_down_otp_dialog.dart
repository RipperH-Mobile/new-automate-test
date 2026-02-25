import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CountDownOtpDialog {
  static Future<void> show({
    BuildContext? context,
    int? countDownStart,
    VoidCallback? onConfirm,
  }) {
    if (context != null && countDownStart != null) {
      return UChatNewDialog.showSingleButtonCustomDialog(
        context: context,
        title: 'Please wait a moment...'.tr,
        confirmText: 'Close'.tr,
        confirmTextColor: context.theme.appColors.textLight,
        description: _CountDown(
          countDownStart: countDownStart,
        ),
        onConfirm: onConfirm,
      );
    }
    return Future.value();
  }
}

class _CountDown extends StatefulWidget {
  const _CountDown({
    required this.countDownStart,
  });

  final int countDownStart;

  @override
  State<_CountDown> createState() => __CountDownState();
}

class __CountDownState extends State<_CountDown> {
  Timer? timer;

  int countDown = 0;

  @override
  void initState() {
    super.initState();
    countDown = widget.countDownStart;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (countDown == 0) {
          timer.cancel();
        } else {
          setState(() {
            countDown--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'You have requested an OTP recently. Please wait for'.tr,
        style: context.theme.appTexts.body3.copyWith(
          color: context.theme.appColors.textLight,
        ),
        children: [
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: '@count seconds'.trParams(
              {
                'count': countDown.toString(),
              },
            ),
            style: TextStyle(
              color: context.theme.appColors.textError,
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: 'before requesting a new code.'.tr,
          ),
        ],
      ),
    );
  }
}
