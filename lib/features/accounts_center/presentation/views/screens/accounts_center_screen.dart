import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/accounts_center_controller.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/accounts_center_list.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class AccountsCenterScreen extends GetView<AccountsCenterController> {
  const AccountsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Accounts Center'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        child: Column(
          children: [
            AppText.caption1(
              'Manage multiple accounts by adding other accounts you want to use, so you can access their profiles on the same device'
                  .tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
            const SizedBox(
              height: AppSpace.space3,
            ),
            Expanded(
              child: GetBuilder<AccountsCenterController>(
                id: AccountsCenterIds.accountsList,
                builder: (controller) {
                  return AccountsCenterList(
                    itemCount: controller.userList.length,
                    accountList: controller.userList,
                    onTapAddAccount: controller.onTapAddAccount,
                    onTapAccount: controller.onTapAccount,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
