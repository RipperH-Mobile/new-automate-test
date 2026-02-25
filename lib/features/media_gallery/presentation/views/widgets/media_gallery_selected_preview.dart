import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_asset_view.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MediaGallerySelectedPreview extends StatelessWidget {
  final MediaGalleryDoneButtonType? doneButtonType;

  const MediaGallerySelectedPreview({super.key, this.doneButtonType});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaGalleryController>(
      id: MediaGalleryIds.selectedPreviewId,
      builder: (ctl) {
        if (ctl.selectedAssets.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: 1.sw,
          padding: const EdgeInsets.only(bottom: AppSpace.space1),
          decoration: _buildContainerDecoration(context),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (ctl.openSelectedPreview) _buildSelectedPreviewList(ctl),
                _buildBottomBar(context, ctl),
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.appColors.backgroundNeutralLightest,
      boxShadow: [
        BoxShadow(
          color: context.theme.appColors.backgroundGray.withValues(alpha: .08),
          offset: const Offset(0, -2),
          blurRadius: 8,
        ),
      ],
    );
  }

  Widget _buildSelectedPreviewList(MediaGalleryController ctl) {
    return SizedBox(
      height: AppSize.size16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space2),
        itemCount: ctl.selectedAssets.length,
        itemBuilder: (context, index) {
          final asset = ctl.selectedAssets[index];
          return Padding(
            padding: index != (ctl.selectedAssets.length - 1)
                ? const EdgeInsets.only(right: AppSpace.space1)
                : EdgeInsets.zero,
            child: SizedBox(
              width: 48.spMin,
              height: 48.spMin,
              child: MediaGalleryAssetView(
                asset: asset,
                previewWidth: 280.spMin,
                previewHeight: 280.spMin,
                borderRadius: AppRadius.roundedLg,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, MediaGalleryController ctl) {
    return Container(
      height: AppSpace.space12,
      padding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space4,
        top: AppSpace.space2,
        bottom: AppSpace.space1,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: _buildLeftButton(context, ctl)),
          _buildPreviewToggle(context, ctl),
          _buildDoneButton(context),
        ],
      ),
    );
  }

  Widget _buildLeftButton(BuildContext context, MediaGalleryController ctl) {
    if (doneButtonType == MediaGalleryDoneButtonType.done &&
        ctl.selectedAssets.length == 1 &&
        ctl.selectedAssets.firstOrNull?.type == AssetType.image &&
        ctl.enableWarMode()) {
      return buildEditImageWidget(context, () => ctl.handleEditImage(ctl.selectedAssets.first, context));
    }
    return const SizedBox.shrink();
  }

  Widget _buildPreviewToggle(BuildContext context, MediaGalleryController ctl) {
    return GestureDetector(
      onTap: ctl.openSelectedPreviewList,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.body1Bold(
            '@count selected'.trParams({'count': ctl.selectedAssets.length.toString()}),
            context: context,
          ),
          AppSpace.space05.horizontalSpace,
          ctl.openSelectedPreview ? Assets.vectors.arrowDropDown.svg() : Assets.vectors.arrowDropUp.svg(),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return GetBuilder<MediaGalleryController>(
      id: MediaGalleryIds.doneButtonId,
      builder: (ctlDoneButton) {
        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: ctlDoneButton.isAvailableToDone ? ctlDoneButton.onDone : null,
            child: _buildDoneButtonContent(context, ctlDoneButton),
          ),
        );
      },
    );
  }

  Widget _buildDoneButtonContent(BuildContext context, MediaGalleryController ctlDoneButton) {
    final isAvailable = ctlDoneButton.isAvailableToDone;
    final backgroundColor =
        isAvailable ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundGrayLighter;

    switch (doneButtonType) {
      case MediaGalleryDoneButtonType.add:
        return _buildCustomButton(context, 'Add'.tr, backgroundColor);
      case MediaGalleryDoneButtonType.next:
        return _buildCustomButton(context, 'Next'.tr, backgroundColor);
      case MediaGalleryDoneButtonType.done:
      default:
        return ctlDoneButton.buildDefaultDoneButton(backgroundColor);
    }
  }

  Widget _buildCustomButton(BuildContext context, String text, Color backgroundColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space2),
        child: AppText.button2Bold(
          text,
          context: context,
          color: context.theme.appColors.textPrimaryInverse,
          lineHeight: 1.2,
        ),
      ),
    );
  }

  Widget buildEditImageWidget(BuildContext context, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.spMin,
        height: 35.spMin,
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space3,
            vertical: AppSpace.space1,
          ),
          child: Assets.vectors.editedIcon.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.iconInverse,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
