import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_sticker_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/sticker_download_progress_bar.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/sticker_input_selection_list.dart';
import 'package:uchat/features/chat_room/presentation/widgets/swipe_bar.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets/app_text.dart';

import 'chat_room_custom_input.dart';

class ChatRoomStickerInput extends GetView<ChatRoomStickerInputController> {
  final Function(StickerSendingEntity) onSendSticker;
  final SwipeBar swipeBar;
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const ChatRoomStickerInput({
    super.key,
    required this.onSendSticker,
    required this.swipeBar,
    this.controllerTag,
  });

  static const double stickerHeaderHeight = 44;

  final double stickerSize = 96;
  final double stickerPackBoxHeight = 44;
  final double stickerPackBoxWidth = 60;
  final double stickerPackSize = 36;
  final double stickerIconSize = 28;

  double get bottomPadding {
    final viewBottomPadding = Get.mediaQuery.viewPadding.bottom;
    final bottomPadding = ChatRoomCustomInput.inputNavigationHeight + viewBottomPadding + AppSpace.space8;
    return bottomPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStickerPackList(context),
            swipeBar,
          ],
        ),
        Expanded(
          child: _buildStickerList(context),
        ),
      ],
    );
  }

  Widget _buildStickerPackList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpace.space4,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            StickerPackageItem(
              width: stickerPackBoxWidth,
              height: stickerPackBoxHeight,
              onTap: () {
                Get.toNamed(Routes.stickerStore);
              },
              child: Assets.vectors.stickerStore.svg(
                width: stickerIconSize,
                height: stickerIconSize,
              ),
            ),
            Obx(
              () {
                return Expanded(
                  child: SizedBox(
                    height: stickerPackBoxHeight,
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: controller.downloadQueueList.isEmpty &&
                          controller.stickerCtl.currentDownloadingPackId.isEmpty &&
                          !GetPlatform.isMacOS,
                      onReorder: controller.handleReorderStickerPack,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.stickerTabLength,
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          return _buildRecentlyPackIcon(index);
                        } else {
                          return _buildStickerPackIcon(index);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyPackIcon(int index) {
    return Obx(
      key: const ValueKey(
        'sticker-cover-recently-used-container',
      ),
      () {
        return StickerPackageItem(
          width: stickerPackBoxWidth,
          height: stickerPackBoxHeight,
          selected: index == controller.currentStickerPage.value,
          onTap: () async {
            await controller.onTapStickerPack(0);
          },
          child: Assets.vectors.schedule.svg(
            width: stickerIconSize,
            height: stickerIconSize,
          ),
        );
      },
    );
  }

  Widget _buildStickerPackIcon(int packIndex) {
    final pack = controller.stickerCtl.myStickerList.elementAtOrNull(packIndex - 1);

    if (pack == null) {
      return const SizedBox.shrink();
    }
    return Obx(
      key: ValueKey('sticker-cover-${pack.id}-container'),
      () {
        final isDownloaded = pack.isDownloaded == true;
        final statusInQueue = controller.stickerCtl.stickerInQueueDownloadStatus[pack.id];
        if (pack.isExpire) {
          return const SizedBox.shrink();
        }
        return StickerPackageItem(
          width: stickerPackBoxWidth,
          height: stickerPackBoxHeight,
          selected: packIndex == controller.currentStickerPage(),
          onTap: () async {
            await controller.onTapStickerPack(packIndex);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4.0.spMin),
                child: StickerItemPreview(
                  packId: pack.id,
                  fileId: pack.coverId,
                ),
              ),
              if (statusInQueue == StickerDownloadStatus.inQueue)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.downloading_rounded,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                )
              else if (statusInQueue == StickerDownloadStatus.inProgress)
                Positioned(
                  right: 0,
                  bottom: AppSpace.space05,
                  child: SizedBox(
                    width: AppSize.size3,
                    height: AppSize.size3,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      value: controller.stickerCtl.stickerInQueueDownloading[pack.id] ?? 0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        UTheme.color.primary,
                      ),
                      backgroundColor: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                )
              else if (!isDownloaded)
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image(
                    image: AssetImage(
                      'assets/images/sticker_download_icon.png',
                    ),
                    width: AppSize.size4,
                    height: AppSize.size4,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStickerList(BuildContext context) {
    return Obx(
      () {
        if (!controller.initialized) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CupertinoActivityIndicator(),
              5.horizontalSpace,
              AppText.body2(
                'loading'.tr,
                context: context,
              ),
            ],
          );
        }

        return PageView.builder(
          key: const ValueKey('sticker-input-page-view'),
          physics: const BouncingScrollPhysics(),
          allowImplicitScrolling: true,
          controller: controller.pageController,
          itemCount: controller.stickerTabLength,
          onPageChanged: controller.onStickerPageChanged,
          itemBuilder: (context, index) {
            return Obx(() {
              if (index == 0) {
                if (controller.stickerRecentlyUsedList().isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: bottomPadding,
                      ),
                      child: AppText.body2(
                        'No sticker used history'.tr,
                        context: context,
                      ),
                    ),
                  );
                }

                return StickerInputSelectionList(
                  index: index,
                  scrollController: controller.scrollController,
                  stickerItems: controller.stickerRecentlyUsedList(),
                  isDownloaded: true,
                  bottomPadding: bottomPadding,
                  onSelect: (packId, fileId) => controller.selectSticker(
                    packId,
                    fileId,
                    onSendSticker,
                  ),
                  onDownloadSticker: controller.downloadStickerPack,
                  warMode: controller.chatRoomInputCtl.enableWarMode.value,
                  onSendSticker: onSendSticker,
                );
              } else {
                final pack = controller.stickerCtl.myStickerList.elementAtOrNull(index - 1);
                if (pack == null) {
                  return const SizedBox.shrink();
                }

                final statusInQueue = controller.stickerCtl.stickerInQueueDownloadStatus[pack.id];

                if (statusInQueue == StickerDownloadStatus.inQueue) {
                  return Container(
                    margin: EdgeInsets.only(bottom: bottomPadding),
                    child: Center(
                      child: AppText.body2(
                        'In queue'.tr,
                        context: context,
                      ),
                    ),
                  );
                }

                if (statusInQueue == StickerDownloadStatus.inProgress) {
                  return Obx(
                    () {
                      return Container(
                        margin: EdgeInsets.only(bottom: bottomPadding),
                        child: StickerDownloadProgressBar(
                          value: controller.stickerCtl.stickerInQueueDownloading[pack.id] ?? 0,
                        ),
                      );
                    },
                  );
                }

                return StickerInputSelectionList(
                  index: index,
                  scrollController: controller.scrollController,
                  stickerItems: pack.stickerItems,
                  isDownloaded: pack.isDownloaded,
                  bottomPadding: bottomPadding,
                  packId: pack.id,
                  onSelect: (packId, fileId) => controller.selectSticker(
                    packId,
                    fileId,
                    onSendSticker,
                  ),
                  onDownloadSticker: controller.downloadStickerPack,
                  warMode: controller.chatRoomInputCtl.enableWarMode.value,
                  onSendSticker: onSendSticker,
                );
              }
            });
          },
        );
      },
    );
  }
}

class StickerPackageItem extends StatelessWidget {
  final double width;
  final double height;
  final bool selected;
  final Widget child;
  final void Function() onTap;

  const StickerPackageItem({
    super.key,
    required this.width,
    required this.height,
    this.selected = false,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpace.space05,
        ),
        decoration: BoxDecoration(
          color: selected ? context.theme.appColors.backgroundNeutralLight : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppRadius.roundedLg),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
