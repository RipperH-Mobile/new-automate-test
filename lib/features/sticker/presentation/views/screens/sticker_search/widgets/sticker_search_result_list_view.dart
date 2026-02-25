import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_tab.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_search_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_pack_preview.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerSearchResultListView extends StatelessWidget {
  final StickerSearchTab tab;

  const StickerSearchResultListView({super.key, required this.tab});

  String get id {
    switch (tab) {
      case StickerSearchTab.all:
        return StickerSearchIds.allTabView;
      case StickerSearchTab.character:
        return StickerSearchIds.characterTabView;
      case StickerSearchTab.creator:
        return StickerSearchIds.creatorTabView;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StickerSearchController>(
      id: id,
      builder: (ctl) {
        if (ctl.isLoadingNewSearch) {
          return Center(
            child: SizedBox(
              width: 24.w,
              height: 24.w,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final stickers = switch (tab) {
          StickerSearchTab.all => ctl.allStickers,
          StickerSearchTab.character => ctl.characterStickers,
          StickerSearchTab.creator => ctl.creatorStickers,
        };

        if (stickers.isEmpty && ctl.searchTextController.text.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.body2Bold(
                    'No results found'.tr,
                    context: context,
                    textAlign: TextAlign.center,
                    color: context.theme.appColors.textDark,
                  ),
                  AppSpace.space05.verticalSpace,
                  AppText.body4(
                    'Please try searching again with different keywords or check your spelling'.tr,
                    context: context,
                    textAlign: TextAlign.center,
                    color: context.theme.appColors.textLight,
                  ),
                ],
              ),
            ),
          );
        }

        final scrollController = switch (tab) {
          StickerSearchTab.all => ctl.allScrollController,
          StickerSearchTab.character => ctl.characterScrollController,
          StickerSearchTab.creator => ctl.creatorScrollController,
        };
        return ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: stickers.length,
          itemBuilder: (context, index) {
            final stickerPack = stickers.elementAt(index);
            return StickerPackPreview(
              pack: stickerPack,
              isVertical: false,
              onTap: () => ctl.onGoToStickerDetail(stickerPack: stickerPack),
            );
          },
        );
      },
    );
  }
}
