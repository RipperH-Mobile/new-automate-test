import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu_widget_expanded.dart' as custom_context_menu;
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/services/sticker_animation_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_custom_input.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_context_menu.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerInputSelectionList extends StatelessWidget {
  const StickerInputSelectionList({
    super.key,
    required this.index,
    required this.scrollController,
    required this.onSelect,
    required this.onDownloadSticker,
    this.stickerItems = const [],
    this.packId,
    this.isDownloaded = false,
    this.bottomPadding = 0,
    this.warMode = false,
    this.onSendSticker,
  });

  final int index;
  final List<StickerEntity> stickerItems;
  final ScrollController scrollController;
  final Function(String packId, String fileId) onSelect;
  final Function(StickerSendingEntity)? onSendSticker;
  final VoidCallback onDownloadSticker;
  final String? packId;
  final bool isDownloaded;
  final double bottomPadding;

  final double _stickerSize = 96;
  final bool? warMode;

  @override
  Widget build(BuildContext context) {
    if (!isDownloaded) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppRadius.roundedLg,
            ),
            border: Border.all(
              color: context.theme.appColors.textPrimary,
            ),
          ),
          margin: EdgeInsets.only(
            bottom: bottomPadding,
          ),
          child: TextButton(
            onPressed: onDownloadSticker,
            child: AppText.body2(
              'Download stickers'.tr,
              color: context.theme.appColors.textPrimary,
              context: context,
            ),
          ),
        ),
      );
    }

    return StickerGridView(
      key: index == 0 ? const ValueKey('sticker-recently-used') : ValueKey('sticker-${packId ?? 'unknown'}'),
      scrollController: scrollController,
      stickerSize: _stickerSize,
      itemCount: stickerItems.length,
      itemBuilder: (context, index) {
        final sticker = stickerItems[index];
        if (warMode == true) {
          return enhanceStickerPreviewWidget(sticker, context);
        }
        return generalStickerPreviewWidget(sticker);
      },
    );
  }

  Widget generalStickerPreviewWidget(StickerEntity sticker) {
    return GestureDetector(
      onTap: () {
        // Proceed with normal sticker selection
        onSelect(sticker.packId, sticker.fileId);
      },
      child: StickerItemPreview(
        width: _stickerSize,
        height: _stickerSize,
        packId: packId ?? sticker.packId,
        fileId: sticker.fileId,
      ),
    );
  }

  Widget enhanceStickerPreviewWidget(StickerEntity sticker, BuildContext context) {
    final GlobalKey stickerKey = GlobalKey();
    return SizedBox(
      key: stickerKey,
      width: _stickerSize,
      height: _stickerSize,
      child: custom_context_menu.CupertinoContextMenu.builder(
        actions: [
          MediaGalleryContextMenu(
            parentContext: context,
            text: 'Send'.tr,
            onTap: () async {
              Get.back();
              Future.delayed(const Duration(milliseconds: 150), () {
                onSelect(sticker.packId, sticker.fileId);
              });
            },
            tailing: Assets.vectors.send.svg(
              colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
              width: 20.spMin,
              height: 20.spMin,
            ),
          )
        ],
        onTapDownCallBack: (TapDownDetails details) {
          // Capture the actual tap position
          final RenderBox? renderBox = stickerKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final position = renderBox.localToGlobal(Offset.zero);
            final tapRect = Rect.fromLTWH(
              position.dx,
              position.dy,
              renderBox.size.width,
              renderBox.size.height,
            );

            // Store tap position for later animation use
            StickerAnimationService.instance.storeTapPosition(
              packId: sticker.packId,
              fileId: sticker.fileId,
              position: tapRect,
            );
          }
        },
        onJustTap: () => onSelect(sticker.packId, sticker.fileId),
        builder: (BuildContext context, Animation<double> animation) {
          return StickerItemPreview(
            width: _stickerSize * 2,
            height: _stickerSize * 2,
            packId: packId ?? sticker.packId,
            fileId: sticker.fileId,
          );
        },
      ),
    );
  }
}

class StickerGridView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController scrollController;
  final double stickerSize;

  const StickerGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.scrollController,
    required this.stickerSize,
  });

  double get bottomPadding {
    final viewBottomPadding = Get.mediaQuery.viewPadding.bottom;
    final bottomPadding = ChatRoomCustomInput.inputNavigationHeight + viewBottomPadding + AppSpace.space8;
    return bottomPadding;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //NOTE.need to have this to not close the keyboard when tapping on the grid
      },
      child: GridView.builder(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          left: AppSpace.space4,
          right: AppSpace.space4,
        ),
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: UChatScreenUtil.instance.isMobile ? 4 : Get.width / 2 ~/ stickerSize,
          mainAxisSpacing: AppSpace.space2,
          crossAxisSpacing: AppSpace.space2,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
