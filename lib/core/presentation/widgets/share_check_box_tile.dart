import 'package:flutter/material.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/core/presentation/widgets/contact_tile.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class ShareCheckBoxTile extends StatelessWidget {
  /// Room data, All data needed to display in ui should be in here.
  final ShareTargetEntity target;
  final bool isSelected;
  final Function onTap;
  final Function(bool?) onChanged;

  const ShareCheckBoxTile({
    super.key,
    required this.target,
    required this.isSelected,
    required this.onTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ContactTile(
        isSelected: isSelected,
        onTap: onTap,
        onChanged: onChanged,
        name: target.name,
        subtitle: target.status,
        avatarUrl: target.avatarUrl,
        leadingWidget: target.isOa == true
            ? Row(
                children: [
                  Assets.vectors.iconOfficialAccount.svg(),
                  const SizedBox(width: AppSpace.space2),
                ],
              )
            : null,
        trailingWidget: target.groupMemberCount != null
            ? AppText.body3Bold(
                ' (${target.groupMemberCount})',
                context: context,
              )
            : null);
  }
}
