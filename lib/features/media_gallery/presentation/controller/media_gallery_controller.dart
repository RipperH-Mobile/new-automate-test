import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:async_queue/async_queue.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_image_video_use_case.dart';
import 'package:uchat/features/image_edit/uchat_edit_image.dart';
import 'package:uchat/features/media_gallery/domain/events/update_gallery_asset_event.dart';
import 'package:uchat/features/media_gallery/domain/model/album_asset_model.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class MediaGalleryIds {
  static const mainMediaGalleryId = 'main-media-gallery';
  static const albumSelectionBuildId = 'media-gallery-album-selection';
  static const albumMenuId = 'media-gallery-album-menu';
  static const selectedPreviewId = 'media-gallery-selected-preview';
  static const doneButtonId = 'media-gallery-done-button';

  static String downloadProgressId(String assetId) => 'asset_download_progress_$assetId';

  static String galleryAssetsId(String assetId) => 'media-gallery-asset-$assetId';
}

class MediaGalleryController extends FullLifeCycleController with FullLifeCycleMixin {
  static MediaGalleryController get instance => Get.find<MediaGalleryController>();

  final _log = useLogger();
  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;

  /// Max selectable media from gallery, default is `50` images [UChatConstant.maxSelectableMediaFromGallery]
  /// - If user select more than this number, it will disable the select button and then show a snackbar
  /// - If set to `1`, it will only allow user to select one image
  ///   - not show the select button
  ///   - auto close the gallery after user select one image
  ///   - not show the bottom bar
  ///
  /// - Default is `50`
  final int maxSelectable;

  /// Type of media to filter in the gallery
  ///
  /// - `image` - Show only image
  /// - `video` - Show only video
  /// - `imageAndVideo` - Show both image and video
  ///
  /// Default is `imageAndVideo`
  final MediaGalleryFilterMediaType filterMediaType;

  /// Callback when user press done
  final Future<void> Function(MediaGalleryResult result, {int loopCount})? onDoneCallback;
  final Future<void> Function(Uint8List editedImage)? onEditImageCompleteCallback;

  /// Whether or not to enable picking unsupported type such as HEIC, HEIF, tiff, tif images on Android
  /// If true, HEIC, HEIF, tiff, tif images will be allowed to be picked on Android devices.
  /// otherwise, they can't be picked and show an unsupported file dialog.
  final bool enablePickingUnsupportedTypeOnAndroid;

  MediaGalleryController({
    required this.maxSelectable,
    this.filterMediaType = MediaGalleryFilterMediaType.imageAndVideo,
    this.onDoneCallback,
    this.onEditImageCompleteCallback,
    this.enablePickingUnsupportedTypeOnAndroid = true,
  });

  /// Scroll controller for the grid view
  ///
  /// This is used to listen the scroll position of the grid view
  final gridViewScrollController = ScrollController();

  /// Percentage of the scroll position to trigger the fetch more assets
  ///
  /// Default is `0.7`
  final positionTriggerPercentage = 0.7;

  /// Limit of assets per request
  ///
  /// Default is `40`
  final limitAssetsPerRequest = 40;

  /// Loading state for the album list
  bool isLoadingAlbumList = false;

  bool isLoadingAdditionalAlbumInfo = false;

  /// Loading state for the initial assets
  bool isLoadingInitAssets = false;

  /// Loading state for the more assets
  bool isLoadingMoreAssets = false;

  /// Verification status when selecting image
  bool isValidating = false;

  /// Current album
  ///
  /// This is used to store the current album selected
  AlbumAssetModel? get currentAlbum => _mediaGalleryService.currentAlbum;

  /// Current assets
  ///
  /// This is used to store the current assets
  List<AssetEntity> get currentAssets => _mediaGalleryService.cachedAlbumAssets[currentAlbum?.albumId] ?? [];

  /// Selected assets
  ///
  /// This is used to store the selected assets
  final selectedAssets = <AssetEntity>[];

  /// Not available assets
  ///
  /// This is used to store the not available assets
  final notAvailableAssets = <AssetEntity>[];

  /// Open selected preview
  ///
  /// Default is `false`
  bool openSelectedPreview = false;

  /// Selected preview height
  ///
  /// Default is `48`
  double selectedPreviewHeight = AppSpace.space12;

  /// Grid view bottom height
  ///
  /// Default is `32`
  double gridViewBottomHeight = AppSpace.space8;

