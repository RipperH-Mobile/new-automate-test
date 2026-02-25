import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/utils/styles.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class ContactListCheckBoxItem extends StatefulWidget {
  final String title;
  final String contactId;
  final String statusMessage;
  final String avatarUrl;
  // hasAvatar in this widget is unused but keep it for now just in case ?
  final bool hasAvatar;
  final String? avatarText;
  final Function onChanged;
  final bool isSelected;

  const ContactListCheckBoxItem({
    super.key,
    required this.title,
    required this.contactId,
    required this.statusMessage,
    required this.avatarUrl,
    required this.hasAvatar,
    required this.onChanged,
    required this.isSelected,
    this.avatarText,
  });

  @override
  ContactListCheckBoxItemState createState() => ContactListCheckBoxItemState();
}

class ContactListCheckBoxItemState extends State<ContactListCheckBoxItem> {
  ContactListCheckBoxItemState() : super();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
      onPressed: () {
        widget.onChanged();
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Transform.scale(
              scale: 0.8,
              child: RoundCheckBox(
                onTap: (value) {
                  widget.onChanged();
                },
                checkedColor: colorPrimary,
                isChecked: widget.isSelected,
              ),
            ),
            const SizedBox(width: 8),
            Avatar(
              radius: 24,
              avatarText: widget.avatarText,
              url: widget.avatarUrl,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: widget.statusMessage.isEmpty ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  widget.statusMessage != ''
                      ? Text(
                          widget.statusMessage,
                          style: const TextStyle(
                            color: colorStatusMessage,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
