import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/central_notification/presentation/view/widgets/central_notification_list_item.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/image/uchat_icons.dart';

import '../../../domain/entities/central_notification_entity.dart';

class CentralNotificationListItemSlidable extends StatelessWidget {
  final CentralNotificationEntity centralNoti;
  final CentralNotiType notiType;
  final bool isOffline;
  final void Function() onJoinGroupInvite;
  final void Function() onAcceptFriendReq;
  final void Function() onApproveGroupReq;
  final Function(CentralNotificationEntity centralNoti)? onSelectNoti;
  final Function(CentralNotificationEntity centralNoti)? onDeleteNoti;

  const CentralNotificationListItemSlidable({
    super.key,
    required this.centralNoti,
    required this.notiType,
    required this.isOffline,
    required this.onJoinGroupInvite,
    required this.onAcceptFriendReq,
    required this.onApproveGroupReq,
    this.onDeleteNoti,
    this.onSelectNoti,
  });

  @override
  Widget build(BuildContext context) {
    return UChatSlidableItem(
      key: ValueKey(centralNoti.id),
      groupTag: 'CentralNotiListItem',
      enableCloseListener: true,
      disableSlidable: true,
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
          if (onDeleteNoti != null)
            SlidableAction(
              backgroundColor: UTheme.color.deleteIconBackgroundColor,
              foregroundColor: UTheme.color.onAccent,
              icon: UChatIcons.deleteIcon,
              label: 'Delete'.tr,
              onPressed: (BuildContext context) {
                onDeleteNoti?.call(centralNoti);
              },
            ),
        ],
      ),
      child: BasicTextButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Slidable.of(context)?.close();
          onSelectNoti?.call(centralNoti);
        },
        child: CentralNotificationListItem(
          key: key,
          centralNoti: centralNoti,
          notiType: notiType,
          isOffline: isOffline,
          onJoinGroupInvite: onJoinGroupInvite,
          onAcceptFriendReq: onAcceptFriendReq,
          onApproveGroupReq: onApproveGroupReq,
        ),
      ),
    );
  }
}
