import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/profile/presentation/controllers/group_profile_controller.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_action_button.dart';
import 'package:uchat/gen/assets.gen.dart';

class GroupProfilePanel extends GetView<GroupProfileController> {
  const GroupProfilePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => ProfileActionButton(
              title: 'Chat'.tr,
              svgPath: Assets.vectors.chatActiveIcon.path,
              onTap: controller.loading.isFalse ? controller.handleChat : null,
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          Obx(
            () => ProfileActionButton(
              title: 'Call'.tr,
              svgPath: Assets.vectors.phone.path,
              onTap: controller.loading.isFalse
                  ? () {
                      controller.handleCall(CallType.voice);
                    }
                  : null,
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          Obx(
            () => ProfileActionButton(
              title: 'Video Call'.tr,
              svgPath: Assets.vectors.videoCamera.path,
              onTap: controller.loading.isFalse
                  ? () {
                      controller.handleCall(CallType.video);
                    }
                  : null,
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          Obx(
            () => ProfileActionButton(
              title: controller.isMuted.value ? 'Unmute'.tr : 'Mute'.tr,
              svgPath: controller.isMuted.value ? Assets.vectors.bellmute.path : Assets.vectors.bell.path,
              onTap: controller.loading.isFalse ? controller.handleToggleMuteChat : null,
            ),
          ),
        ],
      ),
    );
  }
}
