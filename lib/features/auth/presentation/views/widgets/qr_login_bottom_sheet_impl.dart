import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/features/auth/presentation/views/widgets/qr_login_bottom_sheet.dart';

/// Example of how to show a QR login bottom sheet
void showQrLoginBottomSheet(BuildContext context) async {
  await showCupertinoModalBottomSheet(
    isDismissible: false,
    barrierColor: const Color(0xff000000).withValues(alpha: 0.8),
    topRadius: const Radius.circular(20),
    expand: false,
    context: Get.context!,
    builder: (_) {
      return QrLoginBottomSheetWidget(
        loginFrom: 'UChat Business',
        loginForUsing: 'UChat Business',
        onLogin: () {},
        onCancel: () {},
      );
    },
    // Using with GetX controller
    // builder: (_) {
    //   final ctl = GetController<C>();
    //   return GetBuilder<C>(
    //     init: ctl(parameter: value),
    //     builder: (_) {
    //       return const QrLoginBottomSheetWidget();
    //     },
    //   );
    // },
  );
}
