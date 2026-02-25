import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_touchable.dart';

class ChatListSearchRoomMessageList extends StatelessWidget {
  const ChatListSearchRoomMessageList({
    super.key,
    required this.roomMessageList,
    required this.onTabItem,
    this.textHighlightStr,
    this.limitLength,
  });

  final List<SearchMessagesResultModel> roomMessageList;
  final void Function(SearchMessagesResultModel contact)? onTabItem;
  final String? textHighlightStr;
  final int? limitLength;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: (limitLength != null ? min(limitLength!, roomMessageList.length) : roomMessageList.length),
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
        if (index == roomMessageList.length) {
          return const SizedBox();
        }
        SearchMessagesResultModel data = roomMessageList[index];
        // TODO There has to be a better way than query room sub here. Improve this later.
        RoomSubscriptionCollection? roomSub = GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionWithRoomIdSync(
          data.room.id ?? '',
        );
        return RoomListItemTouchable(
          borderPadding: const EdgeInsets.all(0),
          room: data.room,
          roomSub: roomSub,
          onPressed: () {
            onTabItem?.call(data);
          },
          customSubtitle: 'Found @count message@s'.trParams({
            'count': data.foundMessageCount.toString(),
            's': data.foundMessageCount > 1 ? 's' : '',
          }),
          showUnreadCount: false,
          showLastMessage: false,
          showFailMessageBadge: false,
          avatarHeight: 48.spMin,
          customIndent: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
          ),
          itemHeight: 60.spMin,
          isSearch: true,
          customBackgroundColor: Colors.transparent,
        );
      },
    );
  }
}
