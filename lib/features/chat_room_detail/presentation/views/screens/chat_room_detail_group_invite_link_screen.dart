import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_invite_link_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

class ChatRoomDetailGroupInviteLinkScreen extends GetView<ChatRoomDetailGroupInviteLinkController> {
  const ChatRoomDetailGroupInviteLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Invite link'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: controller.onBack,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
        child: Column(
          children: [
            GetBuilder<ChatRoomDetailGroupInviteLinkController>(
              id: ChatRoomDetailGroupInviteLinkIds.inviteLinkSection,
              builder: (ctl) {
                return UChatRowMenu(
                  title: 'Invite Link'.tr,
                  subTitle: 'Share link to let people join your group'.tr,
                  suffixText: ctl.inviteLinkStatus.displayValue,
                  centerRightContent: true,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
                  hasBorder: false,
                  borderRadius: AppRadius.rounded2xl,
                  onTap: controller.onGoToInviteLinkStatusSetting,
                );
              },
            ),
            const _InviteLinkPreview(),
          ],
        ),
      ),
    );
  }
}

class _InviteLinkPreview extends StatelessWidget {
  const _InviteLinkPreview();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatRoomDetailGroupInviteLinkController>(
      id: ChatRoomDetailGroupInviteLinkIds.inviteLinkPreview,
      builder: (ctl) {
        if (ctl.inviteLinkStatus == InviteLinkStatus.off) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(top: AppSpace.space4, bottom: AppSpace.space2),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightestPressed,
              borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body4Bold(
                    'Link: @accessType group'.trParams({'accessType': ctl.roomAccessType.displayValue}),
                    context: context,
                    color: context.theme.appColors.textLighter,
                  ),
                  AppSpace.space2.verticalSpace,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.theme.appColors.borderDisable, width: 1),
                      borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpace.space2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
                              child: Text(
                                ctl.inviteLink ?? 'No link available'.tr,
                                style: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textDark),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Builder(
                            builder: (optionContext) {
                              return GestureDetector(
                                onTap: () {
                                  UChatPopover.open(
                                    context: optionContext,
                                    contentDxOffset: -180.w,
                                    width: 220.w,
                                    menu: [
                                      PopoverMenuItem(
                                        onPressed: (_) async {
                                          Get.back();
                                          ctl.onGetQRCode();
                                        },
                                        child: Row(
                                          children: [
                                            Assets.vectors.qrCode.svg(
                                              width: 20.spMin,
                                              height: 20.spMin,
                                              colorFilter: ColorFilter.mode(
                                                context.theme.appColors.textDarkest,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            AppSpace.space3.horizontalSpace,
                                            AppText.body1(
                                              'Get QR Code'.tr,
                                              context: context,
                                              color: context.theme.appColors.textDarkest,
                                              lineHeight: 1.2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopoverMenuItem(
                                        onPressed: (_) async {
                                          Get.back();
                                          ctl.onRevokeLink();
                                        },
                                        child: Row(
                                          children: [
                                            Assets.vectors.trash.svg(
                                              width: 20.spMin,
                                              height: 20.spMin,
                                            ),
                                            AppSpace.space3.horizontalSpace,
                                            AppText.body1(
                                              'Revoke'.tr,
                                              context: context,
                                              color: context.theme.appColors.textError,
                                              lineHeight: 1.2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                child: Assets.vectors.moreOption.svg(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpace.space4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: AppFilledButton.defaultButton(
                          context: context,
                          label: 'Share'.tr,
                          size: AppButtonSize.medium,
                          style: AppButtonStyle.fullRounded,
                          onTap: ctl.onShareInviteLink,
                        ),
                      ),
                      AppSpace.space4.horizontalSpace,
                      Expanded(
                        child: AppFilledButton.defaultButton(
                          context: context,
                          label: 'Copy'.tr,
                          size: AppButtonSize.medium,
                          style: AppButtonStyle.fullRounded,
                          onTap: () {
                            ctl.onCopyInviteLink(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
