import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_controller.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_icon_menu.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_request_item.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_tap_bar_menu.dart';
import 'package:uchat/gen/assets.gen.dart';

import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/app_text.dart';

import '../../domain/entities/add_contact_invited_entity.dart';
import '../widgets/add_contact_group_requested_item.dart';

// final _log = useLogger();

class AddContactScreen extends GetView<AddContactController> {
  const AddContactScreen({
    super.key,
  });

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: AppSpace.space24,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.only(left: AppSpace.space3 - 2),
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
        title: AppText.title3('Add friends'.tr, context: context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddContactIconMenu(
                  icon: Assets.vectors.addContactInvite.svg(
                    height: AppSize.size20.spMin,
                    width: AppSize.size20.spMin,
                  ),
                  title: 'Invite',
                  onPressed: () => controller.handleInvite(context),
                ),
                AddContactIconMenu(
                  icon: Assets.vectors.addContactQr.svg(
                    height: AppSize.size20.spMin,
                    width: AppSize.size20.spMin,
                  ),
                  title: 'QR Code',
                  onPressed: controller.handleScanQRCode,
                ),
                AddContactIconMenu(
                  icon: Assets.vectors.addContactSearch.svg(
                    height: AppSize.size20.spMin,
                    width: AppSize.size20.spMin,
                  ),
                  title: 'Search',
                  onPressed: controller.handleSearchFriend,
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            width: double.maxFinite,
            color: context.theme.appColors.backgroundNeutralLight,
          ),
          AppSpace.space1.verticalSpace,
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppSpace.space2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      onTap: (int index) async {
                        String tapCategory = '';
                        switch (index) {
                          case 0:
                            tapCategory = 'Friends';
                          case 1:
                            tapCategory = 'Groups';
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
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: context.theme.appColors.textLighter,
                      tabs: [
                        /// TODO: Hide for now, maybe come back later
                        /// [All requests] tap menu
                        // Obx(() {
                        //   return Tab(
                        //       child: AddContactTapBarMenu(
                        //           title: 'All requests', isShowRedDot: controller.isNewRequest.value));
                        // }),

                        /// [Friends] tap menu
                        Obx(() {
                          return Tab(
                            child: AddContactTapBarMenu(
                              title: 'Friends'.tr,
                              isShowRedDot: controller.isNewFriend.value,
                            ),
                          );
                        }),

                        /// [Groups] tap menu
                        Obx(() {
                          return Tab(
                            child: AddContactTapBarMenu(
                              title: 'Groups'.tr,
                              isShowRedDot: controller.isNewGroup.value,
                            ),
                          );
                        }),

                        /// [Group request] tap menu
                        Obx(() {
                          return Tab(
                            child: AddContactTapBarMenu(
                              title: 'Request'.tr,
                              isShowRedDot: controller.isNewGroupRequest.value,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      /// TODO: Hide for now, maybe come back later
                      /// [All requests] request list
                      // _buildTapItemList(
                      //   controller.allRequestList,
                      //   controller.allRequestPagingController,
                      //   context,
                      // ),

                      /// [Friends] request list
                      Obx(() {
                        return _buildTapItemList(
                          controller.friendRequestList(),
                          controller.friendRequestPagingController,
                          context,
                        );
                      }),

                      /// [Groups] request list
                      Obx(() {
                        return _buildTapItemList(
                          controller.groupInviteList(),
                          controller.groupInvitePagingController,
                          context,
                        );
                      }),

                      /// [Group request] list
                      Obx(() {
                        return _buildRequestedTapItemList(
                          controller.groupRequestList(),
                          controller.groupRequestPagingController,
                          context,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTapItemList(
    List<AddContactInvitedEntity> requestList,
    PagingController<int, AddContactInvitedEntity> pagingController,
    BuildContext context,
  ) {
    return PagedListView<int, AddContactInvitedEntity>.separated(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (BuildContext context, _, int index) {
          final item = requestList.elementAtOrNull(index);

          if (item == null) return const SizedBox();

          final isLastItem = index == requestList.length - 1;
          final isFriendRequest = item.isFriendRequest == true;
          final isGroupInvite = item.isGroupInvite == true;

          return Container(
            padding: const EdgeInsets.only(left: AppSpace.space4),
            margin: isLastItem ? const EdgeInsets.only(bottom: AppSpace.space6) : null,
            child: AddContactRequestItem(
              data: item,
              title: item.name ?? 'UNKNOWN'.tr,
              subTitle: isFriendRequest
                  ? 'Sent you a friend request'.tr
                  : isGroupInvite
                      ? '@sender has sent you an invitation to join group'.trParams({
                          'sender': controller.getNickName(item.senderId) ?? item.senderName ?? 'Someone'.tr,
                        })
                      : 'UNKNOWN'.tr,
              avatarId: item.avatarId ?? '',
              accountId: item.id ?? '',
              isFriendRequest: isFriendRequest,
              type: item.type,
              invitedAt: item.invitedAt ?? DateTime.now(),
              onTap: () => controller.onTapItem(item),
              onAccept: () => controller.handleAcceptRequest(
                item.id ?? '',
                item.type,
                context,
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return _buildEmptyPage(context);
        },
        firstPageProgressIndicatorBuilder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRequestedTapItemList(
    List<AddContactGroupRequestedEntity> requestList,
    PagingController<int, AddContactGroupRequestedEntity> pagingController,
    BuildContext context,
  ) {
    return PagedListView<int, AddContactGroupRequestedEntity>.separated(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (BuildContext context, _, int index) {
          final item = requestList.elementAtOrNull(index);

          if (item == null) return const SizedBox();

          final isLastItem = index == requestList.length - 1;

          return Container(
            padding: const EdgeInsets.only(left: AppSpace.space4),
            margin: isLastItem ? const EdgeInsets.only(bottom: AppSpace.space6) : null,
            child: AddContactGroupRequestItem(
              item: item,
              onTapItem: () => controller.onTapToOpenAccountProfile(item.accountId ?? ''),
              onApprove: () => controller.handleApproveGroupRequest(item),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return _buildEmptyRequestPage(context);
        },
        firstPageProgressIndicatorBuilder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 145.spMin),
      child: Column(
        children: [
          AppText.subtitle1(
            'Start new connections'.tr,
            color: context.theme.appColors.textDark,
            context: context,
          ),
          AppSpace.space1.verticalSpace,
          AppText.body4(
            'Add friends, scan QR codes, or join\n a group to get started!'.tr,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyRequestPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 145.spMin),
      child: Column(
        children: [
          AppText.subtitle1(
            'No request found'.tr,
            color: context.theme.appColors.textDark,
            context: context,
          ),
          AppSpace.space1.verticalSpace,
          AppText.body4(
            'There are no join requests. You can share\nthe invite link with others to let them join\nthe group'.tr,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
            context: context,
          ),
        ],
      ),
    );
  }
}
