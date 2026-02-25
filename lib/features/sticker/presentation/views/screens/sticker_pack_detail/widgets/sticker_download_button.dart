import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/widgets/button/app_button_base.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';

class StickerDownloadButton extends StatelessWidget {
  final StickerDownloadStatus downloadStatus;
  final double downloadProgress;
  final double height;
  final double width;
  final VoidCallback? onTapDownload;
  final VoidCallback? onTapDelete;

  const StickerDownloadButton({
    super.key,
    required this.downloadStatus,
    this.downloadProgress = 0.0,
    this.height = 56.0,
    this.width = double.infinity,
    this.onTapDownload,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (downloadStatus.isInQueue) {
      return AppOutlinedButton(
        onTap: () {},
        isAutoSizeText: true,
        appButtonSize: AppButtonSize.large,
        label: 'In queue'.tr,
        backgroundColor: context.theme.appColors.buttonSecondary,
        overlayColor: context.theme.appColors.buttonSecondaryPressed,
        textColor: context.theme.appColors.textDarkest,
        iconColor: context.theme.appColors.icon,
        iconAlignment: IconAlignment.start,
        shape: RoundedRectangleBorder(
          borderRadius: AppButtonBase.getBorderRadius(AppButtonStyle.rounded),
          side: BorderSide(
            color: context.theme.appColors.borderDarker,
            width: 1,
          ),
        ),
      );
    }

    if (downloadStatus.isInProgress) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          LayoutBuilder(
            builder: (_, constrain) {
              final containerWidth = downloadProgress * constrain.maxWidth;
              double borderSize = 0.0;
              if (downloadProgress > .9 && downloadProgress < .96) {
                borderSize = AppRadius.roundedMd;
              } else if (downloadProgress >= 0.96) {
                borderSize = AppRadius.roundedXl;
              }

              return SizedBox(
                height: constrain.maxHeight,
                child: AnimatedContainer(
                  width: containerWidth,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppRadius.roundedXl),
                      bottomLeft: const Radius.circular(AppRadius.roundedXl),
                      topRight: Radius.circular(borderSize),
                      bottomRight: Radius.circular(borderSize),
                    ),
                    color: downloadProgress == 0 ? Colors.white : const Color(0xFF00FFA3),
                  ),
                ),
              );
            },
          ),
          LayoutBuilder(
            builder: (context, constrain) {
              return SizedBox(
                height: constrain.maxHeight,
                child: AppOutlinedButton(
                  onTap: () {},
                  isAutoSizeText: true,
                  appButtonSize: AppButtonSize.large,
                  label: 'Downloading @progress'.trParams({
                    'progress': '${(downloadProgress * 100).toStringAsFixed(0)}%',
                  }),
                  backgroundColor: Colors.transparent,
                  overlayColor: context.theme.appColors.buttonSecondaryPressed,
                  textColor: context.theme.appColors.textDarkest,
                  iconColor: context.theme.appColors.icon,
                  iconAlignment: IconAlignment.start,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppButtonBase.getBorderRadius(AppButtonStyle.rounded),
                    side: BorderSide(
                      color: context.theme.appColors.border,
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }

    if (downloadStatus.isCompleted) {
      return AppOutlinedButton.defaultButton(
        context: context,
        label: 'Downloaded'.tr,
      );
    }

    return AppOutlinedButton.primary(
      context: context,
      borderColor: context.theme.appColors.borderPrimary,
      label: 'Download'.tr,
      onTap: onTapDownload ?? () {},
    );
  }
}
