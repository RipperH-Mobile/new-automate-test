import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_panel.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_phone_number_menu.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_skeleton_loading.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_uchat_id_menu.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_header.dart';

const _kAppBarMaxHeightRatio = 0.48;

class ProfileScreenV2 extends GetView<ProfileControllerV2> {
  const ProfileScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    final maxHeight = (Get.height * _kAppBarMaxHeightRatio);
    final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Obx(
      () {
        return controller.loadingProfile.value && controller.profile.value == null
            ? const ProfileSkeletonLoading()
            : ScaffoldBasic(
                key: const ValueKey('content'),
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                backgroundColor: context.theme.appColors.border,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () {
                          return SizedBox(
                            height: maxHeight,
                            child: Stack(
                              children: [
                                ProfileHeader(
                                  maxHeight: maxHeight,
                                  minHeight: minHeight,
                                  avatarUrl: controller.profile.value?.avatarUrl ?? '',
                                  name: controller.profile.value?.displayName ?? 'Unknown'.tr,
                                  nickname: controller.profile.value?.friendNickname,
                                  status: controller.profile.value?.statusMessage ?? '',
                                  customActionButtons: controller.isFriend ? const ProfilePanel() : null,
                                  onEdit: controller.canEditProfile ? controller.handleEditNickname : null,
                                ),
                              ],
                            ),
                          );
                        },
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
                            if (!controller.hidePhoneNumber || controller.allowAddByUsername)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpace.space4,
                                ),
                                child: CornerBoxMenu(
                                  children: [
                                    if (!controller.hidePhoneNumber) const ProfilePhoneNumberMenu(),
                                    if (controller.allowAddByUsername) const ProfileUchatIdMenu(),
                                  ],
                                ),
                              ),
                            if (controller.isFriend && !controller.isBlocked)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpace.space4,
                                ),
                                child: CornerBoxMenu.singleItem(
                                  onTap: () {
                                    controller.handleShareContact();
                                  },
                                  child: AppText.body1(
                                    'Share contact'.tr,
                                    context: context,
                                  ),
                                ),
                              )
                            else if (controller.showAddFriendButton && !controller.isBlocked)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpace.space4,
                                ),
                                child: CornerBoxMenu.singleItem(
                                  child: AppText.body1(
                                    'Add to contact'.tr,
                                    context: context,
                                  ),
                                  onTap: () {
                                    controller.handleAddFriend();
                                  },
                                ),
                              ),
                            if (controller.profile.value != null)
                              CornerBoxMenu(
                                children: [
                                  if (controller.profile.value?.isBlocked == true)
                                    CornerBoxMenuItem(
                                      child: AppText.body1(
                                        'Unblock @name'.trParams(
                                          {'name': controller.profile.value?.getName ?? 'Unknown'.tr},
                                        ),
                                        context: context,
                                      ),
                                      onTap: () {
                                        controller.showDialogUnBlockUser();
                                      },
                                    )
                                  else
                                    CornerBoxMenuItem(
                                      child: AppText.body1(
                                        'Block @name'.trParams(
                                          {'name': controller.profile.value?.getName ?? 'Unknown'.tr},
                                        ),
                                        context: context,
                                        color: context.theme.appColors.textError,
                                      ),
                                      onTap: () {
                                        controller.showDialogBlockUser();
                                      },
                                    ),
                                  CornerBoxMenuItem(
                                    child: AppText.body1(
                                      'Report @name'.trParams(
                                        {'name': controller.profile.value?.getName ?? 'Unknown'.tr},
                                      ),
                                      color: context.theme.appColors.textError,
                                      context: context,
                                    ),
                                    onTap: () {
                                      controller.handleReportUser();
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
