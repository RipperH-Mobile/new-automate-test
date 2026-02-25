import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class ContactItem extends StatefulWidget {
  final String title;
  final String contactId;
  final String avatarUrl;
  // hasAvatar is unused in this widget but keep it for now just in case ?
  final bool hasAvatar;
  final String? avatarText;
  final Function? onDeleteMember;
  final bool showDeleteButton;

  const ContactItem({
    super.key,
    required this.title,
    required this.contactId,
    required this.avatarUrl,
    required this.hasAvatar,
    this.avatarText,
    this.onDeleteMember,
    this.showDeleteButton = true,
  });

  @override
  ContactItemState createState() => ContactItemState();
}

class ContactItemState extends State<ContactItem> {
  bool isSelected = false;

  ContactItemState() : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: AppSize.size16,
          child: Column(
            children: <Widget>[
              Avatar(
                radius: 32.spMin,
                avatarText: widget.avatarText,
                url: widget.avatarUrl,
                borderColor: Colors.transparent,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: AppSpace.space015,
                    ),
                    AppText.body4(
                      widget.title,
                      context: context,
                      textOverflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.showDeleteButton)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (widget.onDeleteMember != null) widget.onDeleteMember!();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSpace.space4,
                  bottom: AppSpace.space4,
                ),
                child: SizedBox(
                  height: 22.spMin,
                  width: 22.spMin,
                  child: Image.asset(
                    'assets/images/v2/clear_icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
