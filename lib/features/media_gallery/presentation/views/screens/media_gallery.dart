import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_app_bar.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_grid.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_manage_setting.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_selected_preview.dart';
import 'package:uchat/utils/vibrate.dart';

enum MediaGalleryDoneButtonType { done, next, add }

enum MediaGalleryAppBarActionType { back, close }

enum MediaGalleryFilterMediaType {
  image,
  video,
  imageAndVideo;

  RequestType get requestType {
    switch (this) {
      case MediaGalleryFilterMediaType.image:
        return RequestType.image;
      case MediaGalleryFilterMediaType.video:
        return RequestType.video;
      case MediaGalleryFilterMediaType.imageAndVideo:
        return RequestType.common;
    }
  }
}

class MediaGallery extends StatelessWidget {
  /// Max selectable media from gallery, default is `50` images [UChatConstant.maxSelectableMediaFromGallery]
  ///
  /// - If user select more than this number, it will disable the select button and then show a snackbar
  /// - Default is `50`
  ///
  /// - If set to `1`, it will only allow user to select one image
  ///   - not show the select button
  ///   - auto close the gallery after user select one image
  ///   - not show the bottom bar
  final int maxSelectable;

  /// Type of done button in the bottom bar
  ///
  /// - `done` - Show the done button (send button)
  /// - `next` - Show the next button
  /// - `add` - Show the add button
  ///
  /// It can not customize the done button right now.
  /// Because the done button is depend on size of selected preview section.
  ///
  /// Default is `done`
  final MediaGalleryDoneButtonType doneButtonType;

  /// Type of action button in the app bar
  ///
  /// - `back` - Show the back button in the app bar on the left side
  /// - `close` - Show the close button in the app bar on the right side
  ///
  /// It can not show both back and close button at the same time.
  ///
  /// Default is `close`
  final MediaGalleryAppBarActionType appBarActionType;

  /// Filter media type
  ///
  /// - `image` - Show only image
  /// - `video` - Show only video
  /// - `imageAndVideo` - Show both image and video
  ///
  /// Default is `imageAndVideo`
  final MediaGalleryFilterMediaType filterMediaType;

  /// Show drag handle on the top of the gallery over the app bar
  ///
  /// Default is `true`
  final bool showDragHandle;

  /// Callback when user press the done button
  final Future<void> Function(MediaGalleryResult result, {int loopCount})? onDoneCallback;
  final Future<void> Function(Uint8List editedImage)? onEditImageCompleteCallback;
  final bool isShowCloseButton;

  final void Function(double inversePositionDy)? onVerticalPositionUpdate;

  final void Function(double inversePositionDy)? onVerticalDragEnd;
  final bool disableSafeArea;

  /// Whether or not to enable picking unsupported type such as HEIC, HEIF, tiff, tif images on Android
  /// If true, HEIC, HEIF, tiff, tif images will be allowed to be picked on Android devices.
  /// otherwise, they can't be picked and show an unsupported file dialog.
  final bool enablePickingUnsupportedTypeOnAndroid;

  const MediaGallery({
    super.key,
    this.showDragHandle = true,
    this.maxSelectable = UChatConstant.maxSelectableMediaFromGallery,
    this.doneButtonType = MediaGalleryDoneButtonType.done,
    this.appBarActionType = MediaGalleryAppBarActionType.close,
    this.filterMediaType = MediaGalleryFilterMediaType.imageAndVideo,
    this.onDoneCallback,
    this.isShowCloseButton = true,
    this.onVerticalPositionUpdate,
    this.onVerticalDragEnd,
    this.onEditImageCompleteCallback,
    this.disableSafeArea = false,
    this.enablePickingUnsupportedTypeOnAndroid = true,
  });

  /// Open the media gallery picker
  static Future<MediaGalleryResult?> open({
    bool showDragHandle = true,
    int maxSelectable = UChatConstant.maxSelectableMediaFromGallery,
    MediaGalleryDoneButtonType doneButtonType = MediaGalleryDoneButtonType.done,
    MediaGalleryAppBarActionType appBarActionType = MediaGalleryAppBarActionType.close,
    MediaGalleryFilterMediaType filterMediaType = MediaGalleryFilterMediaType.imageAndVideo,
    Future<void> Function(MediaGalleryResult result, {int loopCount})? onDoneCallback,
    final Future<void> Function(Uint8List editedImage)? onEditImageCompleteCallback,
    bool isShowCloseButton = true,
    void Function(double inversePositionDy)? onVerticalPositionUpdate,
    void Function(double inversePositionDy)? onVerticalDragEnd,
    bool enablePickingUnsupportedTypeOnAndroid = true,
  }) async {
    final mediaGalleryService = GetIt.I<MediaGalleryService>();
    final hasPermission = await mediaGalleryService.checkPermission();

    if (!hasPermission) {
      final granted = await mediaGalleryService.requestPermission();
      if (!granted) {
        return null;
      }
    }

    GetIt.I<VibrateUtil>().vibrateLight();
    return await showCupertinoModalBottomSheet<MediaGalleryResult>(
      context: Get.context!,
      duration: const Duration(milliseconds: 200),
      topRadius: const Radius.circular(AppSpace.space4),
      builder: (_) {
        return MediaGallery(
          showDragHandle: showDragHandle,
          maxSelectable: maxSelectable,
          doneButtonType: doneButtonType,
          appBarActionType: appBarActionType,
          filterMediaType: filterMediaType,
          onDoneCallback: onDoneCallback,
          onEditImageCompleteCallback: onEditImageCompleteCallback,
          isShowCloseButton: isShowCloseButton,
          onVerticalPositionUpdate: onVerticalPositionUpdate,
          onVerticalDragEnd: onVerticalDragEnd,
          enablePickingUnsupportedTypeOnAndroid: enablePickingUnsupportedTypeOnAndroid,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaGalleryController>(
      init: MediaGalleryController(
        maxSelectable: maxSelectable,
        filterMediaType: filterMediaType,
        onDoneCallback: onDoneCallback,
        onEditImageCompleteCallback: onEditImageCompleteCallback,
        enablePickingUnsupportedTypeOnAndroid: enablePickingUnsupportedTypeOnAndroid,
      ),
      id: MediaGalleryIds.mainMediaGalleryId,
      builder: (ctl) {
        return Column(
          children: [
            MediaGalleryAppBar(
              showDragHandle: showDragHandle,
              appBarActionType: appBarActionType,
              isShowCloseButton: isShowCloseButton,
              onVerticalPositionUpdate: onVerticalPositionUpdate,
              onVerticalDragEnd: onVerticalDragEnd,
              disableSafeArea: disableSafeArea,
            ),
            FutureBuilder(
              future: PhotoManager.requestPermissionExtend(),
              builder: (context, snapshot) {
                if (snapshot.data == PermissionState.limited || snapshot.data == PermissionState.denied) {
                  return MediaGalleryManageSetting(
                    onSelectMorePhotos: ctl.onSelectMorePhotos,
                    onChangeSetting: ctl.onChangeSetting,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Expanded(child: MediaGalleryGrid()),
            Align(
              alignment: Alignment.bottomCenter,
              child: MediaGallerySelectedPreview(
                doneButtonType: doneButtonType,
              ),
            ),
          ],
        );
      },
    );
  }
}
