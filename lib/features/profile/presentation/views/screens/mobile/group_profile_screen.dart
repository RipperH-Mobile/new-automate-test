import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/features/profile/presentation/controllers/group_profile_controller.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_skeleton_loading.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

import '../../widgets/group_member_section.dart';
import '../../widgets/group_profile_panel.dart';
import '../../widgets/profile_header.dart';

const _kAppBarMaxHeightRatio = 0.48;

class ProfileGroupScreen extends GetView<GroupProfileController> {
  const ProfileGroupScreen({
    super.key,
  });

  String get id => Get.parameters['id'] ?? '';

  @override
  Widget build(BuildContext context) {
    final maxHeight = (Get.height * _kAppBarMaxHeightRatio);
    final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Obx(
      () {
        final roomEntity = controller.room.value;

        if (controller.loading.value && roomEntity == null) {
          return const ProfileSkeletonLoading();
        }

        if (roomEntity == null) {
          return const SizedBox.shrink();
        }

        return ScaffoldBasic(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: context.theme.appColors.border,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: maxHeight,
                  child: ProfileHeader(
                    maxHeight: maxHeight,
                    minHeight: minHeight,
                    avatarUrl: GetIt.I<FileService>().getFileUrl(roomEntity.photoId ?? ''),
                    name: roomEntity.roomName ?? 'Unknown'.tr,
                    customActionButtons: roomEntity.isJoined == true ? const GroupProfilePanel() : null,
                    onEdit: controller.canEdit
                        ? () {
                            controller.handleOpenEditGroupName();
                          }
                        : null,
                  ),
                ),
                const SizedBox(
                  height: AppSpace.space6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.space4,
                  ),
                  child: Column(
                    children: [
                      // Member section
                      const GroupMemberSection(),
                      const SizedBox(
                        height: AppSpace.space4,
                      ),
                      if (roomEntity.isJoined == true)
                        CornerBoxMenu(
                          children: [
                            CornerBoxMenuItem(
                              child: AppText.body1(
                                'Leave group'.tr,
                                context: context,
                                color: context.theme.appColors.textError,
                              ),
                              onTap: () async {
                                await controller.handleLeaveGroup(context);
                              },
                            ),
                            CornerBoxMenuItem(
                              child: AppText.body1(
                                'Report group'.tr,
                                context: context,
                                color: context.theme.appColors.textError,
                              ),
                              onTap: () {
                                controller.handleReportGroup();
                              },
                            ),
                          ],
                        )
                      else
                        CornerBoxMenu(
                          children: [
                            CornerBoxMenuItem(
                              child: AppText.body1(
                                'Join this group'.tr,
                                context: context,
                              ),
                              onTap: () {
                                controller.showDialogAcceptGroup();
                              },
                            ),
                            CornerBoxMenuItem(
                              child: AppText.body1(
                                'Decline'.tr,
                                context: context,
                                color: context.theme.appColors.textError,
                              ),
                              onTap: () {
                                controller.showDialogDeclineGroup();
                              },
                            ),
                            CornerBoxMenuItem(
                              child: AppText.body1(
                                'Report group'.tr,
                                context: context,
                                color: context.theme.appColors.textError,
                              ),
                              onTap: () {
                                controller.handleReportGroup();
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
