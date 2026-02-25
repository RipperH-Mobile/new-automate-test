import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_slidable.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

import 'rooms_edit_controller.dart';

class RoomsEditScreen extends GetView<RoomsEditController> {
  const RoomsEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.white,
      appBar: ScaffoldBasic.appBarBasic(
        title: AppBarTitle(title: 'Edit chats'.tr),
        centerTitle: false,
        titleSpacing: 20.spMin,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.spMin,
              vertical: 16.spMin,
            ),
            child: Obx(() {
              return InkWell(
                onTap: controller.handleCancelSelectedRooms,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: controller.selectedRooms.isNotEmpty ? UTheme.color.primary : const Color(0xFF999999),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
          ),
        ],
      ),

      ///3bottom btn
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
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
              top: (Platform.isAndroid || Platform.isMacOS || Platform.isWindows) ? 10.spMin : 5.spMin,
              bottom: (Platform.isAndroid || Platform.isMacOS || Platform.isWindows) ? 10.spMin : 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: controller.handleTriggerReadAllSelectedChat,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  child: Text(
                    'Read'.tr,
                    style: UTheme.textTheme.appBarAction.copyWith(
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: controller.handleHideAllSelectedChat,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  child: Text(
                    'Hide'.tr,
                    style: UTheme.textTheme.appBarAction.copyWith(
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: controller.handleDeleteAllSelectedChat,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  child: Text(
                    'Delete'.tr,
                    style: UTheme.textTheme.appBarAction.copyWith(
                      color: const Color(0xFFFF1552),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.spMin),
            child: SearchBox(
              height: 42.spMin,
              color: const Color(0xFFF2F2F2),
              focusNode: controller.searchInputFocus,
              searchController: controller.searchController,
              onSuffixPressed: controller.handleClearSearch,
            ),
          ),
          Expanded(
            child: Obx(() {
              return SlidableAutoCloseBehavior(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.spMin,
                    horizontal: 20.spMin,
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
                        child: Row(
                          children: [
                            RoundCheckBox(
                              onTap: (value) {
                                controller.handleSelectCheckbox(roomSub);
                              },
                              uncheckedWidget: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                              checkedColor: UTheme.color.primary,
                              disabledColor: Colors.grey[300],
                              checkedWidget: Image.asset(
                                UChatAssetPath.checkBoxIconNew,
                              ),
                              isChecked: isSelected,
                              size: 25.spMin,
                              borderColor: isSelected ? UTheme.color.primary : Colors.grey[300]!,
                              border: Border.all(
                                width: 0,
                                color: Colors.grey[300]!,
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
                                // onSelectRoom: controller.handleSelectRoom,
                                draftMessage: room()?.draftMessage ?? '',
                                isTyping: isTyping,
                              ),
                            ),
                          ],
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
