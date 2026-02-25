import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_search_screen_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/contacts/contact_list_item_touchable.dart';

class ChatListRecentlySearch extends StatelessWidget {
  final List<RecentSearchCollection> recentList;
  final void Function(RecentSearchCollection recentItem)? onTabItem;
  final void Function(RecentSearchCollection recentItem)? onRemoveItem;
  final void Function()? onClearRecentSearch;
  final String? textHighlightStr;
  final int? limitLength;

  const ChatListRecentlySearch({
    super.key,
    required this.recentList,
    this.onTabItem,
    this.onRemoveItem,
    this.onClearRecentSearch,
    this.textHighlightStr,
    this.limitLength,
  });

  ContactsSearchScreenController get controller => Get.find<ContactsSearchScreenController>();

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        _buildRecentListHeader(context),
        _buildRecentList(context),
      ],
    );
  }

  Widget _buildRecentList(BuildContext context) {
    return Obx(
      () => SliverList.separated(
        itemCount: (limitLength != null ? min(limitLength!, recentList.length) : recentList.length),
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.19,
          ),
          child: Divider(
            height: AppSpace.spacePx,
            color: context.theme.appColors.borderDisable,
            thickness: AppSize.sizePx,
          ),
        ),
        itemBuilder: (context, index) {
          final recentItem = recentList[index];
          // Set a key based on unique id
          // so that Flutter can efficiently update only the changed widgets
          final itemKey = ValueKey(recentItem.id);
          final searchType = recentItem.type;

          if (searchType == RecentSearchType.room) {
            final room = recentItem.room;

            if (room != null && room.isGroup == true) {
              return ContactListItemTouchable<RoomCollection>(
                key: itemKey,
                borderPadding: const EdgeInsets.all(0),
                data: room.toCollection(),
                heroTag: 'recent_${room.id}',
                onPressed: () {
                  onTabItem?.call(recentItem);
                },
                actions: [
                  IconButton(
                    onPressed: () {
                      onRemoveItem?.call(recentItem);
                    },
                    icon: _buildAction(context),
                  )
                ],
              );
            } else if (recentItem.contact case final contact?) {
              return ContactListItemTouchable<ContactInterface>(
                key: itemKey,
                borderPadding: const EdgeInsets.all(0),
                data: contact,
                heroTag: 'recent_${contact.id}',
                onPressed: () {
                  onTabItem?.call(recentItem);
                },
                actions: [
                  IconButton(
                    onPressed: () {
                      onRemoveItem?.call(recentItem);
                    },
                    icon: _buildAction(context),
                  )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return ContactListItemTouchable<RecentSearchCollection>(
              key: itemKey,
              borderPadding: const EdgeInsets.all(0),
              data: recentItem,
              heroTag: 'recent_${recentItem.id}',
              onPressed: () {
                onTabItem?.call(recentItem);
              },
              actions: [
                IconButton(
                  onPressed: () {
                    onRemoveItem?.call(recentItem);
                  },
                  icon: _buildAction(context),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildRecentListHeader(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppText.body3Bold(
                  'Recent searches'.tr,
                  context: context,
                ),
                const SizedBox(width: AppSpace.space1),
                AppText.body3Bold(
                  '${recentList.length}',
                  context: Get.context!,
                  color: Get.context!.theme.appColors.textLighter,
                )
              ],
            ),
            TextButton(
              onPressed: () {
                onClearRecentSearch?.call();
              },
              child: AppText.body3Bold(
                'Clear all'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppSpace.space3),
      child: Assets.vectors.circleCloseIcon.svg(),
    );
  }
}
