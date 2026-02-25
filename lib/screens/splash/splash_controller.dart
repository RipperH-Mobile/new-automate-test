import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/screens.dart';

class SplashController extends GetxController {
  final arg = Get.arguments as SplashArguments?;

  @override
  void onReady() async {
    super.onReady();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    arg?.next?.call();
  }
}
