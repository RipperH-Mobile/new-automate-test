import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EnterPasswordBaseController extends GetxController {
  final TextEditingController passwordCtl = TextEditingController();
  final RxString password = ''.obs;
  final RxString errorMessage = ''.obs;
  final RxInt passwordAttempts = 0.obs;
  final RxInt cooldownTime = 0.obs;

  bool get enableButton => password.isNotEmpty && cooldownTime.value == 0;

  String getFormattedTime(int value) {
    final int minutes = value ~/ 60;
    final int seconds = value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // TODO: Implement this method in the derived class
  int? get cooldown;

  @override
  void onInit() {
    super.onInit();
    if (cooldown != null) {
      cooldownTime.value = cooldown!;
      startCooldown();
    }
    passwordAttempts.value = 0;
  }

  void onPasswordCtlChanged(String value) {
    errorMessage.value = '';
    password.value = value;
  }

  void startCooldown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (cooldownTime.value > 0) {
          cooldownTime.value--;
        } else {
          passwordAttempts.value = 0;
          timer.cancel();
        }
      },
    );
  }

  // TODO: Implement this method in the derived class
  void onForgotPassword();

  // TODO: Implement this method in the derived class
  void onContinue();
}
