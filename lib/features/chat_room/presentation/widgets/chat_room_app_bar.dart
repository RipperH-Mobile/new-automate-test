import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/chat_room_app_bar_button.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomAppBar extends StatelessWidget {
  /// Chat room controller
  ///
  /// `Required`
  final ChatRoomController controller;

  /// Callback when voice call button is pressed
  ///
  /// Default is `null`
  final VoidCallback? onAppBarCallButtonPressed;

  /// Callback when video call button is pressed
  ///
  /// Default is `null`
  final VoidCallback? onVideoCallPressed;

  /// Callback when join call button is pressed
  ///
  /// Default is `null`
  final VoidCallback? onJoinCallPressed;

  final int? amountGroupMember;

  final CallType? callType;

  const ChatRoomAppBar({
    super.key,
    required this.controller,
    this.onAppBarCallButtonPressed,
    this.onVideoCallPressed,
    this.onJoinCallPressed,
    this.amountGroupMember,
    this.callType,
  });

  static const Size size = Size.fromHeight(AppSpace.space16);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedMessages.value != null) {
        return FadeInDown(
          duration: const Duration(milliseconds: 300),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: context.theme.appColors.backgroundChatHeader,
            leadingWidth: AppSpace.space10,
            titleSpacing: 0,
            title: AppText.subtitle1(
              'Select messages'.tr,
              color: context.theme.appColors.textDarkest,
              context: context,
            ),
          ),
        );
      }
      return AppBar(
        backgroundColor: context.theme.appColors.backgroundChatHeader,
        leadingWidth: AppSpace.space10,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpace.space1),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Assets.vectors.iconArrowAppBar.svg(
              height: 20.spMin,
              colorFilter: ColorFilter.mode(
                context.theme.appColors.icon,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            _buildUnreadCount(context),
            _buildTitle(context),
            controller.roomCapability.value.disableCall
                ? const SizedBox.shrink()
                : Obx(
                    () {
                      return _buildCallButtons(
                        onAppBarCallButtonPressed: onAppBarCallButtonPressed,
                        onJoinCallPressed: onJoinCallPressed,
                        callType: callType,
                        disable: !controller.isDirectCallAvailable,
                        context: context,
                      );
                    },
                  )
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 0.2,
      );
    });
  }

  /// Build unread count
  ///
  /// Show unread count badge if there is unread message
  Widget _buildUnreadCount(BuildContext context) {
    return Obx(() {
      final allUnreadCount = controller.allUnreadCount;

      if (allUnreadCount <= 0) return const SizedBox.shrink();
      final text = allUnreadCount > 999 ? '999+' : allUnreadCount.toString();

      return Container(
        margin: const EdgeInsets.only(right: AppSpace.space3),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space2,
          vertical: AppSpace.space1,
        ),
        decoration: BoxDecoration(
          color: context.theme.appColors.iconPrimary,
          borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        ),
        child: AppText.caption1Bold(
          text,
          context: context,
          color: context.theme.appColors.textPrimaryInverse,
        ),
      );
    });
  }

  /// Build title
  ///
  /// Display room title with avatar
  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.roundedFull),
        onTap: controller.openRoomDetail,
        child: Row(
          children: [
            Obx(() => AvatarWrapper(
                  data: controller.room.value?.isDirect == true ? controller.contact.value : controller.room.value,
                  radius: AppSize.size10 / 2,
                  hasBorder: false,
                )),
            AppSpace.space3.horizontalSpace,
            Flexible(
              child: Obx(() {
                final title = controller.appBarTitle;

                if (amountGroupMember != null) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppText.subtitle1(
                          title.isNotEmpty ? title : 'UNKNOWN'.tr,
                          color: context.theme.appColors.textDarkest,
                          context: context,
                        ),
                      ),
                      AppText.subtitle1(
                        ' ($amountGroupMember)',
                        color: context.theme.appColors.textDarkest,
                        context: context,
                      ),
                    ],
                  );
                }

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.roomCapability.value == RoomCapabilityEntity.official)
                      Container(
                        margin: const EdgeInsets.only(
                          top: AppSpace.spacePx,
                          right: AppSpace.space1,
                        ),
                        child: Assets.vectors.oaIconBlue.svg(
                          width: AppSpace.space4,
                          height: AppSpace.space4,
                        ),
                      ),
                    Flexible(
                      child: AppText.subtitle1(
                        title.isNotEmpty ? title : 'UNKNOWN'.tr,
                        color: context.theme.appColors.textDarkest,
                        context: context,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Assets.vectors.chevronRightSvg.svg(),
          ],
        ),
      ),
    );
  }

  /// Build call buttons
  ///
  /// Display voice call and video call buttons
  Widget _buildCallButtons({
    VoidCallback? onAppBarCallButtonPressed,
    VoidCallback? onJoinCallPressed,
    bool disable = false,
    CallType? callType,
    required BuildContext context,
  }) {
    if (onJoinCallPressed != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: SizedBox(
          height: 34.spMin,
          child: ChatRoomAppBarButton(
            backgroundColor: context.theme.appColors.backgroundCallJoin,
            onPressed: disable ? null : onJoinCallPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (callType == CallType.video)
                  Assets.vectors.videoCallIcon.svg(
                    width: AppSize.size3.spMin,
                    height: AppSize.size3.spMin,
                    colorFilter: disable
                        ? ColorFilter.mode(
                            context.theme.appColors.iconDisable,
                            BlendMode.srcIn,
                          )
                        : ColorFilter.mode(
                            context.theme.appColors.iconJoinCall,
                            BlendMode.srcIn,
                          ),
                  )
                else
                  Assets.vectors.voiceCallIcon.svg(
                    width: AppSize.size4.spMin,
                    height: AppSize.size4.spMin,
                    colorFilter: disable
                        ? ColorFilter.mode(
                            context.theme.appColors.iconDisable,
                            BlendMode.srcIn,
                          )
                        : ColorFilter.mode(
                            context.theme.appColors.iconJoinCall,
                            BlendMode.srcIn,
                          ),
                  ),
                const SizedBox(
                  width: AppSpace.space1,
                ),
                Text(
                  'Join'.tr,
                  style: context.theme.appTexts.subtitle1.copyWith(
                    height: 1,
                    fontSize: 15.spMin,
                    color: disable ? context.theme.appColors.textDisable : context.theme.appColors.iconJoinCall,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      child: Row(
        children: [
          ChatRoomAppBarButton(
            onPressed: disable ? null : onAppBarCallButtonPressed,
            child: Assets.vectors.voiceCallIcon.svg(
              colorFilter: disable == true
                  ? ColorFilter.mode(
                      context.theme.appColors.iconDisable,
                      BlendMode.srcIn,
                    )
                  : ColorFilter.mode(
                      context.theme.appColors.iconCallChatRoom,
                      BlendMode.srcIn,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
