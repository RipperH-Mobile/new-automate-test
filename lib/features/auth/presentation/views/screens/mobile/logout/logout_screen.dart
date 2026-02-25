import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/logout/logout_controller.dart';

class LogoutScreen extends GetView<LogoutController> {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: _buildCenterContent(context),
        ),
      ),
    );
  }

  Widget _buildCenterContent(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: 150,
        child: ZoomIn(
            child: Hero(
          tag: 'uchat_logo',
          child: Image.asset('assets/images/uchat_logo_no_bg.png'),
        )),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: FadeIn(
          delay: const Duration(milliseconds: 500),
          child: Text(
            'Good luck!'.tr,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      )
    ]);
  }
}
