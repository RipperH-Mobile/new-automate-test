import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_member_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_invite_member_list_item.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_room_requested_list_item.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_search_bar.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/network_error/network_error_widget.dart';

class ChatRoomDetailMemberScreen extends GetView<ChatRoomDetailMemberController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailMemberScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      appBar: RoomDetailAppBar(
        titleText: 'Members'.tr,
        isSecret: false,
        onOnInvitePressed: () {
          controller.handleOpenInvite();
        },
      ),
      child: Column(
        children: [
          RoomDetailSearchBar(
            searchController: controller.searchController,
            searchInputFocus: controller.searchInputFocus,
            onChanged: controller.updateSearchTerm,
          ),
          const SizedBox(height: AppSpace.space1),
          _buildTabs(context),
          _buildListItem(context),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: AppSpace.space2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.theme.appColors.border,
            width: 1,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          onTap: (int index) async {
            String tapCategory = '';
            switch (index) {
              case 0:
                tapCategory = 'Member';
              case 1:
                tapCategory = 'Request';
            }

            GetIt.I<TaxonomyService>().sendEvent(
              EventName.clickTabRequestAddFriendPage,
              eventProperties: EventProperty.clickTabRequestAddFriendPage(
                tapRequestCategory: tapCategory,
              ),
            );
          },
          controller: controller.tabController,
          isScrollable: true,
          labelColor: context.theme.appColors.textDarkest,
          labelPadding: EdgeInsets.only(left: 10.spMin, right: 10.spMin),
          indicatorPadding: EdgeInsets.only(left: 10.spMin, right: 10.spMin),
          indicatorWeight: 1,
          indicatorColor: context.theme.appColors.textDarkest,
          unselectedLabelColor: context.theme.appColors.textLighter,
          tabs: [
            /// [Members] tap menu
            Tab(
              child: Text(
                'Member'.tr,
                style: context.theme.appTexts.title3,
              ),
            ),

            /// [Groups] tap menu
            Obx(() {
              return controller.canGetGroupRequestList
                  ? Tab(
                      child: Text(
                        'Request'.tr,
                        style: context.theme.appTexts.title3,
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return TabBarView(
          physics: controller.canGetGroupRequestList ? null : const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: [
            /// [Members] request list
            _buildMemberList(context),

            /// [Groups] request list
            _buildRequestedList(context),
          ],
        );
      }),
    );
  }

  Widget _buildMemberList(BuildContext context) {
    return GetBuilder<ChatRoomDetailMemberController>(
      id: ChatRoomDetailMemberIds.memberListViewId,
      tag: tag,
      builder: (controller) {
        if (controller.isInitializingMemberData) {
          return _buildLoadingIndicator();
        } else if (controller.membersList.isEmpty) {
          return _buildNotFound(context);
        }

        return ListView.builder(
          itemCount: controller.membersList.length,
          controller: controller.memberListScrollController,
          itemBuilder: (BuildContext context, int index) {
            return GetBuilder<ChatRoomDetailMemberController>(
              id: ChatRoomDetailMemberIds.memberItemId(controller.membersList[index].accountId),
              tag: tag,
              builder: (controller) {
                bool disableSlideToRemove = controller.isAbleToAccessGroupMemberSetting == false;
                final member = controller.membersList[index];

                // Disable slide to remove owner
                if (member.isOwner) {
                  disableSlideToRemove = true;
                }

                if (controller.currentUserMemberData.value?.isOwner == false) {
                  if (member.isAdmin) {
                    disableSlideToRemove = true;
                  }

                  // Disable slide to remove yourself
                  if (member.accountId == controller.currentUserMemberData.value?.account.id) {
                    disableSlideToRemove = true;
                  }
                }

                return UChatSlidableItem(
                  actionPaneId: member.accountId,
                  groupTag: 'group-member-$roomTag',
                  shouldStayOpenActionPane: controller.openActionPaneId.value == member.accountId,
                  onActionPaneOpenChanged: controller.onSlideChange,
                  disableSlidable: disableSlideToRemove,
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const DrawerMotion(),
                    children: [
                      CustomSlidableAction(
                        backgroundColor: context.theme.appColors.backgroundError,
                        onPressed: (BuildContext context) {
                          if (UserController.instance.isCurrentUser(member.accountId)) {
                            controller.showDialogLeaveGroup();
                          } else {
                            controller.handleShowDialogDeleteMember(
                              member.accountDisplayName ?? 'UNKNOWN'.tr,
                              member.accountId,
                              member.isPending,
                            );
                          }
                        },
                        child: AppText.body3Bold(
                          'Remove'.tr,
                          context: context,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                      ),
                    ],
                  ),
                  child: DetailInviteMemberListItem(
                    onTapProfile: () {
                      controller.handleOpenProfile(member);
                    },
                    memberAndPending: member,
                    highLightName: controller.searchController.text,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildRequestedList(BuildContext context) {
    return GetBuilder<ChatRoomDetailMemberController>(
      id: ChatRoomDetailMemberIds.memberRequestListViewId,
      tag: tag,
      builder: (controller) {
        if (controller.isNetworkErrorRequestData) {
          return _buildNetworkError(
            context: context,
            onRetry: () => controller.getRoomRequestedList(page: 1),
          );
        } else if (controller.isInitializingRequestData || 
            (controller.isLoadingRequestData && !controller.isLoadMoreRequestData)) {
          return _buildLoadingIndicator();
        } else if (controller.filteredRequestedList.isEmpty) {
          return _buildNotFound(context);
        }

        final loadMoreIndicatorCount = controller.isLoadMoreRequestData ? 1 : 0;

        return ListView.builder(
          controller: controller.requestListScrollController,
          itemCount: controller.filteredRequestedList.length + loadMoreIndicatorCount,
          itemBuilder: (BuildContext context, int index) {
            final hasLoadMore = index == controller.filteredRequestedList.length && controller.isLoadMoreRequestData;
            
            if (hasLoadMore) {
              return _buildLoadMore();
            }

            final item = controller.filteredRequestedList[index];

            return UChatSlidableItem(
              actionPaneId: item.accountId,
              groupTag: 'group-requested-$roomTag',
              shouldStayOpenActionPane: controller.openActionPaneId.value == item.accountId,
              onActionPaneOpenChanged: controller.onSlideChange,
              disableSlidable: item.type == GroupRequestType.cancelRequest, // Disable slide for cancelled request
              endActionPane: ActionPane(
                extentRatio: 0.25,
                motion: const DrawerMotion(),
                children: [
                  CustomSlidableAction(
                    backgroundColor: context.theme.appColors.backgroundError,
                    onPressed: (BuildContext context) {
                      controller.handleRejectGroupRequest(item);
                    },
                    child: AppText.body4Bold(
                      'Reject'.tr,
                      color: context.theme.appColors.textPrimaryInverse,
                      context: context,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              child: DetailRoomRequestedListItem(
                item: item,
                highLightName: controller.searchController.text,
                onTapProfile: () => controller.onTapToOpenAccountProfile(item.accountId ?? ''),
                onApprove: () => controller.handleApproveGroupRequest(item),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents the Column from expanding to fill the available space.
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
            const SizedBox(height: kToolbarHeight * 1.5),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMore() {
    return const Padding(
      padding: EdgeInsets.all(AppSpace.space4),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildNetworkError({
    required BuildContext context,
     required void Function() onRetry,
  }) {
    return Center(
      child: NetworkErrorWidget(
        context: context,
        onRetry: onRetry,
      ),
    );
  }
}
