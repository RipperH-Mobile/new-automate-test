import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/video/video_info_wrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UChatMediaGrid extends StatelessWidget {
  final List<RoomFileCollection> mediaList;
  final bool isDesktopPlatform;
  final bool isSelecting;
  final bool showSelection;
  final List<RoomFileCollection> selectedItems;

  final void Function(RoomFileCollection) onTapItem;
  final void Function(RoomFileCollection)? onLongPressItem;
  final void Function(bool isHover, RoomFileCollection item)? onHoverItem;
  final void Function(RoomFileCollection)? onToggleSelection;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? widthBox;
  final double? heightBox;

  const UChatMediaGrid({
    super.key,
    required this.mediaList,
    required this.isDesktopPlatform,
    required this.isSelecting,
    required this.showSelection,
    required this.selectedItems,
    required this.onTapItem,
    this.onLongPressItem,
    this.onHoverItem,
    this.onToggleSelection,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.widthBox,
    this.heightBox,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: mediaList.length,
      itemBuilder: (_, index) {
        final roomFile = mediaList[index];
        return isDesktopPlatform ? _buildDesktopItem(roomFile) : _buildMobileItem(roomFile);
      },
    );
  }

  Widget _buildDesktopItem(RoomFileCollection roomFile) {
    late Widget mediaWidgetChild;
    if (roomFile.type == RoomFileType.video) {
      mediaWidgetChild = VideoInfoWrapper(
        thumbnail: _buildImageWidget(roomFile),
        duration: roomFile.file?.duration ?? 0,
      );
    } else {
      mediaWidgetChild = Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 200, // or Get.width
          height: _calculatedHeight(roomFile),
          child: _buildImageWidget(roomFile),
        ),
      );
    }

    final bool isSelected = selectedItems.contains(roomFile);
    int selectedIndex = -1;
    if (isSelected) {
      selectedIndex = selectedItems.indexOf(roomFile) + 1;
    }

    return InkWell(
      onHover: (hover) => onHoverItem?.call(hover, roomFile),
      onTap: () => onTapItem(roomFile),
      child: Hero(
        tag: MediaViewerService.instance.generateMediaHeroTag(
          openFrom: MediaViewerOpenFrom.roomDetailPhotoAndVideo,
          heroTag: roomFile.file?.heroTag ?? roomFile.file?.apiFileUrl ?? roomFile.file?.url ?? '',
        ),
        child: Stack(
          children: [
            mediaWidgetChild,

            // If user is hovering or showSelection == true, show checkbox
            if (showSelection)
              Positioned(
                top: 8,
                right: 8,
                child: RoundCheckBox(
                  onTap: (value) => onToggleSelection?.call(roomFile),
                  uncheckedColor: Colors.grey.withValues(alpha: .5),
                  uncheckedWidget: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                  ),
                  size: 28.spMin,
                  isChecked: isSelected,
                  checkedColor: UTheme.color.primary,
                  checkedWidget: Center(
                    child: Text(
                      '$selectedIndex',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                  borderColor: isSelected ? UTheme.color.primary : Colors.white,
                  animationDuration: const Duration(milliseconds: 200),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileItem(RoomFileCollection roomFile) {
    final bool isSelected = selectedItems.contains(roomFile);
    final int? selectedIndex = isSelected ? selectedItems.indexOf(roomFile) : null;

    return GestureDetector(
      onTap: () => onTapItem(roomFile),
      onLongPress: () => onLongPressItem?.call(roomFile),
      child: Hero(
        tag: MediaViewerService.instance.generateMediaHeroTag(
          openFrom: MediaViewerOpenFrom.roomDetailPhotoAndVideo,
          heroTag: roomFile.file?.heroTag ?? roomFile.file?.apiFileUrl ?? roomFile.file?.url ?? '',
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (roomFile.type == RoomFileType.video)
              VideoInfoWrapper(
                thumbnail: _buildImageWidget(roomFile),
                duration: roomFile.file?.duration ?? 0,
              )
            else
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: widthBox ?? AppSpace.space50,
                  height: heightBox ?? _calculatedHeight(roomFile),
                  child: _buildImageWidget(roomFile),
                ),
              ),

            // selection circle if isSelecting
            if (isSelecting)
              Positioned(
                right: 8,
                top: 8,
                child: _buildSelectionCircle(selectedIndex),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(RoomFileCollection roomFile) {
    if (ConnectivityController.instance.isOffline) {
      return SizedBox(
        width: 100.spMin,
        height: 100.spMin,
        child: Assets.vectors.iconBlankImage.svg(),
      );
    }
    if (roomFile.type == RoomFileType.video) {
      if (roomFile.file?.thumbnailPath != null) {
        return Container(
          width: 100.spMin,
          height: 100.spMin,
          decoration: BoxDecoration(
            image: _buildImageProvider(
              provider: FileImage(File(roomFile.file!.thumbnailPath!)),
            ),
          ),
        );
      } else {
        return Container(
          width: 100.spMin,
          height: 100.spMin,
          decoration: BoxDecoration(
            image: _buildImageProvider(
              provider: UChatImage.networkProvider(
                FileService().getFileUrl(roomFile.file?.thumbnailFileId ?? ''),
              ),
            ),
          ),
        );
      }
    } else {
      return Container(
        width: 100.spMin,
        height: 100.spMin,
        decoration: BoxDecoration(
          image: _buildImageProvider(
            provider: UChatImage.networkProvider(
              roomFile.file?.apiFileUrl ?? '',
            ),
          ),
        ),
      );
    }
  }

  DecorationImage _buildImageProvider({required ImageProvider provider}) {
    return DecorationImage(
      image: ExtendedResizeImage.resizeIfNeeded(
        provider: provider,
        cacheWidth: 90.cacheSize,
      ),
      fit: BoxFit.cover,
    );
  }

  double _calculatedHeight(RoomFileCollection roomFile) {
    final double width = roomFile.file?.width ?? 1.0;
    final double height = roomFile.file?.height ?? 1.0;
    return (height * 200) / width;
  }

  Widget _buildSelectionCircle(int? selectedIndex) {
    if (selectedIndex == null) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
          border: Border.all(color: Colors.white, width: 1),
        ),
      );
    }
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: UTheme.color.primary,
      ),
      child: Center(
        child: Text(
          '${selectedIndex + 1}',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
