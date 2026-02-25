import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/chat_room_list_presentation.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/search_all_contact_result_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SearchAllContactResultScreen extends GetView<SearchAllContactResultController> {
  const SearchAllContactResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      appBar: AppBarDefault(
        title: controller.title.value,
        maxTitleWidth: UChatConstant.maxAppBarTitleWidth,
        appBarHeight: AppSpace.space12,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () => Get.back(),
        ),
      ),
      child: Obx(() {
        List<Widget> slivers = [];

        if (controller.contactPreviewList.isEmpty) {
          slivers.add(_buildEmptyStateUi(1));
        } else {
          slivers.add(_buildSearchResult());
        }

        return CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: slivers,
        );
      }),
    );
  }

  Widget _buildContactHeader(int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.space3, left: AppSpace.space4, right: AppSpace.space4),
        child: Row(
          children: [
            AppText.body3Bold(
              'Contacts'.tr,
              context: Get.context!,
            ),
            SizedBox(width: 8.spMin),
            AppText.body3Bold(
              '$count',
              context: Get.context!,
              color: Get.context!.theme.appColors.textLighter,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    return Obx(
      () {
        return SliverPadding(
          padding: const EdgeInsets.only(
            bottom: AppSpace.space4,
            top: AppSpace.space4,
          ),
          sliver: SliverMainAxisGroup(
            slivers: [
              _buildContactHeader(controller.contactPreviewList.length),
              ChatListSearchContactList(
                heroTag: 'search_all_contact_result_screen',
                contactList: controller.contactPreviewList,
                textHighlightStr: controller.keyword.value,
                onTabItem: (value) {
                  controller.handleSelectContact(value);
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpace.space6),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyStateUi(int index) {
    List<String> titleText = [
      'No recent searches'.tr,
      'No results found'.tr,
    ];
    List<String> subTitleText = [
      'You don’t have any recent searches \r\n at the moment'.tr,
      'Please try searching again with different \r\n keywords or check your spelling'.tr,
    ];
    return SliverPadding(
      padding: const EdgeInsets.only(right: AppSpace.space4),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: Get.height * 0.6,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpace.space2,
              children: [
                AppText.title3(
                  titleText[index],
                  color: Get.context!.theme.appColors.textDark,
                  context: Get.context!,
                ),
                AppText.body3(
                  subTitleText[index],
                  color: Get.context!.theme.appColors.textLight,
                  context: Get.context!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
