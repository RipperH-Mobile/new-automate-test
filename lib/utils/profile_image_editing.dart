import 'dart:io';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

final profileImage = File('').obs;

Future<File?> handleCropProfileImage(File file, {bool edit = false}) async {
  if (!edit) profileImage(file);

  final croppedImage = await ImageCropper().cropImage(
    sourcePath: file.path,
    compressQuality: 100,
    maxHeight: 1024,
    maxWidth: 1024,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Profile Image'.tr,
        initAspectRatio: CropAspectRatioPreset.square,
        cropStyle: CropStyle.circle,
        lockAspectRatio: true,
        hideBottomControls: true,
      ),
      IOSUiSettings(
        aspectRatioPickerButtonHidden: true,
        cropStyle: CropStyle.circle,
        doneButtonTitle: 'Done'.tr,
        cancelButtonTitle: 'Cancel'.tr,
        resetButtonHidden: true,
      ),
    ],
  );

  eventBus.fire(PasscodePreventEvent(preventActivate: true));

  if (croppedImage == null) return null;

  File fileImage = File(croppedImage.path);
  return fileImage;
}
