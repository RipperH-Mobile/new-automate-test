import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/widgets/sticker_item_preview_grid.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/widgets/sticker_pack_detail_app_bar.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/widgets/sticker_pack_detail_header.dart';
import 'package:uchat/widgets.dart';

class StickerPackDetailScreen extends GetView<StickerPackDetailController> {
  final String? stickerPackId;

  @override
  String? get tag => stickerPackId ?? Get.parameters['stickerPackId'];

  const StickerPackDetailScreen({
    super.key,
    this.stickerPackId,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.white,
      appBar: const StickerPackDetailAppBar(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StickerPackDetailHeader(
              stickerPackId: stickerPackId ?? Get.parameters['stickerPackId'] ?? '',
            ),
            Divider(
              thickness: 1.0,
              height: AppSpace.space3,
              color: context.theme.appColors.border,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
              child: StickerItemPreviewGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
