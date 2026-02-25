import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart' as reorder;
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_manage_controller.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/reorder.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class StickerSettingEditMyStickerScreen extends GetView<StickerManageController> {
  const StickerSettingEditMyStickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      appBar: AppBarDefault(
        title: 'My stickers'.tr,
        leadingButton: AppControlButton.back(
          showIcon: false,
          label: 'Cancel'.tr,
          context: context,
          onTap: () {
            Get.back();
          },
        ),
        actionButton: Obx(() {
          return AppControlButton.forward(
              context: context,
              label: 'Done'.tr,
              actionColor: controller
                      .listEquals(controller.initStickersInEditSticker, controller.downloadedStickersInEditSticker)
                      .value
                  ? context.theme.appColors.textDisable
                  : null,
              onTap: () {
                if (controller
                        .listEquals(controller.initStickersInEditSticker, controller.downloadedStickersInEditSticker)
                        .value ==
                    false) {
                  controller.onEditDone();
                }
              });
        }),
        leadingWidth: AppSpace.space20,
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      ),
      child: Obx(
        () {
          return _buildMyStickerList(context);
        },
      ),
    );
  }

  Widget _buildMyStickerList(BuildContext context) {
    List<MyStickerPackEntity> showDownloadedStickerList = controller.downloadedStickersInEditSticker;

    if (showDownloadedStickerList.isEmpty) {
      if (controller.stickerCtl.pendingSwitchAccountComplete()) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }

      return Center(
        child: AppText.body2Bold(
          'No stickers have been added'.tr,
          context: context,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(
        right: AppSpace.space4,
        left: AppSpace.space4,
        top: AppSpace.space2,
        bottom: AppSpace.space6,
      ),
      child: reorder.ReorderableList(
        onReorder: (item, newPosition) => _reorderCallback(item as ReorderKey, newPosition as ReorderKey),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: showDownloadedStickerList.length,
          itemBuilder: (BuildContext context, int index) {
            final sticker = showDownloadedStickerList[index];

            return reorder.ReorderableItem(
              key: ValueKey('sticker-setting-reorder-listview-${sticker.id}'),
              childBuilder: (
                BuildContext context,
                reorder.ReorderableItemState state,
              ) {
                return _buildStickerItem(
                  sticker,
                  index,
                  context,
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: AppSpace.space4 + AppSpace.space3 + AppSpace.space6),
              child: Divider(
                height: 0,
                color: context.theme.appColors.borderDark,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStickerItem(
    MyStickerPackEntity sticker,
    int index,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightestPressed,
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.rounded2xl),
                topRight: Radius.circular(AppRadius.rounded2xl),
              )
            : index == controller.downloadedStickersInEditSticker.length - 1
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadius.rounded2xl),
                    bottomRight: Radius.circular(AppRadius.rounded2xl),
                  )
                : BorderRadius.zero,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space4,
                  ),
                  child: reorder.ReorderableListener(
                    canStart: () {
                      if (sticker.isExpire == true) {
                        return false;
                      }
                      return true;
                    },
                    child: Opacity(
                        opacity: sticker.isExpire == true ? 0.5 : 1, child: Assets.vectors.iconReorderSticker.svg()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space3,
                    right: AppSpace.space3,
                    top: AppSpace.space2,
                    bottom: AppSpace.space2,
                  ),
                  child: Opacity(
                    opacity: sticker.isExpire == true ? 0.5 : 1,
                    child: StickerItemPreview(
                      packId: sticker.id,
                      fileId: sticker.coverId,
                      width: AppSpace.space16,
                      height: AppSpace.space16,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildBodyItem(
                    sticker,
                    index,
                    context,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: AppSpace.space4,
              left: AppSpace.space4,
            ),
            child: GestureDetector(
                onTap: () => controller.handleDeleteStickerPack(sticker),
                child: Assets.vectors.iconDeleteSticker.svg()),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyItem(MyStickerPackEntity sticker, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: sticker.isExpire == true ? 0.5 : 1,
          child: AppText.body1(
            sticker.name,
            context: context,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: AppSpace.space1,
        ),
        AppText.body3(
          _getExpireDate(sticker),
          context: context,
          color: sticker.isExpire == true ? context.theme.appColors.textError : context.theme.appColors.textLight,
        ),
      ],
    );
  }

  String _getExpireDate(MyStickerPackEntity sticker) {
    final expireAt = sticker.expireAt;
    final formattedDate = (expireAt ?? DateTime.now()).format('dd/MM/yyyy');

    if (sticker.isExpire == true) {
      return 'Expired'.tr;
    } else if (expireAt != null) {
      return 'Expire date @date'.trParams({'date': formattedDate});
    } else {
      return 'No expire date'.tr;
    }
  }

  bool _reorderCallback(ReorderKey item, ReorderKey newPosition) {
    if (controller.stickerCtl.stickerDownloaderService.currentDownloadingPackId.isNotEmpty) {
      return false;
    }

    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final sticker = controller.downloadedStickersInEditSticker[draggingIndex];
    if (sticker.isExpire == true) {
      return false;
    }

    final maxReorderIndex =
        controller.downloadedStickersInEditSticker.where((element) => element.isExpire != true).length;

    if (newPositionIndex >= maxReorderIndex) {
      newPositionIndex = maxReorderIndex - 1;
    }

    final draggedItem = controller.downloadedStickersInEditSticker.removeAt(draggingIndex);
    controller.downloadedStickersInEditSticker.insert(newPositionIndex, draggedItem);

    return true;
  }

  int _indexOfKey(ReorderKey key) {
    final id = key.value.split('-').lastOrNull;

    return controller.downloadedStickersInEditSticker.indexWhere(
      (MyStickerPackEntity d) => d.id == id,
    );
  }
}
