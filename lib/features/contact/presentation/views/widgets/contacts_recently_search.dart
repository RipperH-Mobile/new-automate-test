import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_model.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_search_screen_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/contacts/contact_list_item_touchable.dart';

class ContactsRecentlySearch extends StatelessWidget {
  const ContactsRecentlySearch({
    super.key,
    required this.recentList,
    this.onTabItem,
    this.onRemoveItem,
    this.onClearRecentSearch,
    this.textHighlightStr,
  });

  final List<RecentSearchModel> recentList;
  final void Function(RecentSearchModel recentItem)? onTabItem;
  final void Function(RecentSearchModel recentItem)? onRemoveItem;
  final void Function()? onClearRecentSearch;
  final String? textHighlightStr;

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
        itemCount: recentList.length + 1,
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
          if (index == recentList.length) {
            return const SizedBox();
          }
          final recentItem = recentList[index];
          // Set a key based on unique id (room id for groups, contact id for direct chats)
          // so that Flutter can efficiently update only the changed widgets
          final itemKey = recentItem.room.isGroup ? ValueKey(recentItem.room.id) : ValueKey(recentItem.contact.id);

          if (recentItem.room.isGroup) {
            return ContactListItemTouchable<RoomCollection>(
              key: itemKey,
              borderPadding: const EdgeInsets.all(0),
              data: recentItem.room,
              heroTag: 'recent_${recentItem.room.id}',
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
            // Direct chat: pass the contact to ContactListItemTouchable with the generic type ContactInterface.
            return ContactListItemTouchable<ContactInterface>(
              key: itemKey,
              borderPadding: const EdgeInsets.all(0),
              data: recentItem.contact,
              heroTag: 'recent_${recentItem.contact.id}',
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
            AppText.body3Bold(
              'Recent searches'.tr,
              context: context,
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
