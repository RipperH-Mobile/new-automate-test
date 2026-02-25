import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/entities/share_album_image_entity.dart';
import 'package:uchat/features/album/domain/events/album_delete_event.dart';
import 'package:uchat/features/album/domain/events/album_image_deleted_event.dart';
import 'package:uchat/features/album/domain/events/album_image_update_event.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/events/album_task_completed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_progress_updated_event.dart';
import 'package:uchat/features/album/domain/events/album_task_started_event.dart';
import 'package:uchat/features/album/domain/events/album_update_event.dart';
import 'package:uchat/features/album/domain/params/cancel_album_task_param.dart';
import 'package:uchat/features/album/domain/params/delete_album_param.dart';
import 'package:uchat/features/album/domain/params/delete_images_in_album_param.dart';
import 'package:uchat/features/album/domain/params/download_all_image_in_album_param.dart';
import 'package:uchat/features/album/domain/params/download_image_from_album_param.dart';
import 'package:uchat/features/album/domain/params/fetch_images_in_albums_param.dart';
import 'package:uchat/features/album/domain/params/get_unfinished_album_task_param.dart';
import 'package:uchat/features/album/domain/params/upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/cancel_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_images_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_all_image_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_image_from_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_images_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_unfinished_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_download_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_upload_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_image_list_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_rename_arguments.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailAlbumImageListController extends GetxController {
  String tag;

  ChatRoomDetailAlbumImageListController({required this.tag});

  final album = Rx<AlbumEntity?>(null);
  final images = <AlbumImageEntity>[].obs;
  final albumTask = Rx<AlbumTaskEntity?>(null);

  final isMultiSelecting = false.obs;
  final selectedImages = <AlbumImageEntity>[].obs;
  String roomId = '';

  /// PageKey will be the oldest image's createdAt to fetch older images. When user scroll to older message
  /// this value will be updated to the oldest image again until we got the oldest from server.
  /// DateTime(1970) is used to check if it's the first time fetching images. If it is the first time
  /// we will fetch the first page of images from server without using beforeCreatedAt to get first page of newest images.
  PagingController<DateTime, AlbumImageEntity> pagingController = PagingController(firstPageKey: DateTime(1970));
  StreamSubscription? albumUpdateSubscription;
  StreamSubscription? albumDeleteSubscription;
  StreamSubscription? albumImageUpdateSubscription;
  StreamSubscription? albumImageDeleteSubscription;
  StreamSubscription? uploadToAlbumStartedSubscription;
  StreamSubscription? uploadToAlbumProgressUpdatedSubscription;
  StreamSubscription? uploadToAlbumCompletedSubscription;
  StreamSubscription? uploadToAlbumCanceledSubscription;
  StreamSubscription? uploadToAlbumFailedSubscription;

  ChatRoomController get chatRoomController => Get.find<ChatRoomController>(tag: roomId);

  bool get isDisableAlbumMenu => chatRoomController.roomCapability.value.disableAlbumMenu;

  @override
  void onInit() {
    final arg = Get.arguments as ChatRoomDetailAlbumImageListArguments;
    album(arg.album);
    roomId = arg.roomId;

    albumUpdateSubscription = eventBus.on<AlbumUpdateEvent>().listen((event) {
      if (event.roomId == roomId && event.album.id == album()?.id) {
        album.forceUpdate(album()?.copyWithEntity(event.album));
      }
    });

    albumDeleteSubscription = eventBus.on<AlbumDeleteEvent>().listen((event) {
      if (event.roomId == roomId && event.album.id == album()?.id) {
        /// Prevent Get.back() from being called multiple times. In case this user press delete from this screen This event
        /// will be fired from response in use case and from state.
        if (Get.currentRoute ==
            Routes.roomDetailAlbumImageList.replaceAll(':id', roomId).replaceAll(':albumId', album()?.id ?? '')) {
          Get.back();
        }
      }
    });

    albumImageUpdateSubscription = eventBus.on<AlbumImageUpdateEvent>().listen((event) {
      if (event.roomId == roomId && event.album.id == album()?.id) {
        final newAlbum = album()?.copyWithEntity(event.album);
        album.forceUpdate(newAlbum);
        pagingController.refresh();
      }
    });

    albumImageDeleteSubscription = eventBus.on<AlbumImageDeletedEvent>().listen((event) {
      if (event.roomId == roomId && event.album.id == album()?.id) {
        // Update last ten, total image and other album data.
        final newAlbum = album()?.copyWithEntity(event.album);

        if (newAlbum == null) return;

        album.forceUpdate(newAlbum);
        // Remove deleted images from the list.
        pagingController.itemList?.removeWhere((element) => event.deletedImages.contains(element.imageId));
      }
    });

    uploadToAlbumStartedSubscription = eventBus.on<AlbumTaskStartedEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == album()?.id) {
        albumTask.value = event.task;
        albumTask.refresh();
      }
    });

    uploadToAlbumProgressUpdatedSubscription = eventBus.on<AlbumTaskProgressUpdatedEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == album()?.id) {
        albumTask.value = event.task;
        albumTask.refresh();
      }
    });

    uploadToAlbumCompletedSubscription = eventBus.on<AlbumTaskCompletedEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == album()?.id) {
        AppToast.showAlbumTaskSuccessToast(
          context: Get.context!,
          albumName: album()?.albumName ?? '',
          type: event.task.type!,
        );
        albumTask.value = null;
        albumTask.refresh();
      }
    });

    uploadToAlbumCanceledSubscription = eventBus.on<AlbumTaskCanceledEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == album()?.id) {
        albumTask.value = null;
        albumTask.refresh();
      }
    });

    uploadToAlbumFailedSubscription = eventBus.on<AlbumTaskFailedEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == album()?.id) {
        albumTask.value = event.task;
        albumTask.refresh();
      }
    });

    initAlbumImages();

    /// Find unfinished upload task and init albumTask value.
    initAlbumTask();

    super.onInit();
  }

  @override
  void onClose() {
    albumUpdateSubscription?.cancel();
    albumDeleteSubscription?.cancel();
    albumImageUpdateSubscription?.cancel();
    albumImageDeleteSubscription?.cancel();
    uploadToAlbumStartedSubscription?.cancel();
    uploadToAlbumProgressUpdatedSubscription?.cancel();
    uploadToAlbumCompletedSubscription?.cancel();
    uploadToAlbumCanceledSubscription?.cancel();
    uploadToAlbumFailedSubscription?.cancel();

    super.onClose();
  }

  void initAlbumImages() async {
    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == DateTime(1970)) {
        fetchAlbumImages();
      } else {
        fetchAlbumImages(beforeCreatedAt: pageKey);
      }
    });
  }

  Future<void> initAlbumTask() async {
    if (album() == null) {
      _log.e('initAlbumTask error. album is null.');
      return;
    }
    final result = await GetIt.I<GetUnfinishedAlbumTaskUseCase>().call(GetUnfinishedAlbumTaskParam(
      roomId: roomId,
      albumId: album()!.id,
    ));
    albumTask.value = result.firstOrNull;
  }

  /// Looks like infinite scroll pagination library doesn't support inserting item at the beginning of the list.
  /// so [afterCreatedAt] is unused for now.
  void fetchAlbumImages({
    int page = 1,
    DateTime? beforeCreatedAt,
    DateTime? afterCreatedAt,
  }) async {
    try {
      final result = await GetIt.I<FetchImagesInAlbumUseCase>().call(
        FetchImagesInAlbumParam(
          albumId: album()!.id!,
          page: page,
          beforeCreatedAt: beforeCreatedAt,
          afterCreatedAt: afterCreatedAt,
        ),
      );
      if (result != null) {
        /// If both beforeCreatedAt and afterCreatedAt are null that should mean we are fetching the first page of images.
        if (beforeCreatedAt == null && afterCreatedAt == null) {
          /// clear all images data to start from page 1 again.
          images.clear();
        }

        /// When scrolling to older images, we will append the new images to the end of the list.
        final imageList = result.data?.toList() ?? [];

        /// When fetching if totalPages is 1 that should mean there is only 1 page of images.
        /// So we can use appendLastPage to stop fetching more images.
        if (result.totalPages <= 1) {
          pagingController.appendLastPage(imageList);
        } else {
          pagingController.appendPage(imageList, imageList.lastOrNull?.createAt);
        }
        images.addAll(imageList);
      }
    } catch (e, stackTrace) {
      _log.e('fetchAlbumImages error.', e, stackTrace);
    }
  }

  void openAddItemToAlbumBottomSheet(BuildContext context, {bool openFromPopOver = false}) async {
    if (openFromPopOver) Get.back(); // Close popover
    if (checkIsDownloadOrUploading(context)) return;
    if (isDisableAlbumMenu == true) {
      await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    try {
      await GetIt.I<UploadImageToAlbumUseCase>().call(UploadImageToAlbumParam(
        albumId: album()!.id!,
        roomId: roomId,
      ));
      pagingController.refresh();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else if (e.type != DioExceptionType.cancel) {
        _log.e('openAddItemToAlbumBottomSheet DioException error.', e);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('openAddItemToAlbumBottomSheet ApiException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('openAddItemToAlbumBottomSheet error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void openRenameScreen(BuildContext context) {
    Get.back(); // Close popover
    if (isDisableAlbumMenu == true) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context)) return;
    Get.toNamed(
      Routes.roomDetailAlbumRename.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAlbumRenameArguments(
        roomId: roomId,
        albumId: album()!.id!,
        oldAlbumName: album()!.albumName!,
      ),
    );
  }

  void deleteAlbum(BuildContext context) {
    Get.back(); // Close popover
    if (isDisableAlbumMenu == true) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context)) return;
    UChatNewDialog.showDialog(
      context: context,
      title: 'Delete album'.tr,
      description:
          'Please note that you will not be able to recover the album once it is deleted. Do you want to delete this album?'
              .tr,
      cancelTextColor: context.theme.appColors.textLight,
      confirmText: 'Delete'.tr,
      confirmTextColor: context.theme.appColors.textError,
      onConfirm: () async {
        try {
          if (chatRoomController.roomCapability.value.disableAlbumMenu == true) {
            await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
            return;
          }

          await GetIt.I<DeleteAlbumUseCase>().call(DeleteAlbumParam(
            albumId: album()!.id!,
            roomId: roomId,
          ));
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_ALBUM_IMAGE_UPLOADING_IN_PROGRESS_ERROR') {
            /// If someone else is uploading images to the album this user trying to delete.
            /// The delete will failed and show toast to notify user.
            EasyThrottle.throttle(
              'album_can_not_do_it_now_toast',
              const Duration(seconds: 3), // This is the same as toast duration.
              () => AppToast.showAlbumCannotDoItNowToast(context),
            );
          } else if (e.exceptionType == ApiExceptionType.permissionDenied) {
            UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          } else {
            _log.e('deleteAlbum error with ApiException.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: e,
            );
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('deleteAlbum error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      },
    );
  }

  void onBackPressed() {
    if (isMultiSelecting()) {
      isMultiSelecting(false);
      selectedImages.clear();
    } else {
      Get.back();
    }
  }

  void handleSelectAllOrClearAllPressed() {
    if (selectedImages.length == min(images.length, UChatConstant.albumUploadLimit)) {
      selectedImages.clear();
    } else {
      final Set<AlbumImageEntity> uniqueImages = selectedImages.toSet();
      for (final image in images) {
        if (uniqueImages.length >= UChatConstant.albumUploadLimit) break;
        uniqueImages.add(image);
      }
      selectedImages.assignAll(uniqueImages.toList());
    }
  }

  void handleStartSelect(BuildContext context) {
    if (isDisableAlbumMenu == true) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context)) return;
    if (!isMultiSelecting()) {
      isMultiSelecting(true);
    }
  }

  void handleSelectImage(int index) {
    if (selectedImages.contains(images[index])) {
      selectedImages.remove(images[index]);
    } else {
      if (selectedImages.length >= UChatConstant.albumUploadLimit) {
        EasyThrottle.throttle(
          'album_image_list_max_selectable',
          const Duration(seconds: 3), // This is the same as toast duration.
          () => AppToast.showToast(
            context: Get.context!,
            message: 'Maximum @count selections reached'.trParams({'count': UChatConstant.albumUploadLimit.toString()}),
            icon: Assets.vectors.iconInfo.svg(
              colorFilter: ColorFilter.mode(Get.context!.theme.appColors.iconPrimaryInverse, BlendMode.srcIn),
              width: AppSize.size8,
              height: AppSize.size8,
            ),
          ),
        );
        return;
      }
      selectedImages.add(images[index]);
    }
  }

  void openMediaViewer(AlbumImageEntity image) {
    final albumId = album()?.id;
    if (albumId == null) return;
    MediaViewerService.instance.openMediaViewer(
        initialMedia: image,
        medias: images,
        openFrom: MediaViewerOpenFrom.albumDetail,
        albumId: albumId,
        imageIndexOfGroup: images.indexOf(image),
        onFetchMoreMedias: () async {
          try {
            final result = await GetIt.I<FetchImagesInAlbumUseCase>().call(FetchImagesInAlbumParam(
              albumId: albumId,
              beforeCreatedAt: images.last.createAt,
            ));

            List<MediaFileModel> newMediaFiles = [];
            if (result?.data != null) {
              newMediaFiles = result!.data!
                  .map((e) => MediaFileModel.fromAlbumImageEntity(
                        e,
                        albumId: albumId,
                        albumName: album()?.albumName ?? 'UNKNOWN'.tr,
                        roomId: roomId,
                      ))
                  .toList();
            }

            return newMediaFiles;
          } catch (e, stackTrace) {
            _log.e('loadMoreOnAlbumScreen error', e, stackTrace);
            return [];
          }
        });
  }

  void handleLongPressImage(BuildContext context, AlbumImageEntity image, {bool isDisableAlbumMenu = false}) {
    UChatNewDialog.showAlbumImageLongPressDialog(
      context: context,
      imageUrl: image.imageUrl ?? '',
      isDisableAlbumMenu: isDisableAlbumMenu,
      isSelected: selectedImages.contains(image),
      onSelectPressed: () {
        handleStartSelect(context);
        handleSelectImage(images.indexOf(image));
      },
      onDownloadPressed: () {
        downloadOneImage(context, image);
      },
      onSharePressed: () {
        GetIt.I<SharingService>().share(
          data: ShareBottomSheetDataEntity(
            albumImageList: ShareAlbumImageEntity(
              albumId: album()!.id!,
              images: [image],
            ),
          ),
        );
      },
      onDeletePressed: () {
        deleteOneImage(context, image);
      },
    );
  }

  void shareSelectedImages() async {
    if (selectedImages.isEmpty) return;
    final result = await GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        albumImageList: ShareAlbumImageEntity(
          albumId: album()!.id!,
          images: selectedImages(),
        ),
      ),
    );
    if (result == true) {
      // Reset multi select after confirm is pressed.
      isMultiSelecting(false);
      selectedImages.clear();
    }
  }

  void deleteOneImage(BuildContext context, AlbumImageEntity image) {
    if (isDisableAlbumMenu == true) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context)) return;
    showConfirmDeleteImageDialog(context, [image.imageId!]);
  }

  void deleteSelectedImages(BuildContext context) {
    if (selectedImages.isEmpty) return;
    if (isDisableAlbumMenu == true) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context)) return;
    showConfirmDeleteImageDialog(context, selectedImages.map((e) => e.imageId!).toList());
  }

  void showConfirmDeleteImageDialog(BuildContext context, List<String> imageIds) async {
    final isConfirm = await UChatNewDialog.showDialog(
      context: context,
      title: 'Delete items'.tr,
      description: 'Do you want to delete the @count pictures in this album?'.trParams({
        'count': imageIds.length.toString(),
      }),
      confirmText: 'Delete'.tr,
      confirmTextColor: context.theme.appColors.textError,
      cancelText: 'Cancel'.tr,
      cancelTextColor: context.theme.appColors.textLight,
      onConfirm: () async {
        try {
          if (chatRoomController.roomCapability.value.disableAlbumMenu == true) {
            await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
            return;
          }

          final result = await GetIt.I<DeleteImagesInAlbumUseCase>().call(
            DeleteImagesInAlbumParam(
              albumId: album()!.id!,
              roomId: roomId,
              imageIds: imageIds,
            ),
          );
          if (result != null) {
            for (final image in result.deletedImages) {
              images.removeWhere((element) => element.imageId == image);
            }
          }
        } on ApiException catch (e, stackTrace) {
          if (e.exceptionType == ApiExceptionType.permissionDenied) {
            UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          } else {
            _log.e('deleteImagesInAlbum error with ApiException.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('deleteImagesInAlbum error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
        }
      },
    );
    if (isConfirm) {
      // Reset multi select after confirm is pressed.
      isMultiSelecting(false);
      selectedImages.clear();
    }
  }

  void downloadOneImage(BuildContext context, AlbumImageEntity image) async {
    if (checkIsDownloadOrUploading(context)) return;
    if (image.albumId == null) return;

    try {
      await GetIt.I<DownloadImageFromAlbumUseCase>().call(DownloadImageFromAlbumParam(
        albumId: image.albumId!,
        roomId: roomId,
        images: [image],
      ));
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('downloadOneImage error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void downloadImages(BuildContext context) async {
    if (selectedImages.isEmpty) return;
    if (checkIsDownloadOrUploading(context)) return;

    try {
      List<AlbumImageEntity> selectedData = List.from(selectedImages());
      // Reset multi select after download is pressed.
      isMultiSelecting(false);
      selectedImages.clear();
      final result = await GetIt.I<DownloadImageFromAlbumUseCase>().call(DownloadImageFromAlbumParam(
        albumId: album()!.id!,
        roomId: roomId,
        images: selectedData,
      ));
      if (result.successCount < result.totalImages && result.successCount > 0) {
        UChatNewDialog.showDownloadAlbumImagePartialSuccessDialog(
          context: Get.context!,
          successCount: result.successCount,
          totalImages: result.totalImages,
        );
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('downloadImages error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void downloadAlbum(BuildContext context) async {
    Get.back(); // Close popover
    if (checkIsDownloadOrUploading(context)) return;
    try {
      final result = await GetIt.I<DownloadAllImageInAlbumUseCase>().call(DownloadAllImageInAlbumParam(
        albumId: album()!.id!,
        roomId: roomId,
        imageCount: album()?.totalImages,
      ));

      if (result?.isCanceled == true) return;

      // If not successfully download all images, show partial success dialog.
      if (result != null && result.successCount < result.totalImages && result.successCount > 0) {
        UChatNewDialog.showDownloadAlbumImagePartialSuccessDialog(
          context: Get.context!,
          successCount: result.successCount,
          totalImages: result.totalImages,
        );
      } else if (result != null && result.successCount == 0) {
        // If cannot download any image, show general error dialog.
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('downloadAlbum error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  bool checkIsDownloadOrUploading(BuildContext context) {
    if (albumTask() != null) {
      EasyThrottle.throttle(
        'album_can_not_do_it_now_toast',
        const Duration(seconds: 3), // This is the same as toast duration.
        () => AppToast.showAlbumCannotDoItNowToast(context),
      );
    }
    return albumTask() != null;
  }

  void cancelCurrentTask(BuildContext context) async {
    try {
      await UChatLoading.show();
      if (albumTask()?.type == AlbumTaskType.upload) {
        UploadImageToAlbumUseCase.cancelUploadTask();
        RetryUploadImageToAlbumUseCase.cancelUploadTask();
      } else if (albumTask()?.type == AlbumTaskType.download) {
        DownloadImageFromAlbumUseCase.cancelDownloadTask();
        RetryDownloadImageToAlbumUseCase.cancelDownloadTask();
      } else if (albumTask()?.type == AlbumTaskType.downloadAll) {
        DownloadAllImageInAlbumUseCase.cancelDownloadTask();
      }
      try {
        if (albumTask() != null) {
          await GetIt.I<CancelAlbumTaskUseCase>().call(CancelAlbumTaskParam(
            task: albumTask()!,
          ));
          albumTask.value = null;
          albumTask.refresh();
        }
      } on FailedHostLookupException catch (_) {
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } catch (e, stackTrace) {
        _log.e('handleProgressPressed error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      }
    } catch (e, stackTrace) {
      _log.e('handleProgressPressed error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }
}
