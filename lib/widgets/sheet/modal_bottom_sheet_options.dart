import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modal_bottom_sheet_options_item.dart';
import 'modal_bottom_sheet_options_widget.dart';

Future<void> showUChatModalBottomSheetOptions({
  required String title,
  String? subtitle,
  required List<BottomSheetOptionItem> items,
  required String buttonTitle,
  ButtonType? buttonType,
  required Function(BottomSheetOptionItem item) onSubmit,
}) async {
  await Get.bottomSheet(
    BottomSheetOptions(
      title: title,
      subtitle: subtitle,
      items: items,
      buttonTitle: buttonTitle,
      buttonType: buttonType ?? ButtonType.primary,
      onSubmit: onSubmit,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  );
}
