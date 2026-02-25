import 'package:flutter/material.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/accounts_center_item.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class AccountsCenterList extends StatelessWidget {
  final int itemCount;
  final List<UserEntity> accountList;
  final Function onTapAddAccount;
  final Function onTapAccount;
  final bool useShrinkWrap;

  const AccountsCenterList({
    super.key,
    required this.itemCount,
    required this.accountList,
    required this.onTapAddAccount,
    required this.onTapAccount,
    this.useShrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return SettingFrameContainer.withLongList(
      // TODO (design system) Update this when new design system is implemented.
      // customBorderRadius: AppRadius.rounded4xl,
      dividerPadding: const EdgeInsets.only(
        // Padding on the left of avatar + size of avatar + space between avatar and text
        left: AppSpace.space2 + AccountsCenterItem.avatarRadius * 2 + AppSpace.space4,
      ),
      useShrinkWrap: useShrinkWrap,
      itemCount: itemCount + (itemCount < UChatConstant.loggedInAccountLimit ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == itemCount && itemCount < UChatConstant.loggedInAccountLimit) {
          return AccountsCenterItem.addAccount(context, onTapAddAccount);
        }

        final userData = accountList[index];

        return AccountsCenterItem(
          title: userData.displayName ?? '',
          avatarUrl: userData.avatarUrl,
          isCurrentAccount: UserController.instance.isCurrentUser(userData.id ?? ''),
          onTap: () {
            onTapAccount(userData);
          },
        );
      },
    );
  }
}
