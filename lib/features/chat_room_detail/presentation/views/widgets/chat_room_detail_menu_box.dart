import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';

class ChatRoomDetailMenuBox extends StatelessWidget {
  final List<Widget> children;

  const ChatRoomDetailMenuBox({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: children.isEmpty
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space2,
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
