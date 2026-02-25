import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_by_qr_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AddContactByQrScreen extends GetView<AddContactByQrController> {
  const AddContactByQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.spMin),
        color: Colors.black,
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  MobileScanner(controller: controller.scannerController),
                  Column(
                    children: [
                      _buildNavHeader(),
                      _buildCameraFrame(context),
                    ],
                  ),
                ],
              ),
            ),
            _buildFlashBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpace.space2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 30.spMin,
            color: Colors.white,
            onPressed: controller.handleBack,
          ),
        ],
      ),
    );
  }

  Widget _buildCameraFrame(BuildContext context) {
    final screenWidth = Get.mediaQuery.size.width;
    final screenHeight = Get.mediaQuery.size.height;
    final currentOrientation = Get.mediaQuery.orientation;

    double qrCameraBoxSize = screenHeight / 2;

    if (currentOrientation == Orientation.portrait) {
      qrCameraBoxSize = screenWidth / 1.25;
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Container(
            height: qrCameraBoxSize,
            width: qrCameraBoxSize,
            decoration: BoxDecoration(
              color: const Color(0x11FFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Obx(() {
                  if (!controller.isCameraLoading()) return Container();

                  return SpinKitRing(color: Colors.white, size: 50.spMin, lineWidth: 2.spMin);
                }),
                Align(
                  alignment: Alignment.topLeft,
                  child: Assets.vectors.cropTopLeftBorder.svg(
                    height: AppSize.size12.spMin,
                    width: AppSize.size12.spMin,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Assets.vectors.cropTopRightBorder.svg(
                    height: AppSize.size12.spMin,
                    width: AppSize.size12.spMin,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Assets.vectors.cropBottomLeftBorder.svg(
                    height: AppSize.size12.spMin,
                    width: AppSize.size12.spMin,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Assets.vectors.cropBottomRightBorder.svg(
                    height: AppSize.size12.spMin,
                    width: AppSize.size12.spMin,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth / 10).spMin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: AppSize.size10),
                TextButton(
                  onPressed: controller.handleShowMyQR,
                  child: Container(
                    padding: EdgeInsets.all(15.spMin),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39.spMin),
                      border: Border.all(color: context.theme.appColors.borderDark),
                      color: context.theme.appColors.blanket.withValues(alpha: 0.48),
                    ),
                    child: Row(
                      children: [
                        Assets.vectors.qrCodeIcon.svg(
                          height: AppSize.size6.spMin,
                          width: AppSize.size6.spMin,
                        ),
                        AppSpace.space2.horizontalSpace,
                        AppText.body4Bold(
                          'My QR Code'.tr,
                          color: context.theme.appColors.textPrimaryInverse,
                          textAlign: TextAlign.center,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    GetIt.I<TaxonomyService>().sendEvent(EventName.clickPhotoQRCodePage);

                    controller.handleOpenAlbum(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.spMin),
                      borderRadius: BorderRadius.circular(10.spMin),
                    ),
                    child: Obx(() {
                      return SizedBox(
                        width: AppSize.size10,
                        height: AppSize.size10,
                        child: controller.getImage().isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(AppRadius.roundedLg),
                                child: AssetEntityImage(
                                  controller.getImage()[0],
                                  isOriginal: false,
                                  thumbnailSize: ThumbnailSize.square(AppSize.size10.round()),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppRadius.roundedLg),
                                  color: Colors.grey,
                                ),
                              ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildFlashBar(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      height: Get.height * 0.25,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                return GestureDetector(
                  onTap: () => controller.handleTurnOnFlash(context),
                  child: controller.flashOn.value
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFB800).withValues(alpha: 0.40),
                                blurRadius: AppRadius.roundedLg,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Assets.vectors.flashOn.svg(
                            height: AppSize.size16.spMin,
                            width: AppSize.size16.spMin,
                          ),
                        )
                      : Assets.vectors.flashOff.svg(height: AppSize.size16.spMin, width: AppSize.size16.spMin),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: AppSpace.space6.spMin, bottom: 20.spMin),
              child: AppText.body3(
                'Scan your friend\'s QR code to connect.'.tr,
                color: context.theme.appColors.textLighter,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
