import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/presentation/views/widgets/call_log_list_item.dart';
import 'package:uchat/widgets.dart';

class CallLogListItemTouchable extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final CallLogWithContactEntity data;
  final List<Widget>? actions;
  final String? nameHighlightStr;
  final EdgeInsets? borderPadding;
  final Color? customBackgroundColor;
  final bool? isChangeSize;

  const CallLogListItemTouchable({
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.data,
    this.actions,
    this.nameHighlightStr,
    this.borderPadding,
    this.customBackgroundColor,
    this.isChangeSize,
  });

  @override
  Widget build(BuildContext context) {
    return BasicTextButton(
      padding: borderPadding,
      onPressed: () {
        Slidable.of(context)?.close();
        onPressed?.call();
      },
      onLongPress: onLongPress,
      child: CallLogListItem(
        data: data,
        actions: actions,
        nameHighlightStr: nameHighlightStr,
        customBackgroundColor: customBackgroundColor,
        isChangeSize: isChangeSize,
      ),
    );
  }
}
