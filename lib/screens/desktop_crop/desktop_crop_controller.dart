import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uuid/uuid.dart';

class DesktopCropController extends GetxController {
  DesktopCropController({required this.file});

  final _log = useLogger();

  ///crop
  CustomImageCropController cropCtl = CustomImageCropController();
  File file;
  final cropSize = 1.0.obs;
  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  @override
  void onClose() async {
    cropCtl.dispose();
    super.onClose();
  }

  void handleCrop() async {
    try {
      final imageCrop = await cropCtl.onCropImage();
      File img = File('${(await getTemporaryDirectory()).path}/cropImage_${const Uuid().v4()}.png');
      if (imageCrop?.bytes != null) {
        await img.writeAsBytes(imageCrop!.bytes);
      }
      Get.back(result: img);
    } catch (e) {
      _log.d('err crop ctl = $e');
    }
  }

  void handleAdjustSize(double size) {
    cropCtl.setData(CropImageData(scale: size));
    cropSize.value = size;
  }
}
