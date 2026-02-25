import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_search_input.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_search_result.dart';
import 'package:uchat/widgets/app_text.dart';

class AddContactSearch extends GetView<AddContactSearchController> {
  const AddContactSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: AppSpace.space24,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            Future.delayed(const Duration(milliseconds: 500));

            controller.searchType.value = searchTypeUsername;
            controller.onClearInput();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.spMin),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.theme.appColors.textPrimary,
                ),
                AppSpace.space3.horizontalSpace,
                AppText.body1('Back'.tr, context: context, color: context.theme.appColors.textPrimary),
              ],
            ),
          ),
        ),
        title: AppText.title3('Friend search'.tr, context: context),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSpace.space6.spMin,
          left: AppSpace.space4.spMin,
          right: AppSpace.space4.spMin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildOption(searchTypeUsername, 'UChat ID', context),
                AppSpace.space8.horizontalSpace,
                buildOption(searchTypePhone, 'Phone Number', context),
              ],
            ),
            AppSpace.space8.verticalSpace,
            const AddContactSearchInput(),
            AppSpace.space16.verticalSpace,
            const AddContactSearchResult(),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String value, String label, BuildContext context) {
    return Obx(() {
      final isActive = value == controller.searchType.value;

      return GestureDetector(
        onTap: () => controller.handleTabSearchOption(value),
        child: Row(
          children: [
            Container(
              width: 21.spMin,
              height: 21.spMin,
              decoration: BoxDecoration(
                color: isActive
                    ? context.theme.appColors.backgroundPrimary
                    : context.theme.appColors.backgroundNeutralLighterPressed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 10.5.spMin,
                  height: 10.5.spMin,
                  decoration: BoxDecoration(
                    color: isActive ? context.theme.appColors.backgroundNeutralLightest : null,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            AppSpace.space2.horizontalSpace,
            AppText.body1(label, context: context),
          ],
        ),
      );
    });
  }
}
