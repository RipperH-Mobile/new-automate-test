import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:popover/popover.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/chat_category_type.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/entities/models/typing_model.dart';
import 'package:uchat/features/chat_folder/presentation/screens/chat_folder_chat_room_list_screen.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/util/pop_menu_transition.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/no_chat_found_widget.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_slidable.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_main.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/banner/banner_offline.dart';
import 'package:uchat/widgets/offline_badge/offline_badge_sliver_loading.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

import '../../widgets/sorting_choice_item.dart';

class ChatListScreen extends GetView<ChatListController> {
  const ChatListScreen({super.key});

  double get chatCategoryHeight {
    return controller.manageChatController.enableChatCategory.value ? AppSpace.space8 : AppSpace.space0;
  }

  double get searchBarHeight => AppSpace.space10;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBarMain<AppBar>(
        title: 'Chat'.tr,
        actions: [_buildRightActions(context)],
        leading: _buildLeftActions(),
      ),
      child: Obx(() {
        ///
        /// For Feature [ChatFolder]
        ///
        if (controller.chatFolderController.isEnabled) {
          return ChatFolderChatRoomListScreen(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildSearchBar(context),
                _buildOfflineBadge(context),
              ];
            },
            subHeaderSliverBuilder: ConnectivityController.instance.isOffline
                ? (context, innerBoxIsScrolled) {
                    return [
                      _buildWaitingForNetworkWidget(context),
                    ];
                  }
                : null,
          );
        }

