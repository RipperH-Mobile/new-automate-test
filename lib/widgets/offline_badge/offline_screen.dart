import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/routes/app_pages.dart';

class OfflineScreen extends StatelessWidget {
  final void Function()? onPressed;

  const OfflineScreen({
    super.key,
    this.onPressed,
  });

  HomeController? get controller {
    try {
      return Get.find<HomeController>();
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/offline_big_moon.png',
            height: 80.spMin,
            width: 80.spMin,
          ),
          SizedBox(height: 30.spMin),
          Text(
            'Offline Mode'.tr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: 20.spMin),
          SizedBox(
            width: 330.spMin,
            child: (Get.currentRoute == Routes.coinHistory)
                ? Text(
                    'Now you\'re on offline mode, you can check your history or purchase coin in online mode only.'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff808080),
                    ),
                  )
                : Text(
                    'Now you\'re on offline mode, you can check your last messages at Chat room page.'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff808080),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.spMin),
            child: Material(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(32.r)),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(32.r)),
                hoverColor: Colors.grey.withValues(alpha: .5),
                overlayColor: WidgetStateProperty.all(Colors.grey.withValues(alpha: .6)),
                onTap: onPressed ??
                    () {
                      if (Get.currentRoute == Routes.coinHistory) {
                        SocketCaller.instance.reconnect();
                      } else {
                        Get.back();
                        controller?.paneIndex(0);
                        controller?.cupertinoController?.index = 0;
                      }
                    },
                child: SizedBox(
                  height: 42.spMin,
                  width: 138.spMin,
                  child: Center(
                    child: Text(
                      'Try again'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
