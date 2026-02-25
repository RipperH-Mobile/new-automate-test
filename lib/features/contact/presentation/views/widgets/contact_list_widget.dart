import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';
import 'package:uchat/widgets.dart';

class ContactListWidget<M> extends StatelessWidget {
  final List<M> sectionDataList;
  final int? maxItems;
  final List<Widget> Function(M)? secondaryActionsBuilder;
  final List<Widget> Function(M)? actionsBuilder;
  final void Function(BuildContext context, M currentData)? handleItemPressed;
  final void Function(BuildContext context, M currentData)? onLongPress;
  final String? nameHighlightStr;
  final List<Widget>? actionsTailing;
  final List<Widget> Function(M currentData)? actionsTailingBuilder;
  final String contactType;

  const ContactListWidget({
    super.key,
    required this.sectionDataList,
    required this.contactType,
    this.maxItems,
    this.actionsBuilder,
    this.secondaryActionsBuilder,
    this.handleItemPressed,
    this.onLongPress,
    this.nameHighlightStr,
    this.actionsTailing,
    this.actionsTailingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final int itemCount = maxItems != null ? min(sectionDataList.length, maxItems!) : sectionDataList.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final currentData = sectionDataList[index];
          if (currentData == null) {
            return const SizedBox.shrink();
          }

          String? heroTag;
          String? id;
          if (currentData is ContactInterface) {
            heroTag = 'hold_contact_with_menu_hero-${currentData.id}';
            id = currentData.id;
          } else if (currentData is RoomDataModel) {
            heroTag = 'hold_room_with_menu_hero-${currentData.id}';
            id = currentData.id;
          } else if (currentData is RoomCollection) {
            heroTag = 'hold_room_with_menu_hero-${currentData.id}';
            id = currentData.id;
          }

          List<Widget> actions = <Widget>[];
          if (actionsBuilder != null) {
            actions = actionsBuilder!(currentData);
          }

          List<Widget> secondaryActions = <Widget>[];
          if (secondaryActionsBuilder != null) {
            secondaryActions = secondaryActionsBuilder!(currentData);
          }

          // Calculate dynamic extentRatio for the end action pane.
          double? endExtentRatio;
          if (secondaryActions.isNotEmpty) {
            endExtentRatio = secondaryActions.length == 1 ? 0.2 : 0.4;
          }

          Widget listItem = UChatSlidableItem(
            groupTag: 'ContactSliverList',
            onActionPaneOpenChanged: (itemId, isOpen) async {
              if (isOpen) {
                GetIt.I<TaxonomyService>().sendEvent(
                  EventName.swipeContactPage,
                  eventProperties: EventProperty.clickContact(
                    contactType: contactType,
                  ),
                );
              }
            },
            enableCloseListener: true,
            startActionPane: (actions.isEmpty)
                ? null
                : ActionPane(
                    extentRatio: 0.5,
                    motion: const DrawerMotion(),
                    children: actions,
                  ),
            endActionPane: (secondaryActions.isEmpty)
                ? null
                : ActionPane(
                    extentRatio: endExtentRatio!,
                    motion: const DrawerMotion(),
                    children: secondaryActions,
                  ),
            child: ContactListItemTouchable<M>(
              key: ValueKey(id),
              data: currentData,
              heroTag: heroTag,
              onPressed: () => handleItemPressed?.call(context, currentData),
              onLongPress: () => onLongPress?.call(context, currentData),
              nameHighlightStr: nameHighlightStr,
              customBackgroundColor: context.theme.appColors.backgroundNeutralLighter,
              actions: actionsTailing ?? actionsTailingBuilder?.call(currentData),
              borderPadding: const EdgeInsets.symmetric(horizontal: AppSpace.space0),
            ),
          );

          return Column(
            children: [
              listItem,
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.19),
                child: Divider(
                  height: AppSpace.spacePx,
                  thickness: AppSize.sizePx,
                  color: context.theme.appColors.borderDisable,
                ),
              ),
            ],
          );
        },
        childCount: itemCount,
      ),
    );
  }
}
