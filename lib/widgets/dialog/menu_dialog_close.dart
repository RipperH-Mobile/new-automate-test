import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/dialog/menu_dialog_item.dart';

class MenuDialogClose extends StatelessWidget {
  const MenuDialogClose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuDialogItem(
      label: 'Close'.tr,
      isActive: false,
      onPressed: () {
        Get.back();
      },
    );
  }
}
