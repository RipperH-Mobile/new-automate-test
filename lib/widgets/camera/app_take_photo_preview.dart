import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class AppTakeImagePreview extends StatefulWidget {
  const AppTakeImagePreview({
    super.key,
    required this.image,
  });

  final File image;

  @override
  State<AppTakeImagePreview> createState() => _AppTakeImagePreviewState();
}

class _AppTakeImagePreviewState extends State<AppTakeImagePreview> {
  File? cropImage;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        AppSpace.space3,
                      ),
                      child: Assets.vectors.xClose.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconPrimaryInverse,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        AppSpace.space3,
                      ),
                      child: Assets.vectors.crop01.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconPrimaryInverse,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    onTap: () async {
                      final croppedImage = await ImageCropper().cropImage(
                        sourcePath: cropImage?.path ?? widget.image.path,
                        compressQuality: 100,
                        maxHeight: 1024,
                        maxWidth: 1024,
                        uiSettings: [
                          AndroidUiSettings(
                            backgroundColor: Colors.black,
                            toolbarWidgetColor: Colors.white,
                            toolbarColor: Colors.black,
                            toolbarTitle: '',
                            cropGridStrokeWidth: 1,
                            hideBottomControls: true,
                            showCropGrid: true,
                            lockAspectRatio: false,
                            cropFrameColor: Colors.white,
                            cropGridColor: Colors.white,
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
                      if (croppedImage != null) {
                        cropImage = File(croppedImage.path);
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: UChatConstant.cameraPreviewPaddingFromTop,
            child: Container(
              color: Colors.red,
              child: Image.file(
                cropImage ?? widget.image,
                width: 1.sw,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpace.space2,
                  left: AppSpace.space4,
                  right: AppSpace.space4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFilledButton.dark(
                      label: 'Retake'.tr,
                      context: context,
                      size: AppButtonSize.small,
                      style: AppButtonStyle.fullRounded,
                      isExpanded: false,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    AppFilledButton.primary(
                      label: 'Sent'.tr,
                      icon: Assets.vectors.send.svg(
                        width: AppSpace.space6,
                        height: AppSpace.space6,
                      ),
                      iconAlignment: IconAlignment.end,
                      size: AppButtonSize.small,
                      style: AppButtonStyle.fullRounded,
                      isExpanded: false,
                      context: context,
                      onTap: () {
                        Get.back(
                          result: cropImage ?? widget.image,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
