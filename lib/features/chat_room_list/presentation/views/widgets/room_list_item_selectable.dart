import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/checkbox/round_checkbox.dart';

class RoomListItemSelectable extends StatelessWidget {
  final void Function()? onPressed;
  final RoomCollection room;
  final RoomSubscriptionCollection? roomSub;
  final bool isChecked;
  final EdgeInsets? padding;
  final String? customSubTitle;
  final double? avatarHeight;
  final double checkboxSize;
  final EdgeInsets? checkBoxPadding;
  final bool reachedMaxSelected;

  const RoomListItemSelectable({
    super.key,
    this.onPressed,
    required this.room,
    required this.isChecked,
    this.roomSub,
    this.padding,
    this.customSubTitle,
    this.avatarHeight,
    this.checkboxSize = 25,
    this.checkBoxPadding,
    this.reachedMaxSelected = false,
  });

  bool get shouldHideCheckBox => reachedMaxSelected && !isChecked;

  @override
  Widget build(BuildContext context) {
    return BasicTextButton(
      onPressed: onPressed,
      padding: padding,
      child: RoomListItem(
        room: room,
        roomSub: roomSub,
        showLastMessage: false,
        showUnreadCount: false,
        showFailMessageBadge: false,
        showJoinGroupCallBtn: false,
        customSubtitle: customSubTitle,
        avatarHeight: avatarHeight,
        actions: shouldHideCheckBox
            ? null
            : [
                Padding(
                  padding: checkBoxPadding ?? EdgeInsets.only(right: 8.spMin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UChatRoundCheckBox(
                        size: checkboxSize,
                        onTap: (value) => onPressed?.call(),
                        checkedColor: UTheme.color.checkBox,
                        isChecked: isChecked,
                        animationDuration: const Duration(milliseconds: 200),
                        border: Border.all(
                          color: isChecked ? UTheme.color.primary : const Color(0xFFCCCCCC),
                          width: 1.5,
                        ),
                        checkedWidget: Image.asset(
                          'assets/images/v2/new_checked_icon.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
      ),
    );
  }
}
