import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/accounts_center_item.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class ExpiredAccountBottomSheet extends StatelessWidget {
  final List<UserEntity> expiredAccounts;
  final int expiredHiddenAccountCount;
  final Function onRemovePressed;

  const ExpiredAccountBottomSheet({
    super.key,
    required this.expiredAccounts,
    required this.expiredHiddenAccountCount,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    int listViewCount = expiredAccounts.length;
    if (expiredHiddenAccountCount > 0) {
      listViewCount += 1;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
        color: context.theme.appColors.elevationSurface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.space6,
              right: AppSpace.space6,
              top: AppSpace.space6,
            ),
            child: AppText.title2(
              'You cannot access @count account'.trPluralParams(
                'You cannot access @count accounts',
                expiredAccounts.length + expiredHiddenAccountCount,
                {'count': (expiredAccounts.length + expiredHiddenAccountCount).toString()},
              ),
              context: context,
              color: context.theme.appColors.textDarkest,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: AppSpace.space1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
            child: AppText.body2(
              'Due to your account being forced to sign out, you cannot access accounts',
              context: context,
              color: context.theme.appColors.textDark,
            ),
          ),
          const SizedBox(height: AppSpace.space4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
            child: SettingFrameContainer.withLongList(
              customBorderRadius: AppRadius.rounded4xl,
              dividerPadding: const EdgeInsets.only(
                // Padding on the left of avatar + size of avatar + space between avatar and text
                left: AppSpace.space2 + AccountsCenterItem.avatarRadius * 2 + AppSpace.space4,
              ),
              customDividerColor: const Color(0xFFCACACE),
              // TODO (design system) Update this when new design system is implemented.
              customBackgroundColor: const Color(0xFFE9E9EB),
              // TODO (design system) Update this when new design system is implemented.
              useShrinkWrap: true,
              itemCount: listViewCount,
              itemBuilder: (BuildContext context, int index) {
                if (index == expiredAccounts.length && expiredHiddenAccountCount > 0) {
                  final String moreAccountText;
                  if (expiredAccounts.isNotEmpty) {
                    moreAccountText = 'and @count account'.trPluralParams(
                      'and @count accounts',
                      expiredHiddenAccountCount,
                      {'count': expiredHiddenAccountCount.toString()},
                    );
                  } else {
                    moreAccountText = '@count account'.trPluralParams(
                      '@count accounts',
                      expiredHiddenAccountCount,
                      {'count': expiredHiddenAccountCount.toString()},
                    );
                  }
                  return AccountsCenterItem(
                    title: moreAccountText,
                    customAvatar: Assets.vectors.defaultAvatar.svg(),
                    hideArrowIcon: true,
                    customBackgroundColor: const Color(
                        0xFFE9E9EB), // TODO (design system) Update this when new design system is implemented.
                  );
                }
                final userData = expiredAccounts[index];

                return AccountsCenterItem(
                  title: userData.displayName ?? '',
                  avatarUrl: userData.avatarUrl,
                  isCurrentAccount: UserController.instance.isCurrentUser(userData.id ?? ''),
                  hideArrowIcon: true,
                  customBackgroundColor: const Color(
                      0xFFE9E9EB), // TODO (design system) Update this when new design system is implemented.
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              onRemovePressed();
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.appColors.buttonError,
                borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
                border: Border.all(color: context.theme.appColors.border),
              ),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.space3,
                horizontal: AppSpace.space4,
              ),
              child: AppText.body2Bold(
                'Remove all from list'.tr,
                color: context.theme.appColors.textPrimaryInverse,
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
