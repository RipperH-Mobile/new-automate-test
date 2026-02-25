import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_slidable.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/button_for_edit_screen.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomListEditScreen extends GetView<ChatRoomListEditController> {
  const ChatRoomListEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      appBar: AppBar(
        leadingWidth: 100.spMin,
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
                color: context.theme.appColors.textPrimary,
              ),
              AppText.button1(
                'Back'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ],
          ),
        ),
        elevation: 0,
        title: AppText.title2('Edit Chats list'.tr, context: context),
        centerTitle: true,
        titleSpacing: 0,
        // automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpace.space6),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  controller.handleReadAllChat();
                },
                child: AppText.button1Bold(
                  'Read All'.tr,
                  context: context,
                  color: context.theme.appColors.textPrimary,
                ),
              ),
            ),
          )
        ],
      ),

      ///2bottom btn
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8E8E8),
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.spMin,
              bottom: 10.spMin,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.fromLTRB(AppSpace.space4, AppSpace.space4, AppSpace.space0, AppSpace.space4),
                    child: Obx(() {
                      return ButtonForEditScreen(
                        onPressed: () {
                          controller.handleHideAllSelectedChat();
                        },
                        text: controller.selectedRooms.isNotEmpty
                            ? 'Hide (@count)'.trParams({
                                'count': controller.selectedRooms.length.toString(),
                              })
                            : 'Hide'.tr,
                        textColor: controller.selectedRooms.isNotEmpty
                            ? context.theme.appColors.textDarkest
                            : context.theme.appColors.textDisable,
                        borderColor: context.theme.appColors.borderDisable,
                      );
                    })),
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(AppSpace.space0, AppSpace.space4, AppSpace.space4, AppSpace.space4),
                  child: Obx(() {
                    return ButtonForEditScreen(
                      onPressed: () {
                        controller.handleDeleteAllSelectedChat();
                      },
                      text: controller.selectedRooms.isNotEmpty
                          ? 'Delete (@count)'.trParams({
                              'count': controller.selectedRooms.length.toString(),
                            })
                          : 'Delete'.tr,
                      textColor: controller.selectedRooms.isNotEmpty
                          ? context.theme.appColors.textError
                          : context.theme.appColors.textDisable,
                      borderColor: context.theme.appColors.borderDisable,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.spMin,
              vertical: 10,
            ),
            child: SearchBox(
              height: 42.spMin,
              color: context.theme.appColors.backgroundNeutralLighterPressed,
              focusNode: controller.searchInputFocus,
              searchController: controller.searchController,
              onSuffixPressed: controller.handleClearSearch,
            ),
          ),
          Expanded(
            child: Obx(() {
              return SlidableAutoCloseBehavior(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      //NOTE.25 is round check box
                      left: 25.spMin + AppSpace.space24,
                    ),
                    child: const Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    0,
                    20,
                  ),
                  itemCount: controller.roomSubList.length,
                  itemBuilder: (_, index) {
                    final roomSub = controller.roomSubList.elementAtOrNull(index);
                    final key = roomSub?.widgetKey;
                    final roomData =
                        controller.roomDataList.firstWhereOrNull((element) => element.room()?.id == roomSub?.roomId);
                    final room = roomData?.room;
                    if (roomSub == null || room == null) {
                      return const SizedBox.shrink();
                    }

                    return Obx(() {
                      bool isTyping = false;
                      if (controller.chatListController.isRoomsTyping.value[roomSub.id!] == true) {
                        isTyping = true;
                      }

                      bool isSelected = controller.selectedRooms.contains(roomSub);

                      return GestureDetector(
                        onTap: () {
                          controller.handleSelectCheckbox(roomSub);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              RoundCheckBox(
                                onTap: (_) {
                                  controller.handleSelectCheckbox(roomSub);
                                },
                                uncheckedWidget: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: context.theme.appColors.borderDisable,
                                    ),
                                  ),
                                ),
                                checkedColor: UTheme.color.primary,
                                disabledColor: context.theme.appColors.textPrimary,
                                checkedWidget: Image.asset(
                                  UChatAssetPath.checkBoxIconNew,
                                ),
                                isChecked: isSelected,
                                size: 25.spMin,
                                borderColor: isSelected
                                    ? context.theme.appColors.borderPrimary
                                    : context.theme.appColors.borderDisable,
                                border: Border.all(
                                  width: 0,
                                  color: context.theme.appColors.borderDisable,
                                ),
                                animationDuration: const Duration(milliseconds: 200),
                              ),
                              Expanded(
                                child: RoomListItemSlidable(
                                  disableSlidable: true,
                                  showFailMessageBadge: false,
                                  key: ValueKey('CONTAINER-$key'),
                                  room: room()!,
                                  roomSub: roomSub,
                                  draftMessage: room()?.draftMessage ?? '',
                                  isTyping: isTyping,
                                  onSelectRoom: (_) {
                                    controller.handleSelectCheckbox(roomSub);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
