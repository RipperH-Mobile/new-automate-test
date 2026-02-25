import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_add_select_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_member_list_shimmer.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_search_bar.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailAdminAddSelectScreen extends GetView<ChatRoomDetailAdminAddSelectController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailAdminAddSelectScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurface,
      appBar: RoomDetailAppBar(
        isSecret: false,
        titleText: 'Choose member'.tr,
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
            child: GetBuilder<ChatRoomDetailAdminAddSelectController>(
              id: ChatRoomDetailAdminAddSelectIds.memberList,
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
                    return DetailInviteMemberListItem(
                      onTapProfile: () {
                        controller.handleMemberPressed(controller.members[index], context);
                      },
                      memberAndPending: controller.members[index],
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
}
