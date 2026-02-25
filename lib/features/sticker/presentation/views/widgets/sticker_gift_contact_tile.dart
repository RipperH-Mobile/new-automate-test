import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/contact_tile.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class StickerGiftContactTile extends StatelessWidget {
  final ContactEntity contact;
  final Function onTap;

  const StickerGiftContactTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ContactTile(
      onTap: onTap,
      name: contact.name ?? '',
      subtitle: contact.statusMessage,
      avatarUrl: contact.avatarUrl,
      showCheckBox: false,
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
    );
  }
}
