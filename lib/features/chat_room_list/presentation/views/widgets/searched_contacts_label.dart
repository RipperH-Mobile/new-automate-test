import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

import '../../controllers/create_group/select_member_controller.dart';

class SearchedContactsLabel extends StatelessWidget {
  final bool isAllContacts;
  final SelectMemberController controller = Get.find();

  SearchedContactsLabel({
    super.key,
    required this.isAllContacts,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final contactCount = controller.contacts.length;

      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller.searchController,
        builder: (_, value, __) {
          final searchResults = value.text.isNotEmpty;

          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20.spMin,
                (!isAllContacts || searchResults) ? AppSpace.space0 : AppSpace.space6,
                20.spMin,
                AppSpace.space2,
              ),
              child: Row(
                children: [
                  AppText.subtitle1(
                    isAllContacts
                        ? searchResults
                            ? '${'Results'.tr} '
                            : '${'Friends'.tr} '
                        : 'Recent Chats'.tr,
                    context: context,
                    color: context.theme.appColors.textDarkest,
                  ),
                  AppText.subtitle1(
                    isAllContacts ? contactCount.toString() : '',
                    context: context,
                    color: context.theme.appColors.textLight,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
