import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(
              left: AppSpace.space20,
              right: AppSpace.space4,
              bottom: AppSpace.space4,
            ),
            padding: const EdgeInsets.all(AppSpace.space4),
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundPopUp,
              borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
              boxShadow: [
                BoxShadow(
                  color: context.theme.appColors.textLightest,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpace.space2,
              children: [
                GestureDetector(
                  onTap: () {
                    GetIt.I<TaxonomyService>().sendEvent(
                      EventName.clickProfileSettingPage,
                    );
                    Get.toNamed(Routes.myProfile);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightestPressed,
                      borderRadius: BorderRadius.circular(AppSpace.space4),
                    ),
                    child: Obx(() {
                      final currentUser = UserController.instance.currentUser();
                      final displayName = currentUser?.displayName ?? '';
                      final statusMessage = currentUser?.statusMessage ?? '';

                      return ListTile(
                        leading: Avatar(
                          radius: 20,
                          url: currentUser?.toContact().avatarUrl,
                        ),
                        title: AppText.subtitle1(
                          displayName,
                          context: context,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        subtitle: statusMessage.isNotEmpty
                            ? AppText.body4(
                                statusMessage,
                                context: context,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              )
                            : null,
                        trailing: Assets.vectors.iconArrowBackIos.svg(),
                      );
                    }),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          GetIt.I<TaxonomyService>().sendEvent(EventName.clickStickerSettingPage);
                          Get.toNamed(Routes.stickerStore);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                          decoration: BoxDecoration(
                            color: context.theme.appColors.backgroundNeutralLightestPressed,
                            borderRadius: BorderRadius.circular(AppSpace.space4),
                          ),
                          child: Column(
                            children: [
                              Assets.vectors.iconUchatSticker.svg(),
                              const SizedBox(height: AppSpace.space2),
                              AppText.body3Bold(
                                'Sticker'.tr,
                                context: context,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          GetIt.I<TaxonomyService>().sendEvent(EventName.clickCoinSettingPage);
                          Get.toNamed(Routes.coinStore);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                          decoration: BoxDecoration(
                            color: context.theme.appColors.backgroundNeutralLightestPressed,
                            borderRadius: BorderRadius.circular(AppSpace.space4),
                          ),
                          child: Column(
                            children: [
                              Assets.vectors.iconUchatCoin.svg(),
                              const SizedBox(height: AppSpace.space2),
                              AppText.body3Bold(
                                'Coin'.tr,
                                context: context,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildMenuItem(
                  Assets.vectors.iconAccountSetting.svg(),
                  'Accounts Center'.tr,
                  Routes.accountsCenter,
                  context,
                  EventName.clickAccountsCenterPage,
                ),
                _buildMenuItem(Assets.vectors.iconFriendCallSetting.svg(), 'Friends Chat and Call'.tr,
                    Routes.settingFriendChatCall, context, EventName.clickChatAndCallSettingPage),
                _buildMenuItem(Assets.vectors.iconSetting.svg(), 'Settings'.tr, Routes.setting, context,
                    EventName.clickSettingsSettingPage),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(Widget icon, String text, String routes, BuildContext context, EventName eventName) {
    return GestureDetector(
      onTap: () {
        GetIt.I<TaxonomyService>().sendEvent(
          eventName,
        );
        Get.toNamed(routes);
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightestPressed,
          borderRadius: BorderRadius.circular(AppSpace.space4),
        ),
        child: ListTile(
          minLeadingWidth: 0,
          leading: icon,
          title: AppText.body3Bold(
            text,
            context: context,
          ),
          trailing: Assets.vectors.iconArrowBackIos.svg(),
        ),
      ),
    );
  }
}
