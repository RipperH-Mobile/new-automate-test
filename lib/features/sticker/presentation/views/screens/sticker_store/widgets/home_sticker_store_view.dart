import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_store_preview_category.dart';

class HomeStickerStoreView extends StatelessWidget {
  const HomeStickerStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StickerStoreController>(
      id: StickerStoreIds.homeTabView,
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
            child: Column(
              children: List.generate(
                StickerStoreTabCategory.excludeHomeCategory.length,
                (index) {
                  final category = StickerStoreTabCategory.excludeHomeCategory[index];
                  return StickerStorePreviewCategory(
                    categoryName: category.translatedValue,
                    stickerPacks: controller.stickerCategoryMap[category]?.take(10).toList() ?? [],
                    onSeeAll: () {
                      controller.onSeeAllTab(category);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
