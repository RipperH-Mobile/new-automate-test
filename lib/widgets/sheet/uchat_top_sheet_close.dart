import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'uchat_top_sheet_item.dart';

class UChatTopSheetClose extends StatelessWidget {
  const UChatTopSheetClose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UChatTopSheetItem(
      label: 'Close'.tr,
      iconImage: 'assets/images/cancel_icon.png',
      onPressed: () {
        Get.back();
      },
    );
  }
}
