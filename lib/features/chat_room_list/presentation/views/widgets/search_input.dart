import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';

import '../../controllers/create_group/select_member_controller.dart';

class SearchInput extends StatelessWidget {
  final SelectMemberController controller = Get.find();

  SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      // Listen to changes in the text
      valueListenable: controller.searchController,
      builder: (_, value, __) {
        final hasText = value.text.isNotEmpty;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
          ),
          child: Container(
            height: AppSize.size10,
            decoration: ShapeDecoration(
              color: context.theme.appColors.backgroundNeutralLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
              ),
            ),
            child: SearchBox(
              color: context.theme.appColors.backgroundNeutralLighterPressed,
              focusNode: controller.searchInputFocus,
              searchController: controller.searchController,
              onSuffixPressed: controller.handleClearSearch,
              hasSuffix: hasText,
            ),
          ),
        );
      },
    );
  }
}
