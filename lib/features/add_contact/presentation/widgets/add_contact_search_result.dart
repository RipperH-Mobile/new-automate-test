import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';
import 'package:uchat/features/add_contact/presentation/widgets/search_contact_result.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AddContactSearchResult extends GetView<AddContactSearchController> {
  const AddContactSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value == true) {
        return Container(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 118.spMin),
            child: const CircularProgressIndicator(
              value: null,
            ),
          ),
        );
      }

      if (controller.searchResult.value?.exist == true) {
        return const SearchContactResult();
      } else if (controller.searchText.value.isEmpty) {
        return const SizedBox.shrink();
      } else if (controller.isResultNotFound.value) {
        return Container(
          margin: EdgeInsets.only(top: 118.spMin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Assets.vectors.searchIcon.svg(
                height: AppSize.size8.spMin,
                width: AppSize.size8.spMin,
              ),
              AppSpace.space3.verticalSpace,
              AppText.body1(
                'User not found.'.tr,
                color: context.theme.appColors.textDark,
                context: context,
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
