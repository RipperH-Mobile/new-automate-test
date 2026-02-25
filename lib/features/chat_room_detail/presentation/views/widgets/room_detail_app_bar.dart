import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_member_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets/app_text.dart';

class RoomDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSecret;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMoreOptionPressed;
  final VoidCallback? onOnInvitePressed;
  final VoidCallback? action;
  final VoidCallback? onBack;
  final String? actionText;
  final String titleText;
  final Color? actionTextColors;

  const RoomDetailAppBar({
    super.key,
    required this.isSecret,
    this.onSearchPressed,
    this.onMoreOptionPressed,
    this.onOnInvitePressed,
    required this.titleText,
    this.action,
    this.onBack,
    this.actionText,
    this.actionTextColors,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      centerTitle: true,
      titleSpacing: 0,
      title: AppText.title2(
        titleText,
        context: context,
      ),
      leadingWidth: 100,
      leading: TextButton(
        onPressed: onBack ??
            () {
              Get.back();
            },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 25,
              color: context.theme.appColors.textPrimary,
            ),
            AppText.button1(
              'Back'.tr,
              context: context,
              color: isSecret ? UTheme.color.secretRoomRowBackground : context.theme.appColors.textPrimary,
            ),
          ],
        ),
      ),
      elevation: 0,
      actions: [
        // Search icon
        if (onSearchPressed != null)
          IconButton(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                UChatAssetPath.searchIcon,
                color: context.theme.appColors.textPrimary,
              ),
            ),
            color: context.theme.appColors.textPrimary,
            onPressed: onSearchPressed,
          ),
        if (onOnInvitePressed != null)
          GetX<ChatRoomDetailMemberController>(
            tag: Get.parameters['id'] ?? 'NEW_ROOM',
            builder: (ctl) {
              if (ctl.isAbleToAccessGroupMemberSetting == false) {
                return const SizedBox.shrink();
              }

              return TextButton(
                onPressed: () {
                  onOnInvitePressed!();
                },
                child: AppText.body1Bold('Invite'.tr, context: context, color: context.theme.appColors.textPrimary),
              );
            },
          ),
        if (action != null)
          TextButton(
            onPressed: () {
              action!();
            },
            child: AppText.button1Bold(
              actionText ?? 'Done'.tr,
              context: context,
              color: actionTextColors ?? context.theme.appColors.textPrimary,
            ),
          ),
        // More info icon
        // IconButton(
        //   splashColor: Colors.transparent,
        //   focusColor: Colors.transparent,
        //   highlightColor: Colors.transparent,
        //   icon: SizedBox(
        //     width: 20,
        //     height: 20,
        //     child: Image.asset(
        //       UChatAssetPath.moreInfoIcon,
        //       cacheWidth: 20.cacheSize,
        //       color: const Color(0xFF1A1A1A),
        //     ),
        //   ),
        //   color: const Color(0xFF1A1A1A),
        //   onPressed: onMoreOptionPressed,
        // ),
        // const SizedBox(
        //   width: 15,
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
