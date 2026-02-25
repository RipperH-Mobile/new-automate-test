import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/request_join_group_modal/request_join_group_controller.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/entities/enum/invited_status.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class RequestJoinGroupModal extends StatelessWidget {
  final String inviteLink;
  const RequestJoinGroupModal({super.key, required this.inviteLink});

  /// Static method to show the modal
  ///
  /// This method will handle the controller lifecycle and validation
  /// of the invite link before opening the modal.
  ///
  /// - If the invite link is invalid, it will show an error dialog.
  ///
  /// - If the invite link is valid and the user is already a member,
  ///   it will route to the chat room directly without opening the modal.
  ///
  /// - If the invite link is valid and the user is not a member,
  ///   it will open the modal with the invite details.
  ///
  /// - The controller will be cleaned up after the modal is closed.
  ///
  /// Usage:
  /// ```dart
  /// RequestJoinGroupModal.show(context, inviteLink: 'your_invite_link');
  /// ```
  static Future<void> show(BuildContext context, {required String inviteLink}) async {
    // close previous modal if already opened
    if (Get.routing.route?.settings.name == RequestJoinGroupController.modalRouteName) {
      Get.back();
      // wait for the modal to close
      await Future.delayed(const Duration(milliseconds: 250));
    }

    // validate invite link before open modal
    if (inviteLink.isEmpty && context.mounted) {
      UChatNewDialog.showGeneralErrorDialog(context: context, message: 'Invalid invite link'.tr);
      return;
    }

    // initialize controller and open modal
    final controller = Get.put(RequestJoinGroupController(inviteLink: inviteLink), tag: inviteLink);
    await controller.openModal();

    // clean up controller after modal closed
    if (Get.isRegistered<RequestJoinGroupController>(tag: inviteLink)) {
      Get.delete<RequestJoinGroupController>(tag: inviteLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.appColors.elevationSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpace.space8.r),
          topRight: Radius.circular(AppSpace.space8.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSpace.space6,
          left: AppSpace.space4,
          right: AppSpace.space4,
        ),
        child: GetBuilder<RequestJoinGroupController>(
          tag: inviteLink,
          init: RequestJoinGroupController(inviteLink: inviteLink),
          builder: (ctl) {
            if (ctl.isLoading) {
              return const _RequestJoinGroupShimmer();
            }

            final roomInvite = ctl.roomInvite;
            if (roomInvite == null) {
              return const SizedBox.shrink();
            }

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar with close button
                  SizedBox(
                    height: 160.spMin,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AvatarWrapper(
                          key: ValueKey('request-join-group-${roomInvite.id}'),
                          imageAvatarId: roomInvite.photoId,
                          roomType: roomInvite.roomType?.value,
                          radius: 80.spMin,
                          borderColor: Colors.transparent,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => ctl.onClosePressed(isCloseOverlays: false),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.theme.appColors.backgroundGrayLightest,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpace.space2),
                                child: Assets.vectors.xClose.svg(width: 24.sp, height: 24.sp),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AppSpace.space4.verticalSpace,
                  AppText.title2(context: context, roomInvite.roomName),
                  AppSpace.space1.verticalSpace,
                  AppText.body2(
                    context: context,
                    '@memberCount member'.trParams({'memberCount': roomInvite.memberCount.toString()}),
                    color: context.theme.appColors.textDark,
                  ),
                  if (roomInvite.members?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...roomInvite.members!.reversed.take(6).map(
                                (e) => Align(
                                  widthFactor: 0.7,
                                  child: AvatarWrapper(
                                    key: ValueKey('request-join-group-member-${e.id}'),
                                    imageUrl: e.avatarPublic,
                                    radius: 20,
                                    showOnlineStatus: false,
                                    borderWidth: 2,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  Builder(builder: (_) {
                    if (roomInvite.accessType.isPublic) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
                        child: AppFilledButton.primary(
                          context: context,
                          label: 'Join group'.tr,
                          style: AppButtonStyle.fullRounded,
                          isLoading: ctl.isLoadingJoin,
                          onTap: ctl.joinGroup,
                        ),
                      );
                    } else {
                      if (ctl.invitedStatus == InvitedStatus.none) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
                          child: AppFilledButton.primary(
                            context: context,
                            label: roomInvite.accessType.isPrivate ? 'Request to join group'.tr : 'Join group'.tr,
                            style: AppButtonStyle.fullRounded,
                            isLoading: ctl.isLoadingJoin,
                            onTap: ctl.joinGroup,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
                          child: AppFilledButton.primary(
                            context: context,
                            label: 'Waiting for approval'.tr,
                            style: AppButtonStyle.fullRounded,
                            onTap: null,
                          ),
                        );
                      }
                    }
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RequestJoinGroupShimmer extends StatelessWidget {
  const _RequestJoinGroupShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      enable: true,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar with close button
            SizedBox(
              height: 160.spMin,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 160.spMin,
                    height: 160.spMin,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.elevationSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundGrayLightest,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpace.space2),
                        child: Assets.vectors.xClose.svg(width: 24.sp, height: 24.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AppSpace.space4.verticalSpace,
            SizedBox(
              width: 200.w,
              height: 26.5.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.appColors.elevationSurface,
                  borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                ),
              ),
            ),
            AppSpace.space2.verticalSpace,
            SizedBox(
              width: 100.w,
              height: 24.5.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.appColors.elevationSurface,
                  borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    6,
                    (e) => Align(
                      widthFactor: 0.7,
                      child: SizedBox(
                        width: 40.spMin,
                        height: 40.spMin,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.theme.appColors.elevationSurface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.theme.appColors.elevationSurface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
              child: AppFilledButton.primary(
                context: context,
                label: 'Request to join group'.tr,
                style: AppButtonStyle.fullRounded,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
