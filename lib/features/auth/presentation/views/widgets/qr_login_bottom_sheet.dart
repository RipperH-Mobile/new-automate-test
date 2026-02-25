import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/views/widgets/button.dart';
import 'package:uchat/themes/util.dart';

class QrLoginBottomSheetWidget extends StatelessWidget {
  final String loginFrom;
  final String loginForUsing;
  final VoidCallback onLogin;
  final VoidCallback onCancel;

  const QrLoginBottomSheetWidget({
    super.key,
    required this.loginFrom,
    required this.loginForUsing,
    required this.onLogin,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
          padding: EdgeInsets.fromLTRB(20.spMin, 45.spMin, 20.spMin, 22.spMin),
          child: Builder(builder: (c) {
            return _showDeviceLogin(context);
          })),
    );
  }

  Widget _showDeviceLogin(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              'Log in by QR Code'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/v2/info_circle_icon.png',
              width: 52.spMin,
              height: 52.spMin,
            ),
            SizedBox(
              height: 14.spMin,
            ),
            Text(
              'Would you like to log in?'.tr,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff333333)),
            ),
            SizedBox(
              height: 8.spMin,
            ),
            Text.rich(
              TextSpan(
                text: 'We\'ve detected a login attempt to your UChat account from '.tr,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff808080)),
                children: <TextSpan>[
                  TextSpan(
                    text: loginFrom,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: UTheme.color.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.spMin,
            ),
            Text.rich(
              TextSpan(
                text: 'If you are the one attempting to log in right now, please tap "Log in" to continue using '.tr,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff808080)),
                children: <TextSpan>[
                  TextSpan(
                    text: loginForUsing,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: UTheme.color.primary),
                  ),
                  TextSpan(
                    text: ' on this device. If not, please close this screen.'.tr,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            LoginQRButton(
              onPressed: onLogin,
              text: 'Login'.tr,
              bgColor: const Color(0xff0057ff),
              textColor: Colors.white,
            ),
            SizedBox(
              height: 12.spMin,
            ),
            LoginQRButton(
              onPressed: onCancel,
              text: 'Cancel'.tr,
              bgColor: const Color(0xffF2F2F2),
              textColor: const Color(0xff808080),
            ),
          ],
        ),
      ],
    );
  }
}
