import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/presentation/bindings/chat_room_direct_binding.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_direct_mobile_screen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/menu_list/menu_list_box.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class ChatRoomHoldAndScrollDialog {
  /// The transition duration of the dialog in milliseconds.
  ///
  /// - Default value is `200`.
  static const transitionDurationDialogInMilliseconds = 200;

  /// Show the chat room hold and scroll dialog.
  ///
  /// - [room] is the room collection.
  /// - [menuItems] is the list of menu list items.
  static Future<void> show(RoomCollection room, List<MenuListItem> menuItems) async {
    final roomId = room.id;
    final roomType = room.roomType;

    if (roomId == null || roomType == null) {
      return;
    }

    /// Barrier label to prevent multiple dialog
    final barrierLabel = 'chat_room_hold_and_scroll_dialog-$roomId';

    /// Put controller before show dialog
    _putController(roomId, roomType);

    /// Show dialog
    await showGeneralDialog(
      context: Get.context!,
      barrierDismissible: true,
      barrierLabel: barrierLabel,
      transitionDuration: const Duration(milliseconds: transitionDurationDialogInMilliseconds),
      transitionBuilder: _transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) => _pageBuilder(context, room, menuItems),
    );
    _closeController(roomId, roomType);
  }

  /// Put controller for the chat room hold and scroll dialog.
  ///
  /// - [roomId] is the room ID.
  /// - [roomType] is the room type.
  static void _putController(String roomId, RoomType roomType) {
    /// Manual binding controller
    ChatRoomDirectBinding().putManualBinding(roomId, enableReadMessage: false);
  }

  /// Close controller for the chat room hold and scroll dialog.
  ///
  /// - [roomId] is the room ID.
  /// - [roomType] is the room type.
  static void _closeController(String roomId, RoomType roomType) {
    ChatRoomDirectBinding().closeManualBinding(roomId);
  }

  /// The transition builder of the dialog.
  ///
  /// - [context] is the build context.
  /// - [animation] is the animation.
  /// - [secondaryAnimation] is the secondary animation.
  /// - [child] is the child widget.
  ///
  /// Return the widget.
  static Widget _transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedValue = Curves.easeInOut.transform(animation.value);
    return Transform.scale(
      scale: 1 - (1 - curvedValue) * 0.05,
      child: Opacity(
        opacity: curvedValue,
        child: child,
      ),
    );
  }

  /// The page builder of the dialog.
  ///
  /// - [context] is the build context.
  /// - [room] is the room collection.
  /// - [menuItems] is the list of menu list items.
  ///
  /// Return the widget.
  static Widget _pageBuilder(
    BuildContext context,
    RoomCollection room,
    List<MenuListItem> menuItems,
  ) {
    return SafeArea(
      child: Portal(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: .6.sh,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                      child: ChatRoomDirectMobileScreen(
                        roomTag: room.id!,
                        enableHoldAndScroll: true,
                      ),
                    ),
                  ),
                  AppSpace.space4.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: MenuListBox(
                      menuItems: menuItems,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
