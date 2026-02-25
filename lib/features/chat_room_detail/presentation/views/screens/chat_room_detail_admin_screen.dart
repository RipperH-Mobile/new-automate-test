import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_member_list_shimmer.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_admin_list_item.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_search_bar.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ChatRoomDetailAdminScreen extends GetView<ChatRoomDetailAdminController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailAdminScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: RoomDetailAppBar(
        isSecret: false,
        titleText: 'Administrators'.tr,
        action: () {
          controller.handleAddButtonPressed();
        },
        actionText: 'Add'.tr,
      ),
      child: Column(
        children: [
          RoomDetailSearchBar(
            searchController: controller.searchController,
            searchInputFocus: controller.searchInputFocus,
            onChanged: controller.onSearchTextChanged,
          ),
          const SizedBox(height: AppSpace.space4),
          Expanded(
            child: GetBuilder<ChatRoomDetailAdminController>(
              id: ChatRoomDetailAdminIds.memberList,
              tag: tag,
              builder: (controller) {
                if (controller.initializing) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpace.space4),
                    child: ChatRoomDetailMemberListShimmer(),
                  );
                }
                if (controller.members.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // Prevents the Column from expanding to fill the available space.
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
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.members.length,
                  itemBuilder: (context, index) {
                    return UChatSlidableItem(
                      disableSlidable: !(controller.currentUserMemberData()?.isOwner == true &&
                          !UserController.instance.isCurrentUser(
                            controller.members[index].account.id ?? '',
                          )),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const DrawerMotion(),
                        children: [
                          CustomSlidableAction(
                            autoClose: false,
                            backgroundColor: context.theme.appColors.backgroundError,
                            onPressed: (BuildContext context) {
                              controller.handleRemoveAdmin(
                                context,
                                member: controller.members[index],
                              );
                            },
                            child: AppText.body3Bold(
                              'Remove'.tr,
                              context: context,
                              color: context.theme.appColors.textPrimaryInverse,
                            ),
                          ),
                        ],
                      ),
                      child: DetailAdminListItem(
                        onTapProfile: () {
                          controller.handleEditAdmin(controller.members[index]);
                        },
                        member: controller.members[index],
                        highLightName: controller.searchText,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
