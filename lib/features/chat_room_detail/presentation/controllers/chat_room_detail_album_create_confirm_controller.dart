import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/params/create_album_param.dart';
import 'package:uchat/features/album/domain/params/retry_upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/params/upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/create_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_upload_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_create_confirm_arguments.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';
import 'package:uchat/features/media_gallery/domain/params/media_gallery_params.dart';
import 'package:uchat/features/media_gallery/domain/use_cases/get_media_gallery_use_case.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailAlbumCreateConfirmController extends GetxController {
  String tag;

  ChatRoomDetailAlbumCreateConfirmController({required this.tag});

  TextEditingController textFieldController = TextEditingController();
  String roomId = '';
  String? existingAlbumName;
  String? addToAlbumId;

  /// List of selected image file paths
  ///
  /// Used when user open this screen from chat message (Open context menu of image -> Add to album -> Create new album / Add to existing album)
  ///
  /// Images from message is in `file path format`, and others also in `file path format`.
  /// So, any image selected from message or gallery will be stored in file path format in this list.
  ///
  /// **NOTE: If this list is not empty, the `selectedImages` list will be ignored.**
  final selectedImagePathList = <String>[].obs;

  /// List of selected images from media gallery
  ///
  /// Used when user open this screen from chat room album screen (Open album screen -> Create new album -> Select images from gallery)
  ///
  /// Images from gallery is in `MediaAsset` format.
  /// So, any image selected from gallery will be stored in MediaAsset format in this list.
  ///
  /// **NOTE: If this list is not empty, the `selectedImagePathList` will be ignored.**
  final selectedImages = <MediaAsset>[].obs;
  final albumName = ''.obs;

  /// Used to enable or disable the add / create album button at the top right of the screen.
  final enableAddButton = false.obs;

  /// Used to enable or disable the add image button in the images grid view.
  final enableAddImage = false.obs;

  StreamSubscription? uploadToAlbumFailedSubscription;
  AlbumTaskEntity? uploadTask;

  ChatRoomController get chatRoomController {
    return Get.find<ChatRoomController>(tag: tag);
  }

  int get selectedImageCount {
    if (selectedImages.isNotEmpty) {
      return selectedImages.length;
    }

    return selectedImagePathList.length;
  }

  @override
  void onInit() {
    final arg = Get.arguments as ChatRoomDetailAlbumCreateConfirmArguments;
    roomId = arg.roomId;
    selectedImages.assignAll(arg.selectedMediaResult);
    selectedImagePathList(arg.imagePathList);
    enableAddImage(arg.enableAddImageButton);
    existingAlbumName = arg.existingAlbumName;
    albumName(existingAlbumName ?? '');
    addToAlbumId = arg.addToAlbumId;

    uploadToAlbumFailedSubscription = eventBus.on<AlbumTaskFailedEvent>().listen((event) {
      if (event.task.roomId == roomId && event.task.albumId == addToAlbumId) {
        uploadTask = event.task;
      }
    });

    updateEnableAddButton();

    super.onInit();
  }

  @override
  void onClose() {
    uploadToAlbumFailedSubscription?.cancel();
    super.onClose();
  }

  void handleAddButtonPressed(BuildContext context) {
    if (existingAlbumName == null) {
      createAlbum(context);
    } else {
      uploadImageToAlbum(context);
    }
  }

  void createAlbum(BuildContext context) async {
    try {
      if (chatRoomController.roomCapability.value.disableAlbumMenu == true) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await UChatLoading.show();

      Get.close(2);
      await GetIt.I<CreateAlbumUseCase>().call(CreateAlbumParam(
        albumName: albumName(),
        roomId: roomId,
        selectedImagePathList: selectedImagePathList(),
        selectedMediaAssets: selectedImages.toList(),
      ));
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      } else {
        _log.e('createAlbum ApiException error in ChatRoomDetailAlbumCreateConfirmController.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('createAlbum error in ChatRoomDetailAlbumCreateConfirmController.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }

  void uploadImageToAlbum(BuildContext context) async {
    if (addToAlbumId == null) return;

    try {
      if (chatRoomController.roomCapability.value.disableAlbumMenu == true) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await UChatLoading.show();

      if (uploadTask == null) {
        await GetIt.I<UploadImageToAlbumUseCase>().call(UploadImageToAlbumParam(
          albumId: addToAlbumId!,
          roomId: roomId,
          imagePathList: selectedImagePathList(),
        ));
      } else {
        await GetIt.I<RetryUploadImageToAlbumUseCase>().call(RetryUploadImageToAlbumParam(
          task: uploadTask!,
        ));
      }
      Get.close(2);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      } else {
        _log.e('uploadImageToAlbum ApiException error in ChatRoomDetailAlbumCreateConfirmController.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('uploadImageToAlbum error in ChatRoomDetailAlbumCreateConfirmController.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }

  void onTextFieldChanged(String value) {
    albumName(value);
    updateEnableAddButton();
  }

  void onClearTextField() {
    textFieldController.clear();
    albumName('');
    updateEnableAddButton();
  }

  void removeImage(int index, BuildContext context) {
    if (selectedImages.isNotEmpty) {
      final removedAsset = selectedImages.removeAt(index);
      try {
        final mediaGalleryCtl = MediaGalleryController.instance;
        mediaGalleryCtl.onSelectedAsset(removedAsset.asset, context);
      } catch (e, s) {
        _log.e('removeImage error in ChatRoomDetailAlbumCreateConfirmController.', e, s);
      }
    } else {
      selectedImagePathList.removeAt(index);
    }
    updateEnableAddButton();
  }

  void updateEnableAddButton() {
    enableAddButton(albumName.isNotEmpty && (selectedImagePathList.isNotEmpty || selectedImages.isNotEmpty));
  }

  void openGalleryPicker() async {
    try {
      final mediaResult = await GetIt.I<GetMediaGalleryUseCase>().call(
        MediaGalleryParams(
          filterMediaType: MediaGalleryFilterMediaType.image,
          maxSelectable: UChatConstant.albumUploadLimit,
          enablePickingUnsupportedTypeOnAndroid: false,
        ),
      );
      if (mediaResult == null) return;

      if (mediaResult.imageCount <= 0) return;

      await UChatLoading.show();

      final imagePaths = await mediaResult.imagePaths;
      if (imagePaths.isNotEmpty != true) return;
      selectedImagePathList.addAll(imagePaths);
      updateEnableAddButton();
    } catch (e, stackTrace) {
      _log.e('openGalleryPicker error in ChatRoomDetailAlbumCreateConfirmController.', e, stackTrace);
    } finally {
      await UChatLoading.hide();
    }
  }
}
