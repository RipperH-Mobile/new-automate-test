import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_pack_preview.dart';

class CategoryStickerStoreListView extends StatelessWidget {
  final StickerStoreTabCategory category;

  const CategoryStickerStoreListView({super.key, required this.category});

  String get id {
    switch (category) {
      case StickerStoreTabCategory.popular:
        return StickerStoreIds.popularStickerList;
      case StickerStoreTabCategory.recommended:
        return StickerStoreIds.recommendedStickerList;
      case StickerStoreTabCategory.free:
        return StickerStoreIds.freeStickerList;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StickerStoreController>(
      id: id,
      builder: (controller) {
        final scrollController = switch (category) {
          StickerStoreTabCategory.popular => controller.popularScrollController,
          StickerStoreTabCategory.recommended => controller.recommendedScrollController,
          StickerStoreTabCategory.free => controller.freeScrollController,
          _ => throw ArgumentError('Invalid category: $category'),
        };

        return ListView.builder(
          key: PageStorageKey('${category.name}_list_view'),
          controller: scrollController,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: AppSpace.space3),
          itemCount: controller.stickerCategoryMap[category]?.length ?? 0,
          itemBuilder: (context, index) {
            final stickerPack = controller.stickerCategoryMap[category]?.elementAtOrNull(index);
            if (stickerPack == null) {
              return const SizedBox.shrink();
            }

            return StickerPackPreview(
              pack: stickerPack,
              isVertical: false,
              onTap: () => controller.onGoToStickerDetail(stickerPackId: stickerPack.id),
            );
          },
        );
      },
    );
  }
}
