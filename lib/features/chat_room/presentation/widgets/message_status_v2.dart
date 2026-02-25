import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/contact/presentation/views/widgets/contact_list_item.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageStatusV2 extends StatelessWidget {
  final String sentTime;
  final bool isShowStatus;
  final bool isRead;
  final bool isSending;
  final bool isPinned;
  final bool isShowArrow;
  final bool isEdited;
  final bool isResend;
  final bool isMyMessage;
  final void Function()? onResendTap;
  final List<RoomMemberCollection>? readMembers;
  final bool isAbleToShowReadByMembers;

  /// Whether the message is in a group chat
  final bool isGroup;

  const MessageStatusV2({
    super.key,
    this.sentTime = '',
    this.isShowStatus = true,
    this.isRead = false,
    this.isSending = false,
    this.isPinned = false,
    this.isShowArrow = false,
    this.isEdited = false,
    this.isResend = false,
    this.isMyMessage = false,
    this.readMembers,
    this.isGroup = false,
    this.onResendTap,
    this.isAbleToShowReadByMembers = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget status = const SizedBox.shrink();

    if (!isShowStatus) {
      return status;
    }

    bool shouldShowSentTime = true;

    if (isSending && isMyMessage) {
      status = Assets.vectors.sendingIcon.svg();
    } else if (isResend && isMyMessage) {
      status = GestureDetector(
        onTap: () {
          onResendTap?.call();
        },
        behavior: HitTestBehavior.translucent,
        child: Assets.vectors.resendIcon.svg(),
      );
      shouldShowSentTime = false;
    } else if (isShowArrow) {
      status = Assets.vectors.jumpToArrowIcon.svg(
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconLighter,
          BlendMode.srcIn,
        ),
      );
    } else {
      // Default text for read status
      String readText = '';

      // If the message is in a group chat and has been read by at least one person
      // Display the number of people who have read the message
      // change to '[check icon] @count' if readCount > 0
      if (isGroup && (readMembers?.length ?? 0) > 0) {
        readText = '${readMembers?.length}';
      }

      status = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        textDirection: isMyMessage ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (isRead)
            Row(
              children: [
                Assets.vectors.iconCheck.svg(),
                AppSpace.space05.horizontalSpace,
                AppText.caption2(readText, context: context),
              ],
            ),
          if (isPinned) ...[AppSpace.space1.horizontalSpace, Assets.vectors.pinIcon.svg()],
          if (isEdited) ...[AppSpace.space1.horizontalSpace, Assets.vectors.editedIcon.svg()],
        ],
      );
    }

    return GestureDetector(
      onTap: (!isGroup || readMembers?.isNotEmpty != true || isAbleToShowReadByMembers != true)
          ? null
          : () => _onReadByTap(context),
      child: Column(
        crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          status,
          if (shouldShowSentTime) AppText.caption2(sentTime, context: context),
        ],
      ),
    );
  }

  void _onReadByTap(BuildContext context) {
    BottomSheetUChat.bottomSheet(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      childBackgroundColor: Colors.transparent,
      Get.context!,
      title: 'Seen by'.tr,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 600.h,
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final id = readMembers!.elementAt(index);
            return SizedBox(
              height: 55,
              child: ContactListItem(
                data: id.account,
                spaceBetweenAvatarAndTitle: 20,
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 85.0),
            child: Divider(
              height: 10,
              color: context.theme.appColors.divider.withValues(alpha: 0.3),
            ),
          ),
          itemCount: readMembers!.length,
        ),
      ),
    );
  }
}
