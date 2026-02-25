import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/category_sticker_store_list_view.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_store_app_bar.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/home_sticker_store_view.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class StickerStoreScreen extends GetView<StickerStoreController> {
  const StickerStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: const StickerStoreAppBar(),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: controller.storeTabController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  StickerStoreTabCategory.values.length,
                  (index) {
                    final category = StickerStoreTabCategory.values[index];
                    switch (category) {
                      case StickerStoreTabCategory.home:
                        return const HomeStickerStoreView();
                      case StickerStoreTabCategory.popular:
                        return const CategoryStickerStoreListView(
                          category: StickerStoreTabCategory.popular,
                        );
                      case StickerStoreTabCategory.recommended:
                        return const CategoryStickerStoreListView(
                          category: StickerStoreTabCategory.recommended,
                        );
                      case StickerStoreTabCategory.free:
                        return const CategoryStickerStoreListView(
                          category: StickerStoreTabCategory.free,
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
