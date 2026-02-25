import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_invite_link_qr_code_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/invite_link_qr_code.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ChatRoomDetailGroupInviteLinkQrCodeScreen extends GetView<ChatRoomDetailGroupInviteLinkQrCodeController> {
  const ChatRoomDetailGroupInviteLinkQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurface,
      appBar: AppBarDefault(
        title: 'QR Code'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () {
            Get.back();
          },
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<ChatRoomDetailGroupInviteLinkQrCodeController>(
              id: ChatRoomDetailGroupInviteLinkQrCodeIds.roomName,
              builder: (ctl) {
                if (ctl.isLoadingRoom) {
                  return ShimmerLoading(
                    enable: true,
                    child: Column(
                      children: [
                        Container(
                          width: .4.sw,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        AppSpace.space1.verticalSpace,
                        Container(
                          width: .26.sw,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: Get.width * 0.8),
                      child: AppText.title2(
                        ctl.room.roomName ?? 'Unknown'.tr,
                        context: context,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppText.body3(
                      '@accessType group'.trParams({
                        'accessType': ctl.room.accessType?.displayValue ?? 'Unknown'.tr,
                      }),
                      context: context,
                      color: context.theme.appColors.textLight,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpace.space8),
              child: GetBuilder<ChatRoomDetailGroupInviteLinkQrCodeController>(
                id: ChatRoomDetailGroupInviteLinkQrCodeIds.qrCodeSection,
                builder: (ctl) {
                  return InviteLinkQrCode(
                    inviteLink: ctl.inviteLink,
                  );
                },
              ),
            ),
            SizedBox(
              width: 260.spMin,
              child: AppText.body4(
                'Share this QR code to let people join your group. You can revoke it anytime.'.tr,
                context: context,
                color: context.theme.appColors.textLight,
                textAlign: TextAlign.center,
              ),
            ),
            AppSpace.space10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: controller.onShareQrCode,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
                    child: Column(
                      children: [
                        Assets.vectors.shareIcon.svg(
                          width: 24.spMin,
                          height: 24.spMin,
                          colorFilter: ColorFilter.mode(context.theme.appColors.iconPrimary, BlendMode.srcIn),
                        ),
                        AppSpace.space1.verticalSpace,
                        AppText.body4Bold('Share'.tr, context: context),
                      ],
                    ),
                  ),
                ),
                AppSpace.space10.horizontalSpace,
                GestureDetector(
                  onTap: () => controller.onDownloadQrCode(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
                    child: Column(
                      children: [
                        Assets.vectors.iconDownload.svg(
                          width: 24.spMin,
                          height: 24.spMin,
                          colorFilter: ColorFilter.mode(context.theme.appColors.iconPrimary, BlendMode.srcIn),
                        ),
                        AppSpace.space1.verticalSpace,
                        AppText.body4Bold('Save'.tr, context: context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppSpace.space24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
