import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

import 'setting_hidden_chats_controller.dart';

class SettingHiddenChatsDesktopScreen extends GetView<SettingHiddenChatsController> {
  const SettingHiddenChatsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: buildSettingAppBar(
        centerTitle: true,
        title: 'Hidden chats'.tr,
        leading: AppBarBackButton(
          onPressed: controller.handleBack,
          isShowTextBack: true,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 31.spMin,
          right: 31.spMin,
          bottom: 20.spMin,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SettingSpacer(),
            ),
            _buildRoomList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomList() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final room = controller.rooms.elementAt(index);
            double avatarHeight = 50.spMin;

            final roomLength = controller.rooms.length;
            Border borderSide = Border.all(color: const Color(0xFFE6E6E6));
            BorderRadius borderRadius = BorderRadius.circular(10.spMin);
            final textStyle = UTheme.textTheme.messageTitle.copyWith(
              color: UTheme.color.onTextButton,
              fontWeight: FontWeight.w500,
              fontSize: 14.spMin,
              // fontFamily: 'newUiFont',
            );
            final buttonStyle = ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(const Color(0xFFE6EFFF)),
              overlayColor: WidgetStateProperty.all(
                const Color(0xFFE5E5E5).withValues(alpha: .5),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.spMin)),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 20.spMin,
                  vertical: 15.spMin,
                ),
              ),
            );

            if (roomLength > 1) {
              if (index == 0) {
                borderRadius = BorderRadius.only(
                  topLeft: Radius.circular(10.spMin),
                  topRight: Radius.circular(10.spMin),
                );
              }

              if (index > 0 && index + 1 < roomLength) {
                borderRadius = BorderRadius.circular(0);
                borderSide = const Border(
                  left: BorderSide(color: Color(0xFFE6E6E6)),
                  right: BorderSide(color: Color(0xFFE6E6E6)),
                  bottom: BorderSide(color: Color(0xFFE6E6E6)),
                );
              }

              if (index + 1 == roomLength) {
                borderSide = const Border(
                  bottom: BorderSide(color: Color(0xFFE6E6E6)),
                  left: BorderSide(color: Color(0xFFE6E6E6)),
                  right: BorderSide(color: Color(0xFFE6E6E6)),
                );
                borderRadius = BorderRadius.only(
                  bottomLeft: Radius.circular(10.spMin),
                  bottomRight: Radius.circular(10.spMin),
                );
              }
            }

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.spMin,
                vertical: 12.spMin,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: borderSide,
                borderRadius: borderRadius,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        AvatarWrapper<RoomCollection>(
                          key: ValueKey(room.widgetKey),
                          data: room,
                          radius: avatarHeight / 2,
                          borderColor: Colors.transparent,
                          showOnlineStatus: false,
                        ),
                        SizedBox(
                          width: 14.spMin,
                        ),
                        if (room.isDirect)
                          Expanded(
                            child: Text(
                              room.isRoomEmpty ? 'UNKNOWN'.tr : room.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textStyle,
                            ),
                          )
                        else
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    room.isRoomEmpty ? 'UNKNOWN'.tr : room.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: textStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.spMin,
                                ),
                                Text(
                                  '(${room.memberCount ?? 0})',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.spMin,
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () => controller.handleUnhide(room),
                    child: Text(
                      'unhide'.tr,
                      style: textStyle.copyWith(
                        fontSize: 12.spMin,
                        color: UTheme.color.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.spMin,
                  ),
                  ElevatedButton(
                    style: buttonStyle.copyWith(
                      backgroundColor: WidgetStateProperty.all(const Color(0xffFFEDEF)),
                    ),
                    onPressed: () => controller.handleDeleteRoom(room),
                    child: Text(
                      'delete'.tr,
                      style: textStyle.copyWith(
                        fontSize: 12.spMin,
                        color: const Color(0xFFFF1552),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: controller.rooms.length,
        ),
      );
    });
  }
}
