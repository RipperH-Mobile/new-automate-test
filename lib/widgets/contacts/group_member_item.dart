import 'package:flutter/material.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class GroupMemberItem extends StatelessWidget {
  final ContactInterface contact;

  const GroupMemberItem({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: <Widget>[
          AvatarWrapper<ContactInterface>(
            data: contact,
            radius: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
