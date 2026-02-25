import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/accounts_center_list.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/app_text.dart';

class QuickSwitchBottomSheet extends StatelessWidget {
  final int itemCount;
  final List<UserEntity> accountList;
  final Function onTapAddAccount;
  final Function onTapAccount;

  const QuickSwitchBottomSheet({
    super.key,
    required this.itemCount,
    required this.accountList,
    required this.onTapAddAccount,
    required this.onTapAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
        color: context.theme.appColors.elevationSurfaceDark,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
              bottom: AppSpace.space6,
            ),
            child: Container(
              width: 36,
              height: 5,
              decoration: ShapeDecoration(
                color: context.theme.appColors.iconLighter,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            child: AccountsCenterList(
              itemCount: itemCount,
              accountList: accountList,
              onTapAddAccount: onTapAddAccount,
              onTapAccount: onTapAccount,
              useShrinkWrap: true,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.accountsCenter);
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.appColors.buttonSecondary,
                borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
                border: Border.all(color: context.theme.appColors.border),
              ),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.space3,
                horizontal: AppSpace.space4,
              ),
              child: AppText.body3Bold(
                'Accounts Center'.tr,
                color: context.theme.appColors.textDarkest,
                textAlign: TextAlign.center,
                context: context,
              ),
            ),
          ),
          SizedBox(
            height: AppSpace.space2 + Get.mediaQuery.padding.bottom,
          ),
        ],
      ),
    );
  }
}
