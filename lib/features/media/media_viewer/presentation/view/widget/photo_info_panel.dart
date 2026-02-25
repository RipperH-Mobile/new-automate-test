import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';

class PhotoInfoPanel extends StatelessWidget {
  final bool show;
  final MediaFileModel media;
  final MediaViewerOpenFrom openFrom;
  final VoidCallback onClosePage;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final VoidCallback? onBookmarked;
  final VoidCallback? onDelete;
  final VoidCallback? onGridPressed;
  final Function(BuildContext context)? onOpenMenu;
  final int mediaLength;
  final int? indexLength;
  final bool? showMediaListAndInfo;
  final Widget? previewWidget;
  final VoidCallback? onImageEdit;
  final bool? enableWarMode;

  const PhotoInfoPanel({
    super.key,
    required this.show,
    required this.media,
    required this.onClosePage,
    required this.openFrom,
    this.onDownload,
    this.onShare,
    this.onDelete,
    this.onGridPressed,
    this.onBookmarked,
    this.onOpenMenu,
    required this.mediaLength,
    this.indexLength,
    this.showMediaListAndInfo = true,
    this.previewWidget,
    this.onImageEdit,
    this.enableWarMode,
  });

  factory PhotoInfoPanel.secretRoom({
    required bool show,
    required MediaFileModel media,
    required MediaViewerOpenFrom openFrom,
    required VoidCallback onClosePage,
    Function(BuildContext context)? onOpenMenu,
    int? mediaLength,
  }) {
    return PhotoInfoPanel(
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
    return showMediaListAndInfo != true
        ? _buildBackButton(context)
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTopMenu(context),
              if (openFrom != MediaViewerOpenFrom.profileAvatar) _buildBottomMenu(context),
            ],
          );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: InkWell(
          onTap: onClosePage,
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.space3),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.theme.appColors.iconInformationInverse,
              size: AppSpace.space6,
            ),
          ),
        ),
      ),
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
          leading: GestureDetector(
            onTap: onClosePage,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 26.spMin),
          ),
          automaticallyImplyLeading: false,
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
          openFrom == MediaViewerOpenFrom.albumDetail ? media.albumName ?? 'UNKNOWN'.tr : media.sentByName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.theme.appTexts.body3Bold.copyWith(
            height: 1.4,
            color: context.theme.appColors.textPrimaryInverse,
          ),
        ),
        AppText.body3(
          openFrom == MediaViewerOpenFrom.albumDetail
              ? 'Add by @name'.trParams({'name': media.sentByName})
              : media.sentAtFormat,
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
      if (onOpenMenu != null) _buildInfoButton(context),
    ];
  }

  bool _isExcludedFromGrid() {
    return [
      MediaViewerOpenFrom.albumDetail,
      MediaViewerOpenFrom.roomDetail,
      MediaViewerOpenFrom.profileAvatar,
    ].contains(openFrom);
  }

  Widget _buildInfoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpace.space4),
      child: GestureDetector(
        onTap: () => buildInfoPhoto(media, context),
        child: Assets.vectors.info.svg(),
      ),
    );
  }

  Widget _buildBottomMenu(BuildContext context) {
    return AnimatedOpacity(
      opacity: show ? 1 : 0,
      duration: const Duration(milliseconds: 100),
      child: Column(
        children: [
          previewWidget ?? const SizedBox.shrink(),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: .75),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (onShare != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildActionButton(Assets.vectors.share.svg(), onShare),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (media.isImage &&
                        onImageEdit != null &&
                        media.url.isNotEmpty == true &&
                        enableWarMode == true) ...[
                      _buildActionButton(
                        Assets.vectors.editedIcon.svg(
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.iconInverse,
                            BlendMode.srcIn,
                          ),
                        ),
                        onImageEdit,
                        isIcon: true,
                      ),
                      SizedBox(width: 16.spMin),
                    ],
                    if (onDownload != null) _buildActionButton(Assets.vectors.download.svg(), onDownload, isIcon: true),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '$indexLength of $mediaLength',
                  style: TextStyle(
                    color: context.theme.appColors.textPrimaryInverse,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
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

  void buildInfoPhoto(MediaFileModel currentMedia, BuildContext context) {
    BottomSheetUChat.bottomSheet(
      context,
      title: 'Details'.tr,
      child: Column(
        children: [
          _buildTabDetail(context, title: 'Sent by'.tr, description: currentMedia.sentByName, hasTopBorder: true),
          _buildTabDetail(context, title: 'Time sent'.tr, description: currentMedia.sentAtFormat),
          _buildTabDetail(context, title: 'Size'.tr, description: (currentMedia.size ?? 0).sizeInKBStr),
          _buildTabDetail(
            context,
            title: 'Resolution'.tr,
            description: '${currentMedia.width} x ${currentMedia.height}',
            hasBottomBorder: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTabDetail(
    BuildContext context, {
    required String title,
    required String description,
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
