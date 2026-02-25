import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/widgets.dart';

import '../../controllers/create_group/select_member_controller.dart';

class TabGroups extends GetView<SelectMemberController> {
  const TabGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.spMin),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.groups.length,
            itemBuilder: (BuildContext context, int index) {
              RoomCollection currentGroup = controller.groups.elementAt(index);

              return Obx(() {
                return RoomListItemSelectable(
                  room: currentGroup,
                  reachedMaxSelected:
                      controller.selectedGroupsAndContacts.length >= UserController.instance.maxRoomInChatFolder
                          ? true
                          : false,
                  isChecked: controller.selectedGroupsAndContacts.any((element) => element.id == currentGroup.id),
                  onPressed: () {
                    controller.handleSelectCheckboxForAddToFolder(currentGroup);
                  },
                );
              });
            }
            // }
            ),
      );
    });
  }
}
