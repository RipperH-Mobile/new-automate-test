import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_item_touchable.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';

class CallLogListSection extends StatelessWidget {
  final List<CallLogWithContactEntity> callLogs;
  final List<Widget> Function(CallLogWithContactEntity)? secondaryActionsBuilder;
  final List<Widget> Function(CallLogWithContactEntity)? actionsBuilder;
  final void Function(BuildContext context, CallLogWithContactEntity currentData)? handleItemPressed;
  final String? nameHighlightStr;
  final bool? isChangeSize;

  const CallLogListSection({
    super.key,
    required this.callLogs,
    this.actionsBuilder,
    this.secondaryActionsBuilder,
    this.handleItemPressed,
    this.nameHighlightStr,
    this.isChangeSize,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final currentData = callLogs[index];
          final String id = currentData.id;

          final List<Widget> actions = actionsBuilder?.call(currentData) ?? [];
          final List<Widget> secondaryActions = secondaryActionsBuilder?.call(currentData) ?? [];

          // Calculate dynamic extentRatio for the end action pane.
          double? endExtentRatio;
          if (secondaryActions.isNotEmpty) {
            endExtentRatio = secondaryActions.length == 1 ? 0.2 : 0.4;
          }

          Widget listItem = UChatSlidableItem(
            groupTag: 'CallLogList',
            enableCloseListener: true,
            startActionPane: actions.isEmpty
                ? null
                : ActionPane(
                    extentRatio: 0.5,
                    motion: const DrawerMotion(),
                    children: actions,
                  ),
            endActionPane: secondaryActions.isEmpty
                ? null
                : ActionPane(
                    extentRatio: endExtentRatio!,
                    motion: const DrawerMotion(),
                    children: secondaryActions,
                  ),
            child: CallLogListItemTouchable(
              key: ValueKey(id),
              data: currentData,
              onPressed: () => handleItemPressed?.call(context, currentData),
              nameHighlightStr: nameHighlightStr,
              isChangeSize: isChangeSize,
            ),
          );

          return Column(
            children: [
              listItem,
              Padding(
                padding: EdgeInsets.only(left: isChangeSize == true ? Get.width * 0.19 : Get.width * 0.22),
                child: Divider(
                  height: AppSpace.spacePx,
                  thickness: AppSize.sizePx,
                  color: context.theme.appColors.borderDisable,
                ),
              ),
            ],
          );
        },
        childCount: callLogs.length,
      ),
    );
  }
}