  /// Validation queue
  ///
  /// This is used to validate the selected media
  final validationQueue = AsyncQueue.autoStart(allowDuplicate: false);

  /// Download file from cloud map
  ///
  /// This is used to store the download file from cloud map
  final downloadFileFromCloudMap = <String, double>{};

  MediaGalleryService get _mediaGalleryService => GetIt.I<MediaGalleryService>();

  List<AlbumAssetModel> get albumAssetList => _mediaGalleryService.cachedAlbums;

  final gridColumn = 3;

  StreamSubscription? _updateGalleryAssetSubscription;

  double get previewSize {
    return Get.width / gridColumn;
  }

  bool _isCheckingPermission = false;

  @override
  onInit() {
    super.onInit();
    _loadWarModeConfig();
    gridViewScrollController.addListener(positionListener);
    _updateGalleryAssetSubscription = eventBus.on<UpdateGalleryAssetEvent>().listen((event) {
      if (event.refresh == true && event.albumId == currentAlbum?.albumId) {
        update([MediaGalleryIds.albumSelectionBuildId, MediaGalleryIds.mainMediaGalleryId]);
      }
    });

    if (Platform.isAndroid) {
      checkPermissionToInitAlbums(refresh: true);
    } else {
      checkPermissionToInitAlbums();
    }
  }

  @override
  Future<void> onClose() async {
    gridViewScrollController.removeListener(positionListener);
    gridViewScrollController.dispose();
    validationQueue.close();
    await _updateGalleryAssetSubscription?.cancel();

    // Cancel any pending throttled load more operations
    EasyThrottle.cancel('media_gallery_load_more');

    //! Dispose the media gallery service cache
    //! This line made file path not found after picking images and use them after bottom sheet closed.
    // _mediaGalleryService.releaseCache();

    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    if (Platform.isAndroid) {
      checkPermissionToInitAlbums(refresh: true);
    } else {
      checkPermissionToInitAlbums();
    }
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
    update();
  }

  Future<void> checkPermissionToInitAlbums({bool refresh = false}) async {
    try {
      if (_isCheckingPermission) {
        return;
      }
      _isCheckingPermission = true;

      if (_mediaGalleryService.isGranted) {
        await fetchMedia(isInit: true, refresh: refresh);
        return;
      }

      final result = await _mediaGalleryService.checkPermission();
      if (result == false) {
        final granted = await _mediaGalleryService.requestPermission();
        if (granted) {
          await fetchMedia(isInit: true, refresh: refresh);
        }

        return;
      }
    } catch (e, stackTrace) {
      _log.e('Error checking permission to init albums', e, stackTrace);
    } finally {
      _isCheckingPermission = false;
    }
  }

  /// Only allow user to select one image
  ///
  /// - not show the select button
  /// - auto close the gallery after user select one image
  /// - not show the bottom bar
  bool get onlyOneSelectable => maxSelectable == 1;

  /// Check that user can press done
  ///
  /// - If the selected assets is not empty and download file from cloud map is empty
  /// - Return `true`
  /// - Otherwise, return `false`
  bool get isAvailableToDone => selectedAssets.isNotEmpty && downloadFileFromCloudMap.isEmpty && !isValidating;

  /// Check if there is more assets
  ///
  /// This is used to check if there is more assets
  ///
  /// - If the current assets length is less than the total assets
  /// - Return `true`
  /// - Otherwise, return `false`
  bool get isThereMoreAssets => currentAssets.length < (currentAlbum?.totalAssets ?? 0);

  /// Check if the album is empty
  ///
  /// This is used to check if the album is empty
  bool get isAlbumEmpty {
    return currentAssets.isEmpty;
  }

  /// Get the item count
  ///
  /// This is used to get the item count
  int get itemCount {
    if (isAlbumEmpty) {
      return 0;
    }

    if (isLoadingInitAssets) {
      return 40;
    }

    return currentAssets.length;
  }

