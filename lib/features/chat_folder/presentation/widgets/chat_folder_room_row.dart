import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/widgets.dart';

class ChatFolderRoomRow extends StatelessWidget {
  final List<RoomContactModel> rooms;
  final Function(RoomContactModel room) onRemoveRoom;

  const ChatFolderRoomRow({
    super.key,
    required this.rooms,
    required this.onRemoveRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rooms.length, (index) {
        final room = rooms[index];

        late Widget avatar;
        if (room.data is RoomInterface) {
          final roomData = room.data as RoomInterface;
          avatar = AvatarWrapper<RoomInterface>(
            key: ValueKey(roomData.id),
            data: roomData,
            radius: 25.spMin,
            borderColor: Colors.transparent,
            showOnlineStatus: false,
          );
        } else if (room.data is ContactInterface) {
          final contact = room.data as ContactInterface;
          avatar = AvatarWrapper<ContactInterface>(
            key: ValueKey(contact.id),
            data: contact,
            radius: 25.spMin,
            borderColor: Colors.transparent,
            showOnlineStatus: false,
          );
        }

        String title = room.name ?? '';
        if (room.isGroup) {
          final groupRoomData = room.data as RoomInterface;
          title = '$title (${groupRoomData.memberCount})';
        }

        return UChatRowMenu(
          title: title,
          titleTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4D4D4D),
          ),
          showArrow: false,
          height: 75.spMin,
          prefixWidget: avatar,
          prefixWidgetSize: 55.spMin,
          hasBottomBorder: true,
          suffixWidget: GestureDetector(
            onTap: () => onRemoveRoom(room),
            child: Container(
              width: 30.spMin,
              height: 30.spMin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xFFFF1552),
              ),
              child: const Icon(
                Icons.remove_rounded,
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
