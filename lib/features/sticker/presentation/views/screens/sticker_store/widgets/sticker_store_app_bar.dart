import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerStoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StickerStoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: Get.back,
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      const Set<WidgetState> interactiveStates = <WidgetState>{
                        WidgetState.pressed,
                        WidgetState.hovered,
                        WidgetState.focused,
                      };
                      if (states.any(interactiveStates.contains)) {
                        return Colors.black.withValues(alpha: 0.4);
                      }

                      return const Color(0xFFC4C4C4);
                    }),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSpace.space2.horizontalSpace,
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: context.theme.appColors.iconPrimary,
                      ),
                      AppSpace.space2.horizontalSpace,
                      AppText.button1(
                        'Back'.tr,
                        context: context,
                        color: context.theme.appColors.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
                child: AppText.title2(
                  'Sticker Store'.tr,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GetBuilder<StickerStoreController>(
                  builder: (controller) {
                    return IconButton(
                      onPressed: controller.onGoToStickerSetting,
                      icon: Assets.vectors.iconSetting.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.textDarkest,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          AppSpace.space2.verticalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpace.space2.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                child: GetBuilder<StickerStoreController>(
                  builder: (ctl) {
                    return GestureDetector(
                      onTap: ctl.onGoToSearchScreen,
                      child: const AppSearchBox(enabled: false),
                    );
                  },
                ),
              ),
              AppSpace.space4.verticalSpace,
              GetBuilder<StickerStoreController>(
                id: StickerStoreIds.tabBar,
                builder: (controller) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: controller.storeTabController,
                      isScrollable: true,
                      labelColor: context.theme.appColors.textDarkest,
                      indicatorColor: context.theme.appColors.textDarkest,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelPadding: const EdgeInsets.only(right: AppSpace.space4),
                      labelStyle: context.theme.appTexts.button2Bold,
                      unselectedLabelColor: context.theme.appColors.textLighter,
                      indicatorWeight: 1.5,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                      tabAlignment: TabAlignment.start,
                      onTap: controller.onTabChanged,
                      tabs: StickerStoreTabCategory.values.map((category) => Tab(text: category.value.tr)).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: context.theme.appColors.borderMenu,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 115);
}