  /// Update the selected preview height
  ///
  /// This is used to update the selected preview height
  ///
  /// - If the selected assets is not empty
  ///   - If the open selected preview is `true`
  ///     - Set the selected preview height to `80`
  ///     - Set the grid view bottom height to `152`
  ///   - Otherwise
  ///     - Set the selected preview height to `48`
  ///     - Set the grid view bottom height to `88`
  /// - Otherwise
  ///   - Set the selected preview height to `48`
  ///   - Set the grid view bottom height to `32`
  void updateSelectedPreviewHeight() {
    if (selectedAssets.isNotEmpty) {
      if (openSelectedPreview) {
        selectedPreviewHeight = AppSpace.space20;
        gridViewBottomHeight = AppSpace.space32 + 24;
      } else {
        selectedPreviewHeight = AppSpace.space12;
        gridViewBottomHeight = AppSpace.space20 + 8;
      }
    } else {
      selectedPreviewHeight = AppSpace.space12;
      gridViewBottomHeight = AppSpace.space8;
    }

    update([MediaGalleryIds.mainMediaGalleryId, MediaGalleryIds.selectedPreviewId]);
  }

  /// Open the selected preview list
  void openSelectedPreviewList() {
    openSelectedPreview = !openSelectedPreview;
    updateSelectedPreviewHeight();
  }

  /// Update the loading assets
  ///
  /// - If is init is `true`
  ///   - Set the loading init assets to the loading state
  /// - Otherwise
  ///   - Set the loading more assets to the loading state
  void updateLoadingAssets({bool isInit = false, bool isLoading = false}) {
    if (isInit) {
      isLoadingInitAssets = isLoading;
    } else {
      isLoadingMoreAssets = isLoading;
    }
  }

  /// Position listener
  ///
  /// This is used to listen the position of the grid view
  /// - If the current position is greater than or equal to the max position
  ///   - If there is more assets and not loading more assets
  ///     - Fetch album assets
  ///
  /// Uses throttle to prevent excessive fetch calls when scrolling quickly
  Future<void> positionListener() async {
    final currentPosition = gridViewScrollController.position.pixels;
    final maxPosition = gridViewScrollController.position.maxScrollExtent;

    if (currentPosition >= maxPosition * positionTriggerPercentage) {
      if (isThereMoreAssets && !isLoadingMoreAssets) {
        // Throttle to prevent rapid consecutive fetches
        EasyThrottle.throttle(
          'media_gallery_load_more',
          const Duration(milliseconds: 500),
          () async {
            await fetchMedia();
          },
        );
      }
    }
  }

  Future<void> fetchAlbums() async {
    try {
      isLoadingAlbumList = true;
      update([MediaGalleryIds.albumSelectionBuildId]);
      await _mediaGalleryService.getAlbums(requestType: filterMediaType);
    } catch (e, stackTrace) {
      _log.e('Error fetching albums', e, stackTrace);
    } finally {
      isLoadingAlbumList = false;
      update([MediaGalleryIds.albumSelectionBuildId]);
    }
  }

  Future<void> fetchMedia({bool isInit = false, bool refresh = false}) async {
    try {
      updateLoadingAssets(isInit: isInit, isLoading: true);
      update([MediaGalleryIds.mainMediaGalleryId]);

      if (isInit) {
        await _mediaGalleryService.getImagesFromAlbum(requestType: filterMediaType, refresh: refresh);
      } else {
        await _mediaGalleryService.getImagesFromAlbum(
          albumId: currentAlbum?.albumId,
          requestType: filterMediaType,
          loadMore: true,
          refresh: refresh,
        );
      }
    } catch (e, stackTrace) {
      _log.e('Error fetching media', e, stackTrace);
    } finally {
      updateLoadingAssets(isInit: isInit, isLoading: false);
      update([MediaGalleryIds.mainMediaGalleryId]);
    }
  }

  Future<void> onSelectedAlbum(AlbumAssetModel? selectedNewAlbum) async {
    if (selectedNewAlbum != null) {
      await _mediaGalleryService.changeAlbum(albumId: selectedNewAlbum.albumId);
      update([MediaGalleryIds.albumSelectionBuildId]);
      await fetchMedia();
    }
  }

  /// Get the asset index
  int selectedAssetIndex(AssetEntity asset) {
    return selectedAssets.indexWhere((element) => element.id == asset.id);
  }

  /// Check if the asset is selected
  bool isAvailableAsset(AssetEntity asset) {
    return !notAvailableAssets.contains(asset);
  }

