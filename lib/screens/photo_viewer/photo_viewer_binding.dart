import 'package:get/get.dart';

import 'photo_viewer_controller.dart';

class PhotoViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PhotoViewerController>(PhotoViewerController());
  }
}
