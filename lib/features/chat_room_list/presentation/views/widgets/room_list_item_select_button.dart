import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/widgets.dart';

class RoomListItemWithButton extends StatelessWidget {
  final void Function()? onPressed;
  final RoomCollection room;
  final RoomSubscriptionCollection? roomSub;
  final EdgeInsets? padding;
  final String text;
  final double? avatarHeight;

  const RoomListItemWithButton({
    super.key,
    this.onPressed,
    required this.room,
    required this.text,
    this.roomSub,
    this.padding,
    this.avatarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: RoomListItem(
        room: room,
        roomSub: roomSub,
        showLastMessage: false,
        showUnreadCount: false,
        showFailMessageBadge: text != 'Edit'.tr,
        avatarHeight: avatarHeight,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            // child: RoundCheckBox(
            //   size: 28,
            //   onTap: (value) => onPressed?.call(),
            //   checkedColor: UTheme.color.checkBox,
            //   isChecked: isChecked,
            // ),
            child: TextButton(
              onPressed: () {
                onPressed?.call();
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  const Color(0xFFE6EFFF),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF0056FF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
