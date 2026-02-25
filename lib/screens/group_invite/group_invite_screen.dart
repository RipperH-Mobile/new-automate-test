import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_entity.dart';
import 'package:uchat/widgets.dart';

import 'group_invite_controller.dart';

class GroupInviteScreen extends GetView<GroupInviteController> {
  const GroupInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (Get.mediaQuery.size.width - 80) / 2;

    return ScaffoldBasic(
      bottomNavigationBar: ScaffoldBottomButtonContainer(
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: PrimaryBasicButton(
                  width: buttonWidth,
                  isRounded: false,
                  title: 'Accept'.tr,
                  onPressed: controller.selectedGroups.isEmpty ? null : () => controller.handleAccept(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AccentBasicButton(
                  width: buttonWidth,
                  isRounded: false,
                  title: 'Reject'.tr,
                  onPressed: controller.selectedGroups.isEmpty ? null : () => controller.handleReject(),
                ),
              ),
            ],
          );
        }),
      ),
      child: CustomScrollView(
        slivers: [
          AppBarWithCallHeader<SliverAppBar>(
            centerTitle: true,
            title: AppBarTitle(title: 'Group Invite'.tr),
            leading: AppBarBackButton(
              onPressed: controller.handleBack,
            ),
          ),
          _waitingList(),
        ],
      ),
    );
  }

  Widget _waitingList() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final group = controller.roomInviteList.elementAt(index);

            return Obx(() {
              return ContactListItemSelectable<RoomInviteEntity>(
                key: ValueKey(group.id),
                data: group,
                useGravatar: group.photoId == null,
                showStatusMessage: false,
                showMemberCount: false,
                isChecked: controller.selectedGroups.contains(group),
                onPressed: () => controller.handleSelectCheckbox(group),
              );
            });
          },
          childCount: controller.roomInviteList.length,
        ),
      );
    });
  }
}
