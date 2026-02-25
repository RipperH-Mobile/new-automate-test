import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_manage_controller.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

class StickerSettingMyStickerScreen extends GetView<StickerManageController> {
  const StickerSettingMyStickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      appBar: AppBarDefault(
        title: 'My stickers'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        actionButton: Builder(builder: (context2) {
          return AppControlButton.custom(
            context: context2,
            onTap: () {
              _openMenu(context2);
            },
            svgAsset: Assets.vectors.iconThreeDot.svg(),
          );
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
    List<MyStickerPackEntity> showStickerList = controller.stickerCtl.myStickerList;
    if (showStickerList.isEmpty) {
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
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: showStickerList.length,
        itemBuilder: (BuildContext context, int index) {
          final sticker = showStickerList[index];
          return _buildStickerItem(
            sticker,
            index,
            context,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: AppSpace.space4),
            child: Divider(
              height: 0,
              color: context.theme.appColors.borderDark,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStickerItem(
    MyStickerPackEntity sticker,
    int index,
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.backgroundNeutralLightestPressed,
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.rounded2xl),
                    topRight: Radius.circular(AppRadius.rounded2xl),
                  )
                : index == controller.stickerCtl.myStickerList.length - 1
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
              Container(
                padding: const EdgeInsets.only(
                  right: AppSpace.space4,
                  left: AppSpace.space4,
                  top: AppSpace.space4,
                  bottom: AppSpace.space4,
                ),
                child: _buildTailButton(
                  sticker,
                  context,
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildTailButton(
    MyStickerPackEntity sticker,
    BuildContext context,
  ) {
    return Obx(
      () {
        final statusInQueue = controller.stickerCtl.stickerInQueueDownloadStatus[sticker.id];

        if (statusInQueue == StickerDownloadStatus.inProgress) {
          return GestureDetector(
            onTap: () => controller.handleCancelDownloadStickerPack(sticker),
            child: SizedBox(
              width: AppSpace.space6,
              height: AppSpace.space6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: controller.stickerCtl.stickerInQueueDownloading[sticker.id] ?? 0,
                    valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.borderPrimary),
                    backgroundColor: context.theme.appColors.borderDark,
                    strokeWidth: 2,
                  ),
                  Container(
                    width: 8.5.spMin,
                    height: 8.5.spMin,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.borderPrimary,
                      borderRadius: BorderRadius.circular(AppSpace.space05),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (statusInQueue == StickerDownloadStatus.inQueue) {
          return GestureDetector(
            onTap: () => controller.handleCancelDownloadStickerPack(sticker),
            child: SizedBox(
              width: AppSpace.space6,
              height: AppSpace.space6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 1,
                    color: context.theme.appColors.borderDark,
                    strokeWidth: 2,
                  ),
                  Container(
                    width: 8.5.spMin,
                    height: 8.5.spMin,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.borderPrimary,
                      borderRadius: BorderRadius.circular(AppSpace.space05),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (sticker.isExpire == true || sticker.isDownloaded == true) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () => controller.handleDownloadStickerPack(sticker),
          child: Assets.vectors.iconStickerDownload.svg(),
        );
      },
    );
  }

  Future<void> _openMenu(BuildContext context) {
    return UChatPopover.open(
      context: context,
      contentDxOffset: -120.spMin,
      width: 220.spMin,
      menu: [
        PopoverMenuItem(
          onPressed: (BuildContext context) async {
            Navigator.pop(context);
            controller.goToManageSticker();
          },
          hasBottomDivider: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.body1(
                'Manage'.tr,
                context: context,
              ),
              Assets.vectors.iconManageSticker.svg(),
            ],
          ),
        ),
        PopoverMenuItem(
          onPressed: (BuildContext context) async {
            if (!controller.stickerCtl.isAllStickerDownload) {
              Navigator.pop(context);

              controller.handleDownloadAll();
            }
          },
          hasBottomDivider: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.body1(
                controller.stickerCtl.amountCanDownload == 0
                    ? 'Download all'.tr
                    : 'Download all (@undownload)'.trParams({
                        'undownload': controller.stickerCtl.amountCanDownload.toString(),
                      }),
                context: context,
                color: controller.stickerCtl.isAllStickerDownload ? context.theme.appColors.textDisable : null,
              ),
              Assets.vectors.iconDownloadAll.svg(
                colorFilter: controller.stickerCtl.isAllStickerDownload
                    ? ColorFilter.mode(
                        context.theme.appColors.textDisable,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