  /// On selected asset and send
  ///
  /// This is used to handle the selected asset and send when max selectable is 1
  Future<void> onSelectedAssetAndSend(AssetEntity asset, BuildContext context) async {
    if (notAvailableAssets.contains(asset)) {
      return;
    }

    final amount = selectedAssets.length + 1;
    if (amount > maxSelectable) {
      EasyThrottle.throttle(
        'gallery_picker_max_selectable',
        const Duration(seconds: 3), // This is the same as toast duration.
        () => AppToast.showToast(
          context: context,
          message: 'Maximum @count selections reached'.trParams({'count': maxSelectable.toString()}),
          icon: Assets.vectors.iconInfo.svg(
            colorFilter: ColorFilter.mode(Get.context!.theme.appColors.iconPrimaryInverse, BlendMode.srcIn),
            width: AppSize.size8,
            height: AppSize.size8,
          ),
        ),
      );
      return;
    }

    selectedAssets.add(asset);
    final isValid = await validateSelectedMedia(asset);
    if (isValid) {
      await onDone();
    }
  }

  /// On selected asset
  ///
  /// This is used to handle the selected asset
  Future<void> onSelectedAsset(AssetEntity asset, BuildContext context) async {
    _log.d('onSelectedAsset: ${asset.id}');
    if (notAvailableAssets.contains(asset)) {
      return;
    }

    if (selectedAssets.contains(asset)) {
      selectedAssets.remove(asset);
    } else {
      if (selectedAssets.length < maxSelectable) {
        selectedAssets.add(asset);
        final isLocallyAvailable = await asset.isLocallyAvailable();
        if (isLocallyAvailable == false) {
          downloadFileFromCloudMap[asset.id] = 0.0;
        }

        validationQueue.addJob((_) async {
          try {
            await validateSelectedMedia(asset);
          } catch (e, stackTrace) {
            _log.e('Error in validation queue', e, stackTrace);
          }
        }, label: 'validate-media_${asset.id}');
      } else {
        EasyThrottle.throttle(
          'gallery_picker_max_selectable',
          const Duration(seconds: 3), // This is the same as toast duration.
          () => AppToast.showToast(
            context: context,
            message: 'Maximum @count selections reached'.trParams({'count': maxSelectable.toString()}),
            icon: Assets.vectors.iconInfo.svg(
              colorFilter: ColorFilter.mode(Get.context!.theme.appColors.iconPrimaryInverse, BlendMode.srcIn),
              width: AppSize.size8,
              height: AppSize.size8,
            ),
          ),
        );
      }
    }

    // update([MediaGalleryIds.mainMediaGalleryId]);

    if (selectedAssets.isEmpty) {
      updateSelectedPreviewHeight();
    } else {
      updateSelectedPreviewHeight();
    }
  }

  /// Validate selected media
  ///
  /// This is used to validate the selected media
  ///
  /// - If the image width is greater than the max width media or image height is greater than the max height media
  ///   - Add the asset to the not available assets
  ///   - Remove the asset from the selected assets
  ///   - Show the file too large dialog with size
  ///   - Return `false`
  /// - If the file size is greater than the file size limit
  ///   - Add the asset to the not available assets
  ///   - Remove the asset from the selected assets
  ///   - Show the file too large dialog
  ///   - Return `false`
  /// - Otherwise, return `true`
  Future<bool> validateSelectedMedia(AssetEntity asset) async {
    try {
      isValidating = true;

      if (!onlyOneSelectable && !selectedAssets.contains(asset)) {
        return false;
      }

      final imageWidth = asset.width;
      final imageHeight = asset.height;

      if (imageWidth > UChatConstant.maxWidthMedia || imageHeight > UChatConstant.maxHeightMedia) {
        notAvailableAssets.add(asset);
        selectedAssets.remove(asset);

        update([MediaGalleryIds.galleryAssetsId(asset.id)]);
        UChatNewDialog.showFileTooLargeDialogWithSize(context: Get.context!);

        return false;
      }

      File? file;
      final isLocallyAvailable = await asset.isLocallyAvailable();

      if (isLocallyAvailable == true) {
        file = await asset.file;
      } else {
        file = await downloadFileFromCloud(asset);
        downloadFileFromCloudMap.remove(asset.id);
      }

      int fileSize = 0;
      fileSize = (await file?.length()) ?? 0;

      if (fileSize >= UChatConstant.fileSizeLimit) {
        notAvailableAssets.add(asset);
        selectedAssets.remove(asset);

        update([MediaGalleryIds.galleryAssetsId(asset.id)]);
        UChatNewDialog.showFileTooLargeDialog(context: Get.context!);

        return false;
      }

      if (asset.type == AssetType.image) {
        final mime = (await asset.mimeTypeAsync) ?? '';
        bool isSupportedType = isImageTypeSupported(mime);
        if (Platform.isAndroid) {
          if (enablePickingUnsupportedTypeOnAndroid) {
            isSupportedType = true;
          }
        }

        if (!isSupportedType) {
          notAvailableAssets.add(asset);
          selectedAssets.remove(asset);

          update([MediaGalleryIds.galleryAssetsId(asset.id)]);
          UChatNewDialog.showUnsupportedFile(context: Get.context!);

          return false;
        }
      }

      return true;
    } catch (e, stackTrace) {
      _log.e('Error validating selected media', e, stackTrace);

      return false;
    } finally {
      isValidating = false;
      update([MediaGalleryIds.selectedPreviewId]);
    }
  }

