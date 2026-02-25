import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class SortingChoiceItem extends GetWidget<ChatListController> {
  final String title;
  final Widget icon;
  final ChatSortingType type;
  final bool showDivider;

  const SortingChoiceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.type,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.chatlistSorted, eventProperties: EventProperty.chatListSorted(type.displayName));

        /// For Chat Folder feature
        /// set sorting type to main [sortType] on [ChatListController]
        if (controller.chatFolderController.isEnabled) {
          controller.sortType.value = type;
        } else {
          controller.manageChatController.setSortingType(type);
        }

        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.appColors.backgroundNeutralLightestPressed,
            width: AppSpace.space05,
          ),
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: AppSpace.space4),
                  AppText.body1(
                    title,
                    context: context,
                  ),
                  const Spacer(),
                  buildChecked(context),
                ],
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: AppSpace.space14),
                child: Divider(
                  color: context.theme.appColors.border,
                  height: AppSpace.spacePx,
                  thickness: AppSpace.spacePx,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildChecked(BuildContext context) {
    return Obx(() {
      /// For Chat Folder feature
      /// check sorting value from main [sortType] on [ChatListController]
      if (controller.chatFolderController.isEnabled) {
        if (controller.sortType.value == type) {
          return Assets.vectors.iconCorrectBlue.svg();
        } else {
          return const SizedBox.shrink();
        }
      }

      /// For Chat Category feature
      /// check the value from [ManageChatController]
      if (controller.manageChatController.sortingType.value == type) {
        return Assets.vectors.iconCorrectBlue.svg();
      }

      return const SizedBox.shrink();
    });
  }
}
