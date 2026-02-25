import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'uchat_bottom_sheet_item.dart';

class UChatBottomSheetClose extends StatelessWidget {
  const UChatBottomSheetClose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UChatBottomSheetItem(
      label: 'Close'.tr,
      iconImage: 'assets/images/cancel_icon.png',
      onPressed: () {
        Get.back();
      },
    );
  }
}
