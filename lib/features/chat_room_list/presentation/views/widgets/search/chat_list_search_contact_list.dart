import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_touchable.dart';
import 'package:uchat/widgets/contacts/contact_list_item_touchable.dart';

class ChatListSearchContactList extends StatelessWidget {
  const ChatListSearchContactList({
    super.key,
    required this.contactList,
    required this.onTabItem,
    this.textHighlightStr,
    this.limitLength,
    this.heroTag,
  });

  final List<ContactSearchResultModel> contactList;
  final void Function(ContactSearchResultModel contact)? onTabItem;
  final String? textHighlightStr;
  final int? limitLength;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: (limitLength != null ? min(limitLength!, contactList.length) : contactList.length),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.19,
        ),
        child: const Divider(
          height: 1,
          color: Colors.grey,
          thickness: 0.3,
        ),
      ),
      itemBuilder: (context, index) {
        if (index == contactList.length) {
          return const SizedBox.shrink();
        }
        final data = contactList[index];
        if (data.contact != null) {
          return ContactListItemTouchable(
            heroTag: '${heroTag}_${data.contact?.id}',
            borderPadding: const EdgeInsets.all(0),
            data: data.contact!,
            onPressed: () {
              onTabItem?.call(data);
            },
            nameHighlightStr: textHighlightStr,
            customBackgroundColor: Colors.transparent,
            customTitleColor: context.theme.appColors.textDarkest,
          );
        } else if (data.room != null) {
          RoomSubscriptionCollection? roomSub = GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionWithRoomIdSync(
            data.room?.id ?? '',
          );

          return RoomListItemTouchable(
            borderPadding: const EdgeInsets.all(0),
            room: data.room!,
            roomSub: roomSub,
            onPressed: () {
              onTabItem?.call(data);
            },
            nameHighlightStr: textHighlightStr,
            showLastMessage: false,
            showUnreadCount: false,
            showFailMessageBadge: false,
            avatarHeight: 48.spMin,
            customIndent: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
            ),
            itemHeight: 60.spMin,
            isSearch: true,
            customBackgroundColor: Colors.transparent,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
