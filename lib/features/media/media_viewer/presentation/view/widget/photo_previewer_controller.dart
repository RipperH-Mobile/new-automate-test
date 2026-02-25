import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPreviewerController extends GetxController with GetSingleTickerProviderStateMixin {
  final PhotoViewControllerBase<PhotoViewControllerValue> photoController = PhotoViewController();

  final initialScale = RxnDouble();
  final currentScale = RxDouble(0);
  final hasChangedScale = false.obs;

  final double maxScale = 2.0;
  final double minScale = 0.05;

  @override
  onInit() {
    super.onInit();

    photoController.outputStateStream.listen((state) {
      // set initial scale
      initialScale.value ??= state.scale;
      currentScale.value = state.scale ?? initialScale.value ?? 1;

      if (initialScale.value != null && state.scale != null) {
        hasChangedScale.value = initialScale.value != state.scale;
      }
    });
  }

  @override
  onClose() {
    photoController.dispose();
    super.onClose();
  }

  void onZoomIn() {
    final scaleChangeAmount = currentScale * 1.5;

    if (scaleChangeAmount < maxScale) {
      photoController.setScaleInvisibly(scaleChangeAmount);
    } else {
      photoController.setScaleInvisibly(maxScale);
    }
    update();
  }

  void onZoomOut() {
    final scaleChangeAmount = currentScale / 1.5;

    if (scaleChangeAmount > minScale) {
      photoController.setScaleInvisibly(scaleChangeAmount);
    } else {
      photoController.setScaleInvisibly(minScale);
    }

    update();
  }

  void onMaximize() {
    // zoom 2 times
    photoController.setScaleInvisibly(maxScale / 2);
    if (hasChangedScale.value) {
      photoController.reset();
    }
    update();
  }

  void onReset() {
    // reset scale
    photoController.reset();
    update();
  }
}
