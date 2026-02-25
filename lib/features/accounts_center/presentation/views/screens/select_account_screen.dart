import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/select_account_controller.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/accounts_center_list.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SelectAccountScreen extends GetView<SelectAccountController> {
  const SelectAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ScaffoldBasic(
        backgroundColor: context.theme.appColors.elevationSurfaceDark,
        appBar: AppBarDefault(
          title: 'Select Account'.tr,
          automaticallyImplyLeading: false,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
          child: Column(
            children: [
              AppText.caption1(
                'You have been logged out of the current account. Please select an account to continue'.tr,
                context: context,
                color: context.theme.appColors.textDark,
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              Expanded(
                child: GetBuilder<SelectAccountController>(
                  id: SelectAccountIds.accountsList,
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
      ),
    );
  }
}