        return NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildSearchBar(context),
              _buildOfflineBadge(context),
              _buildHeaderChatCategory(context),
              _buildWaitingForNetworkWidget(context),
            ];
          },
          body: _buildBody(context),
        );
      }),
    );
  }

  Widget _buildHeaderChatCategory(BuildContext context) {
    return Obx(
      () {
        if (controller.manageChatController.enableChatCategory.value) {
          return SliverToBoxPersistentHeader(
            scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
            child: Transform.translate(
              offset: Offset(0, GetPlatform.isAndroid ? -2 : AppSpace.space0),
              child: Container(
                color: context.theme.appColors.backgroundNeutralLighter,
                height: chatCategoryHeight,
                child: _buildHeaderTabBar(context),
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(
      () {
        return controller.manageChatController.enableChatCategory.value
            ? _buildBodyTabBar(context)
            : _buildList(
                context,
                ChatCategoryType.all,
              );
      },
    );
  }

  Widget _buildBodyTabBar(BuildContext context) {
    return TabBarView(
      controller: controller.manageChatController.tabController,
      children: List.generate(
        controller.manageChatController.tabController.length,
        (index) {
          final chatCategories = controller.manageChatController.chatCategories.elementAtOrNull(index);
          if (chatCategories == null) {
            return const SizedBox.shrink();
          }

          return _buildList(
            context,
            chatCategories.type,
          );
        },
      ),
    );
  }

  Widget _buildHeaderTabBar(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpace.space4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: controller.manageChatController.tabController,
              isScrollable: true,
              onTap: controller.manageChatController.onTapOnTabBar,
              labelColor: context.theme.appColors.textDarkest,
              indicatorColor: context.theme.appColors.textDarkest,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(right: AppSpace.space4),
              unselectedLabelColor: context.theme.appColors.textLighter,
              indicatorWeight: 1.5,
              tabs: List.generate(
                controller.manageChatController.tabController.length,
                (index) {
                  return Obx(() {
                    final chatCategory = controller.manageChatController.chatCategories.elementAtOrNull(index);

                    if (chatCategory == null) {
                      return const SizedBox.shrink();
                    }

                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.05),
                          height: AppSpace.spacePx,
                          color: context.theme.appColors.borderDisable,
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: chatCategory.isUnread ? AppSpace.space015 : AppSpace.space0),
                            child: Text(
                              chatCategory.type?.displayName ?? '',
                              style: context.theme.appTexts.button2Bold,
                            ),
                          ),
                        ),
                        if (chatCategory.isUnread)
                          Positioned(
                            top: AppSpace.space05,
                            right: AppSpace.space0,
                            child: Container(
                              width: AppSpace.space015,
                              height: AppSpace.space015,
                              decoration: BoxDecoration(
                                color: UTheme.color.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    );
                  });
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Divider(
            height: 1,
            color: context.theme.appColors.border,
          ),
        )
      ],
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
          height: searchBarHeight,
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

  Widget _buildWaitingForNetworkWidget(BuildContext context) {
    return Obx(() {
      if (ConnectivityController.instance.isOnline) {
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      }

      return OfflineBadgeSliverLoading(
        status: ConnectivityController.instance.connectivityStatus,
      );
    });
  }

  Widget _buildOfflineBadge(BuildContext context) {
    return Obx(() {
      if (ConnectivityController.instance.isOnline) {
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      }

      return SliverToBoxPersistentHeader(child: BannerOffline(onPressed: SocketCaller.instance.reconnect));
    });
  }

  Widget _buildRightActions(BuildContext context) {
    return AppBarNavIcon(
      onPressed: () {
        controller.handleCreateGroupChat();
      },
      bgColor: Colors.transparent,
      iconWidget: Assets.vectors.iconCreateGroup.svg(
        width: AppSpace.space6,
        height: AppSpace.space6,
      ),
    );
  }

  Widget _buildLeftActions() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          GetIt.I<TaxonomyService>().sendEvent(EventName.clickHamburgerChatlistpage);

          UChatPopover.open(
            context: context,
            contentDxOffset: 0,
            contentDyOffset: -10,
            width: 210,
            transition: PopoverTransition.other,
            popoverTransitionBuilder: (animation, child) => popMenuTransition(
              context: context,
              animation: animation,
              child: child,
            ),
            menu: [
              PopoverMenuItem(
                onPressed: (BuildContext context) async {
                  Get.back();
                  GetIt.I<TaxonomyService>().sendEvent(EventName.clickEditChatlist);
                  controller.handleEditChatRoomNew();
                },
                hasBottomDivider: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Edit chat list'.tr,
                      context: context,
                    ),
                    Assets.vectors.iconPencil.svg(),
                  ],
                ),
              ),
              PopoverMenuItem(
                onPressed: (BuildContext context) async {
                  Get.back();
                  showSortingBottomSheet();
                },
                hasBottomDivider: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Sorting'.tr,
                      context: context,
                    ),
                    Assets.vectors.iconSorting.svg(),
                  ],
                ),
              ),
              if (controller.chatFolderController.isEnabled)
                PopoverMenuItem(
                  onPressed: (BuildContext context) async {
                    Get.back();
                    controller.handleManageChatFolder();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.body1(
                        'Folder'.tr,
                        context: context,
                      ),
                      Assets.vectors.folderIcon.svg(),
                    ],
                  ),
                )
              else
                PopoverMenuItem(
                  onPressed: (BuildContext context) async {
                    Get.back();
                    showCategoryBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.body1(
                        'Category'.tr,
                        context: context,
                      ),
                      Assets.vectors.iconCategory.svg(),
                    ],
                  ),
                ),
            ],
          );
        },
        child: Assets.vectors.iconHambergerBar.svg(),
      );
    });
  }

  void showSortingBottomSheet() {
    BottomSheetUChat.bottomSheet(
      Get.context!,
      child: Column(
        children: [
          SortingChoiceItem(
            icon: Assets.vectors.iconTimeLastest.svg(),
            title: 'Time received: Latest'.tr,
            type: ChatSortingType.timeLastest,
          ),
          SortingChoiceItem(
            icon: Assets.vectors.iconTimeOldest.svg(),
            title: 'Time received: Oldest'.tr,
            type: ChatSortingType.timeOldest,
          ),
          SortingChoiceItem(
            icon: Assets.vectors.iconA.svg(),
            title: 'Name: A-Z'.tr,
            type: ChatSortingType.nameASC,
          ),
          SortingChoiceItem(
            icon: Assets.vectors.iconZ.svg(),
            title: 'Name: Z-A'.tr,
            type: ChatSortingType.nameDESC,
          ),
          SortingChoiceItem(
            icon: Assets.vectors.iconUnread.svg(),
            title: 'Unread messages'.tr,
            showDivider: false,
            type: ChatSortingType.unread,
          ),
        ],
      ),
    );
  }

  void showCategoryBottomSheet() {
    BottomSheetUChat.bottomSheet(
      Get.context!,
      title: 'Manage category'.tr,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpace.space4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.body1(
                  'Chat category'.tr,
                  context: Get.context!,
                ),
                Obx(() {
                  GetIt.I<TaxonomyService>().sendEvent(EventName.chatlistCategory,
                      eventProperties: EventProperty.chatListCategory(
                          controller.manageChatController.enableChatCategory.value ? 'true' : 'false'));
                  return SizedBox(
                    width: AppSpace.space12,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: CupertinoSwitch(
                        value: controller.manageChatController.enableChatCategory.value,
                        activeTrackColor: Get.context!.theme.appColors.buttonPrimary,
                        inactiveTrackColor: Get.context!.theme.appColors.iconDisable,
                        onChanged: (bool value) {
                          controller.manageChatController.toggleChatCategory(value);
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Divider(
            color: Get.context!.theme.appColors.border,
            height: AppSpace.spacePx,
            thickness: AppSpace.spacePx,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpace.space4),
            child: AppText.body4(
              'Enable Chat category to easily organize your chats on the Chats tab.'.tr,
              context: Get.context!,
              color: Get.context!.theme.appColors.textLighter,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext buildContext,
    ChatCategoryType? chatCategoryType,
  ) {
    return Obx(
      () {
        final roomDataList = controller.getRoomListChatCategory(chatCategoryType: chatCategoryType);
        roomDataList.removeWhere((room) => room.roomSub() == null);

        if (roomDataList.isEmpty) {
          return const NoChatFoundWidget();
        }

        return SlidableAutoCloseBehavior(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
              bottom: AppSpace.space2,
            ),
            itemCount: roomDataList.length,
            itemBuilder: (context, index) {
              return Obx(() {
                final roomSub = roomDataList.elementAtOrNull(index)?.roomSub();
                if (roomSub == null) return const SizedBox.shrink();

                final room = controller.roomDb.getRoomSync(roomSub.roomId ?? '');
                if (room == null) return const SizedBox.shrink();
                final isTyping = controller.isRoomsTyping.value[roomSub.roomId!] ?? false;
                final whoTypingText = isTyping
                    ? _getWhoTypingText(
                        controller.typingModelList().where((e) => e.roomId == room.id).toList(),
                      )
                    : null;
                return _buildRoomListItem(room, roomSub, buildContext, whoTypingText, isTyping);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildRoomListItem(
    RoomCollection room,
    RoomSubscriptionCollection roomSub,
    BuildContext context,
    String? whoTypingText,
    bool isTyping,
  ) {
    final key = room.widgetKey;
    return Column(
      children: [
        RoomListItemSlidable(
          key: ValueKey('CONTAINER-$key'),
          whoTypingText: whoTypingText,
          room: room,
          roomSub: roomSub,
          onSelectRoom: controller.handleSelectRoom,
          onLongPress: UserController.instance.enableHoldChat ? () => controller.onLongPressChatListItem(room) : null,
          draftMessage: room.draftMessage ?? '',
          isTyping: isTyping,
          disableSlidable: controller.isEditChat.value,
          avatarHeight: AppSpace.space16,
          onReadRoom: controller.handleReadRoom,
          onPinRoom: controller.handlePinRoom,
          onMuteRoom: room.isBookmark ? null : controller.handleMuteRoom,
          onHideChat: room.isBookmark ? null : controller.showDialogHideChat,
          onBlockUser: controller.showDialogBlockUser,
          onUnblockUser: controller.handleUnBlock,
          onLeaveGroup: controller.showDialogLeaveGroup,
          onDeleteRoom: controller.showDialogDeleteChat,
          actionPaneId: key,
          shouldStayOpenActionPane: controller.openActionPaneId.value == key,
          onActionPaneOpenChanged: controller.onActionPaneOpenChanged,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpace.space24,
          ),
          child: Divider(
            height: AppSpace.spacePx,
            color: context.theme.appColors.borderDark,
            thickness: 0.3,
          ),
        ),
      ],
    );
  }

  String? _getWhoTypingText(List<TypingModel> whoTypingModelList) {
    if (whoTypingModelList.isEmpty) return null;

    final displayName = whoTypingModelList.firstOrNull?.name ?? 'Someone'.tr;

    if (whoTypingModelList.length == 1) {
      return displayName;
    }

    final number = whoTypingModelList.length - 1;
    return '@displayName and @number other'.trPluralParams('@number others', number, {
      'number': number.toString(),
      'displayName': displayName,
    });
  }
}
