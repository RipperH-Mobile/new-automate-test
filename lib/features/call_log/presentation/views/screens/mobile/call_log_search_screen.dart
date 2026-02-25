import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_search_screen_controller.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_section.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/contact_search_result_section.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/recent_list_item_shimmer.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contact_list_section.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contacts_recently_search.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class CallLogSearchScreen extends GetView<CallLogSearchScreenController> {
  const CallLogSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarDefault(
        title: 'Search'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () => Get.back(),
        ),
      ),
      child: Column(
        spacing: AppSpace.space2,
        children: [
          Container(
            color: context.theme.appColors.backgroundNeutralLighter,
            padding: const EdgeInsets.only(
              left: AppSpace.space4,
              right: AppSpace.space4,
            ),
            child: SizedBox(
              height: AppSpace.space10,
              child: AppSearchBox(
                focusNode: controller.searchInputFocus,
                controller: controller.searchController,
                onChanged: controller.handleSearch,
              ),
            ),
          ),
          Obx(() {
            if (controller.keyword.isNotEmpty) {
              return Expanded(
                child: controller.contactPreviewList.isEmpty &&
                        controller.callLogs().isEmpty &&
                        controller.isLoading.isFalse
                    ? _buildResultsNotFound(context)
                    : SlidableAutoCloseBehavior(
                        child: SafeArea(
                          child: CustomScrollView(
                            controller: controller.scrollController,
                            slivers: [
                              ..._buildContactsSearchSection(context),
                              ..._buildCallLogSearchSection(context),
                              _buildBottomLoadingIndicator(context),
                              _offlineSliver(context),
                            ],
                          ),
                        ),
                      ),
              );
            } else {
              if (ConnectivityController.instance.isOffline) {
                return Expanded(child: _buildOfflineMode(context));
              }
              // TODO: check load local it suppose to not show load because it's from local, this handle just in case
              // Check if the recent search list is still loading.
              if (controller.isRecentLoading.value) {
                return Expanded(child: _buildRecentSearchShimmer(context));
              }
              // When loaded, display the recent search list (if available) or no recent searches.
              return Expanded(
                child: controller.recentList.isNotEmpty
                    ? _buildRecentlySearchList(context)
                    : _buildNoRecentSearches(context),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildRecentSearchShimmer(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => const RecentListItemShimmer(),
    );
  }

  List<Widget> _buildContactsSearchSection(BuildContext context) {
    return [
      Obx(() {
        final allContacts = controller.contactSection; // Merged friend+group

        if (allContacts.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: _buildResultsNotFound(context),
          );
        }
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.space4),
            child: RichText(
              text: TextSpan(
                text: '${'Contacts'.tr} ',
                style: context.theme.appTexts.body3Bold.copyWith(
                  color: context.theme.appColors.textDarkest,
                ),
                children: [
                  TextSpan(
                    text: '${allContacts.length}',
                    style: context.theme.appTexts.subtitle1.copyWith(
                      color: context.theme.appColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),

      // List of Contact results.
      Obx(() {
        final allContacts = controller.contactSection;
        if (allContacts.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        final section = ContactSearchResultSection(
          'Contacts (@count)'.tr,
          allContacts,
          allContacts.length,
        );

        return ContactListSection<ContactSearchResultModel>(
          sectionList: section,
          nameHighlightStr: controller.keyword.value,
          actionsTailingBuilder: (item) => [
            GestureDetector(
              onTap: () => controller.handleContactCall(context, item, false),
              child: Assets.vectors.iconVoiceCallTailing.svg(),
            ),
            const SizedBox(width: AppSpace.space2),
            GestureDetector(
              onTap: () => controller.handleContactCall(context, item, true),
              child: Assets.vectors.iconVideoCallTailing.svg(),
            ),
          ],
        );
      }),
    ];
  }

  List<Widget> _buildCallLogSearchSection(BuildContext context) {
    return [
      // Header with count or "No results found" message.
      Obx(
        () {
          final callLogResults = controller.callLogs();
          if (callLogResults.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          } else {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space4),
                child: RichText(
                  text: TextSpan(
                    text: '${'Call lists'.tr} ',
                    style: context.theme.appTexts.body3Bold.copyWith(
                      color: context.theme.appColors.textDarkest,
                    ),
                    children: [
                      TextSpan(
                        text: '${controller.total}',
                        style: context.theme.appTexts.subtitle1.copyWith(
                          color: context.theme.appColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      // List of call log results.
      Obx(
        () {
          return CallLogListSection(
            callLogs: controller.callLogs(),
            handleItemPressed: (context, currentData) {
              controller.handleCall(context, currentData);
            },
            isChangeSize: true,
          );
        },
      ),
    ];
  }

  Widget _buildBottomLoadingIndicator(BuildContext context) {
    return Obx(() {
      if (!controller.isLoading.value || controller.callLogs.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
          child: Center(
            child: SizedBox(
              width: AppSpace.space4,
              height: AppSpace.space4,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildRecentlySearchList(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        ContactsRecentlySearch(
          recentList: controller.recentList,
          textHighlightStr: controller.keyword.value,
          onTabItem: (value) {
            controller.handleSelectRecentItem(value);
          },
          onRemoveItem: (value) {
            controller.removeRecentSearch(value);
          },
          onClearRecentSearch: () {
            controller.handleClearRecentSearch();
          },
        ),
        _offlineSliver(context),
      ],
    );
  }

  Widget _offlineSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: AppSpace.space6),
          _buildOfflineMode(context),
        ],
      ),
    );
  }

  Widget _buildOfflineMode(BuildContext context) {
    return Obx(
      () {
        return ConnectivityController.instance.isOffline
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.body2Bold(
                    'A network error occurred.'.tr,
                    context: context,
                    color: context.theme.appColors.textDark,
                  ),
                  const SizedBox(height: AppSpace.space05),
                  AppText.body4(
                    'Connection issue. \nPlease check and try again.'.tr,
                    context: context,
                    color: context.theme.appColors.textLight,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpace.space4),
                  AppFilledButton.dark(
                    context: context,
                    onTap: SocketCaller.instance.reconnect,
                    icon: Assets.vectors.iconRetry.svg(),
                    label: 'Retry'.tr,
                    isExpanded: false,
                    size: AppButtonSize.medium,
                  ),
                  const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoRecentSearches(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No recent searches'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          const SizedBox(height: AppSpace.space2),
          AppText.body4(
            'You don’t have any recent searches at \nthe moment'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildResultsNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No results found'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          const SizedBox(height: AppSpace.space2),
          AppText.body4(
            'Please try searching again with different \nkeywords or check your spelling'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
        ],
      ),
    );
  }
}
