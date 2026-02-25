import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/slider_custom_track_shape.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';

import '../../controller/video_previewer_controller.dart';

class VideoInfoPanel extends GetView<VideoPreviewerController> {
  final String heroTag;
  final bool show;
  final MediaFileModel media;
  final MediaViewerOpenFrom openFrom;
  final VoidCallback onClosePage;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final VoidCallback? onBookmarked;
  final VoidCallback? onGridPressed;
  final Function(BuildContext context)? onOpenMenu;
  final int mediaLength;
  final int? indexLength;
  final Widget? previewWidget;

  const VideoInfoPanel({
    super.key,
    required this.show,
    required this.media,
    required this.onClosePage,
    required this.heroTag,
    required this.openFrom,
    this.onDownload,
    this.onShare,
    this.onGridPressed,
    this.onBookmarked,
    this.onOpenMenu,
    required this.mediaLength,
    this.indexLength,
    this.previewWidget,
  });

  @override
  String get tag => heroTag;

  factory VideoInfoPanel.secretRoom({
    required String heroTag,
    required bool show,
    required MediaFileModel media,
    required MediaViewerOpenFrom openFrom,
    required VoidCallback onClosePage,
    Function(BuildContext context)? onOpenMenu,
    int? mediaLength,
  }) {
    return VideoInfoPanel(
      heroTag: heroTag,
      show: show,
      media: media,
      openFrom: openFrom,
      onClosePage: onClosePage,
      onOpenMenu: onOpenMenu,
      mediaLength: mediaLength ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTopMenu(context),
        _buildBottomMenu(context),
      ],
    );
  }

  Widget _buildTopMenu(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: AppBar(
          backgroundColor: Colors.black.withValues(alpha: .75),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: onClosePage,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 26.spMin,
            ),
          ),
          centerTitle: true,
          title: _buildTitle(context),
          actions: _buildTopMenuActions(context),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          media.sentByName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.theme.appTexts.body3Bold.copyWith(
            height: 1.4,
            color: context.theme.appColors.textLightest,
          ),
        ),
        AppText.body3(
          media.sentAtFormat,
          color: context.theme.appColors.textPrimaryInverse,
          context: context,
        ),
      ],
    );
  }

  List<Widget> _buildTopMenuActions(BuildContext context) {
    return [
      if (!media.isGif && onGridPressed != null && !_isExcludedFromGrid())
        Padding(
          padding: const EdgeInsets.only(right: AppSpace.space3),
          child: GestureDetector(
            onTap: onGridPressed,
            child: Assets.vectors.grid.svg(),
          ),
        ),
      _buildInfoButton(context),
    ];
  }

  Widget _buildInfoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpace.space4),
      child: GestureDetector(
        onTap: () => buildInfoVideo(media, context),
        child: Assets.vectors.info.svg(),
      ),
    );
  }

  bool _isExcludedFromGrid() {
    return [
      MediaViewerOpenFrom.albumDetail,
      MediaViewerOpenFrom.roomDetail,
    ].contains(openFrom);
  }

  Widget _buildBottomMenu(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.black.withValues(alpha: .75),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPlaybackControls(context),
                previewWidget ?? const SizedBox.shrink(),
                _buildBottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaybackControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: Row(
        children: [
          Obx(() {
            return InkWell(
                onTap: controller.isError.value ? null : controller.onTapPlayButton,
                child: controller.isPlaying.value ? Assets.vectors.pause.svg() : Assets.vectors.play.svg());
          }),
          AppSpace.space3.horizontalSpace,
          Obx(() {
            return Text(
              controller.currentPlayingTime.value.formattedVideoTime,
              style: TextStyle(
                color: controller.isError.value
                    ? const Color(0xFFCCCCCC).withValues(alpha: .4)
                    : Colors.white.withValues(alpha: .75),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                child: SliderTheme(
                  data: SliderThemeData(
                    trackShape: SliderCustomTrackShape(),
                    trackHeight: 4.spMin,
                    thumbShape: controller.isError.value ? SliderComponentShape.noThumb : null,
                  ),
                  child: Slider(
                    min: 0,
                    max: controller.totalPlayTime.value.inMilliseconds.toDouble(),
                    value: controller.currentPlayingTimeValue.value
                        .clamp(0, controller.totalPlayTime.value.inMilliseconds.toDouble()),
                    onChanged: controller.seekToVideo,
                    onChangeStart: (value) => controller.onSeekStart(),
                    onChangeEnd: (value) => controller.onSeekEnd(),
                    thumbColor: Colors.white,
                    activeColor: Colors.white.withValues(alpha: 0.8),
                    inactiveColor: Colors.white.withValues(alpha: controller.isError.value ? 0.2 : 0.4),
                  ),
                ),
              );
            }),
          ),
          Obx(() {
            return Text(
              Duration(milliseconds: media.duration?.toInt() ?? 0).formattedVideoTime,
              style: TextStyle(
                color: controller.isError.value
                    ? const Color(0xFFCCCCCC).withValues(alpha: .4)
                    : Colors.white.withValues(alpha: .75),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onShare != null) _buildActionButton(Assets.vectors.share.svg(), onShare),
            Text(
              '$indexLength of $mediaLength',
              style: TextStyle(
                color: context.theme.appColors.textPrimaryInverse,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            if (onDownload != null) _buildActionButton(Assets.vectors.download.svg(), onDownload, isIcon: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(Widget asset, VoidCallback? onTap, {bool isIcon = false}) {
    return SizedBox(
      width: AppSize.size6,
      height: AppSize.size6,
      child: InkWell(
        onTap: onTap,
        child: asset,
      ),
    );
  }

  void buildInfoVideo(MediaFileModel currentMedia, BuildContext context) {
    BottomSheetUChat.bottomSheet(
      context,
      title: 'Details'.tr,
      child: Column(
        children: [
          _buildDetailRow(context, 'Sent by'.tr, currentMedia.sentByName, hasTopBorder: true),
          _buildDetailRow(context, 'Time sent'.tr, currentMedia.sentAtFormat),
          _buildDetailRow(
              context, 'Duration'.tr, Duration(milliseconds: currentMedia.duration?.toInt() ?? 0).formattedVideoTime),
          _buildDetailRow(context, 'Size'.tr, (currentMedia.size ?? 0).sizeInMBStr),
          if (currentMedia.thumbnailWidth != null && currentMedia.thumbnailHeight != null)
            _buildDetailRow(
              context,
              'Resolution'.tr,
              '${currentMedia.width ?? currentMedia.thumbnailWidth} x ${currentMedia.height ?? currentMedia.thumbnailHeight}',
              hasBottomBorder: true,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String title,
    String description, {
    bool hasTopBorder = false,
    bool hasBottomBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightestPressed,
        borderRadius: BorderRadius.only(
          topRight: hasTopBorder ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
          topLeft: hasTopBorder ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
          bottomRight: hasBottomBorder ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
          bottomLeft: hasBottomBorder ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.body1(title, context: context),
            const SizedBox(width: AppSpace.space2),
            Expanded(
              child: AppText.body1(
                description,
                context: context,
                textAlign: TextAlign.right,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
