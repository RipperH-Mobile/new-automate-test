import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/widgets/sticker_download_button.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_price.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_uchat_coin.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class StickerPackDetailHeader extends StatelessWidget {
  final String stickerPackId;

  const StickerPackDetailHeader({super.key, required this.stickerPackId});

  @override
  Widget build(BuildContext context) {
    // Header
    return GetBuilder<StickerPackDetailController>(
      id: StickerPackDetailIds.header,
      tag: stickerPackId,
      builder: (ctl) {
        if (ctl.isLoadingStickerDetail) {
          return ShimmerLoading(
            enable: true,
            child: Align(
              child: Column(
                children: [
                  Container(
                    width: 164.spMin,
                    height: 164.spMin,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                    ),
                  ),
                  AppSpace.space3.verticalSpace,
                  Container(
                    width: .7.sw,
                    height: 20.spMin,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                    ),
                  ),
                  AppSpace.space2.verticalSpace,
                  Container(
                    width: .3.sw,
                    height: 14.spMin,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                    ),
                  ),
                  AppSpace.space3.verticalSpace,
                  Container(
                    width: 80.spMin,
                    height: 20.spMin,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLight,
                      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                    child: Container(
                      width: .3.sw,
                      height: 40.spMin,
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundNeutralLight,
                        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.space4,
                      vertical: AppSpace.space4,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: context.theme.appColors.backgroundNeutralLight,
                              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedXl)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final pack = ctl.stickerPack;

        if (pack == null) {
          return Center(
            child: AppText.body1('Sticker pack not found'.tr, context: context),
          );
        }

        return Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StickerItemPreview(
                packId: pack.id,
                fileId: pack.coverId,
                width: 164.spMin,
                height: 164.spMin,
                enableFileSize: ctl.enableWarMode.value,
              ),
              AppSpace.space3.verticalSpace,
              AppText.body1Bold(
                pack.name,
                context: context,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              AppSpace.space2.verticalSpace,
              AppText.body3(
                pack.publisher,
                context: context,
                color: context.theme.appColors.textLight,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              AppSpace.space3.verticalSpace,
              StickerPrice(
                price: pack.price,
                textStyle: context.theme.appTexts.body1Bold,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.coinStore);
                  },
                  child: StickerUChatCoin(
                    coinCount: ctl.currentCoin,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      if (pack.price > 0) ...[
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: AppOutlinedButton.defaultButton(
                                  isExpanded: true,
                                  context: context,
                                  label: 'Send as gift'.tr,
                                  onTap: () {
                                    ctl.handleSendAsGiftPressed();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpace.space2.horizontalSpace,
                      ],
                      Expanded(
                        child: Column(
                          children: [
                            GetBuilder<StickerPackDetailController>(
                              id: StickerPackDetailIds.downloadButton,
                              tag: stickerPackId,
                              builder: (buttonCtl) {
                                if (pack.isOwner) {
                                  return Expanded(
                                    child: StickerDownloadButton(
                                      downloadStatus: buttonCtl.downloadStatus,
                                      downloadProgress: buttonCtl.downloadProgress,
                                      onTapDownload: buttonCtl.onTapDownloadPack,
                                      onTapDelete: buttonCtl.onTapDeletePack,
                                    ),
                                  );
                                } else {
                                  if (pack.price > 0) {
                                    return Expanded(
                                      child: AppFilledButton.primary(
                                        isExpanded: true,
                                        context: context,
                                        label: 'Purchase'.tr,
                                        onTap: () {
                                          ctl.handlePurchasePressed();
                                        },
                                      ),
                                    );
                                  }

                                  return Expanded(
                                    child: AppFilledButton.primary(
                                      context: context,
                                      label: 'Get free sticker'.tr,
                                      onTap: () async {
                                        await buttonCtl.onAcquireStickerPack(stickerPackId);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
