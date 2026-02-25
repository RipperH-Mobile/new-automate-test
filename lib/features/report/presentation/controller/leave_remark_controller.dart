import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveRemarkController {
  final reportRemarkTextController = TextEditingController();
  final reportRemarkText = ''.obs;
  final reportRemarkFocus = FocusNode();

  void onChangedRemark(String? text) {
    final text = reportRemarkTextController.value.text.trim();
    reportRemarkText.value = text;
  }

  void init() {
    reportRemarkText.value = '';
    reportRemarkTextController.clear();
  }
}
