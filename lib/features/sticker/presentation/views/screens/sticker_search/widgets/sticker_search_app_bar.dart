import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_search_controller.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StickerSearchAppBar({super.key});

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
                  'Search'.tr,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.space2, horizontal: AppSpace.space4),
            child: GetBuilder<StickerSearchController>(
              builder: (ctl) {
                return AppSearchBox(
                  focusNode: ctl.searchFocusNode,
                  controller: ctl.searchTextController,
                  onChanged: ctl.onSearchTextChanged,
                  onTap: ctl.onTapSearchTextField,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);
}
