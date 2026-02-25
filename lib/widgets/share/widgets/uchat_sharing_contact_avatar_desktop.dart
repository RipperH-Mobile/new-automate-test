import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/widgets.dart';

class UChatSharingContactAvatarDesktop<M> extends StatelessWidget {
  final bool isCheck;
  final M? data;
  final String displayName;
  final String avatar;
  final void Function()? onTap;
  final int maxLines;
  final double sizeFactor;
  final double coverSizeFactor;
  final bool showCloseIcon;
  final double elementNumber;
  // If true, Will build an empty SizedBox.
  final bool isInvisible;

  const UChatSharingContactAvatarDesktop({
    super.key,
    required this.isCheck,
    this.data,
    required this.displayName,
    required this.avatar,
    this.onTap,
    this.maxLines = 2,
    this.sizeFactor = 1,
    this.coverSizeFactor = 1.45,
    this.showCloseIcon = false,
    this.elementNumber = 4.0,
    this.isInvisible = false,
  });

  Widget avatarWidget() {
    final bool useGravatar;
    if (data is RoomCollection) {
      useGravatar = (data as RoomCollection).id == null;
      return AvatarWrapper<M>(
        data: data,
        useGravatar: useGravatar,
        radius: 25.spMin,
        onlineStatusSize: 8.spMin,
      );
    } else if (data is ContactInterface) {
      useGravatar = (data as ContactInterface).id == null;
      return AvatarWrapper<M>(
        data: data,
        useGravatar: useGravatar,
        radius: 25.spMin,
        onlineStatusSize: 8.spMin,
      );
    }

    return CircleAvatar(
      radius: 25.spMin,
      backgroundColor: const Color(0xFFE6E6E6),
      child: Text(
        avatar,
        style: TextStyle(
          fontSize: 10.spMin,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF4D4D4D),
        ),
      ),
    );
  }

  String get _name {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.name ?? '';
    } else if (data is RoomCollection) {
      final room = data as RoomCollection;
      return room.title;
    }
    return displayName;
  }

  @override
  Widget build(BuildContext context) {
    if (isInvisible) {
      return SizedBox(
        width: (Get.width / elementNumber) * 0.9 * sizeFactor * coverSizeFactor,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.spMin,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                avatarWidget(),
                showCloseIcon
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 20.spMin,
                          height: 20.spMin,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF1552),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                              size: 12.spMin,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            SizedBox(height: 4.spMin),
            Text(
              _name,
              style: TextStyle(
                color: const Color(0xFF4D4D4D),
                fontSize: 10.spMin,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
