import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class QrCodeController extends GetxController {
  final String username;
  final String displayName;
  final VoidCallback? onClickShare;
  final VoidCallback? onClickSave;
  final VoidCallback? onSaved;

  QrCodeController({
    required this.username,
    required this.displayName,
    this.onClickShare,
    this.onClickSave,
    this.onSaved,
  });

  GlobalKey qrCodeGlobalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();

  final qrCodeData = ''.obs;
  final isDownloading = false.obs;
  final isShareBottomSheetOpening = false.obs;

  @override
  void onInit() {
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
      onClickShare?.call();

      if (isShareBottomSheetOpening.value) return;

      isShareBottomSheetOpening.value = true;
      Uint8List? image = await capturedQRCode();

      if (image == null) {
        return;
      }

      // Get directory to save temp file
      final String path = (await getApplicationDocumentsDirectory()).path;
      final qrImage = File('$path/my_uchat_qr.png');
      await qrImage.writeAsBytes(image);

      await GetIt.I<SharingService>().share(
        data: ShareBottomSheetDataEntity(
          newFile: await FileInfoModel.fromFile(qrImage, 0),
        ),
      );

      isShareBottomSheetOpening.value = false;
    } catch (e, stackTrace) {
      _log.d('Handle share qr error', e, stackTrace);
    }
  }

  void handleDownloadQr(BuildContext context) async {
    try {
      onClickSave?.call();

      final result = await PermissionController.instance.requestGalleryPermissionDirect(context);

      if (!result || isDownloading.value) return;

      isDownloading.value = true;
      await UChatLoading.show();
      Uint8List? image = await capturedQRCode();

      if (image == null) {
        return;
      }

      final saveResult = await SaverGallery.saveImage(
        image,
        fileName: 'my_uchat_qr',
        skipIfExists: false,
      );

      await UChatLoading.hide();
      if (saveResult.isSuccess && context.mounted) {
        onSaved?.call();
        if (!context.mounted) return;
        AppToast.showDownloadToast(
          context: context,
          title: 'Saved successfully'.tr,
          height: AppSize.size12.spMin,
        );
        await Future.delayed(const Duration(seconds: 3));
        isDownloading.value = false;
      }
    } catch (e, stackTrace) {
      if (context.mounted) {
        AppToast.hideToast(context);
      }

      isDownloading.value = false;
      await UChatLoading.hide();
      _log.e('handleDownloadQr error.', e, stackTrace);
    }
  }

  Future<Uint8List?> capturedQRCode() async {
    final boundary = qrCodeGlobalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void genQrCodeData() {
    qrCodeData('${AppEnv.addFriendPrefix}$username');
  }
}
