import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

import '../../controllers/create_group/select_member_controller.dart';

class TitleBar extends GetView<SelectMemberController> {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedLength = controller.selectedContacts.length;

      if (selectedLength > 0) {
        return Text(
          'Selected (@count)'.trParams({
            'count': selectedLength.toString(),
          }),
          textAlign: TextAlign.center,
          style: UTheme.textTheme.appBarTitle.copyWith(
            color: UTheme.color.onAppBar,
          ),
        );
      } else {
        return Text(
          'New group'.tr,
          textAlign: TextAlign.center,
          style: UTheme.textTheme.appBarTitle.copyWith(
            color: UTheme.color.onAppBar,
          ),
        );
      }
    });
  }
}
