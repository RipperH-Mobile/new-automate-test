import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/gen/assets.gen.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.images.uchatLogoSplash.image(
          width: 220,
          height: 220,
        ),
      ),
    );
  }
}
