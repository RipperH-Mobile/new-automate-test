import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/events/album_create_event.dart';
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
import 'package:uchat/features/album/domain/params/delete_album_task_param.dart';
import 'package:uchat/features/album/domain/params/download_all_image_in_album_param.dart';
import 'package:uchat/features/album/domain/params/fetch_albums_params.dart';
import 'package:uchat/features/album/domain/params/get_unfinished_album_task_param.dart';
import 'package:uchat/features/album/domain/params/retry_download_image_to_album_param.dart';
import 'package:uchat/features/album/domain/params/retry_upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/params/upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/cancel_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_all_image_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_image_from_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_albums_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_unfinished_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_download_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_upload_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';
import 'package:uchat/features/chat_room/presentation/chat_room_presentation.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_create_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_image_list_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_list_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_rename_arguments.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailAlbumListController extends GetxController with GetTickerProviderStateMixin {
  final String tag;

  ChatRoomDetailAlbumListController({required this.tag});

  final albumList = <AlbumEntity>[].obs;
  final albumTasks = <AlbumTaskEntity?>[].obs;
  final albumCount = 0.obs;
  final isAlbumDataInitCompleted = false.obs;

  String roomId = '';
  PagingController<int, AlbumEntity> pagingController = PagingController(firstPageKey: 1);
  StreamSubscription? albumCreateSubscription;
  StreamSubscription? albumUpdateSubscription;
  StreamSubscription? albumDeleteSubscription;
  StreamSubscription? albumImageUpdateSubscription;
  StreamSubscription? albumImageDeleteSubscription;
  StreamSubscription? uploadToAlbumStartedSubscription;
  StreamSubscription? uploadToAlbumProgressUpdatedSubscription;
  StreamSubscription? uploadToAlbumCompletedSubscription;
  StreamSubscription? uploadToAlbumCanceledSubscription;
  StreamSubscription? uploadToAlbumFailedSubscription;

  /// Animation variable to used in upload failed icon shake.
  final animation = Rxn<Animation<double>>();
  Map<String, AnimationController> allAnimationController = {};
  Map<String, Animation<double>> allAnimation = {};

  ChatRoomController get chatRoomController => Get.find<ChatRoomController>(tag: roomId);

  bool get isDisableAlbumMenu => chatRoomController.roomCapability.value.disableAlbumMenu;

  @override
  void onInit() {
    final arg = Get.arguments as ChatRoomDetailAlbumListArguments;
    roomId = arg.roomId;

    albumCreateSubscription = eventBus.on<AlbumCreateEvent>().listen((event) {
      if (event.roomId == roomId) {
        /// If album already exist, don't add it again. This is to prevent duplicate album in the list
        /// This can happen when AlbumCreateEvent is fired from use case (data from response)
        /// and state processor. This case will happen for the user that pressed create album.
        if (albumList.any((e) => e.id == event.album.id)) return;
        albumList.insert(0, event.album);
        pagingController.itemList = albumList();
        albumCount.value = albumCount.value + 1;
      }
    });

    albumUpdateSubscription = eventBus.on<AlbumUpdateEvent>().listen((event) {
      if (event.roomId == roomId) {
        int index = albumList.indexWhere((album) => album.id == event.album.id);
        if (index >= 0) {
          albumList[index] = albumList[index].copyWithEntity(event.album);
          albumList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
          pagingController.itemList = albumList();
        }
      }
    });

    albumDeleteSubscription = eventBus.on<AlbumDeleteEvent>().listen((event) {
      if (event.roomId == roomId) {
        int index = albumList.indexWhere((album) => album.id == event.album.id);

        /// If album is already deleted, don't try to delete it again and stop the function.
        if (index < 0) return;

        albumList.removeAt(index);
        pagingController.itemList = albumList();
        albumCount.value = albumCount.value - 1;
        if (event.album.id != null) {
          // Delete any unfinished task for this album.
          clearAlbumTask(event.album.id!);
        }
      }
    });

    albumImageUpdateSubscription = eventBus.on<AlbumImageUpdateEvent>().listen((event) {
      if (event.roomId == roomId) {
        int index = albumList.indexWhere((album) => album.id == event.album.id);
        if (index >= 0) {
          albumList[index] = albumList[index].copyWithEntity(event.album);
          albumList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
        }
      }
    });

    albumImageDeleteSubscription = eventBus.on<AlbumImageDeletedEvent>().listen((event) {
      if (event.roomId == roomId) {
        int index = albumList.indexWhere((album) => album.id == event.album.id);
        if (index >= 0) {
          albumList[index] = albumList[index].copyWithEntity(event.album);
          albumList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
        }
      }
    });

    uploadToAlbumStartedSubscription = eventBus.on<AlbumTaskStartedEvent>().listen((event) {
      if (event.task.roomId == roomId) {
        albumTasks.addIf(!albumTasks.any((e) => e?.albumId == event.task.albumId), event.task);
        allAnimationController[event.task.albumId!] = AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );
        allAnimation[event.task.albumId!] =
            Tween<double>(begin: 0.0, end: 1.0).animate(allAnimationController[event.task.albumId!]!);
      }
    });

    uploadToAlbumProgressUpdatedSubscription = eventBus.on<AlbumTaskProgressUpdatedEvent>().listen((event) {
      if (event.task.roomId == roomId) {
        int index = albumTasks.indexWhere((e) => e?.albumId == event.task.albumId);
        if (index >= 0) {
          albumTasks[index] = event.task;
          albumTasks.refresh();
        }
      }
    });

    uploadToAlbumCompletedSubscription = eventBus.on<AlbumTaskCompletedEvent>().listen((event) {
      if (event.task.roomId == roomId) {
        /// Update ui with complete status.
        int index = albumTasks.indexWhere((e) => e?.albumId == event.task.albumId);
        if (index >= 0) {
          albumTasks[index] = event.task;
          albumTasks.refresh();
        }

        /// Clear albumTask after 3 seconds to let the animation play first.
        Future.delayed(const Duration(seconds: 3), () {
          albumTasks.removeAt(index);
        });
      }
    });

    uploadToAlbumCanceledSubscription = eventBus.on<AlbumTaskCanceledEvent>().listen((event) {
      if (event.task.roomId == roomId) {
        albumTasks.removeWhere((e) => e?.albumId == event.task.albumId);
      }
    });

    uploadToAlbumFailedSubscription = eventBus.on<AlbumTaskFailedEvent>().listen((event) {
      if (event.task.roomId == roomId) {
        int index = albumTasks.indexWhere((e) => e?.albumId == event.task.albumId);
        if (index >= 0) {
          albumTasks[index] = event.task;
          albumTasks.refresh();
        }
        allAnimationController[event.task.albumId!]?.reset();
        allAnimationController[event.task.albumId!]?.forward();
      }
    });

    pagingController.addPageRequestListener((pageKey) {
      fetchAlbums(page: pageKey);
    });

    /// Find unfinished upload task and init albumTask value.
    initAlbumTask();

    super.onInit();
  }

  @override
  void onClose() {
    albumCreateSubscription?.cancel();
    albumUpdateSubscription?.cancel();
    albumDeleteSubscription?.cancel();
    albumImageUpdateSubscription?.cancel();
    albumImageDeleteSubscription?.cancel();
    uploadToAlbumStartedSubscription?.cancel();
    uploadToAlbumProgressUpdatedSubscription?.cancel();
    uploadToAlbumCompletedSubscription?.cancel();
    uploadToAlbumCanceledSubscription?.cancel();
    uploadToAlbumFailedSubscription?.cancel();
    for (final key in allAnimationController.keys) {
      allAnimationController[key]?.dispose();
    }

    super.onClose();
  }

  Future<void> initAlbumTask() async {
    try {
      final result = await GetIt.I<GetUnfinishedAlbumTaskUseCase>().call(GetUnfinishedAlbumTaskParam(
        roomId: roomId,
      ));
      albumTasks.value = result;
      for (final task in result) {
        if (task.albumId != null) {
          if (task.type == AlbumTaskType.download || task.type == AlbumTaskType.downloadAll) {
            /// If there is unfinished download task, clear it. because when retry download start from the beginning anyway.
            /// This is to prevent stuck failed download task.
            /// If there are any stuck download task, It will be cleared here when user go back to room detail and come back
            /// to this screen. but this should be a really rare case where user failed to download all images in album for
            /// the download task to stuck in failed status.
            clearAlbumTask(task.albumId!);
          } else {
            allAnimationController[task.albumId!] = AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: this,
            );
            allAnimation[task.albumId!] =
                Tween<double>(begin: 0.0, end: 1.0).animate(allAnimationController[task.albumId!]!);
          }
        }
      }
    } catch (e, stackTrace) {
      _log.e('initAlbumTask error.', e, stackTrace);
    }
  }

  void clearAlbumTask(String albumId) async {
    await GetIt.I<DeleteAlbumTaskUseCase>().call(DeleteAlbumTaskParam(albumId: albumId));
  }

  void fetchAlbums({int page = 1, int pageSize = 10}) async {
    try {
      final result = await GetIt.I<FetchAlbumsUseCase>().call(FetchAlbumsParams(
        roomId: roomId,
        page: page,
        pageSize: pageSize,
      ));
      if (page == 1) {
        /// clear all images data to start from page 1 again.
        albumList.clear();
      }
      if (result != null) {
        final dataList = result.data?.toList() ?? [];
        if (result.page >= result.totalPages) {
          pagingController.appendLastPage(dataList);
        } else {
          pagingController.appendPage(dataList, result.page + 1);
        }
        albumList.addAll(dataList);
        albumCount(result.total);
        isAlbumDataInitCompleted(true);
      }
    } catch (e) {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }

  void openAlbumDetailScreen(AlbumEntity album) {
    Get.toNamed(
      Routes.roomDetailAlbumImageList.replaceAll(':id', roomId).replaceAll(':albumId', album.id!),
      arguments: ChatRoomDetailAlbumImageListArguments(roomId: roomId, album: album),
    );
  }

  void openAddItemToAlbumBottomSheet(String albumId, BuildContext context, {bool isPopOver = true}) async {
    if (isPopOver) Get.back(); // Close popover
    if (checkIsDownloadOrUploading(context, albumId)) return;
    if (isDisableAlbumMenu == true) {
      await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    try {
      await GetIt.I<UploadImageToAlbumUseCase>().call(UploadImageToAlbumParam(
        albumId: albumId,
        roomId: roomId,
      ));
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('openAddItemToAlbumBottomSheet error with ApiException.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('openAddItemToAlbumBottomSheet error.', e, stackTrace);
    }
  }

  void openRenameScreen(String albumName, String albumId, BuildContext context) {
    Get.back(); // Close popover
    if (isDisableAlbumMenu) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }
    if (checkIsDownloadOrUploading(context, albumId)) return;
    Get.toNamed(
      Routes.roomDetailAlbumRename.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAlbumRenameArguments(
        roomId: roomId,
        albumId: albumId,
        oldAlbumName: albumName,
      ),
    );
  }

  void downloadAlbum(AlbumEntity album, BuildContext context) async {
    Get.back(); // Close popover
    if (checkIsDownloadOrUploading(context, album.id!)) return;
    try {
      final result = await GetIt.I<DownloadAllImageInAlbumUseCase>().call(DownloadAllImageInAlbumParam(
        albumId: album.id!,
        roomId: roomId,
        imageCount: album.totalImages,
      ));

      // If not successfully download all images, show partial success dialog.
      if (result != null && result.successCount < result.totalImages && result.successCount > 0) {
        UChatNewDialog.showDownloadAlbumImagePartialSuccessDialog(
          context: Get.context!,
          successCount: result.successCount,
          totalImages: result.totalImages,
        );
      } else if (result != null && result.successCount == 0 && !result.isCanceled) {
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

  Future<void> deleteAlbum(String albumId, BuildContext context) async {
    Get.back(); // Close popover
    if (checkIsDownloadOrUploading(context, albumId)) return;
    if (isDisableAlbumMenu) {
      await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }

    await UChatNewDialog.showDialog(
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
            albumId: albumId,
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

  void openCreateAlbumScreen(BuildContext context) async {
    if (isDisableAlbumMenu) {
      await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }

    final mediaGalleryService = GetIt.I<MediaGalleryService>();
    final hasPermission = await mediaGalleryService.checkPermission();

    if (!hasPermission) {
      final granted = await mediaGalleryService.requestPermission();
      if (!granted) {
        return;
      }
    }

    Get.toNamed(
      Routes.roomDetailAlbumCreate.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAlbumCreateArguments(
        roomId: roomId,
        hasGalleryPermission: await PermissionController.instance.checkGalleryPermission(),
      ),
    );
  }

  void handleProgressPressed(AlbumEntity album, BuildContext context) {
    final task = albumTasks().firstWhereOrNull((e) => e?.albumId == album.id);
    if (task == null) return;
    if (task.status == AlbumTaskStatus.inProgress) {
      cancelCurrentUploadTask(context, task);
    } else if (task.status == AlbumTaskStatus.failed) {
      UChatNewDialog.showRetryAlbumUploadDownloadDialog(
        context: context,
        title: task.uiString,
        showRetryButton: task.remainingUploadRetryAttempt > 0,
        onRetry: () async {
          if (task.type == AlbumTaskType.upload) {
            await GetIt.I<RetryUploadImageToAlbumUseCase>().call(RetryUploadImageToAlbumParam(
              task: task,
            ));
          } else if (task.type == AlbumTaskType.download) {
            await GetIt.I<RetryDownloadImageToAlbumUseCase>().call(RetryDownloadImageToAlbumParam(
              task: task,
            ));
          } else if (task.type == AlbumTaskType.downloadAll) {
            await GetIt.I<DownloadAllImageInAlbumUseCase>().call(DownloadAllImageInAlbumParam(
              albumId: task.albumId!,
              roomId: roomId,
              taskId: task.taskId,
              imageCount: album.totalImages,
            ));
          }
        },
        onDiscard: () async {
          cancelCurrentUploadTask(context, task);
        },
      );
    }
  }

  void cancelCurrentUploadTask(BuildContext context, AlbumTaskEntity task) async {
    try {
      await UChatLoading.show();
      if (task.type == AlbumTaskType.upload) {
        UploadImageToAlbumUseCase.cancelUploadTask();
        RetryUploadImageToAlbumUseCase.cancelUploadTask();
      } else if (task.type == AlbumTaskType.download) {
        DownloadImageFromAlbumUseCase.cancelDownloadTask();
        RetryDownloadImageToAlbumUseCase.cancelDownloadTask();
      } else if (task.type == AlbumTaskType.downloadAll) {
        DownloadAllImageInAlbumUseCase.cancelDownloadTask();
      }
      await GetIt.I<CancelAlbumTaskUseCase>().call(CancelAlbumTaskParam(
        task: task,
      ));
      albumTasks.removeWhere((e) => e?.albumId == task.albumId);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
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

  bool checkIsDownloadOrUploading(BuildContext context, String albumId) {
    bool isTaskExist = albumTasks().any((e) => e?.albumId == albumId);
    if (isTaskExist) {
      EasyThrottle.throttle(
        'album_can_not_do_it_now_toast',
        const Duration(seconds: 3), // This is the same as toast duration.
        () => AppToast.showAlbumCannotDoItNowToast(context),
      );
    }
    return isTaskExist;
  }
}
