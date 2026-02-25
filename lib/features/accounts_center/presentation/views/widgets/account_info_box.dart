import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class AccountInfoBox extends StatelessWidget {
  final String avatarUrl;
  final String displayName;
  final bool isCurrentAccount;
  final Function onTapSwitchAccount;

  const AccountInfoBox({
    super.key,
    required this.avatarUrl,
    required this.displayName,
    required this.isCurrentAccount,
    required this.onTapSwitchAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        // TODO (design system) Update this when new design system is implemented.
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      ),
      padding: const EdgeInsets.only(
        left: AppSpace.space2,
        right: AppSpace.space4,
        top: AppSpace.space2,
        bottom: AppSpace.space2,
      ),
      child: Row(
        children: [
          Avatar(
            url: avatarUrl,
            radius: 24,
          ),
          const SizedBox(
            width: AppSpace.space4,
          ),
          Expanded(
            child: AppText.body3Bold(
              displayName,
              color: context.theme.appColors.textDarkest,
              textOverflow: TextOverflow.ellipsis,
              context: context,
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          if (isCurrentAccount)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                color: context.theme.appColors.borderLighter,
                border: Border.all(color: context.theme.appColors.border),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space3,
                vertical: AppSpace.space2,
              ),
              child: AppText.body4Bold(
                'Active'.tr,
                color: context.theme.appColors.textPrimary,
                context: context,
              ),
            )
          else
            GestureDetector(
              onTap: () {
                onTapSwitchAccount();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.space3,
                  vertical: AppSpace.space2,
                ),
                child: AppText.body3Bold(
                  'Use account'.tr,
                  color: context.theme.appColors.textPrimaryInverse,
                  context: context,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
