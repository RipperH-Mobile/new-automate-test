import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/chat_room_list/presentation/chat_room_list_presentation.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/chat_list_recently_search.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/recent_search_item_shimmer.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ChatSearchScreen extends GetView<ChatSearchController> {
  const ChatSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      appBar: AppBarDefault(
        title: 'Search'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () {
            AppToast.hideToast(context);
            Get.back();
          },
        ),
        appBarHeight: AppSpace.space12,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpace.space4, bottom: AppSpace.space4),
        child: Column(
          spacing: AppSpace.space2,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: AppSearchBox(
                focusNode: controller.searchInputFocus,
                controller: controller.searchController,
                scrollPhysics: const ClampingScrollPhysics(),
                scrollController: controller.scrollController,
                onChanged: controller.handleSearch,
                onSubmitted: (value) => controller.handleSearch(value, isOnSubmitted: true),
              ),
            ),
            Obx(() {
              List<Widget> slivers = [];

              if (controller.keyword.isNotEmpty) {
                if (controller.contactPreviewList.isEmpty && controller.messagePreviewList.isEmpty) {
                  slivers.add(_buildEmptyStateUi(1));
                } else {
                  slivers.add(_buildSearchResult());
                }
              } else if (controller.isLoading.value == false) {
                if (controller.recentList.isEmpty) {
                  slivers.add(_buildEmptyStateUi(0));
                } else {
                  slivers.add(_buildRecentlySearchList(context));
                }
              } else if (controller.isLoading.value) {
                slivers.add(const SliverToBoxAdapter(child: RecentSearchItemShimmer()));
              }

              return Expanded(
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  slivers: slivers,
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMessageHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.space3, left: AppSpace.space4, right: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppText.body3Bold(
                  'Messages'.tr,
                  context: Get.context!,
                ),
                SizedBox(width: 8.spMin),
                AppText.body3Bold(
                  '${controller.allMessageCount()}',
                  context: Get.context!,
                  color: Get.context!.theme.appColors.textLighter,
                ),
              ],
            ),
            if (controller.messagePreviewList.length > UChatConstant.maxSearchResultShowed)
              GestureDetector(
                onTap: controller.onSeeMoreSearchMessageResult,
                child: AppText.body3Bold(
                  'See more'.tr,
                  context: Get.context!,
                  color: Get.context!.theme.appColors.textPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContactHeader(int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.space3, left: AppSpace.space4, right: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            if (count > UChatConstant.maxSearchResultShowed)
              GestureDetector(
                onTap: controller.onSeeMoreSearchContactResult,
                child: AppText.body3Bold(
                  'See more'.tr,
                  context: Get.context!,
                  color: Get.context!.theme.appColors.textPrimary,
                ),
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
              if (controller.contactPreviewList.isNotEmpty) _buildContactHeader(controller.contactPreviewList.length),
              if (controller.contactPreviewList.isNotEmpty)
                ChatListSearchContactList(
                  contactList: controller.contactPreviewList,
                  textHighlightStr: controller.keyword.value,
                  limitLength: UChatConstant.maxSearchResultShowed,
                  onTabItem: (value) {
                    controller.handleSelectContact(value);
                  },
                ),
              if (controller.contactPreviewList.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(height: 12.spMin),
                ),
              if (controller.messagePreviewList.isNotEmpty) _buildMessageHeader(),
              if (controller.messagePreviewList.isNotEmpty)
                ChatListSearchRoomMessageList(
                  roomMessageList: controller.messagePreviewList,
                  textHighlightStr: controller.keyword.value,
                  limitLength: UChatConstant.maxSearchResultShowed,
                  onTabItem: (value) {
                    controller.handleSelectMessage(value);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentlySearchList(BuildContext context) {
    return ChatListRecentlySearch(
      recentList: controller.recentList,
      textHighlightStr: controller.keyword.value,
      limitLength: UChatConstant.maxRecentSearchResultShowed,
      onTabItem: (value) {
        controller.handleSelectRecentItem(value);
      },
      onRemoveItem: (value) {
        controller.removeRecentSearch(value);
      },
      onClearRecentSearch: () {
        controller.onClearAllRecentSearch(context);
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
                Text(
                  titleText[index],
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF656565)),
                ),
                Text(
                  subTitleText[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
