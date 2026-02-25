import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/uchat_image.dart';

class AnnouncementDialog extends GetView<AnnouncementController> {
  const AnnouncementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> announcementList = [];
      List<Widget> pageCount = List.generate(
        controller.announcementList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(
            left: 1,
            right: 4,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: Get.height * 0.007,
              height: Get.height * 0.007,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.anmCurrentPage() == index ? UTheme.color.normalRoomSendMoreIconActive : Colors.grey,
              ),
            ),
          ),
        ),
      );
      for (final announcement in controller.announcementList) {
        announcementList.add(
          announcement.image != null
              ? UChatImage.network(
                  FileService().getAnnounceUrl(announcement.getImage(controller.lang)),
                  fit: BoxFit.cover,
                )
              : Container(),
        );
      }

      double ratio = 3 / 4;
      return Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        insetPadding: EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (context, ct) {
            // using ratio to calculate width and height from  ct.minWidth
            double height = min(ct.maxWidth, Get.height * 0.75);
            double width = height * ratio;

            return SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        PageView(
                          onPageChanged: controller.onAnmPageChange,
                          controller: controller.anmPageController,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...announcementList,
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.6),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.handleToggleCheckBox(!controller.isNotShowTodayCheck());
                          // Get.back();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Checkbox(
                                  activeColor: UTheme.color.blueCi,
                                  value: controller.isNotShowTodayCheck(),
                                  onChanged: (value) {
                                    // Get.back();
                                    controller.handleToggleCheckBox(value);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              Text('Don\'t show again today'.tr),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [...pageCount],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
