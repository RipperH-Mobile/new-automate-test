import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/login_welcome/login_welcome_controller.dart';
import 'package:uchat/features/home/presentation/view/widgets/splash_overlay.dart';
import 'package:uchat/themes/themes.dart';

class LoginWelcomeScreen extends GetView<LoginWelcomeController> {
  const LoginWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: UTheme.color.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final mainTask = (controller.userCtl.loadingTaskNumber() / controller.userCtl.totalNumberTasks).floor() * 100;
        final state = controller.userCtl.loadingTaskNumber.value;
        return SplashOverlay(
          showWelcome: true,
          showUpdating: false,
          loadingPercentage: '${min(mainTask <= 0 ? 100 : mainTask, state)}%',
          loadingStatus: controller.userCtl.loadingTaskStatus(),
        );
      }),
    );
  }
}
