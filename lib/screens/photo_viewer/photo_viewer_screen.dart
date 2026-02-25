import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'photo_viewer_controller.dart';

// TODO: refactor
class PhotoViewerScreen extends GetView<PhotoViewerController> {
  final String? elementTag;
  final bool? isShowedMenu;
  final bool? isMyProfile;
  final String? heroTag;

  @override
  String? get tag => elementTag;

  const PhotoViewerScreen({
    super.key,
    this.elementTag,
    this.isShowedMenu,
    this.isMyProfile,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExtendedImageSlidePage(
        key: controller.slidePageKey,
        slideAxis: SlideAxis.vertical,
        slideType: SlideType.onlyImage,
        child: _buildImageView(),
      ),
    );
  }

  Widget _buildImageView() {
    return GestureDetector(
      onTap: () => controller.showMenu.value = !controller.showMenu.value,
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImageHero(),
            // Close icon
            Obx(() {
              return Positioned(
                top: 0.spMin,
                left: 0.spMin,
                right: 0.spMin,
                child: AnimatedOpacity(
                  opacity: controller.showMenu() ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15.spMin,
                      right: 15.spMin,
                      bottom: 10.spMin,
                      top: (Get.height * 0.06).spMin,
                    ),
                    color: Colors.black.withValues(alpha: 0.75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => controller.showMenu() ? Get.back() : (),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHero() {
    return PageView(
      onPageChanged: ((value) {
        controller.index(value);
      }),
      controller: PageController(initialPage: controller.index()),
      children: [
        ...controller.photoDataList.map(
          (e) => Container(
            child: e.isAsset ?? false
                ? Image.asset(e.url!)
                : UChatImage.network(
                    e.url ?? '',
                    cacheKey: e.cacheKey,
                    enableSlideOutPage: true,
                    mode: ExtendedImageMode.gesture,
                  ),
          ),
        )
      ],
    );
  }
}