  /// Download file from cloud
  ///
  /// This is used to download the file from cloud and return the file
  ///
  /// - If the asset is not locally available
  ///   - Download the file from cloud
  ///   - Return the file
  /// - Otherwise, return `null`
  Future<File?> downloadFileFromCloud(AssetEntity asset) async {
    final progressHandler = PMProgressHandler();
    final downloadProgressId = MediaGalleryIds.downloadProgressId(asset.id);
    final assetId = asset.id;

    // assign the progress handler to the map
    downloadFileFromCloudMap[asset.id] = 0.0;
    progressHandler.stream.listen((state) {
      downloadFileFromCloudMap[assetId] = state.progress;

      if (state.state == PMRequestState.success) {
        downloadFileFromCloudMap.remove(assetId);
      }

      update([downloadProgressId]);
      update([MediaGalleryIds.doneButtonId], downloadFileFromCloudMap.isEmpty);
    });

    return asset.loadFile(progressHandler: progressHandler).then((value) {
      return value;
    });
  }

  /// On done
  ///
  /// This is used to handle the on done pressed
  Future<void> onDone() async {
    if (onDoneCallback != null) {
      onDoneCallback!(MediaGalleryResult.fromAssets(selectedAssets));
      return;
    }

    if (selectedAssets.isEmpty) {
      Get.back();
    }

    final mediaGalleryResult = MediaGalleryResult.fromAssets(selectedAssets);
    Get.back<MediaGalleryResult>(result: mediaGalleryResult);
  }

  Future<void> onSelectMorePhotos() async {
    await PhotoManager.presentLimited();
    Get.back();
  }

  Future<void> onChangeSetting() async {
    await PhotoManager.openSetting();
    Get.back();
  }

  Future<void> getAllAdditionalAlbumInfo() async {
    try {
      isLoadingAdditionalAlbumInfo = true;
      update([MediaGalleryIds.albumMenuId]);

      final futures = <Future>[];
      for (var album in albumAssetList) {
        if (album.isFetchedAdditional == false) {
          futures.add(_mediaGalleryService.getAdditionalAlbumInfo(albumId: album.albumId));
        }
      }

      await Future.wait(futures);
    } catch (e, stackTrace) {
      _log.e('Error fetching additional album info', e, stackTrace);
    } finally {
      isLoadingAdditionalAlbumInfo = false;
      update([MediaGalleryIds.albumMenuId]);
    }
  }

  void handleEditImage(AssetEntity? asset, BuildContext context) async {
    final UChatEditImage imageEdit = UChatEditImage(
      editorFactory: (file, configs, callbacks) => ProImageEditor.file(
        file,
        configs: configs,
        callbacks: callbacks,
      ),
      doneIcon: buildDefaultDoneButton(context.theme.appColors.backgroundPrimary),
    );

    final file = await asset?.file;
    await imageEdit.handleEditImage(
      file: file,
      context: context,
      onEditComplete: (image) async {
        Get.back();
        onEditImageCompleteCallback?.call(image);
      },
    );
  }

  Widget buildDefaultDoneButton(Color backgroundColor) {
    return Container(
      width: 44.spMin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space3,
          vertical: AppSpace.space1,
        ),
        child: Assets.vectors.send.svg(),
      ),
    );
  }

  Future<void> onSendSample(AssetEntity asset) async {
    if (onDoneCallback != null) {
      GetIt.I<DebugSendSampleImageVideoUseCase>().call(
        DebugSendSampleImageVideoParams(asset: asset, onDoneCallback: onDoneCallback!),
      );
    } else {
      Get.back<MediaGalleryResult>(result: MediaGalleryResult.fromAssets([asset]));
    }
  }
}
