import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets.dart';

class RoomMemberAvatarRow extends StatelessWidget {
  final List<RoomMemberCollection> members;
  final int maxDisplayCount;
  final TextDirection direction;

  const RoomMemberAvatarRow({
    super.key,
    required this.members,
    this.maxDisplayCount = 8,
    this.direction = TextDirection.rtl,
  });

  bool whereToPutNumber(int index) {
    return direction == TextDirection.rtl
        ? index == 0 && members.length > maxDisplayCount
        : index == maxDisplayCount - 1 && members.length > maxDisplayCount;
  }

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const SizedBox.shrink();
    }

    List<Widget> avatars = [];
    for (var i = 0; i < maxDisplayCount; i++) {
      if (i >= members.length) {
        break;
      }

      final member = members[i];
      final account = member.account;
      final accountId = member.accountId;

      final imageUrl = account != null
          ? AccountService().getUserPublicAvatar(account.id!)
          : AccountService().getUserPublicAvatar(accountId!);

      final avatarWidget = AvatarWrapper(
        radius: 16.spMin,
        imageUrl: imageUrl,
        id: accountId,
      );

      if (whereToPutNumber(i)) {
        avatars.add(
          Align(
            alignment: Alignment.center,
            widthFactor: 0.7,
            child: Stack(
              children: [
                avatarWidget,
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        '+${members.length - maxDisplayCount}',
                        style: UTheme.textTheme.profileRoomMemberPlus.copyWith(
                          color: UTheme.color.onProfileScreen,
                          fontSize: (members.length > 99) ? 8 : 12,
                          height: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        avatars.add(
          Align(
            alignment: Alignment.center,
            widthFactor: 0.7,
            child: avatarWidget,
          ),
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: direction,
          children: avatars,
        ),
      ],
    );
  }
}
