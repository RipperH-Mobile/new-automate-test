import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_owner_transfer_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_member_list_shimmer.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_admin_member_list_item.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_search_bar.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';
import 'package:dotted_line/dotted_line.dart';

class ChatRoomDetailOwnerTransferScreen extends GetView<ChatRoomDetailOwnerTransferController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailOwnerTransferScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: RoomDetailAppBar(
        isSecret: false,
        titleText: 'Ownership Transfer'.tr,
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
            child: GetBuilder<ChatRoomDetailOwnerTransferController>(
              id: ChatRoomDetailOwnerTransferIds.memberList,
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
                  itemCount: controller.members.length,
                  itemBuilder: (context, index) {
                    return DetailAdminMemberListItem(
                      onTapProfile: () {
                        _showOwnershipTransferDialog(
                          context,
                          name: controller.members[index].account.nickname ??
                              controller.members[index].account.displayName ??
                              'UNKNOWN'.tr,
                          onConfirm: () {
                            controller.handleOwnerTransfer(controller.members[index]);
                          },
                          urlOwner: controller.currentUserMemberData()?.account.avatarUrl ?? '',
                          urlTarget: controller.members[index].account.avatarUrl,
                        );
                      },
                      member: controller.members[index],
                      highLightName: controller.searchText,
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

  Future<void> _showOwnershipTransferDialog(
    BuildContext context, {
    required String name,
    required VoidCallback onConfirm,
    required String urlOwner,
    required String urlTarget,
  }) {
    return UChatDialogV3.showDefaultDialog(
        context: Get.context!,
        title: 'Transfer to @name?'.trParams({'name': name}),
        description: 'Do you confirm that you want to transfer ownership rights of @groupName to @name?'.trParams({
          'groupName': controller.title.value,
          'name': name,
        }),
        confirmText: 'Confirm'.tr,
        onConfirm: onConfirm,
        contentWidget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Avatar(
                      radius: 34.spMin,
                      url: urlOwner,
                    ),
                    Positioned(
                      bottom: -AppSpace.space4,
                      child: Assets.vectors.iconOldOwner.svg(),
                    ),
                  ],
                ),
                SizedBox(
                  width: AppSpace.space16,
                  child: DottedLine(
                    dashLength: AppSpace.space1,
                    dashGapLength: AppSpace.space2,
                    lineThickness: AppSpace.space05,
                    dashColor: context.theme.appColors.border,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Avatar(
                      radius: 34.spMin,
                      url: urlTarget,
                    ),
                    Positioned(
                      bottom: -AppSpace.space4,
                      child: Assets.vectors.iconNewOwner.svg(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpace.space6),
          ],
        ));
  }
}
