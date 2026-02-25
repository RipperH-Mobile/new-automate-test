import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/domain/use_cases/take_photo_use_case.dart';
import 'package:uchat/features/media_gallery/domain/use_cases/get_one_image_gallery_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_default_group_avatar_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class GroupProfilePickerScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  final defaultGroupAvatarImages = <String>[].obs;
  final selectedDefaultAvatar = ''.obs;
  final randomDefaultGroupAvatar = ''.obs; // the random URL from the first screen
  final isUsingRandomDefault = false.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};
    randomDefaultGroupAvatar.value = args['randomDefaultGroupAvatar'] ?? '';
    isUsingRandomDefault.value = args['isUsingRandomDefault'] ?? false;

    // This is the last-chosen URL from the first screen
    final currentSelectedUrl = args['currentSelectedUrl'] ?? '';

    // If user is using random default, select it
    if (isUsingRandomDefault.value && randomDefaultGroupAvatar.value.isNotEmpty) {
      selectedDefaultAvatar.value = randomDefaultGroupAvatar.value;
    }
    // Else if the user had previously chosen some default from the grid, highlight that one
    else if (currentSelectedUrl.isNotEmpty) {
      selectedDefaultAvatar.value = currentSelectedUrl;
      // not using the random default anymore
      isUsingRandomDefault.value = false;
    }

    initData();
  }

  Future<void> initData() async {
    handleFetchDefaultGroupAvatar();
  }

  Future<void> handleFetchDefaultGroupAvatar() async {
    try {
      final response = await GetIt.I<FetchDefaultGroupAvatarUseCase>().call(NoParams());

      defaultGroupAvatarImages.value = response;
    } catch (e) {
      defaultGroupAvatarImages.value = [];
    }

    _log.d('Fetched defaultGroupAvatarImages: $defaultGroupAvatarImages');
  }

  /// User tapped "Choose from library"
  Future<void> handleSelectPhotoFromGallery(BuildContext context) async {
    final mediaResult = await GetIt.I<GetOneImageGalleryUseCase>().call(NoParams());
    if (mediaResult == null) return;

    if (mediaResult.imageCount > 0) {
      final selectedMedias = mediaResult.images;
      final pickedFile = await selectedMedias.first.file;

      if (pickedFile != null) {
        Get.back(result: pickedFile);
      }
    }
  }

  /// Called when user taps “Take Photo”
  Future<void> handleCapturePhotoFromCamera(BuildContext context) async {
    if (UChatCallController.instance.isSomeoneCameraOn) {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to access the camera while on a video call. Please try again after the call ends.'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
      return;
    }

    final response = await GetIt.I<TakePhotoUseCase>().call(
      (route) => route.settings.name == Routes.groupCreateFinal,
    );

    if (response != null && context.mounted) {
      final croppedFile = await _cropImage(context, response);
      if (croppedFile != null) {
        Get.back(result: croppedFile);
      }
    }
  }

  /// Crop the selected image using image_cropper
  Future<File?> _cropImage(BuildContext context, File imageFile) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1080,
      maxHeight: 1080,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.black,
          toolbarWidgetColor: context.theme.appColors.textPrimaryInverse,
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          showCropGrid: true,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          rotateButtonsHidden: true,
          resetButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (cropped == null) {
      // user canceled cropping => return null
      return null;
    }
    return File(cropped.path);
  }

  Future<void> handleSelectDefaultPhoto(String url) async {
    _log.d('Selected default photo: $url');
    try {
      selectedDefaultAvatar(url);
      // They are no longer using the random default that was auto-picked
      isUsingRandomDefault.value = false;
      // Return the chosen URL to the first screen
      Get.back(result: url);
    } catch (e, stackTrace) {
      _log.e('Call handleSelectDefaultPhoto error.', e, stackTrace);
    }
  }

  void handleCropProfileImage(File file) async {
    eventBus.fire(PasscodePreventEvent(preventActivate: true));

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      maxHeight: 1024,
      maxWidth: 1024,
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          showCropGrid: true,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          cropStyle: CropStyle.rectangle,
        ),
        IOSUiSettings(
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          rotateButtonsHidden: true,
          resetButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedImage == null) return;

    File fileImage = File(croppedImage.path);

    Get.back(result: fileImage);
  }
}
