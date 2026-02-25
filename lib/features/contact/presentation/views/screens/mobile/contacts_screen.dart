import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/navigator_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/presentation/arguments/contact_sorting_type.dart';
import 'package:uchat/features/contact/presentation/views/widgets/all_group_list_item.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contact_list_widget.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_main.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/banner/banner_notification.dart';
import 'package:uchat/widgets/banner/banner_offline.dart';
import 'package:uchat/widgets/banner/banner_setup_setting.dart';
import 'package:uchat/widgets/banner/banner_update_version.dart';
import 'package:uchat/widgets/offline_badge/offline_badge_loading.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

class ContactsScreen extends GetView<ContactsController> {
  const ContactsScreen({super.key});

  // final SliverOverlapAbsorberHandle appBar = SliverOverlapAbsorberHandle();
  // final SliverOverlapAbsorberHandle searchBar = SliverOverlapAbsorberHandle();
  // final SliverOverlapAbsorberHandle tapBar = SliverOverlapAbsorberHandle();
  // final SliverOverlapAbsorberHandle avatarBar = SliverOverlapAbsorberHandle();
  // final SliverOverlapAbsorberHandle offlineBar = SliverOverlapAbsorberHandle();
  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    if (!isMobile && controller.listTabController.index != 0) {
      controller.listTabController.index = 0;
    }
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarMain<AppBar>(
        title: 'Contact'.tr,
        actions: _buildActions(context),
      ),
      child: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildSearchBar(context),
          ];
        },
        body: Obx(() {
          return CustomScrollView(
            slivers: <Widget>[
              // SliverOverlapInjector(handle: appBar),
              // SliverOverlapInjector(handle: searchBar),
              // SliverOverlapInjector(handle: offlineBar),
              // SliverOverlapInjector(handle: avatarBar),
              // SliverOverlapInjector(handle: tapBar),
              SliverFillRemaining(
                child: Column(
                  children: [
                    _buildAllBanner(context),
                    if (isMobile) ...[
                      _buildTabBar(context),
                    ],
                    _buildInternetSlow(context),
                    Expanded(child: _buildTabBarView(context)),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildInternetSlow(BuildContext context) {
    return Obx(() {
      if (ConnectivityController.instance.isOnline) {
        return const SizedBox.shrink();
      }

      return OfflineBadgeLoading(status: ConnectivityController.instance.connectivityStatus);
    });
  }

  Widget _buildAllBanner(BuildContext context) {
    return Obx(() {
      bool hasNewVersion = AppController.instance.isCanUpdate();
      bool disableNotification = !controller.notiPermGranted();
      final user = UserController.instance.currentUser();
      final shouldSetupEmail = user?.email == null;
      final shouldSetupPassword = user?.hasPassword == false;

      if (ConnectivityController.instance.isOffline) {
        return BannerOffline(
          onPressed: SocketCaller.instance.reconnect,
        );
      } else if (hasNewVersion) {
        return BannerUpdateVersion(
          onPressed: () {
            UChatCallController.instance.removeExistingCall();
            GetIt.I<NavigatorService>().goToAppStore();
          },
        );
      } else if (disableNotification) {
        return BannerNotification(
          onPressed: () async {
            await PermissionController.instance.checkNotificationPermission();

            controller.checkImportantPermission();
          },
        );
      } else if (shouldSetupEmail) {
        return BannerSetupSetting(
          text: 'Set a email to secure account'.tr,
          onPressed: () {
            Get.toNamed(Routes.settingAccountEmailUnregistered);
          },
        );
      } else if (shouldSetupPassword) {
        return BannerSetupSetting(
          text: 'Set a password to secure account'.tr,
          onPressed: () async {
            final result = await Get.toNamed(Routes.settingAccountPromptSetPassword);

            if (result == null) return;

            if (user != null) {
              Get.toNamed(Routes.accountSetting, arguments: AccountSettingArguments(user: user));
            }
            Get.toNamed(Routes.settingAccountChangePassword);
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      AppBarNavIcon(
        bgColor: Colors.transparent,
        onPressed: () => controller.onOpenAddContactScreen(context),
        iconWidget: Assets.vectors.add.svg(
          width: AppSpace.space6,
          height: AppSpace.space6,
        ),
      ),
    ];
  }

  Widget _buildTabBar(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, GetPlatform.isAndroid ? -2 : AppSpace.space0),
      child: SizedBox(
        height: AppSpace.space8,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.05),
              height: AppSpace.spacePx,
              color: context.theme.appColors.borderDisable,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: controller.listTabController,
                  isScrollable: true,
                  labelColor: context.theme.appColors.textDarkest,
                  indicatorColor: context.theme.appColors.textDarkest,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.only(right: AppSpace.space4),
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
                      EventName.clickTabContactHomepage,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                height: 1,
                thickness: 0.5,
                color: context.theme.appColors.border,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SliverToBoxPersistentHeader(
      scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
      child: Container(
        color: context.theme.appColors.backgroundNeutralLighter,
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          bottom: AppSpace.space3,
        ),
        child: SizedBox(
          height: AppSpace.space10,
          child: GestureDetector(
            onTap: () => controller.handleSearch(),
            child: const AppSearchBox(
              enabled: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    if ((controller.friendList().isEmpty &&
        controller.groupList().isEmpty &&
        controller.officialAccountList().isEmpty)) {
      return Container(
        color: context.theme.appColors.backgroundNeutralLighter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Assets.vectors.noFriendIcon.svg(
                width: AppSize.size24,
                height: AppSize.size24,
              ),
            ),
            const SizedBox(height: AppSpace.space4),
            AppText.body1Bold(
              'Your contact list is empty.'.tr,
              context: context,
            ),
            const SizedBox(height: AppSpace.space1),
            AppText.body3(
              'Add friends to start chatting!'.tr,
              context: context,
              color: context.theme.appColors.textLight,
            ),

            const SizedBox(height: AppSpace.space1),
            ElevatedButton(
              onPressed: () => controller.onOpenAddContactScreen(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.appColors.buttonPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSize.size2, horizontal: AppSize.size4),
              ),
              child: AppText.button2Bold(
                'Add Friend'.tr,
                context: context,
                color: context.theme.appColors.textPrimaryInverse,
                textAlign: TextAlign.center,
              ),
            ),
            // Because this column center is not equal to center of the screen
            // Add an empty box to push other widgets in column up a little to
            // make it center of the screen.
            const SizedBox(
              // kToolbarHeight is used because there is appbar at the top of this screen
              // by adding the same space here should make children in this column
              // position in the center of the screen.
              // * 1.5 is because column use center and just * 1 will not push
              // other children enough to make it look more center. TLDR: It's magic.
              height: kToolbarHeight * 1.5,
              // Set width to force this column to use all screen width
              width: double.infinity,
            ),
          ],
        ),
      );
    } else {
      return TabBarView(
        controller: controller.listTabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SlidableAutoCloseBehavior(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                ..._buildOfficialAccountList(context),
                ..._buildGroupList(context),
                ..._buildFriendList(context),
              ],
            ),
          ),
          SlidableAutoCloseBehavior(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                ..._buildFriendList(context),
              ],
            ),
          ),
          SlidableAutoCloseBehavior(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                ..._buildGroupList(context),
              ],
            ),
          ),
          SlidableAutoCloseBehavior(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                ..._buildOfficialAccountList(context),
              ],
            ),
          ),
        ],
      );
    }
  }

  List<Widget> _buildOfficialAccountList(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.all(
              controller.officialAccountList().isNotEmpty || controller.listTabController.index != 0
                  ? AppSpace.space4
                  : AppSpace.space0,
            ),
            child: Obx(() {
              return InkWell(
                onTap: isMobile
                    ? null
                    : () {
                        controller.officialAccountsCollapse.toggle();
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.officialAccountList().isNotEmpty || controller.listTabController.index != 0
                        ? RichText(
                            text: TextSpan(
                              text: '${'Official Accounts'.tr} ',
                              style: context.theme.appTexts.body3Bold.copyWith(
                                color: context.theme.appColors.textDarkest,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${controller.officialAccountList().length}',
                                  style: context.theme.appTexts.subtitle1.copyWith(
                                    color: context.theme.appColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    if (!isMobile)
                      Icon(
                        controller.officialAccountsCollapse()
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                      ),
                    controller.listTabController.index == 3 && controller.officialAccountList().isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              showSortingBottomSheet(context);
                            },
                            child: Row(
                              children: [
                                AppText.caption1(
                                  'Sorting'.tr,
                                  context: context,
                                ),
                                const SizedBox(
                                  width: AppSpace.space2,
                                ),
                                Assets.vectors.sort.svg(),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      // Composite "All" item for official accounts
      Obx(
        () {
          if (controller.officialAccountList().length > 4 && controller.listTabController.index != 3) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  AllListItem<ContactInterface>(
                    items: controller.officialAccountList(),
                    onPressed: () {
                      controller.listTabController.index = 3;
                    },
                    avatarItemBuilder: (contact) {
                      final String avatarUrl = contact.avatarUrl;
                      if (avatarUrl.isEmpty) {
                        return Container(
                          color: context.theme.appColors.backgroundNeutralLight,
                          child: Icon(
                            Icons.person,
                            size: AppSize.size6,
                            color: context.theme.appColors.iconDisable,
                          ),
                        );
                      }
                      return UChatImage.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        customLoadingWidget: (state) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        customErrorWidget: (state) => Assets.vectors.iconNoAvatar.svg(),
                      );
                    },
                    nameExtractor: (contact) => contact.name ?? '',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.19),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: context.theme.appColors.borderDisable,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
      // official account list
      Obx(() {
        final officialAccounts = controller.officialAccountList();
        final displayedOfficialAccounts = controller.isGlobalReversed.value && controller.listTabController.index == 3
            ? officialAccounts.reversed.toList()
            : officialAccounts;

        return ContactListWidget<ContactCollection>(
          contactType: 'Official Account',
          maxItems: controller.listTabController.index != 3 ? 4 : null,
          sectionDataList: displayedOfficialAccounts,
          handleItemPressed: (_, ContactInterface currentData) {
            controller.handleProfile(currentData, 'Official Account');
          },
          onLongPress: (_, ContactInterface currentData) {
            controller.onLongPressContactListItem(context, currentData);
          },
          secondaryActionsBuilder: (contact) {
            return [
              _buildActionButton(
                text: 'Hide'.tr,
                backgroundColor: context.theme.appColors.backgroundNeutralBolder,
                foregroundColor: context.theme.appColors.textErrorInverse,
                onTap: () {
                  controller.handleHideContact(contact: contact, contactType: 'Official account');
                },
              ),
              _buildActionButton(
                text: 'Block'.tr,
                backgroundColor: context.theme.appColors.backgroundError,
                foregroundColor: context.theme.appColors.textErrorInverse,
                onTap: () {
                  controller.handleBlockUser(contact: contact, contactType: 'Official account');
                },
              ),
            ];
          },
        );
      }),
    ];
  }

  List<Widget> _buildGroupList(BuildContext context) {
    return [
      // Header showing "Groups" and the count.
      SliverToBoxAdapter(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.all(
              controller.groupList().isNotEmpty || controller.listTabController.index != 0
                  ? AppSpace.space4
                  : AppSpace.space0,
            ),
            child: Obx(
              () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.groupList().isNotEmpty || controller.listTabController.index != 0
                        ? RichText(
                            text: TextSpan(
                              text: '${'Groups'.tr} ',
                              style: context.theme.appTexts.body3Bold.copyWith(
                                color: context.theme.appColors.textDarkest,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${controller.groupList().length}',
                                  style: context.theme.appTexts.subtitle1.copyWith(
                                    color: context.theme.appColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    controller.listTabController.index == 2 && controller.groupList().isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              showSortingBottomSheet(context);
                            },
                            child: Row(
                              children: [
                                AppText.caption1(
                                  'Sorting'.tr,
                                  context: context,
                                ),
                                const SizedBox(
                                  width: AppSpace.space2,
                                ),
                                Assets.vectors.sort.svg(),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                );
              },
            ),
          ),
        ),
      ),
      // Composite "All" item for groups
      Obx(
        () {
          if (controller.groupList().length > 4 && controller.listTabController.index != 2) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  AllListItem<RoomCollection>(
                    items: controller.groupList(),
                    onPressed: () {
                      controller.listTabController.index = 2;
                    },
                    avatarItemBuilder: (group) {
                      final String imageUrl = group.roomAvatarUrl;
                      if (imageUrl.isEmpty) {
                        return Container(
                          color: context.theme.appColors.backgroundNeutralLight,
                          child: Icon(
                            Icons.group,
                            size: AppSize.size6,
                            color: context.theme.appColors.iconDisable,
                          ),
                        );
                      }
                      return UChatImage.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        customLoadingWidget: (state) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        customErrorWidget: (state) => Container(
                          color: context.theme.appColors.backgroundNeutralLight,
                          child: Icon(
                            Icons.error,
                            color: context.theme.appColors.iconDisable,
                          ),
                        ),
                      );
                    },
                    nameExtractor: (group) {
                      final roomName = group.roomName ?? '';
                      final memberCount = group.memberCount ?? 0;
                      return '$roomName ($memberCount)';
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.19),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: context.theme.appColors.borderDisable,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
      // group list (limited to 4 items if not in full mode)
      Obx(() {
        // Get the current groups list.
        final groups = controller.groupList();
        // If reversal is requested, use a reversed copy; otherwise, use the list as is.
        final displayedGroups = controller.isGlobalReversed.value && controller.listTabController.index == 2
            ? groups.reversed.toList()
            : groups;

        return ContactListWidget<RoomCollection>(
          contactType: 'Group',
          maxItems: controller.listTabController.index != 2 ? 4 : null,
          sectionDataList: displayedGroups,
          handleItemPressed: (_, RoomCollection currentData) {
            controller.handleGroupInfo(currentData);
          },
          onLongPress: (_, RoomCollection currentData) {
            controller.onLongPressContactListItem(context, currentData);
          },
          secondaryActionsBuilder: (room) {
            return [
              _buildActionButton(
                text: 'Leave'.tr,
                backgroundColor: context.theme.appColors.backgroundError,
                foregroundColor: context.theme.appColors.textErrorInverse,
                onTap: () {
                  controller.handleLeaveGroup(room: room);
                },
              ),
            ];
          },
        );
      }),
    ];
  }

  List<Widget> _buildFriendList(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.all(
              controller.friendList().isNotEmpty || controller.listTabController.index != 0
                  ? AppSpace.space4
                  : AppSpace.space0,
            ),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.friendList().isNotEmpty || controller.listTabController.index != 0
                      ? RichText(
                          text: TextSpan(
                            text: '${'Friends'.tr} ',
                            style: context.theme.appTexts.body3Bold.copyWith(
                              color: context.theme.appColors.textDarkest,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${controller.friendList().length}',
                                style: context.theme.appTexts.subtitle1.copyWith(
                                  color: context.theme.appColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  controller.listTabController.index == 1 && controller.friendList().isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            showSortingBottomSheet(context);
                          },
                          child: Row(
                            children: [
                              AppText.caption1(
                                'Sorting'.tr,
                                context: context,
                              ),
                              const SizedBox(
                                width: AppSpace.space2,
                              ),
                              Assets.vectors.sort.svg(),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              );
            }),
          ),
        ),
      ),
      // Composite "All" item for friends
      Obx(
        () {
          if (controller.friendList().length > 4 && controller.listTabController.index != 1) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  AllListItem<ContactInterface>(
                    items: controller.friendList(),
                    onPressed: () {
                      controller.listTabController.index = 1;
                    },
                    avatarItemBuilder: (contact) {
                      final String avatarUrl = contact.avatarUrl;
                      if (avatarUrl.isEmpty) {
                        return Container(
                          color: context.theme.appColors.backgroundNeutralLight,
                          child: Icon(
                            Icons.person,
                            size: AppSize.size6,
                            color: context.theme.appColors.iconDisable,
                          ),
                        );
                      }
                      return UChatImage.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        customLoadingWidget: (state) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        customErrorWidget: (state) => Container(
                          color: context.theme.appColors.backgroundNeutralLight,
                          child: Icon(
                            Icons.error,
                            color: context.theme.appColors.iconDisable,
                          ),
                        ),
                      );
                    },
                    nameExtractor: (contact) => contact.name ?? '',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.19),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: context.theme.appColors.borderDisable,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
      // friend list (limited to 4 items if not in full mode)
      Obx(() {
        final friends = controller.friendList();
        final displayedFriends = controller.isGlobalReversed.value && controller.listTabController.index == 1
            ? friends.reversed.toList()
            : friends;

        return ContactListWidget<ContactInterface>(
          contactType: 'Friend',
          maxItems: controller.listTabController.index != 1 ? 4 : null,
          sectionDataList: displayedFriends,
          handleItemPressed: (_, ContactInterface currentData) {
            controller.handleProfile(currentData, 'Friend');
          },
          onLongPress: (_, ContactInterface currentData) {
            controller.onLongPressContactListItem(context, currentData);
          },
          secondaryActionsBuilder: (contact) {
            return [
              _buildActionButton(
                text: 'Hide'.tr,
                backgroundColor: context.theme.appColors.backgroundNeutralBolder,
                foregroundColor: context.theme.appColors.textErrorInverse,
                onTap: () {
                  controller.handleHideContact(contact: contact, contactType: 'Friend');
                },
              ),
              _buildActionButton(
                text: 'Block'.tr,
                backgroundColor: context.theme.appColors.backgroundError,
                foregroundColor: context.theme.appColors.textErrorInverse,
                onTap: () {
                  controller.handleBlockUser(contact: contact, contactType: 'Friend');
                },
              ),
            ];
          },
        );
      }),
    ];
  }

  void showSortingBottomSheet(BuildContext context) {
    BottomSheetUChat.bottomSheet(
      context,
      child: Obx(
        () => Column(
          children: [
            _buildChoiceSorting(
              context,
              icon: Assets.vectors.iconA.svg(),
              title: 'Name: A-Z'.tr,
              type: ContactSortingType.nameASC,
            ),
            _buildChoiceSorting(
              context,
              icon: Assets.vectors.iconZ.svg(),
              title: 'Name: Z-A'.tr,
              type: ContactSortingType.nameDESC,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceSorting(
    BuildContext context, {
    required String title,
    required Widget icon,
    required ContactSortingType type,
    bool showDivider = true,
  }) {
    final isSelected =
        (type == ContactSortingType.nameDESC) ? controller.isGlobalReversed.value : !controller.isGlobalReversed.value;

    return GestureDetector(
      onTap: () {
        controller.setSortingType(type);
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.appColors.backgroundNeutralLightestPressed,
            width: AppSpace.space05,
          ),
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: AppSpace.space4),
                  AppText.body1(title, context: context),
                  const Spacer(),
                  if (isSelected) Assets.vectors.iconCorrectBlue.svg(),
                ],
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: AppSpace.space14),
                child: Divider(
                  color: context.theme.appColors.border,
                  height: AppSpace.spacePx,
                  thickness: AppSpace.spacePx,
                ),
              ),
          ],
        ),
      ),
    );
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
}
