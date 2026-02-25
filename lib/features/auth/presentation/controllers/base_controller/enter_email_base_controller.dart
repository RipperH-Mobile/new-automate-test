import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EnterEmailBaseController extends GetxController {
  final TextEditingController emailCtl = TextEditingController();
  final RxString email = ''.obs;
  final RxString errorMessage = ''.obs;

  bool get enableContinueButton => email.value.isEmail;

  @override
  dispose() {
    emailCtl.dispose();
    super.dispose();
  }

  void onEmailCtlChanged(String value) {
    errorMessage.value = '';
    email.value = value;
    validateEmail();
  }

  void clearEmail() {
    emailCtl.clear();
    errorMessage.value = '';
  }

  Future<void> validateEmail() async {
    final value = emailCtl.text.trim();
    final error = _validateEmailInput(value);
    errorMessage.value = error ?? '';
  }

  String? _validateEmailInput(String value) {
    if (value.isEmpty) {
      errorMessage.value = '';
    } else if (!value.isEmail) {
      return 'Email format is invalid. please try again'.tr;
    }
    return null;
  }

  // TODO: Implement this method in the derived class
  void onContinue();
}
