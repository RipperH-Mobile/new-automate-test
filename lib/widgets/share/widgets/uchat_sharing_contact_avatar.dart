import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets.dart';

class UChatSharingContactAvatar<M> extends StatelessWidget {
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

  const UChatSharingContactAvatar({
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
        radius: (75 / 2).spMin,
        onlineStatusSize: 8.spMin,
      );
    } else if (data is ContactInterface) {
      useGravatar = (data as ContactInterface).id == null;
      return AvatarWrapper<M>(
        data: data,
        useGravatar: useGravatar,
        radius: (75 / 2).spMin,
        onlineStatusSize: 8.spMin,
      );
    }

    return CircleAvatar(
      radius: (75 / 2).spMin,
      backgroundColor: const Color(0xFFE6E6E6),
      child: Text(
        avatar,
        style: TextStyle(
          fontSize: 15.spMin,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF808080),
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      _name,
      style: TextStyle(
        color: UTheme.color.contactItemTitle,
        fontSize: 14.spMin,
        height: 1.5,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: TextAlign.center,
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
      child: SizedBox(
        width: (Get.width / elementNumber) * 0.9 * sizeFactor * coverSizeFactor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 56.spMin,
                  width: 56.spMin,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    fit: StackFit.passthrough,
                    children: [
                      avatarWidget(),
                      isCheck
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 56.spMin,
                                height: 56.spMin,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: UTheme.color.primary.withValues(alpha: 0.7),
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 35.spMin,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.spMin,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _buildName(context),
                  ),
                ),
              ],
            ),
            showCloseIcon
                ? Positioned(
                    top: 0,
                    right: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
