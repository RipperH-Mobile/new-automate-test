import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uchat/widgets.dart';

class ContactListItemTouchable<M> extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final M data;
  final bool showStatusMessage;
  final String? heroTag;
  final List<Widget>? actions;
  final String? nameHighlightStr;
  final EdgeInsets? borderPadding;
  final Color? customBackgroundColor;
  final Color? customTitleColor;

  const ContactListItemTouchable({
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.data,
    this.showStatusMessage = true,
    this.heroTag,
    this.actions,
    this.nameHighlightStr,
    this.borderPadding,
    this.customBackgroundColor,
    this.customTitleColor,
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
      child: ContactListItem<M>(
        data: data,
        showStatusMessage: showStatusMessage,
        heroTag: heroTag,
        actions: actions,
        nameHighlightStr: nameHighlightStr,
        customBackgroundColor: customBackgroundColor,
        customNoHighlightTitleColor: customTitleColor,
      ),
    );
  }
}
