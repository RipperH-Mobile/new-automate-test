import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/add_contact/presentation/widgets/my_qr_code.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class MyQrCodeController extends GetxController {
  final user = Get.find<UserController>();
  GlobalKey qrCodeGlobalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();
  final showScanQrCodeButton = Get.parameters['showScanQrCodeButton']?.toUpperCase() == 'TRUE';

  final errorCorrectionLevel = 1.obs;
  final qrCodeData = ''.obs;
  final isDownloading = false.obs;
  final isShareBottomSheetOpening = false.obs;

  @override
  void onInit() {
    errorCorrectionLevel(QrErrorCorrectLevel.levels[3]);
    genQrCodeData();
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  void handleRefreshQr() {
    genQrCodeData();
  }

  void handleShareQr() async {
    try {
      if (isShareBottomSheetOpening.value) return;

      isShareBottomSheetOpening.value = true;
      Uint8List? image = await capturedQRCode();

      // Get directory to save temp file
      final String path = (await getApplicationDocumentsDirectory()).path;
      final qrImage = File('$path/my_uchat_qr.png');
      await qrImage.writeAsBytes(image);

      await GetIt.I<SharingService>().share(
        data: ShareBottomSheetDataEntity(
          newFile: await FileInfoModel.fromFile(qrImage, 0),
        ),
      );

      Get.back();

      isShareBottomSheetOpening.value = false;
    } catch (e, stackTrace) {
      _log.d('Handle share qr error', e, stackTrace);
    }
  }

  void handleDownloadQr(BuildContext context) async {
    try {
      final result = await PermissionController.instance.requestGalleryPermissionDirect(context);

      if (!result || isDownloading.value) return;

      isDownloading.value = true;
      await UChatLoading.show();
      Uint8List? image = await capturedQRCode();

      final saveResult = await SaverGallery.saveImage(
        image.buffer.asUint8List(),
        fileName: 'my_uchat_qr',
        skipIfExists: false,
      );

      if (saveResult.isSuccess && context.mounted) {
        Get.back();
        AppToast.showDownloadToast(
          context: context,
          title: 'Saved successfully'.tr,
          height: AppSize.size12.spMin,
        );

        isDownloading.value = false;
      }
    } catch (e, stackTrace) {
      if (context.mounted) {
        AppToast.hideToast(context);
      }

      isDownloading.value = false;
      _log.e('handleDownloadQr error.', e, stackTrace);
    } finally {
      UChatLoading.hide();
    }
  }

  Future<Uint8List> capturedQRCode() async {
    Uint8List image = await screenshotController.captureFromWidget(MyQrCode(
      width: 512.spMin,
      height: 512.spMin,
      qrCodeData: qrCodeData.value,
      padding: EdgeInsets.all(20.spMin),
      backgroundColor: Colors.white,
    ));

    return image;
  }

  void genQrCodeData() {
    qrCodeData(
      '${AppEnv.addFriendPrefix}${user.currentUser()!.username!}',
    );
  }
}
