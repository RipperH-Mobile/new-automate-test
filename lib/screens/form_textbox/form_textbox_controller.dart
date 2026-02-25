import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/form_textbox/form_textbox_argument.dart';

class FormTextboxController extends GetxController {
  final arg = Get.arguments as FormTextboxArgument?;

  TextEditingController inputController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final newTextValue = ''.obs;
  final isChanged = false.obs;
  final originalValue = ''.obs;

  @override
  void onInit() async {
    originalValue(arg?.value ?? '');
    super.onInit();
  }

  int? get maxLength {
    return arg?.maxLength;
  }

  bool get isShowBackButton {
    return arg?.showBackButton ?? true;
  }

  bool get isShowRestoreOriginalValue {
    return arg?.showRestoreOriginalValue ?? true;
  }

  String get restoreOriginalValueText {
    return arg?.restoreOriginalValueText ?? 'Original value: '.tr;
  }

  String get title {
    return arg?.title ?? 'TEXTBOX'.tr;
  }

  String? get value {
    return arg?.value;
  }

  String get actionButtonTitle {
    return arg?.actionButtonTitle ?? 'Save'.tr;
  }

  String? get description {
    return arg?.description;
  }

  void handleBack() {
    focusNode.unfocus();

    String? value;
    if (originalValue() != '') {
      value = originalValue();
    }

    Get.back<String?>(result: value);
  }

  void handleActionButton() {
    focusNode.unfocus();

    String? value;
    if (inputController.text != '') {
      value = inputController.text;
    } else {
      if (originalValue() != '') {
        value = originalValue();
      }
    }

    if (arg?.onActionButton != null) {
      arg?.onActionButton?.call(value);
    } else {
      Get.back<String>(result: value);
    }
  }

  void onInputChange(String newValue) {
    if (newValue != value) {
      isChanged(true);
    } else {
      isChanged(false);
    }
    newTextValue(newValue);
  }

  void handleRestoreOriginalValue() {
    inputController.text = originalValue();
    newTextValue(originalValue());
  }
}
