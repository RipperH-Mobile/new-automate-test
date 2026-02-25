import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefundAndBanController extends GetxController {
  final enableButton = false.obs;
  final reasonTextController = TextEditingController();
  final reportRemarkFocus = FocusNode();

  @override
  void onClose() {
    reportRemarkFocus.dispose();
    super.onClose();
  }

  void setEnableButton(bool value) {
    enableButton(value);
  }

  void onChanged(String text) {
    if (text.isNotEmpty) {
      setEnableButton(true);
    } else {
      setEnableButton(false);
    }
  }
}
