import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_search_screen_controller.dart';
import 'package:uchat/features/contact/presentation/views/sections/contact_section.dart';
import 'package:uchat/features/contact/presentation/views/sections/group_section.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contact_list_section.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contacts_recently_search.dart';
import 'package:uchat/features/contact/presentation/views/widgets/sliver_future_builder.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/search_box.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ContactsSearchScreen extends GetView<ContactsSearchScreenController> {
  const ContactsSearchScreen({super.key});

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
        appBarHeight: AppSpace.space12,
      ),
      child: Column(
        spacing: AppSpace.space2,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppSpace.space4,
              left: AppSpace.space4,
              top: AppSpace.space2,
            ),
            child: Obx(
              () => SearchBox(
                height: 42.spMin,
                color: context.theme.appColors.backgroundNeutralLight,
                focusNode: controller.searchInputFocus,
                searchController: controller.searchController,
                hasSuffix: controller.keyword.value.isNotEmpty,
                onSuffixPressed: controller.handleClearSearch,
                onChanged: controller.handleSearch,
              ),
            ),
          ),
          Obx(() {
            if (controller.keyword.isNotEmpty) {
              return Expanded(
                  child: controller.contactPreviewList.isEmpty
                      ? _buildResultsNotFound(context)
                      : _buildSearchResultTab(context));
            } else {
              return Expanded(
                child:
                    controller.recentList.isNotEmpty ? _buildRecentlySearchList(context) : _buildOfflineMode(context),
              );
            }
          }),
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
                    backgroundColor: context.theme.appColors.iconLight,
                  ),
                  const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
                ],
              )
            : const SizedBox.shrink();
      },
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

  /// Builds the tab bar and tab view for search results.
  Widget _buildSearchResultTab(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(context),
        Expanded(child: _buildTabBarView(context)),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: Get.height * 0.05),
          height: AppSpace.spacePx,
          color: context.theme.appColors.borderDisable,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpace.space2,
            bottom: AppSpace.space2,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: controller.searchTabController,
              isScrollable: true,
              labelColor: context.theme.appColors.textDarkest,
              indicatorColor: context.theme.appColors.textDarkest,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
              unselectedLabelColor: context.theme.appColors.textLighter,
              indicatorWeight: 1.5,
              onTap: (int index) async {
                String tapCategory = '';
                switch (index) {
                  case 0:
                    tapCategory = 'All';
                  case 1:
                    tapCategory = 'Friends';
                  case 2:
                    tapCategory = 'Groups';
                  case 3:
                    tapCategory = 'Official Accounts';
                }

                GetIt.I<TaxonomyService>().sendEvent(
                  EventName.clickTabContactSearchPage,
                  eventProperties: EventProperty.clickTabContactHomepage(
                    tapCategory: tapCategory,
                  ),
                );
              },
              tabs: [
                Tab(
                  child: Text(
                    'All'.tr,
                    style: context.theme.appTexts.button2Bold,
                  ),
                ),
                Tab(
                  child: Text(
                    'Friends'.tr,
                    style: context.theme.appTexts.button2Bold,
                  ),
                ),
                Tab(
                  child: Text(
                    'Groups'.tr,
                    style: context.theme.appTexts.button2Bold,
                  ),
                ),
                Tab(
                  child: Text(
                    'Official Accounts'.tr,
                    style: context.theme.appTexts.button2Bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: controller.searchTabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // All results: combine Official, Group & Friend sections
        SlidableAutoCloseBehavior(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              ..._buildOfficialAccountSearchSection(context),
              ..._buildGroupSearchSection(context),
              ..._buildFriendSearchSection(context),
              _offlineSliver(context),
            ],
          ),
        ),
        // Friends Tab
        SlidableAutoCloseBehavior(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              ..._buildFriendSearchSection(context),
              _offlineSliver(context),
            ],
          ),
        ),
        // Groups Tab
        SlidableAutoCloseBehavior(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              ..._buildGroupSearchSection(context),
              _offlineSliver(context),
            ],
          ),
        ),
        // Official Accounts Tab
        SlidableAutoCloseBehavior(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              ..._buildOfficialAccountSearchSection(context),
              _offlineSliver(context),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildOfficialAccountSearchSection(BuildContext context) {
    return [
      Obx(
        () {
          final officialResults = controller.officialAccountSection;
          if (officialResults.isEmpty && controller.currentTabIndex.value == 3) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: _buildResultsNotFound(context),
            );
          } else if (officialResults.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          } else {
            final contacts = officialResults.map((result) => result.contact!).toList();
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space4),
                child: RichText(
                  text: TextSpan(
                    text: '${'Official Accounts'.tr} ',
                    style: context.theme.appTexts.body3Bold.copyWith(
                      color: context.theme.appColors.textDarkest,
                    ),
                    children: [
                      TextSpan(
                        text: '${contacts.length}',
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
      Obx(
        () {
          final officialResults = controller.officialAccountSection;
          if (officialResults.isNotEmpty) {
            return ContactListSection<ContactInterface>(
              sectionList: ContactSection(
                'Official Accounts (@count)'.tr,
                officialResults.map((result) => result.contact!).toList(),
                officialResults.length,
              ),
              handleItemPressed: (_, contact) {
                controller.onSelectContact(contact);
              },
              nameHighlightStr: controller.keyword.value,
              secondaryActionsBuilder: (contact) {
                return [
                  _buildActionButton(
                    text: 'Hide'.tr,
                    backgroundColor: context.theme.appColors.backgroundNeutralBolder,
                    foregroundColor: context.theme.appColors.textErrorInverse,
                    onTap: () {
                      controller.handleHideContact(contact);
                    },
                  ),
                  _buildActionButton(
                    text: 'Block'.tr,
                    backgroundColor: context.theme.appColors.backgroundError,
                    foregroundColor: context.theme.appColors.textErrorInverse,
                    onTap: () {
                      controller.handleBlockUser(contact);
                    },
                  ),
                ];
              },
            );
          } else {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
        },
      ),
    ];
  }

  List<Widget> _buildGroupSearchSection(BuildContext context) {
    return [
      // Header with count or "No results found" message.
      Obx(() {
        final groupResults = controller.groupSection;
        // If in the Groups tab (index 2) and no results, show a not-found message.
        if (groupResults.isEmpty && controller.currentTabIndex.value == 2) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: _buildResultsNotFound(context),
          );
        } else if (groupResults.isEmpty) {
          // In other tabs (like "All") simply hide this section.
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        } else {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: RichText(
                text: TextSpan(
                  text: '${'Groups'.tr} ',
                  style: context.theme.appTexts.body3Bold.copyWith(
                    color: context.theme.appColors.textDarkest,
                  ),
                  children: [
                    TextSpan(
                      text: '${groupResults.length}',
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
      }),
      // List of group results with Future conversion.
      Obx(() {
        final groupResults = controller.groupSection;
        if (groupResults.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        } else {
          return SliverFutureBuilder<List<RoomDataModel>>(
            future: Future.wait(
              groupResults.map((result) => RoomDataModel.fromRoom(result.room!)).toList(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final rooms = snapshot.data!;
              final section = GroupSection('Groups (@count)'.tr, rooms, rooms.length);
              return ContactListSection<RoomDataModel>(
                sectionList: section,
                handleItemPressed: (_, data) {
                  controller.onSelectedRoom(data.room.value!);
                },
                nameHighlightStr: controller.keyword.value,
                secondaryActionsBuilder: (data) {
                  return [
                    _buildActionButton(
                      text: 'Leave'.tr,
                      backgroundColor: context.theme.appColors.backgroundError,
                      foregroundColor: context.theme.appColors.textErrorInverse,
                      onTap: () {
                        controller.handleLeaveGroup(data.room()!);
                      },
                    ),
                  ];
                },
              );
            },
          );
        }
      }),
    ];
  }

  List<Widget> _buildFriendSearchSection(BuildContext context) {
    return [
      // Header with count or "No results found" message.
      Obx(() {
        final friendResults = controller.friendSection;
        // If in the Friends tab (index 1) and no results, show a not-found message.
        if (friendResults.isEmpty && controller.currentTabIndex.value == 1) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: _buildResultsNotFound(context),
          );
        } else if (friendResults.isEmpty) {
          // In other tabs (like "All") simply hide this section.
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        } else {
          final contacts = friendResults.map((result) => result.contact!).toList();
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: RichText(
                text: TextSpan(
                  text: '${'Friends'.tr} ',
                  style: context.theme.appTexts.body3Bold.copyWith(
                    color: context.theme.appColors.textDarkest,
                  ),
                  children: [
                    TextSpan(
                      text: '${contacts.length}',
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
      }),
      // List of friend results.
      Obx(() {
        final friendResults = controller.friendSection;
        if (friendResults.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        } else {
          final contacts = friendResults.map((result) => result.contact!).toList();
          final section = ContactSection(
            'Friends (@count)'.tr,
            contacts,
            contacts.length,
          );
          return ContactListSection<ContactInterface>(
            sectionList: section,
            handleItemPressed: (_, contact) {
              controller.onSelectContact(contact);
            },
            nameHighlightStr: controller.keyword.value,
            secondaryActionsBuilder: (contact) {
              return [
                _buildActionButton(
                  text: 'Hide'.tr,
                  backgroundColor: context.theme.appColors.backgroundNeutralBolder,
                  foregroundColor: context.theme.appColors.textErrorInverse,
                  onTap: () {
                    controller.handleHideContact(contact);
                  },
                ),
                _buildActionButton(
                  text: 'Block'.tr,
                  backgroundColor: context.theme.appColors.backgroundError,
                  foregroundColor: context.theme.appColors.textErrorInverse,
                  onTap: () {
                    controller.handleBlockUser(contact);
                  },
                ),
              ];
            },
          );
        }
      }),
    ];
  }

  Widget _buildActionButton({
    required String text,
    required GestureTapCallback onTap,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      autoClose: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: (BuildContext context) {
        onTap.call();
      },
      child: AppText.button2Bold(
        text,
        context: Get.context!,
        color: foregroundColor,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
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
