import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;
import 'package:photo_manager/photo_manager.dart';

import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/add_contact/util/image_with_frame.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/media_gallery/domain/use_cases/get_one_image_gallery_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/qr_code/qr_code_bottom_sheet.dart';

final _log = useLogger();

class AddContactByQrController extends GetxController {
  final isCameraLoading = true.obs;
  final flashOn = false.obs;
  final popOnFinish = false.obs;
  final isShowingInvalidToast = false.obs;
  final hasResult = false.obs;

  final getImage = RxList<AssetEntity>();
  final mobile_scanner.MobileScannerController scannerController = mobile_scanner.MobileScannerController(
    autoStart: false,
    detectionSpeed: mobile_scanner.DetectionSpeed.noDuplicates,
    facing: mobile_scanner.CameraFacing.back,
    formats: [mobile_scanner.BarcodeFormat.qrCode],
  );

  StreamSubscription<Object?>? _scanSubscription;
  StreamSubscription? _callIncomingSubscription;

  @override
  void onInit() async {
    onInitScanner();

    final popOnFinishArg = Get.parameters['popOnFinish'];
    popOnFinish(
      popOnFinishArg != null && popOnFinishArg.toUpperCase() == 'TRUE',
    );

    await fetchAssets();

    _scanSubscription = scannerController.barcodes.listen((barcodeCapture) {
      onScanResult(barcodeCapture);
    });

    _callIncomingSubscription = eventBus.on<CallIncomingEvent>().listen(
      (event) async {
        Get.until((route) => Get.currentRoute == Routes.addContact);
      },
    );

    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    isCameraLoading.value = false;
  }

  @override
  void onClose() {
    scannerController.dispose();
    _scanSubscription?.cancel();
    _callIncomingSubscription?.cancel();
    super.onClose();
  }

  Future<void> onInitScanner() async {
    final result = await onCheckCameraPermission(Get.context!);
    if (!result) return;

    await scannerController.start();
  }

  Future<void> onScanResult(mobile_scanner.BarcodeCapture barcodeCapture) async {
    if (isCameraLoading.value == true) return;

    useLogger().d('onScanResult: ${barcodeCapture.barcodes.firstOrNull?.rawValue}');
    final result = barcodeCapture.barcodes.firstOrNull?.rawValue;

    _handleQRCodeResult(result);
  }

  void _handleQRCodeResult(String? result) {
    if (result == null) return;
    if (hasResult.value) return;

    if (result.isUChatQRCode) {
      hasResult.value = true;
      Get.back(result: result);
    } else {
      if (isShowingInvalidToast.value) return;

      isShowingInvalidToast.value = true;
      AppToast.showToast(
        context: Get.context!,
        message: 'Invalid QR Code'.tr,
      );

      // Reset flag after toast duration
      Future.delayed(AppToast.toastDuration, () {
        isShowingInvalidToast.value = false;
      });
    }
  }

  void handleBack() {
    Get.back();
  }

  Future<bool> onCheckGalleryPermission(BuildContext context) async {
    return await PermissionController.instance.requestGalleryPermissionDirect(context);
  }

  Future<bool> onCheckCameraPermission(BuildContext context) async {
    return await PermissionController.instance.requestCameraPermissionDirect(context);
  }

  void handleOpenAlbum(BuildContext context) async {
    try {
      final isPermissionGranted = await onCheckGalleryPermission(context);

      if (!isPermissionGranted) return;

      scannerController.stop();

      // Pick an image
      final mediaResult = await GetIt.I<GetOneImageGalleryUseCase>().call(NoParams());

      if (mediaResult == null) {
        scannerController.start();
        return;
      }

      if (mediaResult.imageCount > 0) {
        final imagePaths = await mediaResult.imagePaths;
        final imagePath = imagePaths.first;

        /// On Android app is put to background so PasscodePreventEvent is needed.
        /// On iOS app is not put to background passcode screen will not open so PasscodePreventEvent is not needed.
        if (Platform.isAndroid) {
          eventBus.fire(PasscodePreventEvent(preventActivate: true));
        }

        // Add white out frame to the QRr image before process
        // In case the QR image doesn't have out frame and can not process
        final imageWithFrame = await ImageWithFrame.processImage(imagePath: imagePath);

        await UChatLoading.show();
        await Future.delayed(const Duration(seconds: 1), () async {
          final mobile_scanner.BarcodeCapture? barcodeCapture = await scannerController.analyzeImage(
            imageWithFrame.path,
            formats: [mobile_scanner.BarcodeFormat.qrCode],
          );

          final result = barcodeCapture?.barcodes.firstOrNull?.rawValue;

          _handleQRCodeResult(result);
        });
        await UChatLoading.hide();
      }
      scannerController.start();
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleOpenAlbum error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }

  void handleTurnOnFlash(BuildContext context) async {
    final isCanAccessCamera = await onCheckCameraPermission(context);

    if (!isCanAccessCamera) return;

    await scannerController.toggleTorch();
    flashOn(!flashOn.value);
  }

  Future<void> handleShowMyQR() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickMyQRCodePage);

    try {
      final user = UserController.instance.currentUser();
      if (user == null) return;

      await scannerController.stop();
      await QrCodeBottomSheet.showFromUserEntity(user);
    } catch (e, stackTrace) {
      _log.e('Handle show my qr error', e, stackTrace);
    } finally {
      await scannerController.start();
    }
  }

  Future<void> fetchAssets() async {
    try {
      final mediaGalleryService = GetIt.I<MediaGalleryService>();
      final hasPermission = await mediaGalleryService.checkPermission();

      if (!hasPermission) {
        final granted = await mediaGalleryService.requestPermission();
        if (!granted) {
          return;
        }
      }

      final images = await mediaGalleryService.getImagesFromAlbum();
      if (images.isNotEmpty) {
        getImage(images);
        return;
      }
    } catch (e, stackTrace) {
      _log.e('fetchAssets error.', e, stackTrace);
    }
  }
}
